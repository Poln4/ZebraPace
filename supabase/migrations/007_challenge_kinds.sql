-- ZebraPace — challenges beyond weight: steps, daily logging, sleep and
-- activity, alongside the existing weight-loss kind.
--
-- Run this in the Supabase Dashboard → SQL Editor, after 002–006. Safe to
-- re-run.
--
-- Why it's built on the existing weight_* tables instead of new ones: the
-- membership-scoped RLS (is_weight_challenge_member), the invite-code
-- RPCs and delete_my_account all already key off weight_challenges /
-- weight_challenge_entries. Renaming those tables would break every
-- function body that references them by name, and a parallel set of
-- tables would mean duplicating all of that security logic. So the table
-- names stay (a little misleading now — "weight_" really means
-- "challenge_") and they just learn about kinds:
--   1. weight_challenges gains `kind`, `starts_on` and `weeks`. Existing
--      rows become kind 'weight' with no fixed length (weeks null), so
--      the current 5% challenge keeps working exactly as before.
--   2. weight_challenge_entries gains `daily_goal` (each member's own
--      target — steps, hours of sleep, active minutes), and its weight
--      columns become nullable, since a steps challenge member has no
--      starting weight.
--   3. New table challenge_days: one row per member per day with that
--      day's value and whether it met the member's goal. Scoring is
--      "days your own goal was met", so people with very different
--      capacities can compete fairly.
--   4. New RPCs create_challenge / join_challenge (the weight-only
--      create_weight_challenge / join_weight_challenge stay, so an older
--      app build keeps working).
--   5. delete_my_account also clears challenge_days.

alter table public.weight_challenges
  add column if not exists kind text not null default 'weight',
  add column if not exists starts_on date,
  add column if not exists weeks integer;

do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'weight_challenges_kind_check'
  ) then
    alter table public.weight_challenges
      add constraint weight_challenges_kind_check
      check (kind in ('weight', 'steps', 'logging', 'sleep', 'activity'));
  end if;
  if not exists (
    select 1 from pg_constraint where conname = 'weight_challenges_weeks_check'
  ) then
    alter table public.weight_challenges
      add constraint weight_challenges_weeks_check
      check (weeks is null or weeks between 1 and 52);
  end if;
end $$;

alter table public.weight_challenge_entries
  add column if not exists daily_goal double precision;

alter table public.weight_challenge_entries
  alter column start_weight_kg drop not null,
  alter column current_weight_kg drop not null;

create table if not exists public.challenge_days (
  challenge_id uuid not null references public.weight_challenges(id) on delete cascade,
  user_id uuid not null references auth.users(id) default auth.uid(),
  day date not null,
  value double precision not null default 0,
  goal_met boolean not null default false,
  -- Rest/flare day in the member's own log. Counts as met for steps and
  -- activity (resting is part of pacing, not a failure), shown with its
  -- own marker so nobody mistakes it for a step count.
  rest_day boolean not null default false,
  updated_at timestamptz not null default now(),
  primary key (challenge_id, user_id, day)
);

alter table public.challenge_days enable row level security;

drop policy if exists challenge_days_member_select on public.challenge_days;
create policy challenge_days_member_select on public.challenge_days
  for select using (public.is_weight_challenge_member(challenge_id));

drop policy if exists challenge_days_owner_insert on public.challenge_days;
create policy challenge_days_owner_insert on public.challenge_days
  for insert with check (
    user_id = auth.uid() and public.is_weight_challenge_member(challenge_id)
  );

drop policy if exists challenge_days_owner_update on public.challenge_days;
create policy challenge_days_owner_update on public.challenge_days
  for update using (user_id = auth.uid()) with check (user_id = auth.uid());

-- RLS only filters rows; the base permission is a separate GRANT (see 004).
grant select, insert, update on public.challenge_days to authenticated;

-- The app streams this table (supabase.from(...).stream()), which needs it
-- in the realtime publication.
do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'challenge_days'
  ) then
    alter publication supabase_realtime add table public.challenge_days;
  end if;
end $$;

-- starts_on comes from the client's local date rather than current_date,
-- which is the server's UTC date and can be a day off in the evening.
create or replace function public.create_challenge(
  p_name text,
  p_code text,
  p_kind text,
  p_starts_on date,
  p_weeks integer,
  p_target_percent double precision default 5
) returns public.weight_challenges
language plpgsql security definer set search_path = public as $$
declare
  v_row public.weight_challenges;
begin
  insert into public.weight_challenges
    (name, code, kind, starts_on, weeks, target_percent, created_by)
  values
    (trim(p_name), trim(p_code), p_kind, p_starts_on, p_weeks, p_target_percent, auth.uid())
  returning * into v_row;
  return v_row;
exception when unique_violation then
  raise exception 'That code is already taken — pick another.';
end;
$$;

-- Joins by code without any kind-specific data — the joiner may not know
-- yet whether it's a weight or a steps challenge. The app then asks for a
-- starting weight or a daily goal and writes it to their own entry row
-- (allowed by weight_challenge_entries_owner_update).
create or replace function public.join_challenge(
  p_code text,
  p_display_name text
) returns public.weight_challenge_entries
language plpgsql security definer set search_path = public as $$
declare
  v_challenge public.weight_challenges;
  v_row public.weight_challenge_entries;
begin
  select * into v_challenge
  from public.weight_challenges
  where lower(code) = lower(trim(p_code));

  if not found then
    raise exception 'No challenge found with that code.';
  end if;

  insert into public.weight_challenge_entries
    (challenge_id, user_id, display_name, updated_at)
  values
    (v_challenge.id, auth.uid(), trim(p_display_name), now())
  on conflict (challenge_id, user_id) do update
    set display_name = excluded.display_name
  returning * into v_row;

  return v_row;
end;
$$;

grant execute on function public.create_challenge(text, text, text, date, integer, double precision)
  to authenticated;
grant execute on function public.join_challenge(text, text) to authenticated;

-- Same as 006, plus challenge_days.
create or replace function public.delete_my_account()
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  t text;
begin
  if v_uid is null then
    raise exception 'Not signed in';
  end if;

  delete from public.challenge_days where user_id = v_uid;
  delete from public.weight_challenge_weigh_ins where user_id = v_uid;
  delete from public.weight_challenge_entries where user_id = v_uid;

  update public.weight_challenges c
  set created_by = (
    select e.user_id
    from public.weight_challenge_entries e
    where e.challenge_id = c.id
    order by e.updated_at asc
    limit 1
  )
  where c.created_by = v_uid
    and exists (select 1 from public.weight_challenge_entries e where e.challenge_id = c.id);

  delete from public.weight_challenges where created_by = v_uid;

  foreach t in array array[
    'daily_logs', 'activities', 'calisthenics', 'therapies',
    'liquid_logs', 'soreness_checks', 'checkins', 'injuries'
  ]
  loop
    if to_regclass('public.' || t) is not null then
      execute format('delete from public.%I where user_id = $1', t) using v_uid;
    end if;
  end loop;

  delete from auth.users where id = v_uid;
end;
$$;

revoke all on function public.delete_my_account() from public, anon;
grant execute on function public.delete_my_account() to authenticated;
