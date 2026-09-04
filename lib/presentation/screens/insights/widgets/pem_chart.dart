import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../core/utils/stats.dart';
import '../../../../domain/services/pem_service.dart';
import '../../../../l10n/app_localizations.dart';

class PemChart extends StatelessWidget {
  const PemChart({super.key, required this.result});

  final PemResult result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (!result.hasEnoughData) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(l10n.pemChartInsufficientData,
            style: const TextStyle(fontSize: 12.5, color: CupertinoColors.systemGrey)),
      );
    }

    final maxSteps = result.points.map((p) => p.steps).fold<int>(0, (a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 180,
          child: ScatterChart(
            ScatterChartData(
              minY: 0.5,
              maxY: 5.5,
              maxX: maxSteps * 1.1,
              minX: 0,
              scatterSpots: [
                for (final p in result.points)
                  ScatterSpot(
                    p.steps.toDouble(),
                    p.laggedBodyScore.toDouble(),
                    dotPainter: FlDotCirclePainter(
                      color: p.bucket == ExertionBucket.higher
                          ? ZebraColors.sand
                          : ZebraColors.brandTeal,
                      radius: 5,
                    ),
                  ),
              ],
              titlesData: const FlTitlesData(
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: const FlGridData(show: true),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.pemChartCorrelationCaption(
            result.correlation!.toStringAsFixed(2),
            classifyCorrelationStrength(result.correlation!).label(l10n),
            result.higherExertionAvgScore?.toStringAsFixed(1) ?? '—',
            result.typicalAvgScore?.toStringAsFixed(1) ?? '—',
          ),
          style: const TextStyle(fontSize: 11.5, color: CupertinoColors.systemGrey),
        ),
      ],
    );
  }
}
