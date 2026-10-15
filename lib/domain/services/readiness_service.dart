import 'dart:math' as math;

import '../../core/constants/enums.dart';
import '../../core/utils/date_utils.dart';
import '../models/soreness_check.dart';

/// One day's autonomic markers. Either value may be missing. [hrvMs] is
/// whatever HRV metric the device records (SDNN from Apple Health, RMSSD
/// from Health Connect): only ever compared against its own history, never
/// against a fixed number.
class AutonomicReading {
  const AutonomicReading({this.restingHeartRate, this.hrvMs});

  final double? restingHeartRate;
  final double? hrvMs;
}

enum ReadinessLevel {
  /// Not enough history to say anything. The envelope stays as usual.
  unknown,

  /// Markers are within the person's own normal range.
  steady,

  /// Something is off: hold at baseline, no growth today.
  lower,

  /// Clearly strained: a smaller day than usual.
  low;

  bool get reducesEnvelope => this == lower || this == low;
}

enum ReadinessReason {
  restingHeartRateUp,
  hrvDown,
  /// Soreness logged 3+ days ago still isn't easing (past the 24–72h DOMS window).
  recoveryWindowExceeded,
  /// A soreness check in the last 2 days came out as a possible crash.
  possibleCrash,
}

class ReadinessResult {
  const ReadinessResult({
    required this.level,
    this.reasons = const {},
    this.restingHeartRateDelta,
    this.hrvPercentBelow,
    this.restingHeartRateToday,
    this.restingHeartRateUsual,
    this.restingHeartRateHistoryDays = 0,
    this.restingHeartRateFromSleep = false,
    this.hrvToday,
    this.hrvUsual,
    this.hrvHistoryDays = 0,
  });

  static const unknown = ReadinessResult(level: ReadinessLevel.unknown);

  final ReadinessLevel level;
  final Set<ReadinessReason> reasons;

  /// Today's resting HR minus the personal baseline, in bpm.
  final double? restingHeartRateDelta;

  /// How far today's HRV sits below the personal baseline, in percent.
  final double? hrvPercentBelow;

  /// Today's readings and the personal "usual" (baseline mean; geometric
  /// mean for HRV) for display. Usual is null until there are
  /// [ReadinessService.minBaselineReadings] days of history; the history
  /// counts say how far along that is.
  final double? restingHeartRateToday;
  final double? restingHeartRateUsual;
  final int restingHeartRateHistoryDays;

  /// True when no resting HR was logged or recorded, so the series is the
  /// logged lowest sleeping heart rate instead (labelled as such).
  final bool restingHeartRateFromSleep;
  final double? hrvToday;
  final double? hrvUsual;
  final int hrvHistoryDays;

  ReadinessResult withRestingHeartRateFromSleep() => ReadinessResult(
        level: level,
        reasons: reasons,
        restingHeartRateDelta: restingHeartRateDelta,
        hrvPercentBelow: hrvPercentBelow,
        restingHeartRateToday: restingHeartRateToday,
        restingHeartRateUsual: restingHeartRateUsual,
        restingHeartRateHistoryDays: restingHeartRateHistoryDays,
        restingHeartRateFromSleep: true,
        hrvToday: hrvToday,
        hrvUsual: hrvUsual,
        hrvHistoryDays: hrvHistoryDays,
      );
}

/// Turns autonomic markers (resting HR, HRV) and recent soreness checks
/// into a readiness level for the step envelope. Every comparison is against
/// the person's own rolling baseline, never a population norm. A heuristic
/// for pacing, not a diagnosis.
class ReadinessService {
  /// Rolling window for the personal baseline (the research's 7–21 days).
  static const baselineDays = 21;
  static const minBaselineReadings = 5;

  /// Resting HR floors in bpm, so a very stable baseline (tiny SD) doesn't
  /// flag a 1-bpm wobble.
  static const restingHrLowerFloorBpm = 3.0;
  static const restingHrLowFloorBpm = 6.0;

  /// HRV is compared on a log scale (ln HRV is close to normally
  /// distributed; raw HRV is skewed). 0.05 ≈ a 5% drop.
  static const lnHrvSdFloor = 0.05;

