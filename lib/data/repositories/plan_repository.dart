import 'dart:convert';

import 'package:drift/drift.dart';

import '../../core/constants/enums.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/id_gen.dart';
import '../../domain/models/training_plan.dart';
import '../db/app_database.dart' as db;

/// Everything behind the Plan tab: the plan's structure (edited in the plan
/// editor) and what was logged against it.
class PlanRepository {
  PlanRepository(this._db);

  final db.AppDatabase _db;

  // --- Mapping ---

  TrainingPlan _plan(db.TrainingPlan r) => TrainingPlan(
        id: r.id,
        name: r.name,
        startDate: r.startDate,
        weeks: r.weeks,
        weeklyCeilingMin: r.weeklyCeilingMin,
        floorNote: r.floorNote,
        currentPhaseId: r.currentPhaseId,
        testWeeks: r.testWeeks,
        isActive: r.isActive,
      );

  PlanPhase _phase(db.PlanPhase r) => PlanPhase(
        id: r.id,
        planId: r.planId,
        position: r.position,
        name: r.name,
        goal: r.goal,
        effort: r.effort,
        cardio: r.cardio,
        gate: r.gate,
      );

  PlanSession _session(db.PlanSession r) => PlanSession(
        id: r.id,
        planId: r.planId,
        position: r.position,
        name: r.name,
        weekday: r.weekday,
        durationMin: r.durationMin,
        lowDayNote: r.lowDayNote,
        isCardio: r.isCardio,
      );

  PlanExercise _exercise(db.PlanExercise r) => PlanExercise(
        id: r.id,
        sessionId: r.sessionId,
        position: r.position,
        name: r.name,
        cue: r.cue,
        currentStepId: r.currentStepId,
        stepChangedOn: r.stepChangedOn,
      );

  PlanStep _step(db.PlanStep r) => PlanStep(
        id: r.id,
        exerciseId: r.exerciseId,
        position: r.position,
        name: r.name,
        dose: r.dose,
        unit: SetUnit.fromDb(r.unit),
        needsClearance: r.needsClearance,
        clearedOn: r.clearedOn,
      );

  PlanSessionLog _sessionLog(db.PlanSessionLog r) => PlanSessionLog(
        id: r.id,
        planId: r.planId,
        sessionId: r.sessionId,
        date: r.date,
        mode: PlanSessionMode.fromDb(r.mode),
        durationMin: r.durationMin,
        nextMorning: NextMorning.fromDb(r.nextMorning),
        activityId: r.activityId,
        note: r.note,
      );

  PlanSetLog _setLog(db.PlanSetLog r) => PlanSetLog(
        id: r.id,
        sessionLogId: r.sessionLogId,
        exerciseId: r.exerciseId,
        stepId: r.stepId,
        setValues: _decodeSets(r.setValues),
        unit: SetUnit.fromDb(r.unit),
        pain: r.pain,
        sharp: r.sharp,
      );

  static List<int> _decodeSets(String raw) {
    try {
      return (jsonDecode(raw) as List).map((e) => (e as num).toInt()).toList();
    } catch (_) {
      return const [];
    }
  }

  // --- Plans ---

