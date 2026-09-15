-- Fixes: PostgresException 42P17 "infinite recursion detected in policy for
-- relation weight_challenge_entries".
--
-- The previous migration's weight_challenge_entries_member_select policy
-- checked membership with a subquery against weight_challenge_entries
-- itself ("mine"). But RLS applies to *every* read of that table,
-- including the one inside its own policy's subquery — so evaluating the
-- policy re-triggers the policy, forever. weight_challenge_weigh_ins and
-- weight_challenges read weight_challenge_entries too, so they'd hit the
-- same recursion transitively.
--
-- Fix: move the membership check into a SECURITY DEFINER function. Such a
-- function runs as its owner (the table owner, which bypasses RLS by
-- default), so the query inside it never re-invokes the policy at all —
-- the standard pattern for self-referential RLS checks.

create or replace function public.is_weight_challenge_member(p_challenge_id uuid)
returns boolean
language sql
security definer
stable
set search_path = public
as $$
  select exists (
    select 1 from public.weight_challenge_entries
    where challenge_id = p_challenge_id and user_id = auth.uid()
  );
$$;

grant execute on function public.is_weight_challenge_member(uuid) to authenticated;

drop policy if exists weight_challenge_entries_member_select on public.weight_challenge_entries;
create policy weight_challenge_entries_member_select on public.weight_challenge_entries
  for select using (public.is_weight_challenge_member(challenge_id));

drop policy if exists weight_challenge_weigh_ins_member_select on public.weight_challenge_weigh_ins;
create policy weight_challenge_weigh_ins_member_select on public.weight_challenge_weigh_ins
  for select using (public.is_weight_challenge_member(challenge_id));

drop policy if exists weight_challenges_member_select on public.weight_challenges;
create policy weight_challenges_member_select on public.weight_challenges
  for select using (
    created_by = auth.uid()
    or public.is_weight_challenge_member(id)
  );
