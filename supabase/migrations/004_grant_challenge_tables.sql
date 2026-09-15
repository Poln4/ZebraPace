-- Fixes: PostgresException 42501 "permission denied for table
-- weight_challenges" (hint: GRANT SE...).
--
-- Row-level security policies only decide *which rows* a role can see or
-- change once it's already allowed to attempt the operation — that base
-- permission is a separate, ordinary GRANT. weight_challenge_entries and
-- weight_challenge_weigh_ins apparently already had one from whenever they
-- were first created; weight_challenges (new in migration 002) never got
-- one, so any query touching it — including embedded selects like
-- `weight_challenge_entries.select('weight_challenges(*)')` — was denied
-- before RLS even got a chance to run.
--
-- Grants matching exactly what each table's RLS policies allow: clients
-- only ever read weight_challenges directly (creating one goes through the
-- SECURITY DEFINER create_weight_challenge function, which runs as the
-- table owner and doesn't need this grant at all).

grant select on public.weight_challenges to authenticated;
grant select, insert, update on public.weight_challenge_entries to authenticated;
grant select, insert on public.weight_challenge_weigh_ins to authenticated;
