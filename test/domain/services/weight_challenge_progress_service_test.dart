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

  Future<void> seedDay(int daysAgo, double weightKg) async {
    final date = dateKey(DateTime(2026, 3, 20).subtract(Duration(days: daysAgo)));
    final log = await repo.getOrCreateDailyLog(date);
    await repo.upsertDailyLog(log.copyWith(weightKg: weightKg));
  }

  test('returns null when there are no weigh-ins in the window', () async {
    expect(await service.computeCurrentWeightKg(asOf), isNull);
  });

  test('with fewer than 5 readings, averages all of them without trimming', () async {
    await seedDay(1, 79.0);
    await seedDay(2, 80.0);
    await seedDay(3, 90.0); // would be an outlier, but sample is too small to trim

    final result = await service.computeCurrentWeightKg(asOf);
    expect(result, closeTo((79.0 + 80.0 + 90.0) / 3, 0.001));
  });

  test('with 5+ readings, drops the single highest and lowest before averaging', () async {
    await seedDay(1, 100.0); // outlier high
    await seedDay(2, 79.0);
    await seedDay(3, 80.0);
    await seedDay(4, 81.0);
    await seedDay(5, 50.0); // outlier low

    final result = await service.computeCurrentWeightKg(asOf);
    expect(result, closeTo((79.0 + 80.0 + 81.0) / 3, 0.001));
  });

  test('only counts readings within the last 7 days', () async {
    await seedDay(10, 200.0); // outside the window, must be ignored
    await seedDay(1, 80.0);

    final result = await service.computeCurrentWeightKg(asOf);
    expect(result, closeTo(80.0, 0.001));
  });
}
