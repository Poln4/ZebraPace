import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/utils/date_utils.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/data/repositories/daily_log_repository.dart';
import 'package:zebrapace_app/domain/services/pacing_service.dart';

void main() {
  late AppDatabase db;
  late DailyLogRepository repo;
  late PacingService service;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = DailyLogRepository(db);
    service = PacingService(repo);
  });

  tearDown(() => db.close());

  Future<void> seedDay(String date, int steps, {bool rest = false, bool flare = false}) async {
    final log = await repo.getOrCreateDailyLog(date);
    await repo.upsertDailyLog(
      log.copyWith(steps: steps, isRestDay: rest, isFlareDay: flare),
    );
  }

  test('baseline excludes the target date itself and rest/flare days, takes 7 most recent qualifying rows', () async {
    // 10 consecutive days of steps ending the day before target; baseline
    // should only average the most-recent 7 (dates -1..-7), not all 10.
    for (var i = 10; i >= 1; i--) {
      await seedDay(dateKey(DateTime(2026, 1, 20).subtract(Duration(days: i))), 1000 * i);
    }
    // A rest day right before target should be excluded from the average.
    await seedDay(dateKey(DateTime(2026, 1, 19)), 50, rest: true);

    final evaluation = await service.evaluateForDate(
      dateKey(DateTime(2026, 1, 20)),
      growthGoalPct: 1.01,
      cautionPct: 1.10,
    );

    // Most recent 7 qualifying rows (rest day on the 19th excluded) are
    // steps for i=2..8 relative to day 20, i.e. 8000,7000,6000,5000,4000,3000,2000
    // averaged = 5000.
    expect(evaluation.avgSteps, 5000);
    expect(evaluation.goalSteps, (5000 * 1.01).floor());
    expect(evaluation.cautionSteps, (5000 * 1.10).floor());
  });

  test('no qualifying history yields a zero baseline, not an error', () async {
    final evaluation = await service.evaluateForDate(
      dateKey(DateTime(2026, 1, 20)),
      growthGoalPct: 1.01,
      cautionPct: 1.10,
    );
    expect(evaluation.avgSteps, 0);
    expect(evaluation.hasBaseline, isFalse);
  });

  group('evaluateStepsMessage branch order', () {
    const evaluation = PacingEvaluation(avgSteps: 5000, goalSteps: 5050, cautionSteps: 5500);

    test('flare day always wins regardless of step count', () {
      final kind = PacingService(repo).evaluateStepsMessage(
        steps: 9000,
        isFlareDay: true,
        evaluation: evaluation,
      );
      expect(kind, PacingMessageKind.flareNeutral);
    });

    test('over the caution line triggers caution even if also above goal', () {
      final kind = service.evaluateStepsMessage(
        steps: 5600,
        isFlareDay: false,
        evaluation: evaluation,
      );
      expect(kind, PacingMessageKind.caution);
    });

    test('at or above goal but under caution celebrates', () {
      final kind = service.evaluateStepsMessage(
        steps: 5050,
        isFlareDay: false,
        evaluation: evaluation,
      );
      expect(kind, PacingMessageKind.goalCelebration);
    });

    test('more than 15% below baseline is gentle-low', () {
      final kind = service.evaluateStepsMessage(
        steps: 4000, // < 5000 * 0.85 = 4250
        isFlareDay: false,
        evaluation: evaluation,
      );
      expect(kind, PacingMessageKind.gentleLow);
    });

    test('between 85% of baseline and goal is steady', () {
      final kind = service.evaluateStepsMessage(
        steps: 4800,
        isFlareDay: false,
        evaluation: evaluation,
      );
      expect(kind, PacingMessageKind.steady);
    });

    test('no baseline yet yields noBaseline regardless of step count', () {
      final kind = service.evaluateStepsMessage(
        steps: 4800,
        isFlareDay: false,
        evaluation: const PacingEvaluation(avgSteps: 0, goalSteps: 0, cautionSteps: 0),
      );
      expect(kind, PacingMessageKind.noBaseline);
    });
  });
}
