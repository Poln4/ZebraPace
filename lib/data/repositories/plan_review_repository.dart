import 'package:drift/drift.dart';

import '../../core/utils/date_utils.dart';
import '../../core/utils/id_gen.dart';
import '../../domain/models/training_plan.dart';
import '../db/app_database.dart' as db;

/// The Plan tab's review side: Sunday check-ins, baseline tests and the
/// graded-exposure fear list.
class PlanReviewRepository {
  PlanReviewRepository(this._db);

  final db.AppDatabase _db;

  // --- Check-ins ---

  PlanCheckin _checkin(db.PlanCheckin r) => PlanCheckin(
        id: r.id,
        planId: r.planId,
        weekStart: r.weekStart,
        sessionsDone: r.sessionsDone,
        sessionsPlanned: r.sessionsPlanned,
        hadPem: r.hadPem,
        pemCause: r.pemCause,
        jointsOk: r.jointsOk,
        proteinDays: r.proteinDays,
        weightKg: r.weightKg,
        win: r.win,
        fearStep: r.fearStep,
        decision: CheckinDecision.fromDb(r.decision),
        ceilingBefore: r.ceilingBefore,
        ceilingAfter: r.ceilingAfter,
      );

  Stream<List<PlanCheckin>> watchCheckins(String planId) {
    final q = _db.select(_db.planCheckins)
      ..where((t) => t.planId.equals(planId))
      ..orderBy([(t) => OrderingTerm.desc(t.weekStart)]);
    return q.watch().map((rows) => rows.map(_checkin).toList());
  }

  /// Saves the check-in (one per week — saving again replaces it) and sets
  /// the plan's ceiling to the decided value.
  Future<void> saveCheckin(PlanCheckin c) async {
    await _db.transaction(() async {
      await (_db.delete(_db.planCheckins)
            ..where((t) => t.planId.equals(c.planId) & t.weekStart.equals(c.weekStart)))
          .go();
      await _db.into(_db.planCheckins).insert(db.PlanCheckinsCompanion.insert(
            id: c.id,
            planId: c.planId,
            weekStart: c.weekStart,
            sessionsDone: Value(c.sessionsDone),
            sessionsPlanned: Value(c.sessionsPlanned),
            hadPem: Value(c.hadPem),
            pemCause: Value(c.pemCause),
            jointsOk: Value(c.jointsOk),
            proteinDays: Value(c.proteinDays),
            weightKg: Value(c.weightKg),
            win: Value(c.win),
            fearStep: Value(c.fearStep),
            decision: c.decision.db,
            ceilingBefore: Value(c.ceilingBefore),
            ceilingAfter: Value(c.ceilingAfter),
            updatedAt: nowIso(),
          ));
      if (c.ceilingAfter != null) {
        await (_db.update(_db.trainingPlans)..where((t) => t.id.equals(c.planId))).write(
          db.TrainingPlansCompanion(
              weeklyCeilingMin: Value(c.ceilingAfter), updatedAt: Value(nowIso())),
        );
      }
    });
  }

  Future<void> deleteCheckin(String id) async {
    await (_db.delete(_db.planCheckins)..where((t) => t.id.equals(id))).go();
  }

  // --- Baseline tests ---

  PlanTest _test(db.PlanTest r) =>
      PlanTest(id: r.id, planId: r.planId, position: r.position, name: r.name, unit: r.unit);

  PlanTestResult _result(db.PlanTestResult r) =>
      PlanTestResult(id: r.id, testId: r.testId, date: r.date, value: r.value, note: r.note);

  Stream<List<PlanTest>> watchTests(String planId) {
    final q = _db.select(_db.planTests)
      ..where((t) => t.planId.equals(planId))
      ..orderBy([(t) => OrderingTerm.asc(t.position)]);
    return q.watch().map((rows) => rows.map(_test).toList());
  }

  Future<void> saveTest(PlanTest test) async {
    await _db.into(_db.planTests).insertOnConflictUpdate(db.PlanTestsCompanion.insert(
          id: test.id,
          planId: test.planId,
          position: test.position,
          name: test.name,
          unit: Value(test.unit),
          updatedAt: nowIso(),
        ));
  }

  Future<void> deleteTest(String testId) async {
    await _db.transaction(() async {
      await (_db.delete(_db.planTestResults)..where((t) => t.testId.equals(testId))).go();
      await (_db.delete(_db.planTests)..where((t) => t.id.equals(testId))).go();
    });
  }

