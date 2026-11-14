import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/data/db/app_database.dart' hide PlanCheckin, ExposureLog, PlanTest;
import 'package:zebrapace_app/data/repositories/plan_repository.dart';
import 'package:zebrapace_app/data/repositories/plan_review_repository.dart';
import 'package:zebrapace_app/domain/models/training_plan.dart';
import 'package:zebrapace_app/domain/services/export_import_service.dart';

void main() {
  late AppDatabase db;
  late PlanRepository plans;
  late PlanReviewRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    plans = PlanRepository(db);
    repo = PlanReviewRepository(db);
  });

  tearDown(() => db.close());

  test('a check-in sets the ceiling, and saving the same week again replaces it', () async {
    final planId =
        await plans.createPlan(name: 'P', startDate: '2026-11-16', weeks: 12, weeklyCeilingMin: 75);
    PlanCheckin checkin(CheckinDecision d, int after) => PlanCheckin(
        id: d.name, planId: planId, weekStart: '2026-11-16', decision: d, ceilingBefore: 75, ceilingAfter: after);

    await repo.saveCheckin(checkin(CheckinDecision.raise, 85));
    expect((await plans.watchActivePlan().first)?.weeklyCeilingMin, 85);

    await repo.saveCheckin(checkin(CheckinDecision.keep, 75));
    final all = await repo.watchCheckins(planId).first;
    expect(all.single.decision, CheckinDecision.keep);
    expect((await plans.watchActivePlan().first)?.weeklyCeilingMin, 75);
  });

  test('a try with a fear-after rating updates the item', () async {
    await repo.addFearItem('Stairs', 5);
    final item = (await repo.watchFearItems().first).single;
    await repo.addExposure(ExposureLog(
        id: 'x', fearItemId: item.id, date: '2026-11-15', fearAfter: 3, nothingBad: true));
    final updated = (await repo.watchFearItems().first).single;
    expect(updated.fear, 3);
    expect(updated.initialFear, 5);
    expect((await repo.watchExposures().first).single.nothingBad, isTrue);
  });

  test('tests, check-ins and the fear list survive export and import', () async {
    final planId = await plans.createPlan(name: 'P', startDate: '2026-11-16', weeks: 12, testWeeks: '1,6,12');
    await repo.saveTest(PlanTest(id: 't', planId: planId, position: 0, name: 'Sit-to-stand', unit: 'reps'));
    await repo.addResult(testId: 't', date: '2026-11-16', value: 7);
    await repo.saveCheckin(PlanCheckin(
        id: 'c', planId: planId, weekStart: '2026-11-16', decision: CheckinDecision.keep, win: 'Stairs'));
    await repo.addFearItem('Kneeling', 6);

    final service = ExportImportService(db);
    final json = await service.exportAllDataJson();
    await service.deleteAllDataExceptSettings();
    expect(await repo.watchFearItems().first, isEmpty);

    await service.importAllDataJson(json, replace: true);
    expect((await plans.watchActivePlan().first)?.testWeeks, '1,6,12');
    expect((await repo.watchResults(planId).first).single.value, 7);
    expect((await repo.watchCheckins(planId).first).single.win, 'Stairs');
    expect((await repo.watchFearItems().first).single.name, 'Kneeling');
  });

  test('deleting a plan removes its tests and check-ins but keeps the fear list', () async {
    final planId = await plans.createPlan(name: 'P', startDate: '2026-11-16', weeks: 12);
    await repo.saveTest(PlanTest(id: 't', planId: planId, position: 0, name: 'Test'));
    await repo.addResult(testId: 't', date: '2026-11-16', value: 1);
    await repo.saveCheckin(PlanCheckin(
        id: 'c', planId: planId, weekStart: '2026-11-16', decision: CheckinDecision.keep));
    await repo.addFearItem('Stairs', 4);

    await plans.deletePlan(planId);
    expect(await db.select(db.planTests).get(), isEmpty);
    expect(await db.select(db.planTestResults).get(), isEmpty);
    expect(await db.select(db.planCheckins).get(), isEmpty);
    expect((await repo.watchFearItems().first).length, 1);
  });
}
