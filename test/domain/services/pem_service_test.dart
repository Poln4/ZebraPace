import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/core/utils/date_utils.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/data/repositories/daily_log_repository.dart';
import 'package:zebrapace_app/domain/services/pem_service.dart';

void main() {
  late AppDatabase db;
  late DailyLogRepository repo;
  late PemService service;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = DailyLogRepository(db);
    service = PemService(repo);
  });

  tearDown(() => db.close());

  Future<void> seed(DateTime date, {int steps = 0, BodyFeeling? body}) async {
    final key = dateKey(date);
    final log = await repo.getOrCreateDailyLog(key);
    await repo.upsertDailyLog(log.copyWith(steps: steps, bodyFeeling: body));
  }

  test('below minimum sample size returns no correlation', () async {
    final start = DateTime(2026, 1, 1);
    for (var i = 0; i < 2; i++) {
      await seed(start.add(Duration(days: i * 2)), steps: 5000);
      await seed(start.add(Duration(days: i * 2 + 1)), body: BodyFeeling.good);
    }
    final result = await service.analyze(
      dateKey(start),
      dateKey(start.add(const Duration(days: 10))),
      lagDays: 1,
    );
    expect(result.hasEnoughData, isFalse);
  });

  test('calendar-date lag only pairs a day with the exact date N days later', () async {
    final start = DateTime(2026, 1, 1);
    // 5 days with steps, but the lagged-by-1 date only has a body score
    // logged for 4 of them (day 5's lagged date is never logged) —
    // calendar-based lag should yield exactly 4 points, not 5.
    for (var i = 0; i < 5; i++) {
      await seed(start.add(Duration(days: i)), steps: 1000 + i * 100);
    }
    for (var i = 0; i < 4; i++) {
      final laggedDate = start.add(Duration(days: i + 1));
      final log = await repo.getOrCreateDailyLog(dateKey(laggedDate));
      await repo.upsertDailyLog(log.copyWith(bodyFeeling: BodyFeeling.manageable));
    }

    final result = await service.analyze(
      dateKey(start),
      dateKey(start.add(const Duration(days: 10))),
      lagDays: 1,
    );
    expect(result.points.length, 4);
  });

  test('a gap in logging does not silently bridge to the next available row', () async {
    // Day 1 has steps; day 2 (the true +1 lag date) has no body score logged
    // at all, but day 3 does. A row-shift implementation would incorrectly
    // pair day 1's steps with day 3's score; calendar-based must not.
    final start = DateTime(2026, 1, 1);
    await seed(start, steps: 5000);
    final day3 = start.add(const Duration(days: 2));
    final log = await repo.getOrCreateDailyLog(dateKey(day3));
    await repo.upsertDailyLog(log.copyWith(bodyFeeling: BodyFeeling.severe));
    // Pad with enough other unrelated qualifying days to not matter for this
    // specific assertion (checking day1 specifically is excluded).
    for (var i = 3; i < 8; i++) {
      await seed(start.add(Duration(days: i)), steps: 3000, body: BodyFeeling.good);
    }

    final result = await service.analyze(
      dateKey(start),
      dateKey(start.add(const Duration(days: 10))),
      lagDays: 1,
    );
    expect(result.points.any((p) => p.date == dateKey(start)), isFalse);
  });
}
