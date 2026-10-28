import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/data/db/app_database.dart';

import 'generated_migrations/schema.dart';

/// Every shipped schema (drift_schemas/, dumped from the commit where each
/// version was last current) must upgrade to exactly the schema the current
/// code expects. When bumping schemaVersion:
///   dart run drift_dev schema dump lib/data/db/app_database.dart drift_schemas/drift_schema_vN.json
///   dart run drift_dev schema generate drift_schemas/ test/data/db/generated_migrations/
void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late SchemaVerifier verifier;
  setUpAll(() => verifier = SchemaVerifier(GeneratedHelper()));

  // Never opened, so this builds no database — it only reads the constant.
  final latest = AppDatabase(NativeDatabase.memory()).schemaVersion;

  for (var from = 1; from < latest; from++) {
    test('v$from -> v$latest matches the current schema', () async {
      final db = AppDatabase(await verifier.startAt(from));
      addTearDown(db.close);
      await verifier.migrateAndValidate(db, latest);
    });
  }

  test('v1 -> latest keeps daily logs and marks their values as typed', () async {
    final schema = await verifier.schemaAt(1);
    schema.rawDatabase.execute(
        "INSERT INTO daily_logs (id, date, steps, protein_g, updated_at) "
        "VALUES ('a', '2026-08-01', 4200, 55, '2026-08-01T00:00:00.000')");

    final db = AppDatabase(schema.newConnection());
    addTearDown(db.close);
    await verifier.migrateAndValidate(db, latest);

    final row = await db
        .customSelect("SELECT steps, protein_g, steps_source FROM daily_logs WHERE id = 'a'")
        .getSingle();
    expect(row.read<int>('steps'), 4200);
    expect(row.read<double>('protein_g'), 55);
    expect(row.read<String>('steps_source'), 'manual');
  });
}
