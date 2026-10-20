import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/activities_table.dart';
import 'tables/calisthenics_table.dart';
import 'tables/checkins_table.dart';
import 'tables/daily_logs_table.dart';
import 'tables/injuries_table.dart';
import 'tables/liquid_logs_table.dart';
import 'tables/settings_table.dart';
import 'tables/soreness_checks_table.dart';
import 'tables/therapies_table.dart';
import 'tables/weather_cache_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    DailyLogs,
    Activities,
    Calisthenics,
    Therapies,
    LiquidLogs,
    Settings,
    WeatherCache,
    SorenessChecks,
    Checkins,
    Injuries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          // v1 -> v2: sleep tracking columns on DailyLogs. This app's first
          // real migration — every table before this only ever shipped via
          // onCreate.
          if (from < 2) {
            await m.addColumn(dailyLogs, dailyLogs.sleepHours);
            await m.addColumn(dailyLogs, dailyLogs.sleepQuality);
            await m.addColumn(dailyLogs, dailyLogs.sleepHeartRateMin);
            await m.addColumn(dailyLogs, dailyLogs.sleepHeartRateMax);
          }
          // v2 -> v3: heart rate range on Activities and Calisthenics, for
          // deeper exertion insights beyond sleeping HR.
          if (from < 3) {
            await m.addColumn(activities, activities.heartRateMinBpm);
            await m.addColumn(activities, activities.heartRateMaxBpm);
            await m.addColumn(calisthenics, calisthenics.heartRateMinBpm);
            await m.addColumn(calisthenics, calisthenics.heartRateMaxBpm);
          }
          // v3 -> v4: DailyLogs.proteinG widened from whole grams to decimal
          // grams (same shape as creatineG already had). SQLite has no
          // ALTER COLUMN, so this recreates the table against the current
          // Dart schema and copies existing rows across — alterTable, not
          // addColumn, since proteinG already exists.
          // The rebuild uses the current schema, so columns added after v4
          // have to be declared as new here or the copy looks for them in
          // the old table.
          if (from < 4) {
            await m.alterTable(TableMigration(
              dailyLogs,
              newColumns: [
                dailyLogs.restingHeartRate,
                dailyLogs.hrvMs,
                dailyLogs.stepsSource,
                dailyLogs.sleepSource,
                dailyLogs.heartSource,
              ],
            ));
          }
          // v4 -> v5: manual/pre-filled resting HR and HRV. A pre-v4 install
          // already got them from the rebuild above.
          if (from == 4) {
            await m.addColumn(dailyLogs, dailyLogs.restingHeartRate);
            await m.addColumn(dailyLogs, dailyLogs.hrvMs);
          }
          // v5 -> v6: where Health-backed values came from (auto-sync).
          // Existing values count as manual so a first sync never replaces
          // something the person already entered.
          if (from >= 4 && from < 6) {
            await m.addColumn(dailyLogs, dailyLogs.stepsSource);
            await m.addColumn(dailyLogs, dailyLogs.sleepSource);
            await m.addColumn(dailyLogs, dailyLogs.heartSource);
          }
          if (from < 6) {
            await customStatement(
                "UPDATE daily_logs SET steps_source = 'manual' WHERE steps > 0");
            await customStatement("UPDATE daily_logs SET sleep_source = 'manual' "
                'WHERE sleep_hours IS NOT NULL OR sleep_heart_rate_min IS NOT NULL '
                'OR sleep_heart_rate_max IS NOT NULL');
            await customStatement("UPDATE daily_logs SET heart_source = 'manual' "
                'WHERE resting_heart_rate IS NOT NULL OR hrv_ms IS NOT NULL');
          }
          // v6 -> v7: per-set values (sets can differ) and a reps/seconds
          // unit for isometric holds. Older rows keep setValues null and
          // read as sets × reps.
          if (from < 7) {
            await m.addColumn(calisthenics, calisthenics.setValues);
            await m.addColumn(calisthenics, calisthenics.unit);
          }
        },
      );

  static QueryExecutor _openConnection() {
    // Full schema (incl. app2's checkins/injuries) ships in v1 via onCreate —
    // no need to replay app.py's incremental ALTER TABLE migration history.
    //
    // The `web` option is ignored on native platforms and vice versa —
    // driftDatabase() picks the right backend per-platform automatically.
    // sqlite3.wasm and drift_worker.js live in web/ (drift_worker.js is
    // compiled from tool/drift_worker.dart via `dart compile js`; re-run
    // that after bumping the drift package version). Storage on web is
    // IndexedDB/OPFS in the browser — private to that browser profile, not
    // synced anywhere, matching the app's local-only data philosophy.
    return driftDatabase(
      name: 'zebra_data',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }
}
