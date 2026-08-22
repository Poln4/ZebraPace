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
  int get schemaVersion => 1;

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
