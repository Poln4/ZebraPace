import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';

enum InsightsRangeOption { fourteenDays, thirtyDays, ninetyDays }

extension InsightsRangeOptionX on InsightsRangeOption {
  int get days => switch (this) {
        InsightsRangeOption.fourteenDays => 14,
        InsightsRangeOption.thirtyDays => 30,
        InsightsRangeOption.ninetyDays => 90,
      };

  String label(AppLocalizations l10n) => switch (this) {
        InsightsRangeOption.fourteenDays => l10n.insightsRangeFourteenDays,
        InsightsRangeOption.thirtyDays => l10n.insightsRangeThirtyDays,
        InsightsRangeOption.ninetyDays => l10n.insightsRangeNinetyDays,
      };
}

final insightsRangeOptionProvider =
    StateProvider<InsightsRangeOption>((ref) => InsightsRangeOption.thirtyDays);

class DateRange {
  const DateRange(this.start, this.end);

  final String start;
  final String end;
}

final insightsDateRangeProvider = Provider<DateRange>((ref) {
  final option = ref.watch(insightsRangeOptionProvider);
  final selected = ref.watch(selectedDateProvider);
  final end = dateFromKey(selected);
  final start = end.subtract(Duration(days: option.days - 1));
  return DateRange(dateKey(start), dateKey(end));
});