  ReadinessResult evaluate({
    required String date,
    required Map<String, AutonomicReading> readings,
    required List<SorenessCheck> sorenessChecks,
  }) {
    final reasons = <ReadinessReason>{};
    var level = ReadinessLevel.unknown;
    void raise(ReadinessLevel to, ReadinessReason reason) {
      reasons.add(reason);
      if (to.index > level.index) level = to;
    }

    final today = readings[date];
    final history = <AutonomicReading>[
      for (var i = 1; i <= baselineDays; i++) ?readings[_shift(date, -i)],
    ];

    double? rhrDelta;
    double? rhrUsual;
    final rhrToday = today?.restingHeartRate;
    final rhrHistory = [for (final r in history) ?r.restingHeartRate];
    if (rhrHistory.length >= minBaselineReadings) rhrUsual = _meanSd(rhrHistory).$1;
    if (rhrToday != null && rhrHistory.length >= minBaselineReadings) {
      final (mean, sd) = _meanSd(rhrHistory);
      rhrDelta = rhrToday - mean;
      if (level == ReadinessLevel.unknown) level = ReadinessLevel.steady;
      if (rhrDelta >= math.max(2 * sd, restingHrLowFloorBpm)) {
        raise(ReadinessLevel.low, ReadinessReason.restingHeartRateUp);
      } else if (rhrDelta >= math.max(sd, restingHrLowerFloorBpm)) {
        raise(ReadinessLevel.lower, ReadinessReason.restingHeartRateUp);
      }
    }

    double? hrvBelow;
    final hrvToday = today?.hrvMs;
    final lnHrvHistory = [
      for (final r in history)
        if (r.hrvMs case final v? when v > 0) math.log(v),
    ];
    final hrvUsual = lnHrvHistory.length >= minBaselineReadings
        ? math.exp(_meanSd(lnHrvHistory).$1)
        : null;
    if (hrvToday != null && hrvToday > 0 && lnHrvHistory.length >= minBaselineReadings) {
      final (mean, rawSd) = _meanSd(lnHrvHistory);
      final sd = math.max(rawSd, lnHrvSdFloor);
      final lnToday = math.log(hrvToday);
      hrvBelow = (1 - math.exp(lnToday - mean)) * 100;
      if (level == ReadinessLevel.unknown) level = ReadinessLevel.steady;
      if (lnToday <= mean - 2 * sd) {
        raise(ReadinessLevel.low, ReadinessReason.hrvDown);
      } else if (lnToday <= mean - sd) {
        raise(ReadinessLevel.lower, ReadinessReason.hrvDown);
      }
    }

    _applySoreness(date, sorenessChecks, raise);

    return ReadinessResult(
      level: level,
      reasons: reasons,
      restingHeartRateDelta: rhrDelta,
      hrvPercentBelow: hrvBelow,
      restingHeartRateToday: rhrToday,
      restingHeartRateUsual: rhrUsual,
      restingHeartRateHistoryDays: rhrHistory.length,
      hrvToday: hrvToday,
      hrvUsual: hrvUsual,
      hrvHistoryDays: lnHrvHistory.length,
    );
  }

  void _applySoreness(
    String date,
    List<SorenessCheck> checks,
    void Function(ReadinessLevel, ReadinessReason) raise,
  ) {
    final yesterday = _shift(date, -1);
    final recent = checks.where((c) => c.date == date || c.date == yesterday).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    if (recent.isEmpty) return;

    if (recent.any((c) => c.verdict == 'possible_crash')) {
      raise(ReadinessLevel.low, ReadinessReason.possibleCrash);
    }

    // Soreness is still there and not easing, and it was already being
    // logged 3–4 days ago: past the 24–72h window muscle soreness should
    // resolve in, so the structural recovery threshold was exceeded.
    final latest = recent.last;
    final startedEarly = checks.any((c) {
      final daysAgo = dateFromKey(date).difference(dateFromKey(c.date)).inDays;
      return daysAgo >= 3 && daysAgo <= 4;
    });
    if (latest.trend != SorenessTrend.easing && startedEarly) {
      raise(ReadinessLevel.lower, ReadinessReason.recoveryWindowExceeded);
    }
  }

  static String _shift(String date, int days) => dateKey(dateFromKey(date).add(Duration(days: days)));

  static (double mean, double sd) _meanSd(List<double> xs) {
    final mean = xs.reduce((a, b) => a + b) / xs.length;
    final variance = xs.map((x) => (x - mean) * (x - mean)).reduce((a, b) => a + b) / xs.length;
    return (mean, math.sqrt(variance));
  }
}
