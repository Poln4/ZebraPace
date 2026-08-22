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
      sets: row.sets,
      reps: row.reps,
      comfortScore: row.comfortScore,
      mentalState: MentalState.fromDb(row.mentalState),
      bodyFeeling: BodyFeeling.fromDb(row.bodyFeeling),
      contractionMode: ContractionMode.fromDb(row.contractionMode),
    );
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

  Future<void> insert({
    required String date,
    required CalisthenicsExercise exercise,
    required String progression,
    required int sets,
    required int reps,
    required double comfortScore,
    MentalState? mentalState,
    BodyFeeling? bodyFeeling,
    ContractionMode? contractionMode,
  }) async {
    await _db.into(_db.calisthenics).insert(
          db.CalisthenicsCompanion.insert(
            id: newId(),
            date: date,
            exercise: exercise.db,
            progression: progression,
            sets: sets,
            reps: reps,
            comfortScore: Value(comfortScore),
            mentalState: Value(mentalState?.db),
            bodyFeeling: Value(bodyFeeling?.db),
            contractionMode: Value(contractionMode?.db),
            updatedAt: nowIso(),
          ),
        );
  }
}
