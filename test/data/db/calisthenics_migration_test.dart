import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/data/repositories/calisthenics_repository.dart';

void main() {
  test('v6 -> v7 keeps existing calisthenics rows, read as sets × reps', () async {
    // Only the calisthenics table matters here: from == 6 skips every
    // earlier migration step, and v7 only touches this table.
    final db = AppDatabase(NativeDatabase.memory(setup: (raw) {
      raw.execute('''
        CREATE TABLE calisthenics (
          id TEXT NOT NULL PRIMARY KEY, date TEXT NOT NULL, exercise TEXT NOT NULL,
          progression TEXT NOT NULL, sets INTEGER NOT NULL, reps INTEGER NOT NULL,
          comfort_score REAL NOT NULL DEFAULT 0, mental_state TEXT, body_feeling TEXT,
          contraction_mode TEXT, heart_rate_min_bpm INTEGER, heart_rate_max_bpm INTEGER,
          updated_at TEXT NOT NULL, deleted_at INTEGER)''');
      raw.execute("INSERT INTO calisthenics (id, date, exercise, progression, sets, reps, "
          "updated_at) VALUES ('old', '2026-01-01', 'squats', 'Half Squats', 2, 50, 'x')");
      raw.execute('PRAGMA user_version = 6');
    }));
    addTearDown(db.close);

    final row = (await CalisthenicsRepository(db).getRange('2026-01-01', '2026-01-01')).single;
    expect(row.exercise, CalisthenicsExercise.squats);
    expect(row.setValues, [50, 50]);
    expect(row.unit, SetUnit.reps);
  });
}
