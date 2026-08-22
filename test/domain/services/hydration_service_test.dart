import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/core/utils/date_utils.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/data/repositories/daily_log_repository.dart';
import 'package:zebrapace_app/data/repositories/liquid_log_repository.dart';
import 'package:zebrapace_app/domain/services/hydration_service.dart';

void main() {
  late AppDatabase db;
  late HydrationService service;
  late DailyLogRepository dailyLogRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    dailyLogRepo = DailyLogRepository(db);
    service = HydrationService(LiquidLogRepository(db), dailyLogRepo);
  });

  tearDown(() => db.close());

  test('hydration credit applies the drink factor and raw stays unweighted', () async {
    final date = dateKey(DateTime(2026, 1, 1));
    await service.logDrink(date: date, drinkType: DrinkType.coffee, amountMlRaw: 200); // factor 0.9
    await service.logDrink(date: date, drinkType: DrinkType.water, amountMlRaw: 300); // factor 1.0

    final log = await dailyLogRepo.getOrCreateDailyLog(date);
    expect(log.waterMlRaw, 500);
    expect(log.waterMlCredit, closeTo(200 * 0.9 + 300 * 1.0, 0.001));
  });

  test('reset clears both raw and credit totals for the day', () async {
    final date = dateKey(DateTime(2026, 1, 1));
    await service.logDrink(date: date, drinkType: DrinkType.water, amountMlRaw: 500);
    await service.resetToday(date);

    final log = await dailyLogRepo.getOrCreateDailyLog(date);
    expect(log.waterMlRaw, 0);
    expect(log.waterMlCredit, 0);
  });
}
