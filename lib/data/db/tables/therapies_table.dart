import 'package:drift/drift.dart';

import 'sync_columns.dart';

class Therapies extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get therapyName => text()();
  IntColumn get durationMin => integer()();
  TextColumn get mentalState => text().nullable()();
  TextColumn get bodyFeeling => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
