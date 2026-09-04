import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/daily_log.dart';

/// Shared thin vertical bands marking flare/rest days on any insights chart
/// plotted at integer x = 0..logs.length-1 (one per day). Flare wins if a
/// day is somehow both (isLowEnergyDay treats them as related but the flags
/// are independent booleans on DailyLog).
RangeAnnotations dayStatusRangeAnnotations(List<DailyLog?> logs) {
  final bands = <VerticalRangeAnnotation>[];
  for (var i = 0; i < logs.length; i++) {
    final log = logs[i];
    if (log == null) continue;
    if (log.isFlareDay) {
      bands.add(VerticalRangeAnnotation(
        x1: i - 0.3,
        x2: i + 0.3,
        color: CupertinoColors.systemRed.withValues(alpha: 0.12),
      ));
    } else if (log.isRestDay) {
      bands.add(VerticalRangeAnnotation(
        x1: i - 0.3,
        x2: i + 0.3,
        color: ZebraColors.success.withValues(alpha: 0.12),
      ));
    }
  }
  return RangeAnnotations(verticalRangeAnnotations: bands);
}

bool anyDayMarked(List<DailyLog?> logs) =>
    logs.any((l) => l != null && (l.isFlareDay || l.isRestDay));
