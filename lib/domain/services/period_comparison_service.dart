import '../../core/utils/date_utils.dart';
import '../models/daily_log.dart';

/// What one period looked like. Averages only count days where that value
/// was logged; null when none were.
class PeriodSummary {
  const PeriodSummary({
    required this.start,
    required this.end,
    required this.daysLogged,
    required this.avgSteps,
    required this.avgBodyScore,
    required this.avgMentalScore,
    required this.avgSleepHours,
    required this.avgRestingHr,
    required this.avgHrvMs,
    required this.restDays,
    required this.flareDays,
  });

  final String start;
  final String end;
  final int daysLogged;
  final double? avgSteps;
  final double? avgBodyScore;
  final double? avgMentalScore;
  final double? avgSleepHours;
  final double? avgRestingHr;
  final double? avgHrvMs;
  final int restDays;
  final int flareDays;
}

enum ComparisonTarget { previousPeriod, sameTimeLastYear }

/// Zebras+ "compare long periods" (business_plan.md §2: este invierno vs.
/// el anterior). Pure and display-only; nothing in today's pacing reads it.
class PeriodComparisonService {
  PeriodComparisonService._();

  static const lengthsInMonths = [1, 3, 6];

  /// The recent period: [months] calendar months ending on [endKey].
  static ({String start, String end}) recentPeriod(String endKey, int months) {
    final start = _shiftMonths(dateFromKey(endKey), -months);
    return (start: dateKey(DateTime(start.year, start.month, start.day + 1)), end: endKey);
  }

  /// The period it's compared with: the one just before, or the same
  /// dates a year earlier.
  static ({String start, String end}) earlierPeriod(
    String endKey,
    int months,
    ComparisonTarget target,
  ) {
    final recentStart = dateFromKey(recentPeriod(endKey, months).start);
    switch (target) {
      case ComparisonTarget.previousPeriod:
        final end = DateTime(recentStart.year, recentStart.month, recentStart.day - 1);
        return recentPeriod(dateKey(end), months);
      case ComparisonTarget.sameTimeLastYear:
        return recentPeriod(dateKey(_shiftMonths(dateFromKey(endKey), -12)), months);
    }
  }

  /// [date] moved by [months], keeping the day but clamping it to the
  /// month's length (Mar 31 − 1 month = Feb 28, not Mar 3).
  static DateTime _shiftMonths(DateTime date, int months) {
    final firstOfTarget = DateTime(date.year, date.month + months);
    final lastDay = DateTime(firstOfTarget.year, firstOfTarget.month + 1, 0).day;
    return DateTime(firstOfTarget.year, firstOfTarget.month,
        date.day > lastDay ? lastDay : date.day);
  }

  static PeriodSummary summarize(String start, String end, List<DailyLog> logs) {
    final inRange = logs.where((l) => l.date.compareTo(start) >= 0 && l.date.compareTo(end) <= 0);
    double? avg(Iterable<num?> values) {
      final present = values.whereType<num>().toList();
      if (present.isEmpty) return null;
      return present.reduce((a, b) => a + b) / present.length;
    }

    final list = inRange.toList();
    return PeriodSummary(
      start: start,
      end: end,
      daysLogged: list.length,
      avgSteps: avg(list.map((l) => l.steps > 0 ? l.steps : null)),
      avgBodyScore: avg(list.map((l) => l.bodyFeeling?.score)),
      avgMentalScore: avg(list.map((l) => l.mentalState?.score)),
      avgSleepHours: avg(list.map((l) => l.sleepHours)),
      avgRestingHr: avg(list.map((l) => l.restingHeartRate)),
      avgHrvMs: avg(list.map((l) => l.hrvMs)),
      restDays: list.where((l) => l.isRestDay).length,
      flareDays: list.where((l) => l.isFlareDay).length,
    );
  }
}
