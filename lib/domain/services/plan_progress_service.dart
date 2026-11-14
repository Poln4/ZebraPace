import '../../core/utils/date_utils.dart';
import '../models/daily_log.dart';
import '../models/training_plan.dart';

/// Pain-monitoring model: 0–2 safe, 3–5 acceptable if it settles by the
/// next morning, above 5 (or sharp, catching, giving way) too much.
enum PainZone { safe, acceptable, tooMuch }

/// Whether an exercise can move to its next step. Advice only — the person
/// always makes the change themselves.
enum StepReadiness {
  /// Fewer than three comfortable sessions at this step yet.
  notYet,
  ready,

  /// Ready, but another exercise changed in the last 7 days.
  waitForWeek,

  /// Ready, but PEM or a flare in the last 72 hours.
  waitForRecovery,

  /// Ready, but the next step waits for a clinician's sign-off.
  needsClearance,

  /// Already on the last step of the ladder.
  topOfLadder,
}

class PlanProgressService {
  const PlanProgressService();

  static const comfortableSessionsNeeded = 3;
  static const recoveryWindowDays = 3; // 72 hours
  static const oneChangePerDays = 7;

  static PainZone painZone(int? pain, {bool sharp = false}) {
    if (sharp || (pain ?? 0) > 5) return PainZone.tooMuch;
    if ((pain ?? 0) >= 3) return PainZone.acceptable;
    return PainZone.safe;
  }

  /// Monday of the week [date] falls in.
  static String weekStart(String date) {
    final d = dateFromKey(date);
    return dateKey(d.subtract(Duration(days: d.weekday - 1)));
  }

  static String weekEnd(String date) =>
      dateKey(dateFromKey(weekStart(date)).add(const Duration(days: 6)));

  /// 1-based plan week (Monday-aligned, so week 1 is the start date's
  /// week). 0 before the plan starts; may exceed [TrainingPlan.weeks]
  /// once it's over — repeating weeks is part of the plan.
  static int weekNumber(TrainingPlan plan, String date) {
    final start = dateFromKey(weekStart(plan.startDate));
    final d = dateFromKey(date);
    if (d.isBefore(start)) return 0;
    return d.difference(start).inDays ~/ 7 + 1;
  }

  /// Sessions planned for [date]'s weekday.
  static List<PlanSession> sessionsFor(List<PlanSession> sessions, String date) {
    final weekday = dateFromKey(date).weekday;
    return sessions.where((s) => s.weekday == weekday).toList();
  }

  /// A session counts as comfortable for an exercise when its pain stayed
  /// at 5 or under, nothing was sharp, and the next morning wasn't worse
  /// than usual. An unanswered next morning doesn't count against it.
  static bool isComfortable(PlanSetLog set, PlanSessionLog session) =>
      painZone(set.pain, sharp: set.sharp) != PainZone.tooMuch &&
      session.nextMorning != NextMorning.higher &&
      session.nextMorning != NextMorning.pem;

  /// [recent] is the latest logs at the exercise's current step, newest
  /// first (see PlanRepository.recentAtStep). [lastChangeInPlan] is the
  /// latest step change of any exercise in the plan. [recentRedFlag] is
  /// true when there was PEM or a flare day in the last 72 hours.
  static StepReadiness readiness({
    required List<(PlanSetLog, PlanSessionLog)> recent,
    required PlanStep? nextStep,
    required String today,
    required String? lastChangeInPlan,
    required bool recentRedFlag,
  }) {
    final comfortable = recent.length >= comfortableSessionsNeeded &&
        recent.take(comfortableSessionsNeeded).every((r) => isComfortable(r.$1, r.$2));
    if (!comfortable) return StepReadiness.notYet;
    if (nextStep == null) return StepReadiness.topOfLadder;
    if (recentRedFlag) return StepReadiness.waitForRecovery;
    if (lastChangeInPlan != null &&
        dateFromKey(today).difference(dateFromKey(lastChangeInPlan)).inDays < oneChangePerDays) {
      return StepReadiness.waitForWeek;
    }
    if (nextStep.isLocked) return StepReadiness.needsClearance;
    return StepReadiness.ready;
  }

  /// Minutes counted toward the weekly ceiling: every Activity (cardio plan
  /// sessions already wrote one) plus plan sessions that didn't.
  static int ceilingUsed({
    required List<PlanSessionLog> weekLogs,
    required Iterable<int> activityMinutes,
  }) {
    final planOnly = weekLogs
        .where((l) => l.activityId == null && l.mode.isTraining)
        .fold<int>(0, (sum, l) => sum + (l.durationMin ?? 0));
    return planOnly + activityMinutes.fold<int>(0, (a, b) => a + b);
  }

  /// The most recent training session from the last two days still waiting
  /// for its next-morning answer — asked only on a later day.
  static PlanSessionLog? pendingMorningCheck(List<PlanSessionLog> logs, String today) {
    final candidates = logs
        .where((l) =>
            l.mode.isTraining &&
            l.nextMorning == null &&
            l.date.compareTo(today) < 0 &&
            dateFromKey(today).difference(dateFromKey(l.date)).inDays <= 2)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return candidates.firstOrNull;
  }

