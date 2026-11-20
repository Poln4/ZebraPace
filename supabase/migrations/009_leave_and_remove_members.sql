-- ZebraPace — leaving a challenge, and the creator removing a member.
--
-- Run this in the Supabase Dashboard → SQL Editor, after 002–008. Safe to
-- re-run.
--
-- 1. challenge_removed_members: who the creator removed from which
--    challenge. join_challenge / join_weight_challenge refuse them, or a
--    removed member could rejoin with the same code a minute later.
--    No RLS policies on purpose: only the SECURITY DEFINER functions below
--    read or write it, so no client can list or edit it.
-- 2. leave_challenge(challenge): deletes the caller's own days, weigh-ins
--    and entry in that challenge. If the caller created it, it passes to
--    another member (same rule as delete_my_account); if nobody is left,
--    the challenge itself is deleted. Leaving doesn't block rejoining.
-- 3. remove_challenge_member(challenge, user): creator only, never
--    themself (they leave instead). Deletes that member's rows in that
--    challenge for everyone and records them in (1).
--
-- Rows are deleted child-first (days → weigh-ins → entry) because
-- weigh-ins and entries reference weight_challenges without ON DELETE
-- CASCADE (002); challenge_days and the removed list do cascade.

create table if not exists public.challenge_removed_members (
  challenge_id uuid not null references public.weight_challenges(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  removed_at timestamptz not null default now(),
  primary key (challenge_id, user_id)
);

alter table public.challenge_removed_members enable row level security;
revoke all on public.challenge_removed_members from anon, authenticated;

create or replace function public.leave_challenge(p_challenge_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
begin
  if v_uid is null then
    raise exception 'Not signed in';
  end if;
  if not exists (
    select 1 from public.weight_challenge_entries
    where challenge_id = p_challenge_id and user_id = v_uid
  ) then
    raise exception 'You''re not in this challenge.';
  end if;

  delete from public.challenge_days
    where challenge_id = p_challenge_id and user_id = v_uid;
  delete from public.weight_challenge_weigh_ins
    where challenge_id = p_challenge_id and user_id = v_uid;
  delete from public.weight_challenge_entries
    where challenge_id = p_challenge_id and user_id = v_uid;

  -- The creator leaving hands the challenge to the remaining member whose
  -- row is oldest, as delete_my_account does.
  update public.weight_challenges c
  set created_by = (
    select e.user_id
    from public.weight_challenge_entries e
    where e.challenge_id = c.id
    order by e.updated_at asc
    limit 1
  )
  where c.id = p_challenge_id
    and c.created_by = v_uid
    and exists (select 1 from public.weight_challenge_entries e where e.challenge_id = c.id);

  -- Still theirs means nobody else was left: the challenge goes too.
  delete from public.weight_challenges
    where id = p_challenge_id and created_by = v_uid;
end;
$$;

create or replace function public.remove_challenge_member(p_challenge_id uuid, p_user_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
begin
  if v_uid is null then
    raise exception 'Not signed in';
  end if;
  if not exists (
    select 1 from public.weight_challenges
    where id = p_challenge_id and created_by = v_uid
  ) then
    raise exception 'Only the person who created this challenge can remove members.';
  end if;
  if p_user_id = v_uid then
    raise exception 'To leave your own challenge, use Leave instead.';
  end if;

  delete from public.challenge_days
    where challenge_id = p_challenge_id and user_id = p_user_id;
  delete from public.weight_challenge_weigh_ins
    where challenge_id = p_challenge_id and user_id = p_user_id;
  delete from public.weight_challenge_entries
    where challenge_id = p_challenge_id and user_id = p_user_id;

  insert into public.challenge_removed_members (challenge_id, user_id)
  values (p_challenge_id, p_user_id)
  on conflict do nothing;
end;
$$;

revoke all on function public.leave_challenge(uuid) from public, anon;
revoke all on function public.remove_challenge_member(uuid, uuid) from public, anon;
grant execute on function public.leave_challenge(uuid) to authenticated;
grant execute on function public.remove_challenge_member(uuid, uuid) to authenticated;

-- Joining: same as 007 / 002, plus refusing removed members.
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

  if exists (
    select 1 from public.challenge_removed_members
    where challenge_id = v_challenge.id and user_id = auth.uid()
  ) then
    raise exception 'You were removed from this challenge.';
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

-- Older app builds still call this one.
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

  if exists (
    select 1 from public.challenge_removed_members
    where challenge_id = v_challenge.id and user_id = auth.uid()
  ) then
    raise exception 'You were removed from this challenge.';
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

grant execute on function public.join_challenge(text, text) to authenticated;
grant execute on function public.join_weight_challenge(text, text, double precision) to authenticated;
