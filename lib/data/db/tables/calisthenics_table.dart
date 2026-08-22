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

  @override
  Set<Column> get primaryKey => {id};
}
