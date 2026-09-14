-- ZebraPace — turns the single, implicit weight-loss challenge into
-- multiple named, code-gated challenges.
--
-- Run this in the Supabase Dashboard → SQL Editor, same as schema.sql.
--
-- Why this exists: `weight_challenge_entries`/`weight_challenge_weigh_ins`
-- currently have no notion of "which challenge" — every signed-in user can
-- read every row (see the original RLS policy, whatever it was named,
-- dropped below). That was fine with exactly one challenge and 3 known
-- friends; it stops being fine the moment a second group starts a
-- challenge of their own — they'd land in the same pool and see each
-- other's weights. This migration:
--   1. Adds a `weight_challenges` table (name + unique invite code).
--   2. Adds `challenge_id` to both existing tables and backfills every
--      pre-existing row into one new challenge named "5%" with code
--      "CARLA2024" (your current challenge — nothing changes for you or
--      your friend already in it).
--   3. Replaces whatever RLS policies exist today with ones scoped to
--      challenge membership, so a new group's data stays invisible to
--      everyone outside it.
--   4. Adds two SECURITY DEFINER functions (`create_weight_challenge`,
--      `join_weight_challenge`) so joining-by-code can look up a challenge
--      by its code without granting the client blanket SELECT on the
--      challenges table (which would let anyone enumerate other groups'
--      names/codes).

create extension if not exists pgcrypto;

create table if not exists public.weight_challenges (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  code text not null,
  target_percent double precision not null default 5,
  created_by uuid not null references auth.users(id) default auth.uid(),
  created_at timestamptz not null default now()
);

create unique index if not exists weight_challenges_code_key
  on public.weight_challenges (lower(code));

alter table public.weight_challenge_entries
  add column if not exists challenge_id uuid references public.weight_challenges(id);

alter table public.weight_challenge_weigh_ins
  add column if not exists challenge_id uuid references public.weight_challenges(id);

-- One-time backfill: everything that existed before this migration belongs
-- to a single implicit challenge — give it the name/code you chose.
do $$
declare
  v_challenge_id uuid;
  v_creator uuid;
begin
  if exists (select 1 from public.weight_challenge_entries where challenge_id is null) then
    select user_id into v_creator
    from public.weight_challenge_entries
    order by updated_at asc
    limit 1;

    insert into public.weight_challenges (name, code, target_percent, created_by)
    values ('5%', 'CARLA2024', 5, v_creator)
    returning id into v_challenge_id;

    update public.weight_challenge_entries
      set challenge_id = v_challenge_id
      where challenge_id is null;

    update public.weight_challenge_weigh_ins
      set challenge_id = v_challenge_id
      where challenge_id is null;
  end if;
end $$;

alter table public.weight_challenge_entries
  alter column challenge_id set not null;

alter table public.weight_challenge_weigh_ins
  alter column challenge_id set not null;

-- The old primary key was just (user_id) — one person, one challenge.
-- Now a person can belong to several challenges, so the key becomes
-- (challenge_id, user_id). Assumes Postgres's default constraint-naming
-- convention (<table>_pkey); if this errors because yours was named
-- differently, paste the error back and it's a one-line fix.
do $$
begin
  if exists (
    select 1 from information_schema.table_constraints
    where table_schema = 'public'
      and table_name = 'weight_challenge_entries'
      and constraint_name = 'weight_challenge_entries_pkey'
  ) then
    alter table public.weight_challenge_entries drop constraint weight_challenge_entries_pkey;
  end if;
end $$;

alter table public.weight_challenge_entries
  add primary key (challenge_id, user_id);

-- Drop every existing policy on these two tables (names unknown/ad hoc)
-- before laying down the new membership-scoped ones — RLS combines
-- multiple permissive policies with OR, so leaving an old "any signed-in
-- user can read everything" policy in place would silently defeat the
-- new scoping below.
do $$
declare
  pol record;
