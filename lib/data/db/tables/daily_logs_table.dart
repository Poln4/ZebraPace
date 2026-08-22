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

  IntColumn get proteinG => integer().withDefault(const Constant(0))();
  RealColumn get creatineG => real().withDefault(const Constant(0))();

  TextColumn get mentalState => text().nullable()();
  TextColumn get bodyFeeling => text().nullable()();

  /// JSON-encoded list of BraceType.db strings (app.py stored this as a
  /// Python str(list)/eval() pair — replaced with real JSON here).
  TextColumn get bracesUsed => text().withDefault(const Constant('[]'))();
  IntColumn get braceComfort => integer().nullable()();

  IntColumn get steps => integer().withDefault(const Constant(0))();
  BoolColumn get isRestDay => boolean().withDefault(const Constant(false))();
  BoolColumn get isFlareDay => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
