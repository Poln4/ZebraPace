import 'dart:math' as math;

import '../../l10n/app_localizations.dart';

/// Rough, conventional |r| thresholds (0.3 / 0.6) for describing a
/// correlation in plain language alongside the raw coefficient — this app's
/// audience isn't assumed to be statistically fluent.
enum CorrelationStrength {
  weak,
  moderate,
  strong;

  String label(AppLocalizations l10n) => switch (this) {
        CorrelationStrength.weak => l10n.correlationStrengthWeak,
        CorrelationStrength.moderate => l10n.correlationStrengthModerate,
        CorrelationStrength.strong => l10n.correlationStrengthStrong,
      };
}

CorrelationStrength classifyCorrelationStrength(double r) {
  final abs = r.abs();
  if (abs >= 0.6) return CorrelationStrength.strong;
  if (abs >= 0.3) return CorrelationStrength.moderate;
  return CorrelationStrength.weak;
}

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
