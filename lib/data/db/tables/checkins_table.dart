import 'package:drift/drift.dart';

import 'sync_columns.dart';

/// Intraday check-ins (from app2.py) — supplemental to DailyLogs'
/// mentalState/bodyFeeling, which stay the one official daily summary
/// everything else (baselines, PEM check, weather correlation) is built on.
/// Purely additive: as many rows per day as the user wants.
class Checkins extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get loggedAt => text()(); // 'HH:mm', local time
  TextColumn get mentalState => text()();
  TextColumn get bodyFeeling => text()();
  TextColumn get note => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}
