import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../l10n/app_localizations.dart';
import 'chart_date_axis.dart';
import 'insights_providers.dart';

/// Resting heart rate (with the logged lowest sleeping HR alongside, since
/// that's what stands in for it without a watch) and HRV, as two charts:
/// bpm and ms don't share a scale. Indexed over every date in the range,
/// not just logged days, since Health data doesn't need a log.
class HeartTrendChart extends StatelessWidget {
  const HeartTrendChart({super.key, required this.dates, required this.days});

  final List<String> dates;
  final Map<String, HeartTrendDay> days;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    List<FlSpot> spots(double? Function(HeartTrendDay) of) => [
          for (var i = 0; i < dates.length; i++)
            if (days[dates[i]] case final d? when of(d) != null) FlSpot(i.toDouble(), of(d)!),
        ];
    final resting = spots((d) => d.resting);
    final sleeping = spots((d) => d.sleepingMin);
    final hrv = spots((d) => d.hrv);
    if (resting.isEmpty && sleeping.isEmpty && hrv.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(l10n.heartTrendEmptyState,
            style: const TextStyle(fontSize: 13, color: CupertinoColors.systemGrey)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (resting.isNotEmpty || sleeping.isNotEmpty) ...[
          Wrap(
            spacing: 12,
            children: [
              if (resting.isNotEmpty) _Legend(ZebraColors.brandTeal, l10n.heartTrendRestingLabel),
              if (sleeping.isNotEmpty) _Legend(ZebraColors.sand, l10n.heartTrendSleepingLabel),
            ],
          ),
          const SizedBox(height: 6),
          _chart([
            if (resting.isNotEmpty) _line(resting, ZebraColors.brandTeal),
            if (sleeping.isNotEmpty) _line(sleeping, ZebraColors.sand),
          ]),
        ],
        if ((resting.isNotEmpty || sleeping.isNotEmpty) && hrv.isNotEmpty) const SizedBox(height: 14),
        if (hrv.isNotEmpty) ...[
          _Legend(ZebraColors.teal, l10n.heartTrendHrvLabel),
          const SizedBox(height: 6),
          _chart([_line(hrv, ZebraColors.teal)]),
        ],
      ],
    );
  }

  LineChartBarData _line(List<FlSpot> spots, Color color) => LineChartBarData(
        spots: spots,
        isCurved: true,
        preventCurveOverShooting: true,
        color: color,
        barWidth: 2.5,
        dotData: const FlDotData(show: true),
      );

  Widget _chart(List<LineChartBarData> lines) {
    final ys = [for (final l in lines) for (final s in l.spots) s.y];
    final minY = ys.reduce((a, b) => a < b ? a : b);
    final maxY = ys.reduce((a, b) => a > b ? a : b);
    final pad = ((maxY - minY) * 0.15).clamp(2, double.infinity);
    return SizedBox(
      height: 130,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (dates.length - 1).toDouble(),
          minY: (minY - pad).floorToDouble(),
          maxY: (maxY + pad).ceilToDouble(),
          lineBarsData: lines,
          titlesData: FlTitlesData(
            bottomTitles: dateBottomTitles(dates),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 36)),
          ),
          gridData: const FlGridData(drawVerticalLine: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend(this.color, this.label);

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 3, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
      ],
    );
  }
}
