import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../l10n/app_localizations.dart';
import 'chart_date_axis.dart';
import 'chart_day_markers.dart';

/// Weight and body-fat % trends. Kept as two separate charts (not overlaid
/// like the weather one) since the point here is watching each metric's own
/// trend, not reading a correlation between them — overlaying two series on
/// very different natural scales (kg vs. %) would need the same
/// normalization trick as weather for no real benefit.
class BodyMetricsChart extends StatelessWidget {
  const BodyMetricsChart({super.key, required this.logs});

  final List<DailyLog> logs;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hasWeight = logs.any((l) => l.weightKg != null);
    final hasFat = logs.any((l) => l.fatPercentage != null);
    if (!hasWeight && !hasFat) {
      return SizedBox(height: 100, child: Center(child: Text(l10n.bodyMetricsChartEmptyState)));
    }
    final dates = [for (final l in logs) l.date];
    final markers = dayStatusRangeAnnotations(logs);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasWeight) ...[
          Text(l10n.bodyMetricsSectionWeightPlaceholder,
              style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
          SizedBox(
            height: 130,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < logs.length; i++)
                        if (logs[i].weightKg != null) FlSpot(i.toDouble(), logs[i].weightKg!),
                    ],
                    isCurved: true,
                    color: ZebraColors.brandTeal,
                    barWidth: 2.5,
                    dotData: const FlDotData(show: true),
                  ),
                ],
                rangeAnnotations: markers,
                titlesData: FlTitlesData(
                  bottomTitles: dateBottomTitles(dates),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 36)),
                ),
                gridData: const FlGridData(drawVerticalLine: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
        if (hasWeight && hasFat) const SizedBox(height: 14),
        if (hasFat) ...[
          Text(l10n.bodyMetricsSectionBodyFatPlaceholder,
              style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
          SizedBox(
            height: 130,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < logs.length; i++)
                        if (logs[i].fatPercentage != null) FlSpot(i.toDouble(), logs[i].fatPercentage!),
                    ],
                    isCurved: true,
                    color: ZebraColors.sand,
                    barWidth: 2.5,
                    dotData: const FlDotData(show: true),
                  ),
                ],
                rangeAnnotations: markers,
                titlesData: FlTitlesData(
                  bottomTitles: dateBottomTitles(dates),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 36)),
                ),
                gridData: const FlGridData(drawVerticalLine: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
