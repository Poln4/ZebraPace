import 'package:drift/drift.dart';

import 'sync_columns.dart';

/// Injuries / structural events (from app2.py). Deliberately separate from
/// DailyLogs.isFlareDay: a flare is systemic/EDS-driven, an injury is a
/// discrete, localized, dateable event with its own healing timeline.
/// Zone/kind/type vocabulary mirrors ZebraUp's structuralHistory field so
/// the two apps speak the same language, even without syncing data.
class Injuries extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get dateStarted => text()();
  TextColumn get zone => text()();
  TextColumn get kind => text()();
  TextColumn get type => text()();
  TextColumn get note => text().withDefault(const Constant(''))();
  TextColumn get resolvedAt => text().nullable()();
  BoolColumn get stillPainful => boolean().nullable()();
  TextColumn get comparedToUsual => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
