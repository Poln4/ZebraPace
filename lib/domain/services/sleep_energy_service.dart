import '../../core/constants/enums.dart';

/// Purely informational "how rested does today look" readout — deliberately
/// kept separate from PacingService's step goal/caution math, which is
/// intentionally not reactive to any single day's signal (see the
/// principleAutoEscalationTitle philosophy tip). Sleep never changes those
/// numbers; it only drives its own, parallel display.
class SleepEnergyService {
  /// Returns 0.0-1.0, or null when neither sleepHours nor sleepQuality has
  /// been logged yet — callers should show an honest "no data" state rather
  /// than a fabricated value in that case. Averages whichever of the two
  /// components is actually present when only one is logged.
  double? computeEnergyLevel({
    required double? sleepHours,
    required SleepQuality? sleepQuality,
    required double sleepGoalHours,
  }) {
    final durationScore =
        sleepHours == null ? null : (sleepHours / sleepGoalHours).clamp(0.0, 1.0);
    final qualityScore = sleepQuality == null ? null : sleepQuality.score / 5.0;

    if (durationScore == null && qualityScore == null) return null;
    if (durationScore == null) return qualityScore;
    if (qualityScore == null) return durationScore;
    return (durationScore + qualityScore) / 2;
  }
}
