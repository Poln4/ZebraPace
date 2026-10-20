-- Calisthenics sets that differ (30, 20, 23) and isometric holds logged in
-- seconds — mirrors local drift schema v7 (lib/data/db/tables/
-- calisthenics_table.dart).
--
-- set_values: each set's reps or seconds. Null on rows logged before this,
-- which read as `sets` × `reps`. `sets`/`reps` stay filled (set count and
-- best set) for older readers.
-- unit: 'reps' or 'seconds'.
--
-- Also adds the heart-rate range columns, which the local table gained in
-- schema v3 but schema.sql never picked up.
--
-- No sync engine writes to this table yet, so this only keeps the remote
-- shape in step with the app. Safe to re-run.
--
-- Run in the Supabase Dashboard → SQL Editor.

alter table public.calisthenics
  add column if not exists set_values integer[],
  add column if not exists unit text not null default 'reps'
    check (unit in ('reps', 'seconds')),
  add column if not exists heart_rate_min_bpm integer,
  add column if not exists heart_rate_max_bpm integer;
