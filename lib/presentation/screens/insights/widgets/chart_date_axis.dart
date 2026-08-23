import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/utils/date_utils.dart';

/// Shared bottom-axis date labels for insights charts. All of these charts
/// plot points at integer x = 0..dates.length-1 (one per day in range), so
/// labels are looked up by rounding the tick value back to an index rather
/// than parsing a date axis. Thins labels as the range grows so 30/90-day
/// charts don't render an unreadable wall of overlapping text.
AxisTitles dateBottomTitles(List<String> dates, {double reservedSize = 22}) {
  if (dates.isEmpty) {
    return const AxisTitles(sideTitles: SideTitles(showTitles: false));
  }
  return AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: reservedSize,
      interval: _labelInterval(dates.length),
      getTitlesWidget: (value, meta) {
        final i = value.round();
        if (i < 0 || i >= dates.length) return const SizedBox.shrink();
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

/// Roughly 5-7 labels no matter the range length.
double _labelInterval(int dayCount) {
  if (dayCount <= 7) return 1;
  return (dayCount / 6).ceil().toDouble();
}
