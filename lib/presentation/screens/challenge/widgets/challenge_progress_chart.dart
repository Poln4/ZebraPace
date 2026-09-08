import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constants/defaults.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/weight_challenge_entry.dart';
import '../../../../domain/models/weight_challenge_weigh_in.dart';
import '../../../../domain/services/challenge_progress_series_builder.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/section_card.dart';

/// Everyone's percent-of-starting-weight-lost over time, on one shared axis
/// — plotting raw kg wouldn't be comparable across different starting
/// weights, so every series is normalized against each person's own start
/// (see ChallengeProgressSeriesBuilder). A dashed line at 0% marks that
/// starting point for reference, and one at the target % marks the goal.
class ChallengeProgressChart extends StatelessWidget {
  const ChallengeProgressChart({required this.entries, required this.history, super.key});

  final List<WeightChallengeEntry> entries;
  final List<WeightChallengeWeighIn> history;

  static const _seriesColors = [ZebraColors.brandTeal, ZebraColors.teal, ZebraColors.sand];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final series = ChallengeProgressSeriesBuilder.build(entries, history)
        .where((s) => s.points.isNotEmpty)
        .toList();

    if (series.length < 2 || series.every((s) => s.points.length < 2)) {
      return SectionCard(
        title: l10n.challengeTabProgressChartTitle,
        child: Text(
          l10n.challengeTabProgressChartEmptyState,
          style: const TextStyle(fontSize: 13, color: CupertinoColors.systemGrey),
        ),
      );
    }

    final allDates = [for (final s in series) for (final p in s.points) p.date];
    final anchor = allDates.reduce((a, b) => a.isBefore(b) ? a : b);
    double xFor(DateTime date) => date.difference(anchor).inHours / 24.0;
    final maxX = [for (final s in series) for (final p in s.points) xFor(p.date)]
        .reduce((a, b) => a > b ? a : b);

    return SectionCard(
      title: l10n.challengeTabProgressChartTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: maxX <= 0 ? 1 : maxX,
                lineBarsData: [
                  for (var i = 0; i < series.length; i++)
                    LineChartBarData(
                      spots: [for (final p in series[i].points) FlSpot(xFor(p.date), p.percentLost)],
                      isCurved: false,
                      color: _seriesColors[i % _seriesColors.length],
                      barWidth: 2.5,
                      dotData: const FlDotData(show: true),
                    ),
                ],
                extraLinesData: ExtraLinesData(horizontalLines: [
                  HorizontalLine(
                    y: 0,
                    color: CupertinoColors.systemGrey,
                    strokeWidth: 1,
                    dashArray: [4, 4],
                    label: HorizontalLineLabel(
                      show: true,
                      alignment: Alignment.topLeft,
                      style: const TextStyle(fontSize: 9, color: CupertinoColors.systemGrey),
                      labelResolver: (_) => l10n.challengeTabProgressChartStartLabel,
                    ),
                  ),
                  HorizontalLine(
                    y: WeightChallengeDefaults.targetPercent,
                    color: ZebraColors.success,
                    strokeWidth: 1,
                    dashArray: [4, 4],
                    label: HorizontalLineLabel(
                      show: true,
                      alignment: Alignment.topLeft,
                      style: const TextStyle(fontSize: 9, color: ZebraColors.success),
                      labelResolver: (_) => l10n.challengeTabProgressChartGoalLabel,
                    ),
                  ),
                ]),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (value, meta) => Text(
                        '${value.toStringAsFixed(0)}%',
                        style: const TextStyle(fontSize: 9, color: CupertinoColors.systemGrey),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      getTitlesWidget: (value, meta) {
                        final date = anchor.add(Duration(hours: (value * 24).round()));
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            '${date.month}/${date.day}',
                            style: const TextStyle(fontSize: 9, color: CupertinoColors.systemGrey),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                gridData: const FlGridData(drawVerticalLine: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              for (var i = 0; i < series.length; i++)
                _LegendItem(color: _seriesColors[i % _seriesColors.length], label: series[i].displayName),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: ZebraColors.black)),
      ],
    );
  }
}
