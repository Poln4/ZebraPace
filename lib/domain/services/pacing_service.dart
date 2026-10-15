import '../../core/constants/defaults.dart';
import '../../data/repositories/daily_log_repository.dart';
import 'readiness_service.dart';

enum PacingMessageKind {
  flareNeutral,
  caution,
  goalCelebration,
  gentleLow,
  /// Under a smaller-than-usual goal set by low readiness: listening to the
  /// body, not falling short.
  readinessHonored,
  steady,
  noBaseline,
}

class PacingEvaluation {
  const PacingEvaluation({
    required this.avgSteps,
    required this.goalSteps,
    required this.cautionSteps,
    this.readiness = ReadinessResult.unknown,
  });

  final double avgSteps;
  final int goalSteps;
  final int cautionSteps;

  /// What shaped today's envelope. When it [ReadinessLevel.reducesEnvelope],
  /// [goalSteps]/[cautionSteps] are already the reduced values.
  final ReadinessResult readiness;

  bool get hasBaseline => avgSteps > 0;
  bool get isReduced => readiness.level.reducesEnvelope;
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

  /// The energy envelope shrinks on days the body's signals say so,
  /// instead of always asking for growth:
  /// - lower: hold at baseline (no growth); caution line halfway to usual.
  /// - low: goal drops to the gentle-low line; caution line at baseline.
  /// Reaching the top of the envelope is the day's stimulus, not a reason to
  /// keep going.
  PacingEvaluation applyReadiness(
    PacingEvaluation evaluation,
    ReadinessResult readiness, {
    required double cautionPct,
  }) {
    final avg = evaluation.avgSteps;
    return switch (readiness.level) {
      ReadinessLevel.lower => PacingEvaluation(
          avgSteps: avg,
          goalSteps: avg.floor(),
          cautionSteps: (avg * (1 + (cautionPct - 1) / 2)).floor(),
          readiness: readiness,
        ),
      ReadinessLevel.low => PacingEvaluation(
          avgSteps: avg,
          goalSteps: (avg * PacingConstants.lowStepsRatio).floor(),
          cautionSteps: avg.floor(),
          readiness: readiness,
        ),
      _ => PacingEvaluation(
          avgSteps: avg,
          goalSteps: evaluation.goalSteps,
          cautionSteps: evaluation.cautionSteps,
          readiness: readiness,
        ),
    };
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
    if (evaluation.isReduced) return PacingMessageKind.readinessHonored;
    if (steps < evaluation.avgSteps * PacingConstants.lowStepsRatio) {
      return PacingMessageKind.gentleLow;
    }
    return PacingMessageKind.steady;
  }
}
