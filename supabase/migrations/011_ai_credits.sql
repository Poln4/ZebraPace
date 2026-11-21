-- AI credits and sponsoring (business_plan.md §4.5): the two consumable
-- purchases. The revenuecat-webhook Edge Function records each store
-- transaction here; the balance only ever changes on the server, so the
-- phone never decides how many credits someone has.
--
-- store_purchases is the ledger. Its primary key is the store's
-- transaction id, so a webhook retry (or a duplicate event) can't grant
-- the same purchase twice. Sponsor rows are the shared "beca" fund: they
-- outlive the buyer's account (user_id is set null on deletion), because
-- the gift was paid for and belongs to whoever receives it.
--
-- ai_credit_balances holds one running total per person. People can read
-- their own balance and their own purchases; nobody writes through the
-- API. Only the service role (the webhook, later the AI summary function)
-- calls record_store_purchase / refund_store_purchase.
--
-- Run in the Supabase Dashboard → SQL Editor. Safe to re-run.

create table if not exists public.store_purchases (
  transaction_id text primary key check (char_length(transaction_id) <= 200),
  user_id uuid references auth.users(id) on delete set null,
  kind text not null check (kind in ('credits', 'sponsor')),
  product_id text not null check (char_length(product_id) <= 200),
  credits integer not null default 0 check (credits >= 0),
  environment text check (char_length(environment) <= 20),
  purchased_at timestamptz not null default now(),
  refunded_at timestamptz
);

create index if not exists store_purchases_user_idx
  on public.store_purchases (user_id);

create table if not exists public.ai_credit_balances (
  user_id uuid primary key references auth.users(id) on delete cascade,
  balance integer not null default 0 check (balance >= 0),
  updated_at timestamptz not null default now()
);

alter table public.store_purchases enable row level security;
alter table public.ai_credit_balances enable row level security;

drop policy if exists store_purchases_select_own on public.store_purchases;
create policy store_purchases_select_own on public.store_purchases
  for select to authenticated
  using (user_id = auth.uid());

drop policy if exists ai_credit_balances_select_own on public.ai_credit_balances;
create policy ai_credit_balances_select_own on public.ai_credit_balances
  for select to authenticated
  using (user_id = auth.uid());

-- New tables get no base grants in this project (see 004, 010) — not even
-- service_role.
revoke all on public.store_purchases from anon, authenticated;
revoke all on public.ai_credit_balances from anon, authenticated;
grant select on public.store_purchases to authenticated;
grant select on public.ai_credit_balances to authenticated;
grant select, insert, update, delete on public.store_purchases to service_role;
grant select, insert, update, delete on public.ai_credit_balances to service_role;

-- Records one store transaction and adds its credits, atomically.
-- Returns false when the transaction was already recorded (retry).
create or replace function public.record_store_purchase(
  p_transaction_id text,
  p_user_id uuid,
  p_kind text,
  p_product_id text,
  p_credits integer,
  p_environment text,
  p_purchased_at timestamptz
)
returns boolean
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.store_purchases
    (transaction_id, user_id, kind, product_id, credits, environment, purchased_at)
  values
    (p_transaction_id, p_user_id, p_kind, p_product_id, p_credits, p_environment,
     coalesce(p_purchased_at, now()))
  on conflict (transaction_id) do nothing;

  if not found then
    return false;
  end if;

  if p_credits > 0 then
    insert into public.ai_credit_balances (user_id, balance)
    values (p_user_id, p_credits)
    on conflict (user_id) do update
      set balance = public.ai_credit_balances.balance + excluded.balance,
          updated_at = now();
  end if;

  return true;
end;
$$;

-- Marks a refunded transaction and takes its credits back (never below
-- zero: credits already spent stay spent). Returns false when the
-- transaction is unknown or was already refunded.
create or replace function public.refund_store_purchase(p_transaction_id text)
returns boolean
language plpgsql
security definer
set search_path = public
as $$
declare
  v_user uuid;
  v_credits integer;
begin
  update public.store_purchases
  set refunded_at = now()
  where transaction_id = p_transaction_id and refunded_at is null
  returning user_id, credits into v_user, v_credits;

  if not found then
    return false;
  end if;

  if v_credits > 0 and v_user is not null then
    update public.ai_credit_balances
    set balance = greatest(balance - v_credits, 0),
        updated_at = now()
    where user_id = v_user;
  end if;

  return true;
end;
$$;

-- Functions are executable by PUBLIC by default; only the webhook may call these.
revoke all on function public.record_store_purchase(text, uuid, text, text, integer, text, timestamptz)
  from public, anon, authenticated;
revoke all on function public.refund_store_purchase(text)
  from public, anon, authenticated;
grant execute on function public.record_store_purchase(text, uuid, text, text, integer, text, timestamptz)
  to service_role;
grant execute on function public.refund_store_purchase(text) to service_role;
