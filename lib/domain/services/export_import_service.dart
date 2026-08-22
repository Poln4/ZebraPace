import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:drift/drift.dart';

import '../../core/utils/date_utils.dart';
import '../../data/db/app_database.dart' as db;

/// Ported from app.py's export_all_data/import_all_data/delete_all_data.
/// Unlike the original (autoincrement int PKs, vulnerable to import-merge ID
/// collisions across databases), every table here already uses UUID ids —
/// see the plan's data-layer notes — so merge-import is collision-safe by
/// construction; no INSERT OR IGNORE special-casing needed for that reason,
/// though it's still used so re-importing the same export stays idempotent.
class ExportImportService {
  ExportImportService(this._db);

  final db.AppDatabase _db;

  static const _tables = [
    'daily_logs',
    'activities',
    'calisthenics',
    'therapies',
    'liquid_logs',
    'settings',
    'weather_cache',
    'soreness_checks',
    'checkins',
    'injuries',
  ];

  Future<String> exportAllDataJson() async {
    final tables = <String, List<Map<String, dynamic>>>{};
    tables['daily_logs'] = (await _db.select(_db.dailyLogs).get()).map((r) => r.toJson()).toList();
    tables['activities'] = (await _db.select(_db.activities).get()).map((r) => r.toJson()).toList();
    tables['calisthenics'] =
        (await _db.select(_db.calisthenics).get()).map((r) => r.toJson()).toList();
    tables['therapies'] = (await _db.select(_db.therapies).get()).map((r) => r.toJson()).toList();
    tables['liquid_logs'] =
        (await _db.select(_db.liquidLogs).get()).map((r) => r.toJson()).toList();
    tables['settings'] = (await _db.select(_db.settings).get()).map((r) => r.toJson()).toList();
    tables['weather_cache'] =
        (await _db.select(_db.weatherCache).get()).map((r) => r.toJson()).toList();
    tables['soreness_checks'] =
        (await _db.select(_db.sorenessChecks).get()).map((r) => r.toJson()).toList();
    tables['checkins'] = (await _db.select(_db.checkins).get()).map((r) => r.toJson()).toList();
    tables['injuries'] = (await _db.select(_db.injuries).get()).map((r) => r.toJson()).toList();

    final payload = {'exported_at': nowIso(), 'tables': tables};
    return const JsonEncoder.withIndent('  ').convert(payload);
  }

  /// mode='merge' inserts/ignores existing rows; mode='replace' wipes each
  /// table first. Rows for tables not in `_tables`, or malformed, are
  /// silently skipped — same tolerant behavior as the Python original.
  Future<void> importAllDataJson(String jsonPayload, {required bool replace}) async {
    final decoded = jsonDecode(jsonPayload) as Map<String, dynamic>;
    final tables = decoded['tables'] as Map<String, dynamic>? ?? {};

    await _db.transaction(() async {
      for (final tableName in _tables) {
        final rows = tables[tableName] as List<dynamic>?;
        if (rows == null || rows.isEmpty) continue;

        if (replace) await _clearTable(tableName);

        for (final rawRow in rows) {
          final row = (rawRow as Map).cast<String, dynamic>();
          await _insertRow(tableName, row);
        }
      }
    });
  }

  Future<void> deleteAllDataExceptSettings() async {
    await _db.transaction(() async {
      await _db.delete(_db.dailyLogs).go();
      await _db.delete(_db.activities).go();
      await _db.delete(_db.calisthenics).go();
      await _db.delete(_db.therapies).go();
      await _db.delete(_db.liquidLogs).go();
      await _db.delete(_db.weatherCache).go();
      await _db.delete(_db.sorenessChecks).go();
      await _db.delete(_db.checkins).go();
      await _db.delete(_db.injuries).go();
    });
  }

