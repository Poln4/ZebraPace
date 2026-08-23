import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../data/repositories/weather_cache_repository.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../l10n/app_localizations.dart';
import 'chart_date_axis.dart';

/// fl_chart has no native dual Y-axis (unlike Plotly's secondary_y) — this
/// stacks two line charts sharing an x-axis instead of forcing one rescaled
/// axis. A visible layout change from the original Plotly figure.
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
    final scoreByDate = {
      for (final l in logs)
        if (l.bodyFeeling != null) l.date: l.bodyFeeling!.score,
    };
    final dates = [for (final d in weatherDays) d.date];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.weatherChartPressureLabel, style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
        SizedBox(
          height: 110,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    for (var i = 0; i < weatherDays.length; i++)
                      if (weatherDays[i].pressureHpa != null)
                        FlSpot(i.toDouble(), weatherDays[i].pressureHpa!),
                  ],
                  isCurved: true,
                  color: ZebraColors.teal,
                  barWidth: 2,
                  dotData: const FlDotData(show: false),
                ),
              ],
              titlesData: FlTitlesData(
                bottomTitles: dateBottomTitles(dates),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
              ),
              gridData: const FlGridData(drawVerticalLine: false),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(l10n.weatherChartBodyPainScoreLabel, style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
        SizedBox(
          height: 110,
          child: LineChart(
            LineChartData(
              minY: 0.5,
              maxY: 5.5,
              lineBarsData: [
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
              titlesData: FlTitlesData(
                bottomTitles: dateBottomTitles(dates),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 24, interval: 1)),
              ),
              gridData: const FlGridData(drawVerticalLine: false),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ],
    );
  }
}
