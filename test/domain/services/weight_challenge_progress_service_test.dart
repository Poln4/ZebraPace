import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/utils/date_utils.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/data/repositories/daily_log_repository.dart';
import 'package:zebrapace_app/domain/services/weight_challenge_progress_service.dart';

void main() {
  late AppDatabase db;
  late DailyLogRepository repo;
  late WeightChallengeProgressService service;

  final asOf = dateKey(DateTime(2026, 3, 20));

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = DailyLogRepository(db);
    service = WeightChallengeProgressService(repo);
  });

  tearDown(() => db.close());

  Future<void> seedDay(int daysAgo, double weightKg, {required bool rest}) async {
    final date = dateKey(DateTime(2026, 3, 20).subtract(Duration(days: daysAgo)));
    final log = await repo.getOrCreateDailyLog(date);
    await repo.upsertDailyLog(log.copyWith(weightKg: weightKg, isRestDay: rest));
  }

  test('returns null when there are no resting-day weigh-ins in the window', () async {
    await seedDay(1, 80.0, rest: false); // active day, doesn't count
    expect(await service.computeCurrentWeightKg(asOf), isNull);
  });

  test('with fewer than 5 readings, averages all of them without trimming', () async {
    await seedDay(1, 79.0, rest: true);
    await seedDay(2, 80.0, rest: true);
    await seedDay(3, 90.0, rest: true); // would be an outlier, but sample is too small to trim

    final result = await service.computeCurrentWeightKg(asOf);
    expect(result, closeTo((79.0 + 80.0 + 90.0) / 3, 0.001));
  });

  test('with 5+ readings, drops the single highest and lowest before averaging', () async {
    await seedDay(1, 100.0, rest: true); // outlier high
    await seedDay(2, 79.0, rest: true);
    await seedDay(3, 80.0, rest: true);
    await seedDay(4, 81.0, rest: true);
    await seedDay(5, 50.0, rest: true); // outlier low

    final result = await service.computeCurrentWeightKg(asOf);
    expect(result, closeTo((79.0 + 80.0 + 81.0) / 3, 0.001));
  });

  test('only counts readings within the last 7 days', () async {
    await seedDay(10, 200.0, rest: true); // outside the window, must be ignored
    await seedDay(1, 80.0, rest: true);

    final result = await service.computeCurrentWeightKg(asOf);
    expect(result, closeTo(80.0, 0.001));
  });

  test('active-day weigh-ins are excluded even inside the window', () async {
    await seedDay(1, 79.0, rest: true);
    await seedDay(2, 500.0, rest: false);

    final result = await service.computeCurrentWeightKg(asOf);
    expect(result, closeTo(79.0, 0.001));
  });
}
