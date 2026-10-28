import '../../core/utils/date_utils.dart';
import '../../data/repositories/activity_repository.dart';
import '../../data/repositories/checkin_repository.dart';
import '../../data/repositories/daily_log_repository.dart';
import '../models/challenge.dart';
import '../models/challenge_day.dart';
import '../models/daily_log.dart';

/// Turns the user's own local logs into one ChallengeDay per day of a
/// daily-goal challenge (every kind except weight). Only the resulting
/// value + met/not-met leaves the device — the same narrow-sharing rule
/// the weight challenge follows with its single averaged weight.
class ChallengeDayService {
  ChallengeDayService(this._dailyLogs, this._activities, this._checkins);

  final DailyLogRepository _dailyLogs;
  final ActivityRepository _activities;
  final CheckinRepository _checkins;

  static const defaultSleepHours = 7.0;
  static const defaultActiveMinutes = 20.0;
  static const fallbackSteps = 3000.0;

  /// Every day from the challenge's start through [today] (or its last
  /// day, if it already ended). Today is included even though it isn't
  /// over yet — a goal already met this morning shows up right away, and a
  /// not-yet-met today just gets overwritten on the next sync.
  Future<List<ChallengeDay>> computeDays({
    required Challenge challenge,
    required String userId,
    required double? dailyGoal,
    required DateTime today,
  }) async {
    if (!challenge.kind.isDaily || !challenge.isFixedLength) return const [];
    final start = dateKey(challenge.startsOn!);
    final lastDay = challenge.endsOn!.isBefore(today) ? challenge.endsOn! : today;
    final end = dateKey(lastDay);
    if (end.compareTo(start) < 0) return const [];

    final logs = {for (final log in await _dailyLogs.getRange(start, end)) log.date: log};
    final activeMinutes = <String, int>{};
    if (challenge.kind == ChallengeKind.activity || challenge.kind == ChallengeKind.logging) {
      for (final activity in await _activities.getRange(start, end)) {
        activeMinutes[activity.date] = (activeMinutes[activity.date] ?? 0) + activity.durationMin;
      }
    }
    final checkinDates = challenge.kind == ChallengeKind.logging
        ? await _checkins.getDatesWithCheckins(start, end)
        : const <String>{};

    return [
      for (final day in dateKeysBetween(start, end))
        _dayFor(
          challenge: challenge,
          userId: userId,
          day: day,
          log: logs[day],
          activeMinutes: activeMinutes[day] ?? 0,
          checkedIn: checkinDates.contains(day),
          goal: dailyGoal ?? 1,
        ),
    ];
  }

  ChallengeDay _dayFor({
    required Challenge challenge,
    required String userId,
    required String day,
    required DailyLog? log,
    required int activeMinutes,
    required bool checkedIn,
    required double goal,
  }) {
    final kind = challenge.kind;
    final restDay = log != null && (log.isRestDay || log.isFlareDay);

    final value = switch (kind) {
      ChallengeKind.steps => (log?.steps ?? 0).toDouble(),
      ChallengeKind.sleep => log?.sleepHours ?? 0,
      ChallengeKind.activity => activeMinutes.toDouble(),
      ChallengeKind.logging => _isLogged(log, activeMinutes, checkedIn) ? 1.0 : 0.0,
      ChallengeKind.weight => 0.0,
    };
    final goalMet = (restDay && kind.restDayCountsAsMet) || value >= goal;

    return ChallengeDay(
      challengeId: challenge.id,
      userId: userId,
      day: day,
      value: value,
      goalMet: goalMet,
      restDay: restDay,
    );
  }

  /// Something the user entered themselves. HealthKit-filled steps and
  /// sleep don't count — they'd arrive whether or not the user opened the
  /// app, which isn't the habit this challenge is about.
  static bool _isLogged(DailyLog? log, int activeMinutes, bool checkedIn) {
    if (checkedIn || activeMinutes > 0) return true;
    if (log == null) return false;
    return log.mentalState != null ||
        log.bodyFeeling != null ||
        log.weightKg != null ||
        log.isRestDay ||
        log.isFlareDay;
  }

  /// Starting value for the goal field in ChallengeSetupCard. Steps start
  /// from the user's own recent average (non-rest days), rounded down to
  /// the nearest 100 — a goal they're already meeting on a typical day,
  /// in line with the app's gentle-growth approach, rather than a generic
  /// 10,000.
  Future<double> suggestGoal(ChallengeKind kind, String today) async {
    switch (kind) {
      case ChallengeKind.steps:
        final recent = await _dailyLogs.getRecentQualifyingSteps(today, lookbackDays: 14, maxRows: 14);
        if (recent.isEmpty) return fallbackSteps;
        final average = recent.reduce((a, b) => a + b) / recent.length;
        final rounded = (average / 100).floor() * 100.0;
        return rounded > 0 ? rounded : fallbackSteps;
      case ChallengeKind.sleep:
        return defaultSleepHours;
      case ChallengeKind.activity:
        return defaultActiveMinutes;
      case ChallengeKind.logging:
      case ChallengeKind.weight:
        return 1;
    }
  }
}
