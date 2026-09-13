import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constants/defaults.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/weight_challenge_entry.dart';
import '../../../../domain/models/weight_challenge_weigh_in.dart';
import '../../../../domain/services/challenge_progress_series_builder.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/section_card.dart';

/// Everyone's remaining distance to the shared 5% goal, over time, on one
/// shared axis — plotting raw kg wouldn't be comparable across different
/// starting weights, so every series is normalized against each person's
/// own start (see ChallengeProgressSeriesBuilder). Plotted as target%
/// minus percent lost — starting at the target (5, nothing achieved yet)
/// and draining to 0 as the goal is reached — rather than percent lost
/// directly (which would climb from 0 up to the target) or a 100-based
/// scale (which buries the number that actually matters, 5%, at an
/// arbitrary-looking 95). A dashed line at the target marks the start;
/// the goal itself is just 0, the bottom of the axis.
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

    // Needs at least one person with 2+ distinct days logged to draw a
    // line at all — but doesn't require a *second* person to have caught
    // up yet. Your own trend alone is still useful; the chart just shows
    // fewer lines until others have enough history too.
    if (series.every((s) => s.points.length < 2)) {
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
    // One label per day at most, however few or many days the data spans —
    // without an explicit interval, fl_chart's own default tick spacing can
    // place more ticks than there are actual days, so the same date (each
    // rounded to its nearest day) ends up printed several times in a row.
    final xInterval = maxX <= 7 ? 1.0 : (maxX / 6).ceilToDouble();

    final startY = WeightChallengeDefaults.targetPercent;
    const goalY = 0.0;
    final allY = [
      for (final s in series) for (final p in s.points) startY - p.percentLost,
      startY,
      goalY,
    ];
    final rawMinY = allY.reduce((a, b) => a < b ? a : b);
    final rawMaxY = allY.reduce((a, b) => a > b ? a : b);
    // A little headroom above/below the data (and the reference lines)
    // instead of clipping right at the edge values.
    final ySpan = rawMaxY - rawMinY;
    final yPadding = ySpan == 0 ? 1.0 : ySpan * 0.2;
    final minY = rawMinY - yPadding;
    final maxY = rawMaxY + yPadding;
    // Same idea as xInterval: pick a step that yields a handful of ticks
    // rather than however many fl_chart would otherwise fit, and rounded to
    // a value the 1-decimal label below can actually show distinctly.
    final ySpanPadded = maxY - minY;
    final yInterval = ySpanPadded <= 1
        ? 0.2
        : ySpanPadded <= 3
            ? 0.5
            : ySpanPadded <= 8
                ? 1.0
                : (ySpanPadded / 5).ceilToDouble();

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
                minY: minY,
                maxY: maxY,
                lineBarsData: [
                  for (var i = 0; i < series.length; i++)
                    LineChartBarData(
                      spots: [
                        for (final p in series[i].points) FlSpot(xFor(p.date), startY - p.percentLost),
                      ],
                      isCurved: false,
                      color: _seriesColors[i % _seriesColors.length],
                      barWidth: 2.5,
                      dotData: const FlDotData(show: true),
                    ),
                ],
                extraLinesData: ExtraLinesData(horizontalLines: [
                  HorizontalLine(
                    y: startY,
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
                    y: goalY,
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
                      interval: yInterval,
                      getTitlesWidget: (value, meta) => Text(
                        '${value.toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 9, color: CupertinoColors.systemGrey),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: xInterval,
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
