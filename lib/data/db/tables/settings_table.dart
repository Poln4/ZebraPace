import 'package:drift/drift.dart';

/// Flexible key/value store — kept loose (not strongly typed rows) so new
/// settings can be added without a migration, matching app.py's approach.
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  TextColumn get updatedAt => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {key};
}
