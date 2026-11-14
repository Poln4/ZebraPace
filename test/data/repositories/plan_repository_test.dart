import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/data/db/app_database.dart' hide PlanSession, PlanStep, PlanExercise;
import 'package:zebrapace_app/data/repositories/activity_repository.dart';
import 'package:zebrapace_app/data/repositories/plan_repository.dart';
import 'package:zebrapace_app/domain/models/training_plan.dart';
import 'package:zebrapace_app/domain/services/export_import_service.dart';

void main() {
  late AppDatabase db;
  late PlanRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = PlanRepository(db);
  });

  tearDown(() => db.close());

  Future<(String, PlanSession, PlanExercise)> seed({bool cardio = false}) async {
    final planId = await repo.createPlan(name: 'P', startDate: '2026-11-16', weeks: 12);
    final session = PlanSession(
        id: 's1', planId: planId, position: 0, name: cardio ? 'C: cardio' : 'A: strength', weekday: 1, isCardio: cardio);
    await repo.saveSession(session);
    const exercise = PlanExercise(id: 'e1', sessionId: 's1', position: 0, name: 'Push');
    await repo.saveExercise(exercise);
    await repo.saveStep(const PlanStep(id: 'st1', exerciseId: 'e1', position: 0, name: 'Wall push-up'));
    await repo.setCurrentStep('e1', 'st1');
    return (planId, session, exercise);
  }

  test('creating a plan deactivates the previous one', () async {
    final first = await repo.createPlan(name: 'Old', startDate: '2026-01-01', weeks: 4);
    final second = await repo.createPlan(name: 'New', startDate: '2026-11-16', weeks: 12);
    final active = await repo.watchActivePlan().first;
    expect(active?.id, second);
    expect(active?.id, isNot(first));
  });

  test('a cardio session also writes an Activity, and deleting removes both', () async {
    final (planId, session, _) = await seed(cardio: true);
    await repo.logSession(
        planId: planId, date: '2026-11-16', mode: PlanSessionMode.full, session: session, durationMin: 20);

    final activities = await ActivityRepository(db).getRange('2026-11-16', '2026-11-16');
    expect(activities.single.activityName, 'C: cardio');
    expect(activities.single.durationMin, 20);

    final log = (await repo.getSessionLogs(planId, '2026-11-16', '2026-11-16')).single;
    expect(log.activityId, activities.single.id);

    await repo.deleteSessionLog(log);
    expect(await ActivityRepository(db).getRange('2026-11-16', '2026-11-16'), isEmpty);
    expect(await repo.getSessionLogs(planId, '2026-11-16', '2026-11-16'), isEmpty);
  });

  test('a floor day writes no Activity even for a cardio session', () async {
    final (planId, session, _) = await seed(cardio: true);
    await repo.logSession(
        planId: planId, date: '2026-11-16', mode: PlanSessionMode.floor, session: session, durationMin: 5);
    expect(await ActivityRepository(db).getRange('2026-11-16', '2026-11-16'), isEmpty);
  });

  test('set logs come back newest first with their session', () async {
    final (planId, session, exercise) = await seed();
    for (final (date, pain) in [('2026-11-16', 2), ('2026-11-18', 4)]) {
      await repo.logSession(
        planId: planId,
        date: date,
        mode: PlanSessionMode.full,
        session: session,
        entries: [
          PlanSetEntry(
              exerciseId: exercise.id, stepId: 'st1', setValues: const [5, 5], unit: SetUnit.reps, pain: pain),
        ],
      );
    }
    final recent = await repo.recentAtStep(exercise.id, 'st1');
    expect(recent.map((r) => r.$2.date), ['2026-11-18', '2026-11-16']);
    expect(recent.first.$1.pain, 4);
    expect(recent.first.$1.setValues, [5, 5]);

    await repo.setNextMorning(recent.first.$2.id, NextMorning.higher);
    final again = await repo.recentAtStep(exercise.id, 'st1');
    expect(again.first.$2.nextMorning, NextMorning.higher);
  });

  test('plans survive a JSON export and replace-import', () async {
    final (planId, session, exercise) = await seed();
    await repo.logSession(
      planId: planId,
      date: '2026-11-16',
      mode: PlanSessionMode.lowDay,
      session: session,
      entries: [
        PlanSetEntry(exerciseId: exercise.id, stepId: 'st1', setValues: const [6], unit: SetUnit.reps, pain: 3),
      ],
    );
    final service = ExportImportService(db);
    final json = await service.exportAllDataJson();
    await service.deleteAllDataExceptSettings();
    expect(await repo.watchActivePlan().first, isNull);

    await service.importAllDataJson(json, replace: true);
    final plan = await repo.watchActivePlan().first;
    expect(plan?.id, planId);
    expect((await repo.watchSessions(planId).first).single.name, 'A: strength');
    final recent = await repo.recentAtStep(exercise.id, 'st1');
    expect(recent.single.$1.pain, 3);
    expect(recent.single.$2.mode, PlanSessionMode.lowDay);
  });

  test('deleting a plan removes its structure and logs', () async {
    final (planId, session, _) = await seed();
    await repo.logSession(planId: planId, date: '2026-11-16', mode: PlanSessionMode.full, session: session);
    await repo.deletePlan(planId);
    expect(await repo.watchActivePlan().first, isNull);
    expect(await db.select(db.planSteps).get(), isEmpty);
    expect(await db.select(db.planSessionLogs).get(), isEmpty);
  });
}
