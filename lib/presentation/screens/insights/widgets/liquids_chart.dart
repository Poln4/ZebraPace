import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../l10n/app_localizations.dart';

class LiquidsChart extends StatelessWidget {
  const LiquidsChart({super.key, required this.logs, required this.goalMl});

  final List<DailyLog> logs;
  final int goalMl;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (logs.isEmpty) {
      return SizedBox(height: 200, child: Center(child: Text(l10n.liquidsChartEmptyState)));
    }
    final maxCredit = logs.map((l) => l.waterMlCredit).fold<double>(0, (a, b) => a > b ? a : b);
    final maxY = [maxCredit, goalMl.toDouble()].reduce((a, b) => a > b ? a : b) * 1.15;

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          maxY: maxY,
          barGroups: [
            for (var i = 0; i < logs.length; i++)
              BarChartGroupData(x: i, barRods: [
                BarChartRodData(
                  toY: logs[i].waterMlCredit,
                  color: ZebraColors.brandTeal,
                  width: (300 / logs.length).clamp(2, 10),
                ),
              ]),
          ],
          extraLinesData: ExtraLinesData(horizontalLines: [
            HorizontalLine(
              y: goalMl.toDouble(),
              color: ZebraColors.sand,
              strokeWidth: 2,
              dashArray: [6, 4],
            ),
          ]),
          titlesData: const FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
          ),
          gridData: const FlGridData(drawVerticalLine: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
