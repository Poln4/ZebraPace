import 'dart:math' as math;

import '../models/autonomic.dart';

/// What one stand test showed, and how it sits against the person's own
/// earlier tests.
class StandSummary {
  const StandSummary({
    this.hrRise,
    this.maxStandingHr,
    this.sysChange,
    this.diaChange,
    this.usualHrRise,
    this.previousCount = 0,
    this.heartRatePattern = false,
    this.pressureDropPattern = false,
  });

  /// Highest standing heart rate minus the baseline, bpm.
  final int? hrRise;
  final int? maxStandingHr;

  /// Largest fall in systolic / diastolic pressure within the first 3
  /// minutes standing, as a signed change (negative = fell).
  final int? sysChange;
  final int? diaChange;

  /// Median heart-rate rise of earlier tests, once there are
  /// [AutonomicService.minTestsForUsual].
  final double? usualHrRise;
  final int previousCount;

  /// A rise of ≥30 bpm (or any standing heart rate above 120) — the heart
  /// rate part of the POTS criteria for adults. A hint to mention to a
  /// doctor, never a diagnosis.
  final bool heartRatePattern;

  /// A fall of ≥20 systolic or ≥10 diastolic within 3 minutes — the
  /// orthostatic hypotension criterion.
  final bool pressureDropPattern;
}

/// Pure calculations for the Autonomic signals card. Every comparison is
/// against the person's own history; the only fixed numbers are the two
/// published diagnostic criteria (Sheldon 2015 / Freeman 2011), shown as
/// "worth mentioning to your doctor", never as a score.
class AutonomicService {
  static const potsRiseBpm = 30;
  static const potsAbsoluteBpm = 120;
  static const ohSystolicDrop = 20;
  static const ohDiastolicDrop = 10;
  static const minTestsForUsual = 3;

  static StandSummary summarize(
    StandTest test, {
    List<StandTest> earlier = const [],
  }) {
    // Also guards rows saved or imported before the entry checks existed.
    StandReading at(StandPoint p) {
      final r = test.at(p);
      return StandReading(
        hr: VitalRange.hr(r.hr),
        sys: VitalRange.sys(r.sys),
        dia: VitalRange.dia(r.dia),
      );
    }

    final base = at(StandPoint.baseline);
    final standing = [
      StandPoint.min1,
      StandPoint.min3,
      StandPoint.min10,
    ].map(at);
    final standingHr = [for (final r in standing) ?r.hr];
    final maxHr = standingHr.isEmpty ? null : standingHr.reduce(math.max);
    final rise = maxHr != null && base.hr != null ? maxHr - base.hr! : null;

    int? lowestChange(int? baseline, Iterable<int?> values) {
      if (baseline == null) return null;
      final present = [for (final v in values) ?v];
      if (present.isEmpty) return null;
      return present.reduce(math.min) - baseline;
    }

    final early = [at(StandPoint.min1), at(StandPoint.min3)];
    final sysChange = lowestChange(base.sys, early.map((r) => r.sys));
    final diaChange = lowestChange(base.dia, early.map((r) => r.dia));

    final earlierRises = [for (final t in earlier) ?summarize(t).hrRise];
    final usual = earlierRises.length >= minTestsForUsual
        ? _median(earlierRises)
        : null;

    return StandSummary(
      hrRise: rise,
      maxStandingHr: maxHr,
      sysChange: sysChange,
      diaChange: diaChange,
      usualHrRise: usual,
      previousCount: earlierRises.length,
      heartRatePattern:
          (rise != null && rise >= potsRiseBpm) ||
          (maxHr != null && maxHr > potsAbsoluteBpm),
      pressureDropPattern:
          (sysChange != null && sysChange <= -ohSystolicDrop) ||
          (diaChange != null && diaChange <= -ohDiastolicDrop),
    );
  }

  /// The point the timer is waiting on, given seconds since standing up;
  /// null once 10 minutes have passed.
  static StandPoint? nextPoint(int secondsStanding) {
    for (final p in [StandPoint.min1, StandPoint.min3, StandPoint.min10]) {
      if (secondsStanding < p.atSecond) return p;
    }
    return null;
  }

  /// How often each sweating kind came up in the given logs, most common
  /// first.
  static List<(SweatKind, int)> sweatCounts(List<SweatLog> logs) {
    final counts = <SweatKind, int>{};
    for (final l in logs) {
      for (final k in l.kinds) {
        counts[k] = (counts[k] ?? 0) + 1;
      }
    }
    return counts.entries.map((e) => (e.key, e.value)).toList()
      ..sort((a, b) => b.$2.compareTo(a.$2));
  }

  /// The person's usual cuff pressure: median systolic/diastolic of the
  /// readings in the 30 days before [latest] (same position only), once
  /// there are [minTestsForUsual]. Null until then.
  static (double sys, double dia)? usualPressure(
    List<BloodPressureReading> all,
    BloodPressureReading latest,
  ) {
    final cutoff = DateTime.parse(latest.takenAt)
        .subtract(const Duration(days: 30));
    final earlier = all.where(
      (r) =>
          r.id != latest.id &&
          r.position == latest.position &&
          r.takenAt.compareTo(latest.takenAt) < 0 &&
          DateTime.parse(r.takenAt).isAfter(cutoff),
    );
    if (earlier.length < minTestsForUsual) return null;
    return (
      _median([for (final r in earlier) r.systolic]),
      _median([for (final r in earlier) r.diastolic]),
    );
  }

  static double _median(List<int> xs) {
    final s = [...xs]..sort();
    final mid = s.length ~/ 2;
    return s.length.isOdd ? s[mid].toDouble() : (s[mid - 1] + s[mid]) / 2;
  }
}
