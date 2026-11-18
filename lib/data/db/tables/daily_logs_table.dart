import 'package:drift/drift.dart';

import 'sync_columns.dart';

/// One row per calendar day (device-local date). `date` is a unique index,
/// not the primary key — see the plan's "Cloud sync pivot" addendum: every
/// table uses a UUID id so a future remote mirror can use the same strategy
/// uniformly (unique(user_id, date) remotely instead of a special case).
class DailyLogs extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get date => text().unique()();

  RealColumn get weightKg => real().nullable()();
  RealColumn get heightCm => real().nullable()();
  RealColumn get fatPercentage => real().nullable()();

  /// Raw ml consumed today, independent of hydration-factor weighting.
  IntColumn get waterMlRaw => integer().withDefault(const Constant(0))();

  /// Hydration-adjusted credit (= sum of liquid_logs.hydrationMlCredit for
  /// the day). In app.py this was ambiguously named `water_ml` and actually
  /// stored this credit value, not raw ml — split into two explicit columns
  /// here on purpose.
  RealColumn get waterMlCredit => real().withDefault(const Constant(0))();

  /// Was an IntColumn before schemaVersion 4 — widened to allow decimal
  /// grams (e.g. a half-scoop or a label's "17.5g") instead of rounding
  /// every entry to a whole gram.
  RealColumn get proteinG => real().withDefault(const Constant(0))();
  RealColumn get creatineG => real().withDefault(const Constant(0))();

  TextColumn get mentalState => text().nullable()();
  TextColumn get bodyFeeling => text().nullable()();

  /// JSON-encoded list of BraceUse.toJson() objects (type plus side or
  /// count, or a custom brace's id and name). Days logged before that hold
  /// plain BraceType.db strings, which BraceUse.fromJson still reads.
  /// (app.py stored this as a Python str(list)/eval() pair.)
  TextColumn get bracesUsed => text().withDefault(const Constant('[]'))();
  IntColumn get braceComfort => integer().nullable()();

  IntColumn get steps => integer().withDefault(const Constant(0))();
  BoolColumn get isRestDay => boolean().withDefault(const Constant(false))();
  BoolColumn get isFlareDay => boolean().withDefault(const Constant(false))();

  /// Added in schemaVersion 2 — see AppDatabase's MigrationStrategy.
  /// Total sleep duration in decimal hours (a "7h 30m" picker input becomes
  /// 7.5) — no separate minutes column needed.
  RealColumn get sleepHours => real().nullable()();
  TextColumn get sleepQuality => text().nullable()();
  IntColumn get sleepHeartRateMin => integer().nullable()();
  IntColumn get sleepHeartRateMax => integer().nullable()();

  /// Added in schemaVersion 5. Morning resting heart rate (bpm) and HRV
  /// (ms), pre-filled from Apple Health / Health Connect or typed in by hand
  /// (e.g. a finger-on-camera reading) for people without a watch.
  IntColumn get restingHeartRate => integer().nullable()();
  RealColumn get hrvMs => real().nullable()();

  /// Added in schemaVersion 6. Where each Health-backed group came from:
  /// 'health' (synced) or 'manual' (typed, or a synced value edited). Sync
  /// never overwrites a 'manual' group; null means nothing recorded yet.
  /// steps; sleep = sleepHours + sleepHeartRateMin/Max; heart =
  /// restingHeartRate + hrvMs. sleepQuality is always the person's own.
  TextColumn get stepsSource => text().nullable()();
  TextColumn get sleepSource => text().nullable()();
  TextColumn get heartSource => text().nullable()();

  /// Added in schemaVersion 10. Minutes of REM and deep sleep (from Health
  /// when the tracker records stages, or typed in; part of the sleep group
  /// for sleepSource), and whether there were nightmares — a yes/no only,
  /// always the person's own, like sleepQuality. Null means not recorded.
  IntColumn get remSleepMin => integer().nullable()();
  IntColumn get deepSleepMin => integer().nullable()();
  BoolColumn get hadNightmares => boolean().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
