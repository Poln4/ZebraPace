import 'package:drift/drift.dart';

import 'sync_columns.dart';

class Calisthenics extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get exercise => text()();
  TextColumn get progression => text()();
  IntColumn get sets => integer()();
  IntColumn get reps => integer()();

  /// 1.0-5.0 comfort slider value — the only comfort field that matters.
  /// app.py's original also had a dead/unused legacy `comfortable` boolean
  /// column; deliberately not ported.
  RealColumn get comfortScore => real().withDefault(const Constant(0))();

  TextColumn get mentalState => text().nullable()();
  TextColumn get bodyFeeling => text().nullable()();
  TextColumn get contractionMode => text().nullable()();

  /// Heart rate range (bpm) during the set — manually entered. Mirrors
  /// DailyLogs' sleepHeartRateMin/Max and Activities' heartRateMin/MaxBpm.
  IntColumn get heartRateMinBpm => integer().nullable()();
  IntColumn get heartRateMaxBpm => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
