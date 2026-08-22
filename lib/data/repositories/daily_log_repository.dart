import 'dart:convert';

import 'package:drift/drift.dart';

import '../../core/constants/enums.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/id_gen.dart';
import '../../domain/models/daily_log.dart';
import '../db/app_database.dart' as db;

class DailyLogRepository {
  DailyLogRepository(this._db);

  final db.AppDatabase _db;

  DailyLog _toDomain(db.DailyLog row) {
    final braces = (jsonDecode(row.bracesUsed) as List)
        .map((e) => BraceType.fromDb(e as String))
        .whereType<BraceType>()
        .toList();
    return DailyLog(
      id: row.id,
      date: row.date,
      weightKg: row.weightKg,
      heightCm: row.heightCm,
      fatPercentage: row.fatPercentage,
      waterMlRaw: row.waterMlRaw,
      waterMlCredit: row.waterMlCredit,
      proteinG: row.proteinG,
      creatineG: row.creatineG,
      mentalState: MentalState.fromDb(row.mentalState),
      bodyFeeling: BodyFeeling.fromDb(row.bodyFeeling),
      bracesUsed: braces,
      braceComfort: row.braceComfort,
      steps: row.steps,
      isRestDay: row.isRestDay,
      isFlareDay: row.isFlareDay,
    );
  }

  Stream<DailyLog> watchDailyLog(String date) {
    final query = _db.select(_db.dailyLogs)..where((t) => t.date.equals(date));
    return query.watchSingleOrNull().asyncMap((row) async {
      if (row != null) return _toDomain(row);
      return getOrCreateDailyLog(date);
    });
  }

  Future<DailyLog> getOrCreateDailyLog(String date) async {
    final existing = await (_db.select(_db.dailyLogs)..where((t) => t.date.equals(date)))
        .getSingleOrNull();
    if (existing != null) return _toDomain(existing);

    final row = db.DailyLogsCompanion.insert(
      id: newId(),
      date: date,
      updatedAt: nowIso(),
    );
    await _db.into(_db.dailyLogs).insert(row, mode: InsertMode.insertOrIgnore);
    final created =
        await (_db.select(_db.dailyLogs)..where((t) => t.date.equals(date))).getSingle();
    return _toDomain(created);
  }

  Future<void> upsertDailyLog(DailyLog log) async {
    await _db.into(_db.dailyLogs).insertOnConflictUpdate(
          db.DailyLogsCompanion(
            id: Value(log.id),
            date: Value(log.date),
            weightKg: Value(log.weightKg),
            heightCm: Value(log.heightCm),
            fatPercentage: Value(log.fatPercentage),
            waterMlRaw: Value(log.waterMlRaw),
            waterMlCredit: Value(log.waterMlCredit),
            proteinG: Value(log.proteinG),
            creatineG: Value(log.creatineG),
            mentalState: Value(log.mentalState?.db),
            bodyFeeling: Value(log.bodyFeeling?.db),
            bracesUsed: Value(jsonEncode(log.bracesUsed.map((b) => b.db).toList())),
            braceComfort: Value(log.braceComfort),
            steps: Value(log.steps),
            isRestDay: Value(log.isRestDay),
            isFlareDay: Value(log.isFlareDay),
            updatedAt: Value(nowIso()),
          ),
        );
  }

  /// Rows in [date - lookbackDays, date), qualifying for the pacing baseline:
  /// steps > 0, not rest, not flare. Ordered most-recent-first, capped at
  /// sampleSize — mirrors app.py's get_weekly_average_steps exactly.
  Future<List<int>> getRecentQualifyingSteps(
    String beforeDate, {
    required int lookbackDays,
    required int maxRows,
  }) async {
    final start = dateKey(dateFromKey(beforeDate).subtract(Duration(days: lookbackDays)));
    final query = _db.select(_db.dailyLogs)
      ..where((t) =>
          t.date.isBiggerOrEqualValue(start) &
          t.date.isSmallerThanValue(beforeDate) &
          t.steps.isBiggerThanValue(0) &
          t.isRestDay.equals(false) &
          t.isFlareDay.equals(false))
      ..orderBy([(t) => OrderingTerm.desc(t.date)])
      ..limit(maxRows);
    final rows = await query.get();
    return rows.map((r) => r.steps).toList();
  }

  Future<DailyLog?> getLatestBodyMetrics(String beforeOrOnDate) async {
    final query = _db.select(_db.dailyLogs)
      ..where((t) =>
          t.date.isSmallerOrEqualValue(beforeOrOnDate) &
          (t.weightKg.isBiggerThanValue(0) |
              t.heightCm.isBiggerThanValue(0) |
              t.fatPercentage.isBiggerThanValue(0)))
      ..orderBy([(t) => OrderingTerm.desc(t.date)])
      ..limit(1);
    final row = await query.getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  /// All-time count of days that count as a "check-in" — mirrors
  /// app.py's get_total_checkins.
  Future<int> countTotalCheckins() async {
    final query = _db.select(_db.dailyLogs)
      ..where((t) =>
          t.waterMlCredit.isBiggerThanValue(0) |
          t.steps.isBiggerThanValue(0) |
          t.isRestDay.equals(true) |
          t.isFlareDay.equals(true));
    return (await query.get()).length;
  }

  Future<List<DailyLog>> getRange(String startDate, String endDate) async {
    final query = _db.select(_db.dailyLogs)
      ..where((t) => t.date.isBiggerOrEqualValue(startDate) & t.date.isSmallerOrEqualValue(endDate))
      ..orderBy([(t) => OrderingTerm.asc(t.date)]);
    final rows = await query.get();
    return rows.map(_toDomain).toList();
  }

  Future<List<DailyLog>> getAll() async {
    final rows = await (_db.select(_db.dailyLogs)
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
    return rows.map(_toDomain).toList();
  }
}
