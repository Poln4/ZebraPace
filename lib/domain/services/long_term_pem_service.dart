import '../../core/utils/date_utils.dart';
import '../models/daily_log.dart';
import 'pem_service.dart';

/// How much lower the body score runs N days after higher-exertion days.
class LagDip {
  const LagDip({required this.lagDays, required this.dip, required this.pairs});

  final int lagDays;

  /// typical-day average minus higher-day average, in body-score points
  /// (1–5 scale, so positive = worse after bigger days). Null when there
  /// weren't enough paired days or one group was empty.
  final double? dip;

  /// Exertion days that had a body score logged exactly [lagDays] later.
  final int pairs;
}

/// The dip at the usual delay for one calendar month (yyyy-MM).
class MonthDip {
  const MonthDip({required this.month, required this.dip, required this.pairs});

  final String month;
  final double? dip;
  final int pairs;
}

enum DipTrend { smaller, bigger, similar }

class LongTermPemPattern {
  const LongTermPemPattern({
    required this.daysCovered,
    required this.lags,
    required this.usualLagDays,
    required this.months,
    required this.trend,
  });

  /// Calendar days from the first to the last day with steps logged.
  final int daysCovered;

  /// One entry per delay in [LongTermPemService.lagRange].
  final List<LagDip> lags;

  /// The delay with the biggest clear dip, or null when none is clear.
  final int? usualLagDays;

  /// Month by month at [usualLagDays], oldest first; empty without one.
  final List<MonthDip> months;

  /// First vs. last [LongTermPemService.trendMonths] months with a value;
  /// null when there aren't enough months to say.
  final DipTrend? trend;

  bool get hasEnoughHistory => daysCovered >= LongTermPemService.minDaysCovered;

  double? get usualDip =>
      usualLagDays == null ? null : lags.firstWhere((l) => l.lagDays == usualLagDays).dip;
}

/// Zebras+ "your pattern over months" (business_plan.md: long-term
/// pattern detection). Pure and display-only: it reads the whole log
/// and explains the delayed-dip pattern. Today's pacing guidance and
/// warnings never depend on it — they live in PacingService/PemService and
/// stay free (test/core/plus_safety_boundary_test.dart).
class LongTermPemService {
  LongTermPemService._();

  static const lagRange = [1, 2, 3, 4];

  /// About two months, so a pattern isn't read from a couple of weeks.
  static const minDaysCovered = 56;

  /// Same bar as the free headline (_PatternHeadline): a gap under this
  /// many points isn't called a dip.
  static const clearDip = 0.3;

  static const trendMonths = 3;

  static LongTermPemPattern analyze(List<DailyLog> logs) {
    final byDate = {for (final l in logs) l.date: l};
    final withSteps = logs.where((l) => l.steps > 0).map((l) => l.date).toList()..sort();
    final daysCovered = withSteps.isEmpty
        ? 0
        : dateFromKey(withSteps.last).difference(dateFromKey(withSteps.first)).inDays + 1;

    final lags = [
      for (final lag in lagRange) _lagDip(logs, byDate, lag),
    ];

    LagDip? best;
    for (final l in lags) {
      final dip = l.dip;
      if (dip == null || dip < clearDip) continue;
      if (best == null || dip > best.dip!) best = l;
    }
    final usualLag = best?.lagDays;

    final months = <MonthDip>[];
    if (usualLag != null) {
      final byMonth = <String, List<DailyLog>>{};
      for (final l in logs) {
        byMonth.putIfAbsent(l.date.substring(0, 7), () => []).add(l);
      }
      for (final month in byMonth.keys.toList()..sort()) {
        final r = PemService.compute(byMonth[month]!, byDate, lagDays: usualLag);
        months.add(MonthDip(month: month, dip: _dipOf(r), pairs: r.points.length));
      }
    }

    return LongTermPemPattern(
      daysCovered: daysCovered,
      lags: lags,
      usualLagDays: usualLag,
      months: months,
      trend: _trend(months),
    );
  }

  static LagDip _lagDip(List<DailyLog> logs, Map<String, DailyLog> byDate, int lag) {
    final r = PemService.compute(logs, byDate, lagDays: lag);
    return LagDip(lagDays: lag, dip: _dipOf(r), pairs: r.points.length);
  }

  static double? _dipOf(PemResult r) {
    final h = r.higherExertionAvgScore;
    final t = r.typicalAvgScore;
    if (!r.hasEnoughData || h == null || t == null) return null;
    return t - h;
  }

  static DipTrend? _trend(List<MonthDip> months) {
    final values = [for (final m in months) if (m.dip != null) m.dip!];
    if (values.length < trendMonths * 2) return null;
    double mean(Iterable<double> xs) => xs.reduce((a, b) => a + b) / xs.length;
    final first = mean(values.take(trendMonths));
    final last = mean(values.skip(values.length - trendMonths));
    if (first - last >= clearDip) return DipTrend.smaller;
    if (last - first >= clearDip) return DipTrend.bigger;
    return DipTrend.similar;
  }
}
