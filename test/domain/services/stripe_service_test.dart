import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/utils/date_utils.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/data/repositories/daily_log_repository.dart';
import 'package:zebrapace_app/data/repositories/settings_repository.dart';
import 'package:zebrapace_app/domain/services/stripe_service.dart';

void main() {
  late AppDatabase db;
  late DailyLogRepository dailyLogRepo;
  late SettingsRepository settingsRepo;
  late StripeService service;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    dailyLogRepo = DailyLogRepository(db);
    settingsRepo = SettingsRepository(db);
    service = StripeService(dailyLogRepo, settingsRepo);
  });

  tearDown(() => db.close());

  Future<void> seedCheckinDays(int count, {int startOffset = 0}) async {
    for (var i = 0; i < count; i++) {
      final date = dateKey(DateTime(2026, 1, 1).add(Duration(days: startOffset + i)));
      final log = await dailyLogRepo.getOrCreateDailyLog(date);
      await dailyLogRepo.upsertDailyLog(log.copyWith(steps: 1000));
    }
  }

  test('every 5 check-ins earns one stripe, capped at 20 slots', () async {
    await seedCheckinDays(12);
    final status = await service.checkStatus();
    expect(status.stripesEarned, 2); // 12 ~/ 5 = 2
  });

  test('justUnlocked is true the first time a new stripe is crossed, then false on repeat reads', () async {
    await seedCheckinDays(5);
    final first = await service.checkStatus();
    expect(first.stripesEarned, 1);
    expect(first.justUnlocked, isTrue);

    final second = await service.checkStatus();
    expect(second.stripesEarned, 1);
    expect(second.justUnlocked, isFalse,
        reason: 'marker was persisted after the first read, must not refire');
  });

  test('crossing a second stripe after the marker was persisted celebrates again', () async {
    await seedCheckinDays(5);
    await service.checkStatus(); // persists marker at 1
    await seedCheckinDays(5, startOffset: 5); // 5 more distinct days -> 10 total
    final status = await service.checkStatus();
    expect(status.stripesEarned, 2);
    expect(status.justUnlocked, isTrue);
  });
}
