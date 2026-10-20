import 'dart:convert';

import 'package:drift/drift.dart';

import '../../core/constants/enums.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/id_gen.dart';
import '../../domain/models/calisthenics_set.dart';
import '../db/app_database.dart' as db;

class CalisthenicsRepository {
  CalisthenicsRepository(this._db);

  final db.AppDatabase _db;

  CalisthenicsSet _toDomain(db.Calisthenic row) {
    return CalisthenicsSet(
      id: row.id,
      date: row.date,
      exercise: CalisthenicsExercise.fromDb(row.exercise) ?? CalisthenicsExercise.pushups,
      progression: row.progression,
      setValues: _setValuesOf(row),
      unit: SetUnit.fromDb(row.unit),
      comfortScore: row.comfortScore,
      mentalState: MentalState.fromDb(row.mentalState),
      bodyFeeling: BodyFeeling.fromDb(row.bodyFeeling),
      contractionMode: ContractionMode.fromDb(row.contractionMode),
      heartRateMinBpm: row.heartRateMinBpm,
      heartRateMaxBpm: row.heartRateMaxBpm,
    );
  }

  /// Pre-v7 rows (and malformed JSON) fall back to `sets` × `reps`.
  static List<int> _setValuesOf(db.Calisthenic row) {
    final raw = row.setValues;
    if (raw != null) {
      try {
        return (jsonDecode(raw) as List).map((v) => (v as num).toInt()).toList();
      } on Object {
        // fall through to the legacy columns
      }
    }
    return List.filled(row.sets, row.reps);
  }

  Stream<List<CalisthenicsSet>> watchForDate(String date) {
    final query = _db.select(_db.calisthenics)..where((t) => t.date.equals(date));
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  Stream<List<CalisthenicsSet>> watchRecent({int limit = 10}) {
    final query = _db.select(_db.calisthenics)
      ..orderBy([(t) => OrderingTerm.desc(t.date)])
      ..limit(limit);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  Future<List<CalisthenicsSet>> getRange(String startDate, String endDate) async {
    final query = _db.select(_db.calisthenics)
      ..where((t) => t.date.isBiggerOrEqualValue(startDate) & t.date.isSmallerOrEqualValue(endDate));
    final rows = await query.get();
    return rows.map(_toDomain).toList();
  }

  /// Most recent 3 rows for this exercise, on/before targetDate — used by
  /// CalisthenicsService.checkComfortMilestone. Mirrors app.py's query exactly:
  /// ORDER BY date DESC LIMIT 3 (not "most recent 3 calendar days").
  Future<List<double>> getLastThreeComfortScores(String exercise, String targetDate) async {
    final query = _db.select(_db.calisthenics)
      ..where((t) => t.exercise.equals(exercise) & t.date.isSmallerOrEqualValue(targetDate))
      ..orderBy([(t) => OrderingTerm.desc(t.date)])
      ..limit(3);
    final rows = await query.get();
    return rows.map((r) => r.comfortScore).toList();
  }

  /// Same scoping as [getLastThreeComfortScores] (by exercise only, not
  /// progression tier — the stored `progression` is localized display text,
  /// not a stable key) — used by CalisthenicsService.checkGoalMilestone.
  Future<List<(List<int> setValues, SetUnit unit)>> getLastThreeSetValues(
      String exercise, String targetDate) async {
    final query = _db.select(_db.calisthenics)
      ..where((t) => t.exercise.equals(exercise) & t.date.isSmallerOrEqualValue(targetDate))
      ..orderBy([(t) => OrderingTerm.desc(t.date)])
      ..limit(3);
    final rows = await query.get();
    return rows.map((r) => (_setValuesOf(r), SetUnit.fromDb(r.unit))).toList();
  }

  Future<void> insert({
    required String date,
    required CalisthenicsExercise exercise,
    required String progression,
    required List<int> setValues,
    SetUnit unit = SetUnit.reps,
    required double comfortScore,
    MentalState? mentalState,
    BodyFeeling? bodyFeeling,
    ContractionMode? contractionMode,
    int? heartRateMinBpm,
    int? heartRateMaxBpm,
  }) async {
    await _db.into(_db.calisthenics).insert(
          db.CalisthenicsCompanion.insert(
            id: newId(),
            date: date,
            exercise: exercise.db,
            progression: progression,
            sets: setValues.length,
            reps: _best(setValues),
            setValues: Value(jsonEncode(setValues)),
            unit: Value(unit.db),
            comfortScore: Value(comfortScore),
            mentalState: Value(mentalState?.db),
            bodyFeeling: Value(bodyFeeling?.db),
            contractionMode: Value(contractionMode?.db),
            heartRateMinBpm: Value(heartRateMinBpm),
            heartRateMaxBpm: Value(heartRateMaxBpm),
            updatedAt: nowIso(),
          ),
        );
  }

  /// Editable fields only — exercise/progression stay fixed after creation
  /// (progression is localized display text tied to the exercise's tier
  /// list, not a stable key; if the wrong exercise was logged, deleting and
  /// re-adding is simpler than reworking that binding).
  Future<void> update({
    required String id,
    required List<int> setValues,
    required SetUnit unit,
    required double comfortScore,
    MentalState? mentalState,
    BodyFeeling? bodyFeeling,
    ContractionMode? contractionMode,
    int? heartRateMinBpm,
    int? heartRateMaxBpm,
  }) async {
    await (_db.update(_db.calisthenics)..where((t) => t.id.equals(id))).write(
      db.CalisthenicsCompanion(
        sets: Value(setValues.length),
        reps: Value(_best(setValues)),
        setValues: Value(jsonEncode(setValues)),
        unit: Value(unit.db),
        comfortScore: Value(comfortScore),
        mentalState: Value(mentalState?.db),
        bodyFeeling: Value(bodyFeeling?.db),
        contractionMode: Value(contractionMode?.db),
        heartRateMinBpm: Value(heartRateMinBpm),
        heartRateMaxBpm: Value(heartRateMaxBpm),
        updatedAt: Value(nowIso()),
      ),
    );
  }

  static int _best(List<int> values) =>
      values.isEmpty ? 0 : values.reduce((a, b) => a > b ? a : b);

  Future<void> delete(String id) async {
    await (_db.delete(_db.calisthenics)..where((t) => t.id.equals(id))).go();
  }
}
