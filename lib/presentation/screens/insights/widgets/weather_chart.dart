import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../data/repositories/weather_cache_repository.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../l10n/app_localizations.dart';
import 'chart_date_axis.dart';
import 'chart_day_markers.dart';

/// fl_chart has no native dual Y-axis (unlike Plotly's secondary_y), so
/// pressure is min-max normalized onto the body-score's 0.5-5.5 scale and
/// overlaid on the same chart as the real score. This trades absolute
/// pressure readability (recovered via the caption below, in real hPa) for
/// making co-movement — the thing that actually shows a correlation —
/// visible at a glance, closer to what the dual-axis original showed.
class WeatherChart extends StatelessWidget {
  const WeatherChart({super.key, required this.weatherDays, required this.logs});

  final List<WeatherDay> weatherDays;
  final List<DailyLog> logs;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (weatherDays.isEmpty) {
      return SizedBox(height: 160, child: Center(child: Text(l10n.weatherChartEmptyState)));
    }
    final logsByDate = {for (final l in logs) l.date: l};
    final scoreByDate = {
      for (final l in logs)
        if (l.bodyFeeling != null) l.date: l.bodyFeeling!.score,
    };
    final dates = [for (final d in weatherDays) d.date];

    final pressures = [for (final d in weatherDays) d.pressureHpa].whereType<double>().toList();
    final minP = pressures.isEmpty ? null : pressures.reduce((a, b) => a < b ? a : b);
    final maxP = pressures.isEmpty ? null : pressures.reduce((a, b) => a > b ? a : b);

    double? normalizePressure(double? v) {
      if (v == null || minP == null || maxP == null) return null;
      if (maxP == minP) return 3.0; // flat across the range — sit it mid-scale
      return 0.5 + (v - minP) / (maxP - minP) * 5.0;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 160,
          child: LineChart(
            LineChartData(
              minY: 0.5,
              maxY: 5.5,
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    for (var i = 0; i < weatherDays.length; i++)
                      if (normalizePressure(weatherDays[i].pressureHpa) != null)
                        FlSpot(i.toDouble(), normalizePressure(weatherDays[i].pressureHpa)!),
                  ],
                  isCurved: true,
                  color: ZebraColors.teal,
                  barWidth: 2,
                  dotData: const FlDotData(show: false),
                ),
                LineChartBarData(
                  spots: [
                    for (var i = 0; i < weatherDays.length; i++)
                      if (scoreByDate[weatherDays[i].date] != null)
                        FlSpot(i.toDouble(), scoreByDate[weatherDays[i].date]!.toDouble()),
                  ],
                  isCurved: false,
                  dashArray: [4, 3],
                  color: ZebraColors.sand,
                  barWidth: 2,
                  dotData: const FlDotData(show: true),
                ),
              ],
              rangeAnnotations: dayStatusRangeAnnotations(
                [for (final d in weatherDays) logsByDate[d.date]],
              ),
              titlesData: FlTitlesData(
                bottomTitles: dateBottomTitles(dates),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 24, interval: 1),
                ),
              ),
              gridData: const FlGridData(drawVerticalLine: false),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 4,
          children: [
            _LegendDot(color: ZebraColors.teal, label: l10n.weatherChartPressureLabel),
            _LegendDot(color: ZebraColors.sand, label: l10n.weatherChartBodyPainScoreLabel),
          ],
        ),
        if (minP != null && maxP != null) ...[
          const SizedBox(height: 4),
          Text(
            l10n.insightsTabWeatherPressureRange(minP.toStringAsFixed(0), maxP.toStringAsFixed(0)),
            style: const TextStyle(fontSize: 10.5, color: CupertinoColors.systemGrey),
          ),
        ],
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
      ],
    );
  }
}