  /// CSV export of the FULL, unfiltered daily_logs history — deliberately a
  /// separate export path from the ranged doctor PDF, matching the original
  /// (easy to conflate as "the same export" if built as one path).
  Future<String> exportDailyLogsCsv() async {
    final rows = await (_db.select(_db.dailyLogs)
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();
    final header = [
      'date', 'weight_kg', 'height_cm', 'fat_percentage', 'water_ml_raw', 'water_ml_credit',
      'protein_g', 'creatine_g', 'mental_state', 'body_feeling', 'braces_used', 'brace_comfort',
      'steps', 'is_rest_day', 'is_flare_day',
    ];
    final data = [
      header,
      for (final r in rows)
        [
          r.date, r.weightKg, r.heightCm, r.fatPercentage, r.waterMlRaw, r.waterMlCredit,
          r.proteinG, r.creatineG, r.mentalState, r.bodyFeeling, r.bracesUsed, r.braceComfort,
          r.steps, r.isRestDay, r.isFlareDay,
        ],
    ];
    return const ListToCsvConverter().convert(data);
  }

  Future<void> _clearTable(String tableName) async {
    switch (tableName) {
      case 'daily_logs':
        await _db.delete(_db.dailyLogs).go();
      case 'activities':
        await _db.delete(_db.activities).go();
      case 'calisthenics':
        await _db.delete(_db.calisthenics).go();
      case 'therapies':
        await _db.delete(_db.therapies).go();
      case 'liquid_logs':
        await _db.delete(_db.liquidLogs).go();
      case 'settings':
        await _db.delete(_db.settings).go();
      case 'weather_cache':
        await _db.delete(_db.weatherCache).go();
      case 'soreness_checks':
        await _db.delete(_db.sorenessChecks).go();
      case 'checkins':
        await _db.delete(_db.checkins).go();
      case 'injuries':
        await _db.delete(_db.injuries).go();
    }
  }

  Future<void> _insertRow(String tableName, Map<String, dynamic> row) async {
    try {
      switch (tableName) {
        case 'daily_logs':
          await _db.into(_db.dailyLogs).insert(
                db.DailyLogsCompanion.insert(
                  id: row['id'] as String,
                  date: row['date'] as String,
                  weightKg: Value(_toDouble(row['weightKg'])),
                  heightCm: Value(_toDouble(row['heightCm'])),
                  fatPercentage: Value(_toDouble(row['fatPercentage'])),
                  waterMlRaw: Value(_toInt(row['waterMlRaw']) ?? 0),
                  waterMlCredit: Value(_toDouble(row['waterMlCredit']) ?? 0),
                  proteinG: Value(_toInt(row['proteinG']) ?? 0),
                  creatineG: Value(_toDouble(row['creatineG']) ?? 0),
                  mentalState: Value(row['mentalState'] as String?),
                  bodyFeeling: Value(row['bodyFeeling'] as String?),
                  bracesUsed: Value(row['bracesUsed'] as String? ?? '[]'),
                  braceComfort: Value(_toInt(row['braceComfort'])),
                  steps: Value(_toInt(row['steps']) ?? 0),
                  isRestDay: Value(row['isRestDay'] as bool? ?? false),
                  isFlareDay: Value(row['isFlareDay'] as bool? ?? false),
                  updatedAt: row['updatedAt'] as String? ?? nowIso(),
                ),
                mode: InsertMode.insertOrIgnore,
              );
        case 'activities':
          await _db.into(_db.activities).insert(
                db.ActivitiesCompanion.insert(
                  id: row['id'] as String,
                  date: row['date'] as String,
                  activityName: row['activityName'] as String,
                  durationMin: _toInt(row['durationMin']) ?? 0,
                  extraWeightKg: Value(_toDouble(row['extraWeightKg']) ?? 0),
                  mentalState: Value(row['mentalState'] as String?),
                  bodyFeeling: Value(row['bodyFeeling'] as String?),
                  source: Value(row['source'] as String? ?? 'manual'),
                  healthkitUuid: Value(row['healthkitUuid'] as String?),
                  metsAvg: Value(_toDouble(row['metsAvg'])),
                  activeEnergyKcal: Value(_toDouble(row['activeEnergyKcal'])),
                  updatedAt: row['updatedAt'] as String? ?? nowIso(),
                ),
                mode: InsertMode.insertOrIgnore,
              );
        case 'calisthenics':
          await _db.into(_db.calisthenics).insert(
                db.CalisthenicsCompanion.insert(
                  id: row['id'] as String,
                  date: row['date'] as String,
                  exercise: row['exercise'] as String,
                  progression: row['progression'] as String,
                  sets: _toInt(row['sets']) ?? 0,
                  reps: _toInt(row['reps']) ?? 0,
                  comfortScore: Value(_toDouble(row['comfortScore']) ?? 0),
                  mentalState: Value(row['mentalState'] as String?),
                  bodyFeeling: Value(row['bodyFeeling'] as String?),
                  contractionMode: Value(row['contractionMode'] as String?),
                  updatedAt: row['updatedAt'] as String? ?? nowIso(),
                ),
                mode: InsertMode.insertOrIgnore,
              );
        case 'therapies':
          await _db.into(_db.therapies).insert(
                db.TherapiesCompanion.insert(
                  id: row['id'] as String,
                  date: row['date'] as String,
                  therapyName: row['therapyName'] as String,
                  durationMin: _toInt(row['durationMin']) ?? 0,
                  mentalState: Value(row['mentalState'] as String?),
                  bodyFeeling: Value(row['bodyFeeling'] as String?),
                  updatedAt: row['updatedAt'] as String? ?? nowIso(),
                ),
                mode: InsertMode.insertOrIgnore,
              );
        case 'liquid_logs':
          await _db.into(_db.liquidLogs).insert(
                db.LiquidLogsCompanion.insert(
                  id: row['id'] as String,
                  date: row['date'] as String,
                  drinkType: row['drinkType'] as String,
                  customDrinkLabel: Value(row['customDrinkLabel'] as String?),
                  amountMlRaw: _toInt(row['amountMlRaw']) ?? 0,
                  hydrationMlCredit: _toDouble(row['hydrationMlCredit']) ?? 0,
                  updatedAt: row['updatedAt'] as String? ?? nowIso(),
                ),
                mode: InsertMode.insertOrIgnore,
              );
        case 'settings':
          await _db.into(_db.settings).insert(
                db.SettingsCompanion.insert(
                  key: row['key'] as String,
                  value: row['value'] as String,
                  updatedAt: Value(row['updatedAt'] as String? ?? nowIso()),
                ),
                mode: InsertMode.insertOrIgnore,
              );
        case 'weather_cache':
          await _db.into(_db.weatherCache).insert(
                db.WeatherCacheCompanion.insert(
                  date: row['date'] as String,
                  lat: _toDouble(row['lat']) ?? 0,
                  lon: _toDouble(row['lon']) ?? 0,
                  tempC: Value(_toDouble(row['tempC'])),
                  humidityPct: Value(_toDouble(row['humidityPct'])),
                  pressureHpa: Value(_toDouble(row['pressureHpa'])),
                ),
                mode: InsertMode.insertOrIgnore,
              );
        case 'soreness_checks':
          await _db.into(_db.sorenessChecks).insert(
                db.SorenessChecksCompanion.insert(
                  id: row['id'] as String,
                  date: row['date'] as String,
                  onset: row['onset'] as String,
                  spread: row['spread'] as String,
                  trend: row['trend'] as String,
                  verdict: row['verdict'] as String,
                  verdictLabel: row['verdictLabel'] as String,
                  updatedAt: row['updatedAt'] as String? ?? nowIso(),
                ),
                mode: InsertMode.insertOrIgnore,
              );
        case 'checkins':
          await _db.into(_db.checkins).insert(
                db.CheckinsCompanion.insert(
                  id: row['id'] as String,
                  date: row['date'] as String,
                  loggedAt: row['loggedAt'] as String,
                  mentalState: row['mentalState'] as String,
                  bodyFeeling: row['bodyFeeling'] as String,
                  note: Value(row['note'] as String? ?? ''),
                  updatedAt: row['updatedAt'] as String? ?? nowIso(),
                ),
                mode: InsertMode.insertOrIgnore,
              );
        case 'injuries':
          await _db.into(_db.injuries).insert(
                db.InjuriesCompanion.insert(
                  id: row['id'] as String,
                  dateStarted: row['dateStarted'] as String,
                  zone: row['zone'] as String,
                  kind: row['kind'] as String,
                  type: row['type'] as String,
                  note: Value(row['note'] as String? ?? ''),
                  resolvedAt: Value(row['resolvedAt'] as String?),
                  stillPainful: Value(row['stillPainful'] as bool?),
                  comparedToUsual: Value(row['comparedToUsual'] as String?),
                  updatedAt: row['updatedAt'] as String? ?? nowIso(),
                ),
                mode: InsertMode.insertOrIgnore,
              );
      }
    } catch (_) {
      // Skip rows that don't match the current schema — same tolerance as
      // the Python original's `except sqlite3.OperationalError: pass`.
    }
  }

  double? _toDouble(dynamic v) => v == null ? null : (v as num).toDouble();
  int? _toInt(dynamic v) => v == null ? null : (v as num).toInt();
}
