import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/core/utils/date_utils.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/data/repositories/activity_repository.dart';
import 'package:zebrapace_app/data/repositories/calisthenics_repository.dart';
import 'package:zebrapace_app/data/repositories/daily_log_repository.dart';
import 'package:zebrapace_app/domain/services/hr_exertion_service.dart';

void main() {
  late AppDatabase db;
  late ActivityRepository activityRepo;
  late CalisthenicsRepository calisthenicsRepo;
  late DailyLogRepository dailyLogRepo;
  late HrExertionService service;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    activityRepo = ActivityRepository(db);
    calisthenicsRepo = CalisthenicsRepository(db);
    dailyLogRepo = DailyLogRepository(db);
    service = HrExertionService(activityRepo, calisthenicsRepo, dailyLogRepo);
  });

  tearDown(() => db.close());

  Future<void> seedActivity(DateTime date, {int? heartRateMaxBpm}) async {
    await activityRepo.insert(
      date: dateKey(date),
      activityName: 'Walk',
      durationMin: 20,
      heartRateMinBpm: heartRateMaxBpm == null ? null : heartRateMaxBpm - 20,
      heartRateMaxBpm: heartRateMaxBpm,
    );
  }

  Future<void> seedBodyScore(DateTime date, BodyFeeling body) async {
    final log = await dailyLogRepo.getOrCreateDailyLog(dateKey(date));
    await dailyLogRepo.upsertDailyLog(log.copyWith(bodyFeeling: body));
  }

  test('below minimum sample size returns no correlation', () async {
    final start = DateTime(2026, 1, 1);
    for (var i = 0; i < 2; i++) {
      await seedActivity(start.add(Duration(days: i * 2)), heartRateMaxBpm: 140);
      await seedBodyScore(start.add(Duration(days: i * 2 + 1)), BodyFeeling.good);
    }
    final result = await service.analyze(
      dateKey(start),
      dateKey(start.add(const Duration(days: 10))),
      lagDays: 1,
    );
    expect(result.hasEnoughData, isFalse);
  });

  test('takes the day\'s max heart rate across activities and calisthenics', () async {
    final start = DateTime(2026, 1, 1);
    await seedActivity(start, heartRateMaxBpm: 120);
    await calisthenicsRepo.insert(
      date: dateKey(start),
      exercise: CalisthenicsExercise.pushups,
      progression: 'Wall',
      sets: 3,
      reps: 10,
      comfortScore: 4,
      heartRateMinBpm: 100,
      heartRateMaxBpm: 150,
    );
    await seedBodyScore(start.add(const Duration(days: 1)), BodyFeeling.good);
    // Padding so the sample size threshold is met.
    for (var i = 2; i < 6; i++) {
      await seedActivity(start.add(Duration(days: i)), heartRateMaxBpm: 100);
      await seedBodyScore(start.add(Duration(days: i + 1)), BodyFeeling.good);
    }

    final result = await service.analyze(
      dateKey(start),
      dateKey(start.add(const Duration(days: 10))),
      lagDays: 1,
    );
    final firstDay = result.points.firstWhere((p) => p.date == dateKey(start));
    expect(firstDay.maxHeartRateBpm, 150);
  });

  test('a gap in logging does not silently bridge to the next available row', () async {
    final start = DateTime(2026, 1, 1);
    await seedActivity(start, heartRateMaxBpm: 160);
    final day3 = start.add(const Duration(days: 2));
    await seedBodyScore(day3, BodyFeeling.severe);
    for (var i = 3; i < 8; i++) {
      await seedActivity(start.add(Duration(days: i)), heartRateMaxBpm: 110);
      await seedBodyScore(start.add(Duration(days: i + 1)), BodyFeeling.good);
    }

    final result = await service.analyze(
      dateKey(start),
      dateKey(start.add(const Duration(days: 10))),
      lagDays: 1,
    );
    expect(result.points.any((p) => p.date == dateKey(start)), isFalse);
  });

  test('activities/calisthenics without a heart rate range are ignored', () async {
    final start = DateTime(2026, 1, 1);
    await seedActivity(start); // no heart rate logged
    await seedBodyScore(start.add(const Duration(days: 1)), BodyFeeling.good);
    for (var i = 2; i < 6; i++) {
      await seedActivity(start.add(Duration(days: i)), heartRateMaxBpm: 120);
      await seedBodyScore(start.add(Duration(days: i + 1)), BodyFeeling.good);
    }

    final result = await service.analyze(
      dateKey(start),
      dateKey(start.add(const Duration(days: 10))),
      lagDays: 1,
    );
    expect(result.points.any((p) => p.date == dateKey(start)), isFalse);
  });
}
