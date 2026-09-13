import 'package:drift/drift.dart';

import 'sync_columns.dart';

class Activities extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get activityName => text()();
  IntColumn get durationMin => integer()();
  RealColumn get extraWeightKg => real().withDefault(const Constant(0))();
  TextColumn get mentalState => text().nullable()();
  TextColumn get bodyFeeling => text().nullable()();

  /// 'manual' or 'healthkit' — see MetsService / HealthKit import flow (Phase 3).
  TextColumn get source => text().withDefault(const Constant('manual'))();

  /// HKWorkout UUID, when imported from HealthKit. Unique so re-scanning
  /// HealthKit never double-imports the same workout.
  TextColumn get healthkitUuid => text().nullable().unique()();
  RealColumn get metsAvg => real().nullable()();
  RealColumn get activeEnergyKcal => real().nullable()();

  /// Heart rate range (bpm) during the activity — manually entered, or
  /// pulled from HealthKit's HEART_RATE samples within the workout's time
  /// window when imported. Mirrors DailyLogs' sleepHeartRateMin/Max.
  IntColumn get heartRateMinBpm => integer().nullable()();
  IntColumn get heartRateMaxBpm => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
