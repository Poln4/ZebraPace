import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../l10n/app_localizations.dart';
import 'chart_date_axis.dart';
import 'chart_day_markers.dart';

/// Bar (daily steps) + line (7-day rolling average) combo. fl_chart has no
/// native combo chart type — this composites a LineChart transparently over
/// a BarChart in a Stack, both driven by the same shared axis domain
/// (0..logs.length-1 on X, 0..maxY on Y) so the two stay aligned.
class StepsChart extends StatelessWidget {
  const StepsChart({super.key, required this.logs});

  final List<DailyLog> logs;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (logs.isEmpty) {
      return SizedBox(height: 200, child: Center(child: Text(l10n.stepsChartEmptyState)));
    }

    final rollingAvg = _rollingAverage(logs.map((l) => l.steps.toDouble()).toList(), 7);
    final maxSteps = logs.map((l) => l.steps).fold<int>(0, (a, b) => a > b ? a : b);
    final maxY = (maxSteps * 1.15).clamp(10, double.infinity).toDouble();

    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          BarChart(
            BarChartData(
              maxY: maxY,
              barGroups: [
                for (var i = 0; i < logs.length; i++)
                  BarChartGroupData(x: i, barRods: [
                    BarChartRodData(
                      toY: logs[i].steps.toDouble(),
                      color: ZebraColors.brandTeal.withValues(alpha: 0.55),
                      width: (300 / logs.length).clamp(2, 10),
                    ),
                  ]),
              ],
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: dateBottomTitles([for (final l in logs) l.date]),
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 36)),
              ),
              rangeAnnotations: dayStatusRangeAnnotations(logs),
              gridData: const FlGridData(drawVerticalLine: false),
              borderData: FlBorderData(show: false),
            ),
          ),
          LineChart(
            LineChartData(
              maxY: maxY,
              minY: 0,
              lineTouchData: const LineTouchData(enabled: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    for (var i = 0; i < rollingAvg.length; i++)
                      if (rollingAvg[i] != null) FlSpot(i.toDouble(), rollingAvg[i]!),
                  ],
                  isCurved: true,
                  color: ZebraColors.sand,
                  barWidth: 2.5,
                  dotData: const FlDotData(show: false),
                ),
              ],
              titlesData: const FlTitlesData(show: false),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
            ),
          ),
        ],
      ),
    );
  }

  List<double?> _rollingAverage(List<double> values, int window) {
    final out = List<double?>.filled(values.length, null);
    for (var i = 0; i < values.length; i++) {
      final start = (i - window + 1).clamp(0, values.length);
      final slice = values.sublist(start, i + 1);
      out[i] = slice.reduce((a, b) => a + b) / slice.length;
    }
    return out;
  }
}
