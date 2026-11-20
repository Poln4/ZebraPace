import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_utils.dart';
import '../../../../domain/services/plus_access.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../../providers/plus_providers.dart';

/// 14/30/90 days are free; longer windows are Zebras+ (business_plan.md
/// §4.4, N = 13 weeks). What's paid is the window's length, not its date:
/// moving the selected day back still shows any 90-day window.
enum InsightsRangeOption { fourteenDays, thirtyDays, ninetyDays, sixMonths, oneYear, all }

extension InsightsRangeOptionX on InsightsRangeOption {
  /// Window length in days; null for [InsightsRangeOption.all], which runs
  /// from the first logged day.
  int? get fixedDays => switch (this) {
        InsightsRangeOption.fourteenDays => 14,
        InsightsRangeOption.thirtyDays => 30,
        InsightsRangeOption.ninetyDays => 90,
        InsightsRangeOption.sixMonths => 182,
        InsightsRangeOption.oneYear => 365,
        InsightsRangeOption.all => null,
      };

  bool get needsPlus {
    final days = fixedDays;
    return days == null || rangeNeedsPlus(days);
  }

  String label(AppLocalizations l10n) => switch (this) {
        InsightsRangeOption.fourteenDays => l10n.insightsRangeFourteenDays,
        InsightsRangeOption.thirtyDays => l10n.insightsRangeThirtyDays,
        InsightsRangeOption.ninetyDays => l10n.insightsRangeNinetyDays,
        InsightsRangeOption.sixMonths => l10n.insightsRangeSixMonths,
        InsightsRangeOption.oneYear => l10n.insightsRangeOneYear,
        InsightsRangeOption.all => l10n.insightsRangeAll,
      };
}

/// What the person picked. Read [effectiveInsightsRangeOptionProvider] for
/// what's shown — a Zebras+ range falls back to 90 days if the plan lapses.
final insightsRangeOptionProvider =
    StateProvider<InsightsRangeOption>((ref) => InsightsRangeOption.thirtyDays);

final effectiveInsightsRangeOptionProvider = Provider<InsightsRangeOption>((ref) {
  final picked = ref.watch(insightsRangeOptionProvider);
  if (picked.needsPlus && !ref.watch(isPlusProvider)) return InsightsRangeOption.ninetyDays;
  return picked;
});

final earliestLogDateProvider = FutureProvider<String?>((ref) {
  return ref.watch(dailyLogRepositoryProvider).getEarliestDate();
});

class DateRange {
  const DateRange(this.start, this.end);

  final String start;
  final String end;

  /// Inclusive length in days.
  int get days => dateFromKey(end).difference(dateFromKey(start)).inDays + 1;
}

final insightsDateRangeProvider = Provider<DateRange>((ref) {
  final option = ref.watch(effectiveInsightsRangeOptionProvider);
  final earliest = option == InsightsRangeOption.all
      ? ref.watch(earliestLogDateProvider).valueOrNull
      : null;
  return dateRangeFor(option, selected: ref.watch(selectedDateProvider), earliest: earliest);
});

/// The window [option] covers, ending on [selected]. Shared by Insights
/// and the PDF summary, which has its own (always free) period choice.
/// All runs from [earliest], the first logged day (a year when unknown or
/// the log is empty), never after [selected].
DateRange dateRangeFor(InsightsRangeOption option, {required String selected, String? earliest}) {
  final end = dateFromKey(selected);
  final days = option.fixedDays ?? 365;
  final start = dateKey(DateTime(end.year, end.month, end.day - (days - 1)));
  if (option != InsightsRangeOption.all || earliest == null) return DateRange(start, selected);
  return DateRange(earliest.compareTo(selected) > 0 ? selected : earliest, selected);
}
