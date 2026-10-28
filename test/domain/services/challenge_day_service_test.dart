import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/data/repositories/activity_repository.dart';
import 'package:zebrapace_app/data/repositories/checkin_repository.dart';
import 'package:zebrapace_app/data/repositories/daily_log_repository.dart';
import 'package:zebrapace_app/domain/models/challenge.dart';
import 'package:zebrapace_app/domain/services/challenge_day_service.dart';

void main() {
  late AppDatabase db;
  late DailyLogRepository logs;
  late ActivityRepository activities;
  late CheckinRepository checkins;
  late ChallengeDayService service;

  final start = DateTime(2026, 3, 2);

  Challenge challenge(ChallengeKind kind, {int weeks = 1}) => Challenge(
        id: 'c1',
        name: 'Test',
        code: 'CODE',
        kind: kind,
        targetPercent: 5,
        createdBy: 'me',
        createdAt: start,
        startsOn: start,
        weeks: weeks,
      );

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    logs = DailyLogRepository(db);
    activities = ActivityRepository(db);
    checkins = CheckinRepository(db);
    service = ChallengeDayService(logs, activities, checkins);
  });

  tearDown(() => db.close());

  Future<void> seedLog(String date, {int steps = 0, double? sleepHours, bool rest = false}) async {
    final log = await logs.getOrCreateDailyLog(date);
    await logs.upsertDailyLog(log.copyWith(steps: steps, sleepHours: sleepHours, isRestDay: rest));
  }

  test('covers start through today only, not the rest of the challenge', () async {
    final days = await service.computeDays(
      challenge: challenge(ChallengeKind.steps, weeks: 2),
      userId: 'me',
      dailyGoal: 1000,
      today: DateTime(2026, 3, 4),
    );
    expect(days.map((d) => d.day), ['2026-03-02', '2026-03-03', '2026-03-04']);
  });

  test('stops at the last day once the challenge has ended', () async {
    final days = await service.computeDays(
      challenge: challenge(ChallengeKind.steps),
      userId: 'me',
      dailyGoal: 1000,
      today: DateTime(2026, 4, 1),
    );
    expect(days.length, 7);
    expect(days.last.day, '2026-03-08');
  });

  test('steps: met at or above the goal; a rest day counts as met', () async {
    await seedLog('2026-03-02', steps: 4000);
    await seedLog('2026-03-03', steps: 3999);
    await seedLog('2026-03-04', steps: 200, rest: true);

    final days = await service.computeDays(
      challenge: challenge(ChallengeKind.steps),
      userId: 'me',
      dailyGoal: 4000,
      today: DateTime(2026, 3, 4),
    );
    expect(days.map((d) => d.goalMet), [true, false, true]);
    expect(days[2].restDay, isTrue);
    expect(days[2].value, 200);
  });

  test('sleep: a rest day does not excuse a short night', () async {
    await seedLog('2026-03-02', sleepHours: 7.5);
    await seedLog('2026-03-03', sleepHours: 5, rest: true);

    final days = await service.computeDays(
      challenge: challenge(ChallengeKind.sleep),
      userId: 'me',
      dailyGoal: 7,
      today: DateTime(2026, 3, 3),
    );
    expect(days.map((d) => d.goalMet), [true, false]);
  });

  test('activity: sums every activity logged that day', () async {
    await activities.insert(date: '2026-03-02', activityName: 'Walk', durationMin: 10);
    await activities.insert(date: '2026-03-02', activityName: 'Yoga', durationMin: 15);

    final days = await service.computeDays(
      challenge: challenge(ChallengeKind.activity),
      userId: 'me',
      dailyGoal: 20,
      today: DateTime(2026, 3, 2),
    );
    expect(days.single.value, 25);
    expect(days.single.goalMet, isTrue);
  });

  test('logging: a check-in counts, HealthKit-style steps alone do not', () async {
    await checkins.insert(
      date: '2026-03-02',
      mentalState: MentalState.okay,
      bodyFeeling: BodyFeeling.manageable,
    );
    await seedLog('2026-03-03', steps: 5000);

    final days = await service.computeDays(
      challenge: challenge(ChallengeKind.logging),
      userId: 'me',
      dailyGoal: null,
      today: DateTime(2026, 3, 3),
    );
    expect(days.map((d) => d.goalMet), [true, false]);
  });

  test('suggests a steps goal from the recent non-rest average, rounded down to 100', () async {
    await seedLog('2026-03-01', steps: 3050);
    await seedLog('2026-03-02', steps: 3420);
    await seedLog('2026-03-03', steps: 9000, rest: true);

    final goal = await service.suggestGoal(ChallengeKind.steps, '2026-03-04');
    expect(goal, 3200);
  });

  test('weight challenges produce no days', () async {
    final days = await service.computeDays(
      challenge: challenge(ChallengeKind.weight),
      userId: 'me',
      dailyGoal: null,
      today: DateTime(2026, 3, 4),
    );
    expect(days, isEmpty);
  });
}
