-- In-app account deletion (App Store guideline 5.1.1(v), Google Play's
-- account deletion policy). The app calls `rpc('delete_my_account')`.
--
-- Deleting a row from auth.users needs more than the anon/publishable key
-- the app holds, so this runs as SECURITY DEFINER (as the function owner)
-- and only ever acts on auth.uid() — the caller can delete themselves and
-- no one else.
--
-- What it removes, in order:
--   1. The caller's weigh-ins and challenge entries.
--   2. Challenges the caller started: handed to the longest-standing
--      remaining member so friends keep their challenge; deleted when the
--      caller was the only member. (weight_challenges.created_by is
--      NOT NULL with no ON DELETE rule, so it would otherwise block step 4.)
--   3. Rows in the sync tables from schema.sql, if they exist (nothing
--      writes to them yet, but they reference auth.users too).
--   4. The auth user itself — Supabase removes its sessions and
--      identities with it.
--
-- Run in the Supabase Dashboard → SQL Editor. Safe to re-run.

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

  -- Weigh-ins/entries with no remaining members are already gone above.
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
