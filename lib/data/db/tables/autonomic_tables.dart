import 'package:drift/drift.dart';

import 'sync_columns.dart';

/// Active stand test (a simplified NASA lean test): resting baseline, then
/// heart rate (and blood pressure when there's a cuff) at 1, 3 and 10
/// minutes standing. The indirect sympathetic lane of the Autonomic
/// signals card. Values are typed in by the person — a watch's background
/// heart rate in Health is too sparse for these exact minutes.
class StandTests extends Table with SyncColumns {
  TextColumn get id => text()();

  /// yyyy-MM-dd.
  TextColumn get date => text()();

  /// ISO time the person stood up.
  TextColumn get startedAt => text()();

  /// 'lying' or 'sitting' for the baseline.
  TextColumn get baselinePosition => text().withDefault(const Constant('lying'))();

  IntColumn get baselineHr => integer().nullable()();
  IntColumn get baselineSys => integer().nullable()();
  IntColumn get baselineDia => integer().nullable()();
  IntColumn get hr1 => integer().nullable()();
  IntColumn get sys1 => integer().nullable()();
  IntColumn get dia1 => integer().nullable()();
  IntColumn get hr3 => integer().nullable()();
  IntColumn get sys3 => integer().nullable()();
  IntColumn get dia3 => integer().nullable()();
  IntColumn get hr10 => integer().nullable()();
  IntColumn get sys10 => integer().nullable()();
  IntColumn get dia10 => integer().nullable()();

  /// JSON list of symptom keys felt while standing.
  TextColumn get symptoms => text().withDefault(const Constant('[]'))();

  /// True when "Stop test" ended it before 10 minutes.
  BoolColumn get stoppedEarly => boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Sweating as the person describes it: one row per day. Sweat glands are
/// driven by the sympathetic side only, so this is a self-reported
/// sympathetic (sudomotor) signal — not a skin-conductance measurement.
class SweatLogs extends Table with SyncColumns {
  TextColumn get id => text()();

  /// yyyy-MM-dd, one row per day.
  TextColumn get date => text().unique()();

  /// JSON list of [SweatKind] names.
  TextColumn get kinds => text().withDefault(const Constant('[]'))();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Blood pressure typed in from a home cuff, any time — separate from the
/// stand test. Resting pressure mixes both autonomic sides, so it's shown
/// as its own line against the person's usual, never as a verdict.
class BloodPressureReadings extends Table with SyncColumns {
  TextColumn get id => text()();

  /// yyyy-MM-dd.
  TextColumn get date => text()();

  /// ISO time of the reading.
  TextColumn get takenAt => text()();
  IntColumn get systolic => integer()();
  IntColumn get diastolic => integer()();

  /// The cuff's pulse reading, if it gave one.
  IntColumn get pulse => integer().nullable()();

  /// 'sitting', 'lying' or 'standing'.
  TextColumn get position => text().withDefault(const Constant('sitting'))();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
