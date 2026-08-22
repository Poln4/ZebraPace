import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/calisthenics_set.dart';
import '../../../../l10n/app_localizations.dart';

enum ComfortGrouping { exercise, contractionMode }

class CalisthenicsComfortChart extends StatelessWidget {
  const CalisthenicsComfortChart({
    super.key,
    required this.sets,
    required this.grouping,
    required this.comfortThreshold,
  });

  final List<CalisthenicsSet> sets;
  final ComfortGrouping grouping;
  final double comfortThreshold;

  static const _seriesColors = [
    ZebraColors.brandTeal,
    ZebraColors.sand,
    ZebraColors.teal,
    ZebraColors.black,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (sets.isEmpty) {
      return SizedBox(
          height: 180, child: Center(child: Text(l10n.calisthenicsComfortChartEmpty)));
    }
    final sorted = [...sets]..sort((a, b) => a.date.compareTo(b.date));
    final dates = sorted.map((s) => s.date).toSet().toList()..sort();
    final dateIndex = {for (var i = 0; i < dates.length; i++) dates[i]: i};

    final groups = <String, List<CalisthenicsSet>>{};
    for (final s in sorted) {
      final key = grouping == ComfortGrouping.exercise
          ? s.exercise.label(l10n)
          : (s.contractionMode?.label(l10n) ?? l10n.calisthenicsComfortChartUnspecified);
      groups.putIfAbsent(key, () => []).add(s);
    }

    final seriesEntries = groups.entries.toList();

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          minY: 0.5,
          maxY: 5.5,
          lineBarsData: [
            for (var i = 0; i < seriesEntries.length; i++)
              LineChartBarData(
                spots: seriesEntries[i].value
                    .map((s) => FlSpot(dateIndex[s.date]!.toDouble(), s.comfortScore))
                    .toList(),
                isCurved: false,
                color: _seriesColors[i % _seriesColors.length],
                barWidth: 2.5,
                dotData: const FlDotData(show: true),
              ),
          ],
          extraLinesData: ExtraLinesData(horizontalLines: [
            HorizontalLine(
              y: comfortThreshold,
              color: CupertinoColors.systemGrey,
              strokeWidth: 1.5,
              dashArray: [4, 4],
            ),
          ]),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
