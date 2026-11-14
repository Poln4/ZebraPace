import '../../core/constants/enums.dart';
import '../../l10n/app_localizations.dart';

/// How a planned day went. Every mode counts the same — a floor day on a
/// low day is the plan working, not a miss. Rest isn't a mode: it's the
/// day's existing Rest/Flare flag (DailyLogs), so it's recorded once and
/// pacing and challenges keep seeing it.
enum PlanSessionMode {
  full,
  lowDay,
  floor;

  String get db => name;

  /// Modes that load the body enough to judge the next morning.
  bool get isTraining => this == full || this == lowDay;

  String label(AppLocalizations l10n) => switch (this) {
        PlanSessionMode.full => l10n.planModeFull,
        PlanSessionMode.lowDay => l10n.planModeLowDay,
        PlanSessionMode.floor => l10n.planModeFloor,
      };

  static PlanSessionMode fromDb(String? value) =>
      PlanSessionMode.values.where((e) => e.name == value).firstOrNull ?? PlanSessionMode.full;
}

/// The morning-after check from the pain-monitoring model.
enum NextMorning {
  /// At or below the usual baseline.
  settled,

  /// Higher than the usual baseline.
  higher,

  /// Post-exertional malaise — always means back off.
  pem;

  String get db => name;

  String label(AppLocalizations l10n) => switch (this) {
        NextMorning.settled => l10n.planNextMorningSettled,
        NextMorning.higher => l10n.planNextMorningHigher,
        NextMorning.pem => l10n.planNextMorningPem,
      };

  static NextMorning? fromDb(String? value) =>
      NextMorning.values.where((e) => e.name == value).firstOrNull;
}

class TrainingPlan {
  const TrainingPlan({
    required this.id,
    required this.name,
    required this.startDate,
    required this.weeks,
    this.weeklyCeilingMin,
    this.floorNote,
    this.currentPhaseId,
    this.testWeeks,
    this.isActive = true,
  });

  final String id;
  final String name;
  final String startDate;
  final int weeks;
  final int? weeklyCeilingMin;
  final String? floorNote;
  final String? currentPhaseId;

  /// Comma-separated plan weeks to retake the baseline tests, e.g. "1,6,12".
  final String? testWeeks;
  final bool isActive;

  List<int> get testWeekNumbers => (testWeeks ?? '')
      .split(',')
      .map((w) => int.tryParse(w.trim()))
      .whereType<int>()
      .toList();
}

class PlanPhase {
  const PlanPhase({
    required this.id,
    required this.planId,
    required this.position,
    required this.name,
    this.goal,
    this.effort,
    this.cardio,
    this.gate,
  });

  final String id;
  final String planId;
  final int position;
  final String name;
  final String? goal;
  final String? effort;
  final String? cardio;
  final String? gate;
}

class PlanSession {
  const PlanSession({
    required this.id,
    required this.planId,
    required this.position,
    required this.name,
    this.weekday,
    this.durationMin,
    this.lowDayNote,
    this.isCardio = false,
  });

  final String id;
  final String planId;
  final int position;
  final String name;
  final int? weekday;
  final int? durationMin;
  final String? lowDayNote;
  final bool isCardio;
}

class PlanExercise {
  const PlanExercise({
    required this.id,
    required this.sessionId,
    required this.position,
    required this.name,
    this.cue,
    this.currentStepId,
    this.stepChangedOn,
  });

  final String id;
  final String sessionId;
  final int position;
  final String name;
  final String? cue;
  final String? currentStepId;
  final String? stepChangedOn;
}

class PlanStep {
  const PlanStep({
    required this.id,
    required this.exerciseId,
    required this.position,
    required this.name,
    this.dose,
    this.unit = SetUnit.reps,
    this.needsClearance = false,
    this.clearedOn,
  });

  final String id;
  final String exerciseId;
  final int position;
  final String name;
  final String? dose;
  final SetUnit unit;
  final bool needsClearance;
  final String? clearedOn;

