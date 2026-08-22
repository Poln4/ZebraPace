import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/checkin.dart';

/// Today's fluctuation across check-ins logged so far (app2.py) — mental vs.
/// body/pain, plotted against time-of-day rather than a date axis.
class IntradayFluctuationChart extends StatelessWidget {
  const IntradayFluctuationChart({super.key, required this.checkins});

  final List<Checkin> checkins;

  @override
  Widget build(BuildContext context) {
    if (checkins.length < 2) return const SizedBox.shrink();

    return SizedBox(
      height: 140,
      child: LineChart(
        LineChartData(
          minY: 0.5,
          maxY: 5.5,
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (var i = 0; i < checkins.length; i++)
                  FlSpot(i.toDouble(), checkins[i].mentalState.score.toDouble()),
              ],
              isCurved: true,
              color: ZebraColors.brandTeal,
              barWidth: 2,
              dotData: const FlDotData(show: true),
            ),
            LineChartBarData(
              spots: [
                for (var i = 0; i < checkins.length; i++)
                  FlSpot(i.toDouble(), checkins[i].bodyFeeling.score.toDouble()),
              ],
              isCurved: true,
              color: ZebraColors.sand,
              barWidth: 2,
              dotData: const FlDotData(show: true),
            ),
          ],
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 24, interval: 1),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 24,
                getTitlesWidget: (value, meta) {
                  final i = value.round();
                  if (i < 0 || i >= checkins.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(checkins[i].loggedAt, style: const TextStyle(fontSize: 9)),
                  );
                },
              ),
            ),
          ),
          gridData: const FlGridData(drawVerticalLine: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