  /// Same phrase all day; [offset] moves to the next one (after logging).
  /// The person's own phrases come first in [phrases].
  static String? phraseFor(List<String> phrases, String date, {int offset = 0}) {
    if (phrases.isEmpty) return null;
    final d = dateFromKey(date);
    final dayOfYear = d.difference(DateTime(d.year)).inDays;
    return phrases[(dayOfYear + offset) % phrases.length];
  }

  /// A training session as a whole was comfortable: no exercise too much,
  /// and the next morning not worse than usual.
  static bool isComfortableSession(PlanSessionLog log, Iterable<PlanSetLog> sets) =>
      log.mode.isTraining &&
      log.nextMorning != NextMorning.higher &&
      log.nextMorning != NextMorning.pem &&
      sets.every((s) => painZone(s.pain, sharp: s.sharp) != PainZone.tooMuch);

  /// What the logs say about the usual gate ("2 weeks with 2–3 comfortable
  /// sessions each, recovery stable, pain settling by next morning"), over
  /// the 14 days ending on [today]. Facts only — passing the gate stays
  /// the person's call.
  static GateFacts gateFacts({
    required String today,
    required List<PlanSessionLog> logs,
    required List<PlanSetLog> sets,
    required List<DailyLog> dailyLogs,
  }) {
    final end = dateFromKey(today);
    final split = dateKey(end.subtract(const Duration(days: 7)));
    final start = dateKey(end.subtract(const Duration(days: 13)));
    final inWindow = logs.where((l) => l.date.compareTo(start) >= 0 && l.date.compareTo(today) <= 0);
    int comfortable(bool recent) => inWindow
        .where((l) => recent ? l.date.compareTo(split) > 0 : l.date.compareTo(split) <= 0)
        .where((l) => isComfortableSession(l, sets.where((s) => s.sessionLogId == l.id)))
        .length;
    return GateFacts(
      comfortableEarlierWeek: comfortable(false),
      comfortableLatestWeek: comfortable(true),
      noPemOrFlare: !inWindow.any((l) => l.nextMorning == NextMorning.pem) &&
          !dailyLogs.any(
              (d) => d.isFlareDay && d.date.compareTo(start) >= 0 && d.date.compareTo(today) <= 0),
      painSettling: !inWindow.any((l) => l.nextMorning == NextMorning.higher),
    );
  }

  /// Pre-fills the Sunday check-in for the week starting [weekStart].
  static WeekSummary weekSummary({
    required String weekStart,
    required List<PlanSession> sessions,
    required List<PlanSessionLog> logs,
    required List<DailyLog> dailyLogs,
    required int proteinGoalG,
  }) {
    final end = weekEnd(weekStart);
    bool inWeek(String d) => d.compareTo(weekStart) >= 0 && d.compareTo(end) <= 0;
    final week = logs.where((l) => inWeek(l.date)).toList();
    final days = dailyLogs.where((d) => inWeek(d.date)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    final answered = week.where((l) => l.mode.isTraining && l.nextMorning != null);
    return WeekSummary(
      sessionsDone: week.where((l) => l.mode.isTraining).length,
      sessionsPlanned: sessions.where((s) => s.weekday != null).length,
      hadPem: week.any((l) => l.nextMorning == NextMorning.pem) || days.any((d) => d.isFlareDay),
      jointsOk: answered.isEmpty ? null : answered.every((l) => l.nextMorning == NextMorning.settled),
      proteinDays: days.where((d) => proteinGoalG > 0 && d.proteinG >= proteinGoalG).length,
      weightKg: days.map((d) => d.weightKg).whereType<double>().lastOrNull,
    );
  }

  /// Next week's ceiling: about 10% up or down, rounded to 5 minutes.
  static int? ceilingFor(int? current, CheckinDecision decision) {
    if (current == null) return null;
    final factor = switch (decision) {
      CheckinDecision.raise => 1.1,
      CheckinDecision.keep => 1.0,
      CheckinDecision.stepBack => 0.9,
    };
    return ((current * factor) / 5).round() * 5;
  }

  /// The fear-list item to try next: the least feared one still at 3 or
  /// more, else the least feared not yet settled.
  static FearItem? fearToTry(List<FearItem> items) {
    final open = items.where((i) => i.settledOn == null).toList()
      ..sort((a, b) => a.fear.compareTo(b.fear));
    return open.where((i) => i.fear >= 3).firstOrNull ?? open.firstOrNull;
  }

  static bool isRetestWeek(TrainingPlan plan, String date) =>
      plan.testWeekNumbers.contains(weekNumber(plan, date));
}

class GateFacts {
  const GateFacts({
    required this.comfortableEarlierWeek,
    required this.comfortableLatestWeek,
    required this.noPemOrFlare,
    required this.painSettling,
  });

  final int comfortableEarlierWeek;
  final int comfortableLatestWeek;
  final bool noPemOrFlare;
  final bool painSettling;

  /// Both weeks had at least two comfortable sessions.
  bool get sessionsMet => comfortableEarlierWeek >= 2 && comfortableLatestWeek >= 2;
}

class WeekSummary {
  const WeekSummary({
    required this.sessionsDone,
    required this.sessionsPlanned,
    required this.hadPem,
    required this.jointsOk,
    required this.proteinDays,
    required this.weightKg,
  });

  final int sessionsDone;
  final int sessionsPlanned;
  final bool hadPem;
  final bool? jointsOk;
  final int proteinDays;
  final double? weightKg;
}