  /// The most recently updated active plan, or null before one is made.
  Stream<TrainingPlan?> watchActivePlan() {
    final q = _db.select(_db.trainingPlans)
      ..where((t) => t.isActive.equals(true))
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])
      ..limit(1);
    return q.watchSingleOrNull().map((r) => r == null ? null : _plan(r));
  }

  Future<String> createPlan({
    required String name,
    required String startDate,
    required int weeks,
    int? weeklyCeilingMin,
    String? floorNote,
    String? testWeeks,
  }) async {
    final id = newId();
    await _db.transaction(() async {
      // One active plan at a time; older ones stay for their history.
      await (_db.update(_db.trainingPlans)..where((t) => t.isActive.equals(true)))
          .write(db.TrainingPlansCompanion(isActive: const Value(false), updatedAt: Value(nowIso())));
      await _db.into(_db.trainingPlans).insert(db.TrainingPlansCompanion.insert(
            id: id,
            name: name,
            startDate: startDate,
            weeks: Value(weeks),
            weeklyCeilingMin: Value(weeklyCeilingMin),
            floorNote: Value(floorNote),
            testWeeks: Value(testWeeks),
            updatedAt: nowIso(),
          ));
    });
    return id;
  }

  Future<void> updatePlan(TrainingPlan plan) async {
    await (_db.update(_db.trainingPlans)..where((t) => t.id.equals(plan.id))).write(
      db.TrainingPlansCompanion(
        name: Value(plan.name),
        startDate: Value(plan.startDate),
        weeks: Value(plan.weeks),
        weeklyCeilingMin: Value(plan.weeklyCeilingMin),
        floorNote: Value(plan.floorNote),
        currentPhaseId: Value(plan.currentPhaseId),
        testWeeks: Value(plan.testWeeks),
        updatedAt: Value(nowIso()),
      ),
    );
  }

  Future<void> setCurrentPhase(String planId, String? phaseId) async {
    await (_db.update(_db.trainingPlans)..where((t) => t.id.equals(planId))).write(
      db.TrainingPlansCompanion(currentPhaseId: Value(phaseId), updatedAt: Value(nowIso())),
    );
  }

  /// Removes the plan with its structure and logs. Cardio Activities it
  /// wrote stay in Movement — they happened.
  Future<void> deletePlan(String planId) async {
    await _db.transaction(() async {
      final sessionIds = (await (_db.select(_db.planSessions)
                ..where((t) => t.planId.equals(planId)))
              .get())
          .map((s) => s.id)
          .toList();
      final exerciseIds = (await (_db.select(_db.planExercises)
                ..where((t) => t.sessionId.isIn(sessionIds)))
              .get())
          .map((e) => e.id)
          .toList();
      final logIds = (await (_db.select(_db.planSessionLogs)
                ..where((t) => t.planId.equals(planId)))
              .get())
          .map((l) => l.id)
          .toList();
      await (_db.delete(_db.planSetLogs)..where((t) => t.sessionLogId.isIn(logIds))).go();
      await (_db.delete(_db.planSessionLogs)..where((t) => t.planId.equals(planId))).go();
      await (_db.delete(_db.planSteps)..where((t) => t.exerciseId.isIn(exerciseIds))).go();
      await (_db.delete(_db.planExercises)..where((t) => t.sessionId.isIn(sessionIds))).go();
      await (_db.delete(_db.planSessions)..where((t) => t.planId.equals(planId))).go();
      await (_db.delete(_db.planPhases)..where((t) => t.planId.equals(planId))).go();
      await (_db.delete(_db.planCheckins)..where((t) => t.planId.equals(planId))).go();
      final testIds = (await (_db.select(_db.planTests)..where((t) => t.planId.equals(planId)))
              .get())
          .map((t) => t.id)
          .toList();
      await (_db.delete(_db.planTestResults)..where((t) => t.testId.isIn(testIds))).go();
      await (_db.delete(_db.planTests)..where((t) => t.planId.equals(planId))).go();
      await (_db.delete(_db.trainingPlans)..where((t) => t.id.equals(planId))).go();
    });
  }

  // --- Phases ---

  Stream<List<PlanPhase>> watchPhases(String planId) {
    final q = _db.select(_db.planPhases)
      ..where((t) => t.planId.equals(planId))
      ..orderBy([(t) => OrderingTerm.asc(t.position)]);
    return q.watch().map((rows) => rows.map(_phase).toList());
  }

  Future<void> savePhase(PlanPhase phase) async {
    await _db.into(_db.planPhases).insertOnConflictUpdate(db.PlanPhasesCompanion.insert(
          id: phase.id,
          planId: phase.planId,
          position: phase.position,
          name: phase.name,
          goal: Value(phase.goal),
          effort: Value(phase.effort),
          cardio: Value(phase.cardio),
          gate: Value(phase.gate),
          updatedAt: nowIso(),
        ));
  }

  Future<void> deletePhase(PlanPhase phase) async {
    await _db.transaction(() async {
      await (_db.delete(_db.planPhases)..where((t) => t.id.equals(phase.id))).go();
      await (_db.update(_db.trainingPlans)..where((t) => t.currentPhaseId.equals(phase.id)))
          .write(const db.TrainingPlansCompanion(currentPhaseId: Value(null)));
    });
  }

  // --- Sessions ---

  Stream<List<PlanSession>> watchSessions(String planId) {
    final q = _db.select(_db.planSessions)
      ..where((t) => t.planId.equals(planId))
      ..orderBy([(t) => OrderingTerm.asc(t.position)]);
    return q.watch().map((rows) => rows.map(_session).toList());
  }

  Future<void> saveSession(PlanSession session) async {
    await _db.into(_db.planSessions).insertOnConflictUpdate(db.PlanSessionsCompanion.insert(
          id: session.id,
          planId: session.planId,
          position: session.position,
          name: session.name,
          weekday: Value(session.weekday),
          durationMin: Value(session.durationMin),
          lowDayNote: Value(session.lowDayNote),
          isCardio: Value(session.isCardio),
          updatedAt: nowIso(),
        ));
  }

  /// Removes the session and its exercises. Past logs keep their rows
  /// (they read as "a session that no longer exists").
  Future<void> deleteSession(String sessionId) async {
    await _db.transaction(() async {
      final exerciseIds = (await (_db.select(_db.planExercises)
                ..where((t) => t.sessionId.equals(sessionId)))
              .get())
          .map((e) => e.id)
          .toList();
      await (_db.delete(_db.planSteps)..where((t) => t.exerciseId.isIn(exerciseIds))).go();
      await (_db.delete(_db.planExercises)..where((t) => t.sessionId.equals(sessionId))).go();
      await (_db.delete(_db.planSessions)..where((t) => t.id.equals(sessionId))).go();
    });
  }

  // --- Exercises & steps ---

  Stream<List<PlanExercise>> watchExercises(String sessionId) {
    final q = _db.select(_db.planExercises)
      ..where((t) => t.sessionId.equals(sessionId))
      ..orderBy([(t) => OrderingTerm.asc(t.position)]);
    return q.watch().map((rows) => rows.map(_exercise).toList());
  }

  Future<List<PlanExercise>> getExercisesForPlan(String planId) async {
    final q = _db.select(_db.planExercises).join([
      innerJoin(_db.planSessions, _db.planSessions.id.equalsExp(_db.planExercises.sessionId)),
    ])
      ..where(_db.planSessions.planId.equals(planId));
    final rows = await q.get();
    return rows.map((r) => _exercise(r.readTable(_db.planExercises))).toList();
  }

  Future<void> saveExercise(PlanExercise exercise) async {
    await _db.into(_db.planExercises).insertOnConflictUpdate(db.PlanExercisesCompanion.insert(
          id: exercise.id,
          sessionId: exercise.sessionId,
          position: exercise.position,
          name: exercise.name,
          cue: Value(exercise.cue),
          currentStepId: Value(exercise.currentStepId),
          stepChangedOn: Value(exercise.stepChangedOn),
          updatedAt: nowIso(),
        ));
  }

  Future<void> deleteExercise(String exerciseId) async {
    await _db.transaction(() async {
      await (_db.delete(_db.planSteps)..where((t) => t.exerciseId.equals(exerciseId))).go();
      await (_db.delete(_db.planExercises)..where((t) => t.id.equals(exerciseId))).go();
    });
  }

  /// [changedOn] is set when the person moves up or down a step — not when
  /// they first pick a starting step while building the plan.
  Future<void> setCurrentStep(String exerciseId, String stepId, {String? changedOn}) async {
    await (_db.update(_db.planExercises)..where((t) => t.id.equals(exerciseId))).write(
      db.PlanExercisesCompanion(
        currentStepId: Value(stepId),
        stepChangedOn: changedOn == null ? const Value.absent() : Value(changedOn),
        updatedAt: Value(nowIso()),
      ),
    );
  }

  Stream<List<PlanStep>> watchSteps(String exerciseId) {
    final q = _db.select(_db.planSteps)
      ..where((t) => t.exerciseId.equals(exerciseId))
      ..orderBy([(t) => OrderingTerm.asc(t.position)]);
    return q.watch().map((rows) => rows.map(_step).toList());
  }

  /// Every step in a session, for showing exercises with their current dose.
  Stream<List<PlanStep>> watchStepsForSession(String sessionId) {
    final q = _db.select(_db.planSteps).join([
      innerJoin(_db.planExercises, _db.planExercises.id.equalsExp(_db.planSteps.exerciseId)),
    ])
      ..where(_db.planExercises.sessionId.equals(sessionId))
      ..orderBy([OrderingTerm.asc(_db.planSteps.position)]);
    return q.watch().map((rows) => rows.map((r) => _step(r.readTable(_db.planSteps))).toList());
  }

  Future<void> saveStep(PlanStep step) async {
    await _db.into(_db.planSteps).insertOnConflictUpdate(db.PlanStepsCompanion.insert(
          id: step.id,
          exerciseId: step.exerciseId,
          position: step.position,
          name: step.name,
          dose: Value(step.dose),
          unit: Value(step.unit.db),
          needsClearance: Value(step.needsClearance),
          clearedOn: Value(step.clearedOn),
          updatedAt: nowIso(),
        ));
  }

  Future<void> setStepCleared(String stepId, String? clearedOn) async {
    await (_db.update(_db.planSteps)..where((t) => t.id.equals(stepId))).write(
      db.PlanStepsCompanion(clearedOn: Value(clearedOn), updatedAt: Value(nowIso())),
    );
  }

  Future<void> deleteStep(String stepId) async {
    await _db.transaction(() async {
      await (_db.delete(_db.planSteps)..where((t) => t.id.equals(stepId))).go();
      await (_db.update(_db.planExercises)..where((t) => t.currentStepId.equals(stepId)))
          .write(const db.PlanExercisesCompanion(currentStepId: Value(null)));
    });
  }

  // --- Logs ---

  Stream<List<PlanSessionLog>> watchSessionLogs(String planId, String start, String end) {
    final q = _db.select(_db.planSessionLogs)
      ..where((t) =>
          t.planId.equals(planId) &
          t.date.isBiggerOrEqualValue(start) &
          t.date.isSmallerOrEqualValue(end))
      ..orderBy([(t) => OrderingTerm.asc(t.date)]);
    return q.watch().map((rows) => rows.map(_sessionLog).toList());
  }

  Future<List<PlanSessionLog>> getSessionLogs(String planId, String start, String end) =>
      watchSessionLogs(planId, start, end).first;

  /// Writes the session and its exercises in one go. A cardio session also
  /// writes an Activity row (same date, session name, duration) so the rest
  /// of the app sees it; its id is kept so deleting the log removes both.
  Future<void> logSession({
    required String planId,
    required String date,
    required PlanSessionMode mode,
    PlanSession? session,
    int? durationMin,
    String? note,
    List<PlanSetEntry> entries = const [],
  }) async {
    final logId = newId();
    await _db.transaction(() async {
      String? activityId;
      if (session != null && session.isCardio && mode.isTraining && (durationMin ?? 0) > 0) {
        activityId = newId();
        await _db.into(_db.activities).insert(db.ActivitiesCompanion.insert(
              id: activityId,
              date: date,
              activityName: session.name,
              durationMin: durationMin!,
              updatedAt: nowIso(),
            ));
      }
      await _db.into(_db.planSessionLogs).insert(db.PlanSessionLogsCompanion.insert(
            id: logId,
            planId: planId,
            sessionId: Value(session?.id),
            date: date,
            mode: mode.db,
            durationMin: Value(durationMin),
            activityId: Value(activityId),
            note: Value(note),
            updatedAt: nowIso(),
          ));
      for (final e in entries) {
        await _db.into(_db.planSetLogs).insert(db.PlanSetLogsCompanion.insert(
              id: newId(),
              sessionLogId: logId,
              exerciseId: e.exerciseId,
              stepId: e.stepId,
              setValues: Value(jsonEncode(e.setValues)),
              unit: Value(e.unit.db),
              pain: Value(e.pain),
              sharp: Value(e.sharp),
              updatedAt: nowIso(),
            ));
      }
    });
  }

  /// Rewrites a saved session's duration, note and exercises. The log keeps
  /// its id, date, mode and next-morning answer; a cardio session's Activity
  /// row follows the new duration (created, updated or removed).
  Future<void> updateSessionLog({
    required PlanSessionLog log,
    PlanSession? session,
    int? durationMin,
    String? note,
    List<PlanSetEntry> entries = const [],
  }) async {
    await _db.transaction(() async {
      var activityId = log.activityId;
      final wantsActivity =
          session != null && session.isCardio && log.mode.isTraining && (durationMin ?? 0) > 0;
      if (wantsActivity && activityId != null) {
        await (_db.update(_db.activities)..where((t) => t.id.equals(activityId!))).write(
          db.ActivitiesCompanion(durationMin: Value(durationMin!), updatedAt: Value(nowIso())),
        );
      } else if (wantsActivity) {
        activityId = newId();
        await _db.into(_db.activities).insert(db.ActivitiesCompanion.insert(
              id: activityId,
              date: log.date,
              activityName: session.name,
              durationMin: durationMin!,
              updatedAt: nowIso(),
            ));
      } else if (activityId != null) {
        await (_db.delete(_db.activities)..where((t) => t.id.equals(activityId!))).go();
        activityId = null;
      }
      await (_db.update(_db.planSessionLogs)..where((t) => t.id.equals(log.id))).write(
        db.PlanSessionLogsCompanion(
          durationMin: Value(durationMin),
          note: Value(note),
          activityId: Value(activityId),
          updatedAt: Value(nowIso()),
        ),
      );
      await (_db.delete(_db.planSetLogs)..where((t) => t.sessionLogId.equals(log.id))).go();
      for (final e in entries) {
        await _db.into(_db.planSetLogs).insert(db.PlanSetLogsCompanion.insert(
              id: newId(),
              sessionLogId: log.id,
              exerciseId: e.exerciseId,
              stepId: e.stepId,
              setValues: Value(jsonEncode(e.setValues)),
              unit: Value(e.unit.db),
              pain: Value(e.pain),
              sharp: Value(e.sharp),
              updatedAt: nowIso(),
            ));
      }
    });
  }

  Future<void> setNextMorning(String sessionLogId, NextMorning answer) async {
    await (_db.update(_db.planSessionLogs)..where((t) => t.id.equals(sessionLogId))).write(
      db.PlanSessionLogsCompanion(nextMorning: Value(answer.db), updatedAt: Value(nowIso())),
    );
  }

  Future<void> deleteSessionLog(PlanSessionLog log) async {
    await _db.transaction(() async {
      await (_db.delete(_db.planSetLogs)..where((t) => t.sessionLogId.equals(log.id))).go();
      await (_db.delete(_db.planSessionLogs)..where((t) => t.id.equals(log.id))).go();
      if (log.activityId != null) {
        await (_db.delete(_db.activities)..where((t) => t.id.equals(log.activityId!))).go();
      }
    });
  }

  Future<List<PlanSetLog>> getSetLogsFor(Iterable<String> sessionLogIds) async {
    final rows = await (_db.select(_db.planSetLogs)
          ..where((t) => t.sessionLogId.isIn(sessionLogIds.toList())))
        .get();
    return rows.map(_setLog).toList();
  }

  Future<void> setCeiling(String planId, int? minutes) async {
    await (_db.update(_db.trainingPlans)..where((t) => t.id.equals(planId))).write(
      db.TrainingPlansCompanion(weeklyCeilingMin: Value(minutes), updatedAt: Value(nowIso())),
    );
  }

  Stream<List<PlanSetLog>> watchSetLogs(String sessionLogId) {
    final q = _db.select(_db.planSetLogs)..where((t) => t.sessionLogId.equals(sessionLogId));
    return q.watch().map((rows) => rows.map(_setLog).toList());
  }

  /// The latest [limit] logs of an exercise at one step, newest first, each
  /// with the session it belongs to (for that session's next-morning answer).
  Future<List<(PlanSetLog, PlanSessionLog)>> recentAtStep(
    String exerciseId,
    String stepId, {
    int limit = 3,
  }) async {
    final q = _db.select(_db.planSetLogs).join([
      innerJoin(
          _db.planSessionLogs, _db.planSessionLogs.id.equalsExp(_db.planSetLogs.sessionLogId)),
    ])
      ..where(_db.planSetLogs.exerciseId.equals(exerciseId) & _db.planSetLogs.stepId.equals(stepId))
      ..orderBy([OrderingTerm.desc(_db.planSessionLogs.date)])
      ..limit(limit);
    final rows = await q.get();
    return rows
        .map((r) => (_setLog(r.readTable(_db.planSetLogs)), _sessionLog(r.readTable(_db.planSessionLogs))))
        .toList();
  }
}
