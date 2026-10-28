-- Anonymous crash/error reports from the app (lib/core/errors/error_reporter.dart),
-- so failures on real phones show up somewhere instead of vanishing.
--
-- No user id, email or health data: only the error text, a stack trace,
-- platform and app version. Anyone holding the publishable key may
-- INSERT (crashes can happen before sign-in), nobody may read through the
-- API — read them in the Dashboard (Table Editor or SQL Editor), which
-- uses the service role.
--
-- Length checks keep a misbehaving or abusive client from storing large
-- blobs. Run in the Supabase Dashboard → SQL Editor. Safe to re-run.

create table if not exists public.app_errors (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  platform text check (char_length(platform) <= 20),
  app_version text check (char_length(app_version) <= 40),
  location text check (char_length(location) <= 100),
  error text not null check (char_length(error) <= 500),
  stack text check (char_length(stack) <= 4000)
);

alter table public.app_errors enable row level security;

drop policy if exists app_errors_insert on public.app_errors;
create policy app_errors_insert on public.app_errors
  for insert to anon, authenticated
  with check (true);

-- New tables in this project don't get base grants automatically (see 004).
-- Insert only: no select, so reports can't be read back through the API.
grant insert on public.app_errors to anon, authenticated;

-- web/privacy.html promises reports are deleted after about 90 days:
-- a daily pg_cron job does it. cron.schedule with a job name replaces an
-- existing job of the same name, so re-running is fine. If the extension
-- line fails, enable "Cron" under Dashboard → Integrations, then re-run.
create extension if not exists pg_cron;

select cron.schedule(
  'purge-old-app-errors',
  '30 4 * * *',
  $$delete from public.app_errors where created_at < now() - interval '90 days'$$
);
