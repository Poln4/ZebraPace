import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/utils/date_utils.dart';

/// Shared bottom-axis date labels for insights charts. All of these charts
/// plot points at integer x = 0..dates.length-1 (one per day in range), so
/// labels are looked up by rounding the tick value back to an index rather
/// than parsing a date axis.
///
/// Which days get a label is decided here, not by SideTitles.interval:
/// fl_chart's bar charts ignore the interval and label every bar, and its
/// line charts add extra labels at both ends that collide with their
/// neighbours. Counting back from the last day keeps the most recent date
/// labeled.
AxisTitles dateBottomTitles(List<String> dates, {double reservedSize = 22}) {
  if (dates.isEmpty) {
    return const AxisTitles(sideTitles: SideTitles(showTitles: false));
  }
  final last = dates.length - 1;
  final step = dateLabelStep(dates.length);
  return AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: reservedSize,
      interval: 1,
      getTitlesWidget: (value, meta) {
        if ((value - value.roundToDouble()).abs() > 0.01) return const SizedBox.shrink();
        final i = value.round();
        if (i < 0 || i > last || (last - i) % step != 0) return const SizedBox.shrink();
        final d = dateFromKey(dates[i]);
        return Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            '${d.month}/${d.day}',
            style: const TextStyle(fontSize: 9, color: CupertinoColors.systemGrey),
          ),
        );
      },
    ),
  );
}

/// Label every Nth day: every day for a week, every 2nd for two weeks,
/// every 3rd for a month, then about 8 labels across longer ranges.
@visibleForTesting
int dateLabelStep(int dayCount) {
  if (dayCount <= 7) return 1;
  if (dayCount <= 14) return 2;
  if (dayCount <= 31) return 3;
  return (dayCount / 8).ceil();
}