  /// Waiting on a clinician's sign-off.
  bool get isLocked => needsClearance && clearedOn == null;
}

class PlanSessionLog {
  const PlanSessionLog({
    required this.id,
    required this.planId,
    required this.date,
    required this.mode,
    this.sessionId,
    this.durationMin,
    this.nextMorning,
    this.activityId,
    this.note,
  });

  final String id;
  final String planId;
  final String? sessionId;
  final String date;
  final PlanSessionMode mode;
  final int? durationMin;
  final NextMorning? nextMorning;
  final String? activityId;
  final String? note;
}

class PlanSetLog {
  const PlanSetLog({
    required this.id,
    required this.sessionLogId,
    required this.exerciseId,
    required this.stepId,
    required this.setValues,
    required this.unit,
    this.pain,
    this.sharp = false,
  });

  final String id;
  final String sessionLogId;
  final String exerciseId;
  final String stepId;
  final List<int> setValues;
  final SetUnit unit;
  final int? pain;
  final bool sharp;
}

/// One exercise as logged in a session, before it's saved.
class PlanSetEntry {
  const PlanSetEntry({
    required this.exerciseId,
    required this.stepId,
    required this.setValues,
    required this.unit,
    this.pain,
    this.sharp = false,
  });

  final String exerciseId;
  final String stepId;
  final List<int> setValues;
  final SetUnit unit;
  final int? pain;
  final bool sharp;
}

/// The Sunday check-in's decision about next week's ceiling.
enum CheckinDecision {
  raise,
  keep,
  stepBack;

  String get db => name;

  String label(AppLocalizations l10n) => switch (this) {
        CheckinDecision.raise => l10n.planCheckinRaise,
        CheckinDecision.keep => l10n.planCheckinKeep,
        CheckinDecision.stepBack => l10n.planCheckinStepBack,
      };

  static CheckinDecision fromDb(String? value) =>
      CheckinDecision.values.where((e) => e.name == value).firstOrNull ?? CheckinDecision.keep;
}

class PlanCheckin {
  const PlanCheckin({
    required this.id,
    required this.planId,
    required this.weekStart,
    required this.decision,
    this.sessionsDone = 0,
    this.sessionsPlanned = 0,
    this.hadPem = false,
    this.pemCause,
    this.jointsOk,
    this.proteinDays,
    this.weightKg,
    this.win,
    this.fearStep,
    this.ceilingBefore,
    this.ceilingAfter,
  });

  final String id;
  final String planId;
  final String weekStart;
  final int sessionsDone;
  final int sessionsPlanned;
  final bool hadPem;
  final String? pemCause;
  final bool? jointsOk;
  final int? proteinDays;
  final double? weightKg;
  final String? win;
  final String? fearStep;
  final CheckinDecision decision;
  final int? ceilingBefore;
  final int? ceilingAfter;
}

class PlanTest {
  const PlanTest({
    required this.id,
    required this.planId,
    required this.position,
    required this.name,
    this.unit,
  });

  final String id;
  final String planId;
  final int position;
  final String name;
  final String? unit;
}

class PlanTestResult {
  const PlanTestResult({
    required this.id,
    required this.testId,
    required this.date,
    required this.value,
    this.note,
  });

  final String id;
  final String testId;
  final String date;
  final double value;
  final String? note;
}

class FearItem {
  const FearItem({
    required this.id,
    required this.name,
    required this.fear,
    required this.initialFear,
    this.settledOn,
  });

  final String id;
  final String name;
  final int fear;
  final int initialFear;
  final String? settledOn;
}

class ExposureLog {
  const ExposureLog({
    required this.id,
    required this.fearItemId,
    required this.date,
    this.attempt,
    this.prediction,
    this.outcome,
    this.fearBefore,
    this.fearAfter,
    this.nothingBad = false,
  });

  final String id;
  final String fearItemId;
  final String date;
  final String? attempt;
  final String? prediction;
  final String? outcome;
  final int? fearBefore;
  final int? fearAfter;
  final bool nothingBad;
}
