import 'package:drift/drift.dart';

import 'sync_columns.dart';

class LiquidLogs extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get drinkType => text()();

  /// For DrinkType.other, the user's custom-typed label is stored here too
  /// (drinkType stays 'other' for factor lookup; this holds the free-text name).
  TextColumn get customDrinkLabel => text().nullable()();

  IntColumn get amountMlRaw => integer()();

  /// = amountMlRaw * DrinkType.hydrationFactor, computed at write time.
  RealColumn get hydrationMlCredit => real()();

  @override
  Set<Column> get primaryKey => {id};
}