begin
  for pol in
    select policyname from pg_policies
    where schemaname = 'public' and tablename = 'weight_challenge_entries'
  loop
    execute format('drop policy %I on public.weight_challenge_entries', pol.policyname);
  end loop;

  for pol in
    select policyname from pg_policies
    where schemaname = 'public' and tablename = 'weight_challenge_weigh_ins'
  loop
    execute format('drop policy %I on public.weight_challenge_weigh_ins', pol.policyname);
  end loop;
end $$;

alter table public.weight_challenges enable row level security;
alter table public.weight_challenge_entries enable row level security;
alter table public.weight_challenge_weigh_ins enable row level security;

-- weight_challenges: visible only to its creator or a joined member —
-- never browsable by code, which is what forces joining to go through the
-- join_weight_challenge() function below instead of a direct table read.
create policy weight_challenges_member_select on public.weight_challenges
  for select using (
    created_by = auth.uid()
    or exists (
      select 1 from public.weight_challenge_entries e
      where e.challenge_id = weight_challenges.id and e.user_id = auth.uid()
    )
  );

-- weight_challenge_entries: readable by anyone who is themselves a member
-- of that same challenge (own row always qualifies); writable only by the
-- row's own owner.
create policy weight_challenge_entries_member_select on public.weight_challenge_entries
  for select using (
    exists (
      select 1 from public.weight_challenge_entries mine
      where mine.challenge_id = weight_challenge_entries.challenge_id
        and mine.user_id = auth.uid()
    )
  );

create policy weight_challenge_entries_owner_write on public.weight_challenge_entries
  for insert with check (user_id = auth.uid());

create policy weight_challenge_entries_owner_update on public.weight_challenge_entries
  for update using (user_id = auth.uid()) with check (user_id = auth.uid());

-- weight_challenge_weigh_ins: same membership-via-entries scoping for
-- reads; writable only by the row's own owner.
create policy weight_challenge_weigh_ins_member_select on public.weight_challenge_weigh_ins
  for select using (
    exists (
      select 1 from public.weight_challenge_entries e
      where e.challenge_id = weight_challenge_weigh_ins.challenge_id
        and e.user_id = auth.uid()
    )
  );

create policy weight_challenge_weigh_ins_owner_write on public.weight_challenge_weigh_ins
  for insert with check (user_id = auth.uid());

-- Creates a new challenge. SECURITY DEFINER only so it can set created_by
-- reliably; RLS on weight_challenges still applies to everything else.
create or replace function public.create_weight_challenge(
  p_name text,
  p_code text,
  p_target_percent double precision default 5
) returns public.weight_challenges
language plpgsql security definer set search_path = public as $$
declare
  v_row public.weight_challenges;
begin
  insert into public.weight_challenges (name, code, target_percent, created_by)
  values (trim(p_name), trim(p_code), p_target_percent, auth.uid())
  returning * into v_row;
  return v_row;
exception when unique_violation then
  raise exception 'That code is already taken — pick another.';
end;
$$;

-- Joins an existing challenge by its invite code. SECURITY DEFINER is what
-- lets this look up a challenge by code even though normal SELECT on
-- weight_challenges is restricted to members — the alternative (opening up
-- SELECT so the client could look up codes itself) would let any
-- signed-in user enumerate every challenge's name and code.
create or replace function public.join_weight_challenge(
  p_code text,
  p_display_name text,
  p_start_weight_kg double precision
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
    (challenge_id, user_id, display_name, start_weight_kg, current_weight_kg, updated_at)
  values
    (v_challenge.id, auth.uid(), trim(p_display_name), p_start_weight_kg, p_start_weight_kg, now())
  on conflict (challenge_id, user_id) do update
    set display_name = excluded.display_name
  returning * into v_row;

  insert into public.weight_challenge_weigh_ins (challenge_id, user_id, weight_kg, logged_at)
  values (v_challenge.id, auth.uid(), p_start_weight_kg, now());

  return v_row;
end;
$$;

grant execute on function public.create_weight_challenge(text, text, double precision) to authenticated;
grant execute on function public.join_weight_challenge(text, text, double precision) to authenticated;
