import 'package:drift/drift.dart';

import '../../core/constants/defaults.dart';
import '../../core/utils/date_utils.dart';
import '../db/app_database.dart' as db;

class SettingsRepository {
  SettingsRepository(this._db);

  final db.AppDatabase _db;

  Stream<Map<String, String>> watchAll() {
    return _db.select(_db.settings).watch().map(
          (rows) => {for (final r in rows) r.key: r.value},
        );
  }

  Future<Map<String, String>> getAll() async {
    final rows = await _db.select(_db.settings).get();
    return {for (final r in rows) r.key: r.value};
  }

  Future<void> set(String key, String value) async {
    await _db.into(_db.settings).insertOnConflictUpdate(
          db.SettingsCompanion(
            key: Value(key),
            value: Value(value),
            updatedAt: Value(nowIso()),
          ),
        );
  }

  Future<double> getDouble(String key, double fallback) async {
    final row = await (_db.select(_db.settings)..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    if (row == null) return fallback;
    return double.tryParse(row.value) ?? fallback;
  }

  Future<int> getInt(String key, int fallback) async {
    final row = await (_db.select(_db.settings)..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    if (row == null) return fallback;
    return int.tryParse(row.value) ?? double.tryParse(row.value)?.toInt() ?? fallback;
  }

  Future<String> getString(String key, String fallback) async {
    final row = await (_db.select(_db.settings)..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value ?? fallback;
  }
}

class SettingsSnapshot {
  const SettingsSnapshot({
    required this.growthGoalPct,
    required this.cautionPct,
    required this.comfortThreshold,
    required this.waterGoalMl,
    required this.proteinGoalG,
    required this.sleepGoalHours,
    required this.locationName,
    required this.locationLat,
    required this.locationLon,
  });

  factory SettingsSnapshot.fromMap(Map<String, String> map) {
    double d(String key, double fallback) =>
        double.tryParse(map[key] ?? '') ?? fallback;
    int i(String key, int fallback) => int.tryParse(map[key] ?? '') ?? fallback;
    return SettingsSnapshot(
      growthGoalPct: d(SettingsKeys.growthGoalPct, DefaultSettings.growthGoalPct),
      cautionPct: d(SettingsKeys.cautionPct, DefaultSettings.cautionPct),
      comfortThreshold: d(SettingsKeys.comfortThreshold, DefaultSettings.comfortThreshold),
      waterGoalMl: i(SettingsKeys.waterGoalMl, DefaultSettings.waterGoalMl),
      proteinGoalG: i(SettingsKeys.proteinGoalG, DefaultSettings.proteinGoalG),
      sleepGoalHours: d(SettingsKeys.sleepGoalHours, DefaultSettings.sleepGoalHours),
      locationName: map[SettingsKeys.locationName] ?? '',
      locationLat: double.tryParse(map[SettingsKeys.locationLat] ?? ''),
      locationLon: double.tryParse(map[SettingsKeys.locationLon] ?? ''),
    );
  }

  final double growthGoalPct;
  final double cautionPct;
  final double comfortThreshold;
  final int waterGoalMl;
  final int proteinGoalG;
  final double sleepGoalHours;
  final String locationName;
  final double? locationLat;
  final double? locationLon;

  bool get hasLocation => locationLat != null && locationLon != null;
}
