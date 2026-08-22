import '../../core/constants/enums.dart';
import '../../data/repositories/daily_log_repository.dart';
import '../../data/repositories/liquid_log_repository.dart';

/// Ported from app.py's hydration tracking, with the raw-vs-credit split
/// called for in the plan: DailyLog.waterMlRaw/waterMlCredit are derived by
/// summing liquid_logs for the day on every write, rather than incrementally
/// mutated — removes the drift risk the original's mutable running total had.
class HydrationService {
  HydrationService(this._liquidLogRepository, this._dailyLogRepository);

  final LiquidLogRepository _liquidLogRepository;
  final DailyLogRepository _dailyLogRepository;

  Future<void> logDrink({
    required String date,
    required DrinkType drinkType,
    required int amountMlRaw,
    String? customDrinkLabel,
  }) async {
    await _liquidLogRepository.insert(
      date: date,
      drinkType: drinkType,
      amountMlRaw: amountMlRaw,
      customDrinkLabel: customDrinkLabel,
    );
    await _recomputeDailyTotals(date);
  }

  Future<void> resetToday(String date) async {
    await _liquidLogRepository.deleteForDate(date);
    await _recomputeDailyTotals(date);
  }

  Future<void> _recomputeDailyTotals(String date) async {
    final sums = await _liquidLogRepository.sumForDate(date);
    final log = await _dailyLogRepository.getOrCreateDailyLog(date);
    await _dailyLogRepository.upsertDailyLog(
      log.copyWith(waterMlRaw: sums.raw, waterMlCredit: sums.credit),
    );
  }
}
