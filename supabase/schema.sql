-- ZebraPace cloud sync — remote schema for Supabase project jclbxpnixzlmzpkqzvcb.
--
-- Run this in the Supabase Dashboard → SQL Editor (this app only ever holds
-- the anon/publishable key, which can't run DDL — and shouldn't be able to).
--
-- Mirrors the 8 local drift tables that use the `SyncColumns` mixin
-- (lib/data/db/tables/sync_columns.dart) — every table with a UUID `id` and
-- updatedAt/deletedAt. `Settings` (device-local key/value prefs) and
-- `WeatherCache` (a regenerable API cache, not user data) are deliberately
-- excluded, matching how they're excluded from `SyncColumns` locally.
--
-- `id` is always supplied by the client (generated locally via the `uuid`
-- package before insert), so no server-side default is needed.
-- `updated_at`/`deleted_at` are `timestamptz` here even though the local
-- Dart column stores updatedAt as an ISO8601 string — a future SyncService
-- just converts between the two; timestamptz is the more useful type to
-- have on the server for ordering/queries.
--
-- This only creates tables + RLS policies. No SyncService, triggers, or
-- app-side push/pull logic exist yet — that's a separate follow-up plan.

create table if not exists public.daily_logs (
  id uuid primary key,
  user_id uuid not null references auth.users(id) default auth.uid(),
  date date not null,
  weight_kg double precision,
  height_cm double precision,
  fat_percentage double precision,
  water_ml_raw integer not null default 0,
  water_ml_credit double precision not null default 0,
  protein_g integer not null default 0,
  creatine_g double precision not null default 0,
  mental_state text,
  body_feeling text,
  braces_used text not null default '[]',
  brace_comfort integer,
  steps integer not null default 0,
  is_rest_day boolean not null default false,
  is_flare_day boolean not null default false,
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  unique (user_id, date)
);

create table if not exists public.activities (
  id uuid primary key,
  user_id uuid not null references auth.users(id) default auth.uid(),
  date date not null,
  activity_name text not null,
  duration_min integer not null,
  extra_weight_kg double precision not null default 0,
  mental_state text,
  body_feeling text,
  source text not null default 'manual',
  healthkit_uuid text unique,
  mets_avg double precision,
  active_energy_kcal double precision,
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create table if not exists public.calisthenics (
  id uuid primary key,
  user_id uuid not null references auth.users(id) default auth.uid(),
  date date not null,
  exercise text not null,
  progression text not null,
  sets integer not null,
  reps integer not null,
  comfort_score double precision not null default 0,
  mental_state text,
  body_feeling text,
  contraction_mode text,
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create table if not exists public.therapies (
  id uuid primary key,
  user_id uuid not null references auth.users(id) default auth.uid(),
  date date not null,
  therapy_name text not null,
  duration_min integer not null,
  mental_state text,
  body_feeling text,
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create table if not exists public.liquid_logs (
  id uuid primary key,
  user_id uuid not null references auth.users(id) default auth.uid(),
  date date not null,
  drink_type text not null,
  custom_drink_label text,
  amount_ml_raw integer not null,
  hydration_ml_credit double precision not null,
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create table if not exists public.soreness_checks (
  id uuid primary key,
  user_id uuid not null references auth.users(id) default auth.uid(),
  date date not null,
  onset text not null,
  spread text not null,
  trend text not null,
  verdict text not null,
  verdict_label text not null,
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create table if not exists public.checkins (
  id uuid primary key,
  user_id uuid not null references auth.users(id) default auth.uid(),
  date date not null,
  logged_at text not null, -- 'HH:mm' local time, not a full timestamp
  mental_state text not null,
  body_feeling text not null,
  note text not null default '',
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create table if not exists public.injuries (
  id uuid primary key,
  user_id uuid not null references auth.users(id) default auth.uid(),
  date_started date not null,
  zone text not null,
  kind text not null,
  type text not null,
  note text not null default '',
  resolved_at date,
  still_painful boolean,
  compared_to_usual text,
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

-- Row Level Security: every table is scoped to its owning user only.
do $$
declare
  t text;
begin
  foreach t in array array[
    'daily_logs', 'activities', 'calisthenics', 'therapies',
    'liquid_logs', 'soreness_checks', 'checkins', 'injuries'
  ]
  loop
    execute format('alter table public.%I enable row level security;', t);
    execute format(
      'create policy %I on public.%I for all using (user_id = auth.uid()) with check (user_id = auth.uid());',
      t || '_owner_only', t
    );
  end loop;
end $$;
