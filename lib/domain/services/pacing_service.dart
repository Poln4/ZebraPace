import '../../core/constants/defaults.dart';
import '../../data/repositories/daily_log_repository.dart';

enum PacingMessageKind {
  flareNeutral,
  caution,
  goalCelebration,
  gentleLow,
  steady,
  noBaseline,
}

class PacingEvaluation {
  const PacingEvaluation({
    required this.avgSteps,
    required this.goalSteps,
    required this.cautionSteps,
  });

  final double avgSteps;
  final int goalSteps;
  final int cautionSteps;

  bool get hasBaseline => avgSteps > 0;
}

/// Ported from app.py's get_weekly_average_steps + the steps-save message
/// branch. Every threshold/branch order here is load-bearing — this is the
/// app's central safety feature (the "1% rule" + PEM caution line).
class PacingService {
  PacingService(this._dailyLogRepository);

  final DailyLogRepository _dailyLogRepository;

  /// Baseline = mean of the most-recent `sampleSize` qualifying rows found
  /// within `lookbackDays` calendar days before `targetDate` (target date
  /// itself excluded). Not a fixed calendar week.
  Future<PacingEvaluation> evaluateForDate(
    String targetDate, {
    required double growthGoalPct,
    required double cautionPct,
    int lookbackDays = PacingConstants.lookbackDays,
    int sampleSize = PacingConstants.sampleSize,
  }) async {
    final recentSteps = await _dailyLogRepository.getRecentQualifyingSteps(
      targetDate,
      lookbackDays: lookbackDays,
      maxRows: sampleSize,
    );
    final avg = recentSteps.isEmpty
        ? 0.0
        : recentSteps.reduce((a, b) => a + b) / recentSteps.length;
    return PacingEvaluation(
      avgSteps: avg,
      // Python's int(avg * GROWTH_GOAL) truncates towards zero — .floor()
      // matches for the non-negative values this always deals with.
      goalSteps: (avg * growthGoalPct).floor(),
      cautionSteps: (avg * cautionPct).floor(),
    );
  }

  /// Branch order matters and must be preserved exactly (app.py's Save
  /// Steps button handler): flare day takes precedence over any comparison;
  /// otherwise caution > goal > gentle-low > steady, in that order.
  PacingMessageKind evaluateStepsMessage({
    required int steps,
    required bool isFlareDay,
    required PacingEvaluation evaluation,
  }) {
    if (isFlareDay) return PacingMessageKind.flareNeutral;
    if (!evaluation.hasBaseline) return PacingMessageKind.noBaseline;
    if (steps > evaluation.cautionSteps) return PacingMessageKind.caution;
    if (steps >= evaluation.goalSteps) return PacingMessageKind.goalCelebration;
    if (steps < evaluation.avgSteps * PacingConstants.lowStepsRatio) {
      return PacingMessageKind.gentleLow;
    }
    return PacingMessageKind.steady;
  }
}