  /// Every result of the plan's tests, oldest first.
  Stream<List<PlanTestResult>> watchResults(String planId) {
    final q = _db.select(_db.planTestResults).join([
      innerJoin(_db.planTests, _db.planTests.id.equalsExp(_db.planTestResults.testId)),
    ])
      ..where(_db.planTests.planId.equals(planId))
      ..orderBy([OrderingTerm.asc(_db.planTestResults.date)]);
    return q.watch().map((rows) => rows.map((r) => _result(r.readTable(_db.planTestResults))).toList());
  }

  Future<void> addResult({
    required String testId,
    required String date,
    required double value,
    String? note,
  }) async {
    await _db.into(_db.planTestResults).insert(db.PlanTestResultsCompanion.insert(
          id: newId(),
          testId: testId,
          date: date,
          value: value,
          note: Value(note),
          updatedAt: nowIso(),
        ));
  }

  Future<void> deleteResult(String id) async {
    await (_db.delete(_db.planTestResults)..where((t) => t.id.equals(id))).go();
  }

  // --- Fear list & exposure ---

  FearItem _fear(db.FearItem r) => FearItem(
        id: r.id,
        name: r.name,
        fear: r.fear,
        initialFear: r.initialFear,
        settledOn: r.settledOn,
      );

  ExposureLog _exposure(db.ExposureLog r) => ExposureLog(
        id: r.id,
        fearItemId: r.fearItemId,
        date: r.date,
        attempt: r.attempt,
        prediction: r.prediction,
        outcome: r.outcome,
        fearBefore: r.fearBefore,
        fearAfter: r.fearAfter,
        nothingBad: r.nothingBad,
      );

  /// Least feared first — the order the ladder is climbed in.
  Stream<List<FearItem>> watchFearItems() {
    final q = _db.select(_db.fearItems)
      ..orderBy([(t) => OrderingTerm.asc(t.fear), (t) => OrderingTerm.asc(t.name)]);
    return q.watch().map((rows) => rows.map(_fear).toList());
  }

  Future<void> addFearItem(String name, int fear) async {
    await _db.into(_db.fearItems).insert(db.FearItemsCompanion.insert(
          id: newId(),
          name: name,
          fear: fear,
          initialFear: fear,
          updatedAt: nowIso(),
        ));
  }

  Future<void> updateFearItem(FearItem item) async {
    await (_db.update(_db.fearItems)..where((t) => t.id.equals(item.id))).write(
      db.FearItemsCompanion(
        name: Value(item.name),
        fear: Value(item.fear),
        settledOn: Value(item.settledOn),
        updatedAt: Value(nowIso()),
      ),
    );
  }

  Future<void> deleteFearItem(String id) async {
    await _db.transaction(() async {
      await (_db.delete(_db.exposureLogs)..where((t) => t.fearItemId.equals(id))).go();
      await (_db.delete(_db.fearItems)..where((t) => t.id.equals(id))).go();
    });
  }

  /// Newest first.
  Stream<List<ExposureLog>> watchExposures() {
    final q = _db.select(_db.exposureLogs)..orderBy([(t) => OrderingTerm.desc(t.date)]);
    return q.watch().map((rows) => rows.map(_exposure).toList());
  }

  /// Logs a try; the item's fear rating follows the "after" rating if given.
  Future<void> addExposure(ExposureLog log) async {
    await _db.transaction(() async {
      await _db.into(_db.exposureLogs).insert(db.ExposureLogsCompanion.insert(
            id: log.id,
            fearItemId: log.fearItemId,
            date: log.date,
            attempt: Value(log.attempt),
            prediction: Value(log.prediction),
            outcome: Value(log.outcome),
            fearBefore: Value(log.fearBefore),
            fearAfter: Value(log.fearAfter),
            nothingBad: Value(log.nothingBad),
            updatedAt: nowIso(),
          ));
      if (log.fearAfter != null) {
        await (_db.update(_db.fearItems)..where((t) => t.id.equals(log.fearItemId))).write(
          db.FearItemsCompanion(fear: Value(log.fearAfter!), updatedAt: Value(nowIso())),
        );
      }
    });
  }

  Future<void> deleteExposure(String id) async {
    await (_db.delete(_db.exposureLogs)..where((t) => t.id.equals(id))).go();
  }
}
