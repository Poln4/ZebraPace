import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/models/daily_log.dart';
import '../../../../l10n/app_localizations.dart';
import 'chart_date_axis.dart';
import 'chart_day_markers.dart';

/// Shared 1-5 trend line, used for both Mental State and Body/Pain trends
/// (app.py has two separate charts with identical shape — one widget here,
/// parameterized by which score to plot).
class FeelingTrendChart extends StatelessWidget {
  const FeelingTrendChart({super.key, required this.logs, required this.scoreOf, required this.color});

  final List<DailyLog> logs;
  final int? Function(DailyLog) scoreOf; // null = no entry that day
  final Color color;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scores = logs.map(scoreOf).toList();
    if (scores.every((s) => s == null)) {
      return SizedBox(height: 160, child: Center(child: Text(l10n.feelingTrendChartEmptyState)));
    }
    return SizedBox(
      height: 160,
      child: LineChart(
        LineChartData(
          minY: 0.5,
          maxY: 5.5,
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (var i = 0; i < scores.length; i++)
                  if (scores[i] != null) FlSpot(i.toDouble(), scores[i]!.toDouble()),
              ],
              isCurved: false,
              color: color,
              barWidth: 2.5,
              dotData: const FlDotData(show: true),
            ),
          ],
          rangeAnnotations: dayStatusRangeAnnotations(logs),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: dateBottomTitles([for (final l in logs) l.date]),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 24, interval: 1),
            ),
          ),
          gridData: const FlGridData(drawVerticalLine: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
