-- Zebras+ status per account, mirrored from RevenueCat by the
-- revenuecat-webhook Edge Function (business_plan.md §4.1). Lets apps
-- without the RevenueCat SDK (ZebraUp's web version) honor a plan bought
-- in ZebraPace, and gives server-side checks (AI credits, beca) one place
-- to look.
--
-- RevenueCat stays the source of truth: the function re-reads the
-- subscriber from RevenueCat's API on every event and overwrites the row,
-- so missed or out-of-order events heal on the next one.
--
-- `granted` = the entitlement exists for this person (it may have lapsed);
-- clients apply the same rule as ZebraPace's PlusEntitlement.isActiveAt:
--   granted and (expires_at is null or now() < expires_at + 7 days)
-- The 7 days cover being offline over a renewal.
--
-- People can read only their own rows; nobody writes through the API —
-- only the Edge Function, which uses the service role. Rows go away with
-- the account (delete_my_account removes auth.users → cascade).
--
-- Run in the Supabase Dashboard → SQL Editor. Safe to re-run.

create table if not exists public.entitlements (
  user_id uuid not null references auth.users(id) on delete cascade,
  entitlement_id text not null check (char_length(entitlement_id) <= 50),
  granted boolean not null,
  expires_at timestamptz,
  product_id text check (char_length(product_id) <= 200),
  updated_at timestamptz not null default now(),
  primary key (user_id, entitlement_id)
);

alter table public.entitlements enable row level security;

drop policy if exists entitlements_select_own on public.entitlements;
create policy entitlements_select_own on public.entitlements
  for select to authenticated
  using (user_id = auth.uid());

-- New tables in this project don't get base grants automatically (see 004)
-- — not even for service_role, which bypasses RLS but still needs table
-- privileges. The revenuecat-webhook function writes as service_role.
revoke all on public.entitlements from anon, authenticated;
grant select on public.entitlements to authenticated;
grant select, insert, update, delete on public.entitlements to service_role;
