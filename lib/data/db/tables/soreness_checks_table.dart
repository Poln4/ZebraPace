import 'package:drift/drift.dart';

import 'sync_columns.dart';

class SorenessChecks extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get onset => text()();
  TextColumn get spread => text()();
  TextColumn get trend => text()();
  TextColumn get verdict => text()();
  TextColumn get verdictLabel => text()();

  @override
  Set<Column> get primaryKey => {id};
}
