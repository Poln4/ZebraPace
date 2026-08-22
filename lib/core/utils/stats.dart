import 'dart:math' as math;

/// Null if fewer than 2 points or either series has zero variance.
double? pearsonCorrelation(List<double> xs, List<double> ys) {
  final n = xs.length;
  if (n < 2 || ys.length != n) return null;
  final meanX = xs.reduce((a, b) => a + b) / n;
  final meanY = ys.reduce((a, b) => a + b) / n;
  double cov = 0, varX = 0, varY = 0;
  for (var i = 0; i < n; i++) {
    final dx = xs[i] - meanX;
    final dy = ys[i] - meanY;
    cov += dx * dy;
    varX += dx * dx;
    varY += dy * dy;
  }
  if (varX == 0 || varY == 0) return null;
  return cov / math.sqrt(varX * varY);
}
