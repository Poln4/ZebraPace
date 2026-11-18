import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

/// Shared value-axis labels for insights charts (weight, heart rate, ml,
/// steps). fl_chart labels the grid lines and, by default, also the exact
/// min and max of the data: with decimals (62.37 next to 62.5) those extra
/// labels sit on top of their neighbours. Here only grid lines get a label,
/// shortened to as many decimals as the grid spacing needs.
AxisTitles valueSideTitles({double reservedSize = 40}) {
  return AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: reservedSize,
      minIncluded: false,
      maxIncluded: false,
      getTitlesWidget: (value, meta) => SideTitleWidget(
        axisSide: meta.axisSide,
        space: 4,
        child: Text(
          axisNumber(value, meta.appliedInterval),
          style: const TextStyle(fontSize: 10, color: CupertinoColors.systemGrey),
        ),
      ),
    ),
  );
}

/// [value] written as briefly as a grid spaced [interval] apart allows:
/// 62.5, 63, 1.2k, 12k.
String axisNumber(double value, double interval) {
  final abs = value.abs();
  if (abs >= 10000) return '${_trim((value / 1000).toStringAsFixed(0))}k';
  if (abs >= 1000) {
    return '${_trim((value / 1000).toStringAsFixed(interval >= 1000 ? 0 : 1))}k';
  }
  return _trim(value.toStringAsFixed(_decimalsOf(interval)));
}

/// How many decimals (at most 2) it takes to write [interval] exactly:
/// 2 → 0, 0.5 → 1, 0.25 → 2.
int _decimalsOf(double interval) {
  for (var d = 0; d < 2; d++) {
    final scaled = interval * [1, 10][d];
    if ((scaled - scaled.roundToDouble()).abs() < 1e-6) return d;
  }
  return 2;
}

String _trim(String s) => s.contains('.') ? s.replaceFirst(RegExp(r'\.?0+$'), '') : s;
