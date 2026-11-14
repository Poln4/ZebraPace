import 'package:drift/drift.dart';

import 'sync_columns.dart';

/// Training plans (the Plan tab). A plan is the prescription — what the
/// person means to do; Movement stays the log of everything they did.
/// Plans only ever come from the in-app editor: nothing is shipped
/// pre-filled, so no one's medical details end up bundled in the app.
///
/// Structure: plan → phases (descriptive: goal, effort, gate) and
/// plan → sessions (e.g. "A: strength", on a weekday) → exercises (slots,
/// e.g. "Push") → steps (the ladder within a slot, e.g. wall push-up →
/// incline push-up). Each exercise points at its current step; moving up
/// is always the person's own tap, never automatic.
class TrainingPlans extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// yyyy-MM-dd; week 1 is the week this date falls in.
  TextColumn get startDate => text()();
  IntColumn get weeks => integer().withDefault(const Constant(12))();

  /// Minutes per week (all logged movement counts toward it), set by the
  /// person. Null = no ceiling shown.
  IntColumn get weeklyCeilingMin => integer().nullable()();

  /// The daily floor, in the person's words (e.g. "10 calf raises…").
  TextColumn get floorNote => text().nullable()();
  TextColumn get currentPhaseId => text().nullable()();

  /// Plan weeks to retake the baseline tests, comma-separated (e.g. "1,6,12").
  TextColumn get testWeeks => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class PlanPhases extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get planId => text()();
  IntColumn get position => integer()();
  TextColumn get name => text()();
  TextColumn get goal => text().nullable()();
  TextColumn get effort => text().nullable()();
  TextColumn get cardio => text().nullable()();

  /// What has to be true before moving on, in the person's words.
  TextColumn get gate => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class PlanSessions extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get planId => text()();
  IntColumn get position => integer()();
  TextColumn get name => text()();

  /// 1 = Monday … 7 = Sunday (DateTime.weekday). Null = any day.
  IntColumn get weekday => integer().nullable()();
  IntColumn get durationMin => integer().nullable()();

  /// What this session shrinks to on a low day, in the person's words.
  TextColumn get lowDayNote => text().nullable()();

  /// Cardio sessions also save an Activity row, so METs, PEM charts and
  /// activity challenges see them without logging twice.
  BoolColumn get isCardio => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class PlanExercises extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get sessionId => text()();
  IntColumn get position => integer()();
  TextColumn get name => text()();
  TextColumn get cue => text().nullable()();
  TextColumn get currentStepId => text().nullable()();

  /// yyyy-MM-dd of the last step change — the plan allows one change a week.
  TextColumn get stepChangedOn => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class PlanSteps extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get exerciseId => text()();
  IntColumn get position => integer()();
  TextColumn get name => text()();

  /// Free text, e.g. "1→3 × 4–6".
  TextColumn get dose => text().nullable()();

  /// `reps` or `seconds` — see SetUnit.
  TextColumn get unit => text().withDefault(const Constant('reps'))();

  /// Waits for a physio (or other clinician) sign-off before it unlocks.
  BoolColumn get needsClearance => boolean().withDefault(const Constant(false))();
  TextColumn get clearedOn => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class PlanSessionLogs extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get planId => text()();

  /// Null for a floor-only day with no session picked.
  TextColumn get sessionId => text().nullable()();
  TextColumn get date => text()();

  /// full | lowDay | floor — see PlanSessionMode. All count equally.
  TextColumn get mode => text()();
  IntColumn get durationMin => integer().nullable()();

  /// Answered the morning after: settled | higher | pem — see NextMorning.
  TextColumn get nextMorning => text().nullable()();

  /// The Activity row a cardio session also wrote, deleted together.
  TextColumn get activityId => text().nullable()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class PlanSetLogs extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get sessionLogId => text()();
  TextColumn get exerciseId => text()();
  TextColumn get stepId => text()();

  /// Each set's reps or seconds, as a JSON int list, e.g. `[8,8,6]`.
  TextColumn get setValues => text().withDefault(const Constant('[]'))();
  TextColumn get unit => text().withDefault(const Constant('reps'))();

  /// Highest pain during the exercise, 0–10 (pain-monitoring model).
  IntColumn get pain => integer().nullable()();

  /// Sharp, catching or giving way — always "too much", whatever the number.
  BoolColumn get sharp => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// The Sunday check-in: a short weekly review whose job is to set next
/// week's ceiling. Counts are filled from the logs; the person adds a win,
/// a fear-list step and the decision.
class PlanCheckins extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get planId => text()();

  /// Monday of the week being reviewed.
  TextColumn get weekStart => text()();
  IntColumn get sessionsDone => integer().withDefault(const Constant(0))();
  IntColumn get sessionsPlanned => integer().withDefault(const Constant(0))();
  BoolColumn get hadPem => boolean().withDefault(const Constant(false))();

  /// What came before the PEM (training, work, stairs, sleep, migraine…).
  TextColumn get pemCause => text().nullable()();

  /// Next-morning pain stayed at or below baseline all week.
  BoolColumn get jointsOk => boolean().nullable()();
  IntColumn get proteinDays => integer().nullable()();
  RealColumn get weightKg => real().nullable()();
  TextColumn get win => text().nullable()();
  TextColumn get fearStep => text().nullable()();

  /// raise | keep | stepBack — see CheckinDecision.
  TextColumn get decision => text()();
  IntColumn get ceilingBefore => integer().nullable()();
  IntColumn get ceilingAfter => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// A repeatable baseline test (e.g. sit-to-stand reps in 30 s), retaken at
/// the weeks the person chose, since progress is hard to feel week to week.
class PlanTests extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get planId => text()();
  IntColumn get position => integer()();
  TextColumn get name => text()();

  /// Free text, e.g. "reps", "seconds", "kg".
  TextColumn get unit => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class PlanTestResults extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get testId => text()();
  TextColumn get date => text()();
  RealColumn get value => real()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Graded exposure: movements the person avoids, each rated 0–10 for fear.
/// Personal, not tied to a plan — the list outlives any one program.
class FearItems extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get fear => integer()();

  /// The fear rating when it was first added, to show change over time.
  IntColumn get initialFear => integer()();

  /// yyyy-MM-dd once it feels about 2/10 and the person moves on.
  TextColumn get settledOn => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// One small, safe try of a fear-list item: predict, do, note what happened.
class ExposureLogs extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get fearItemId => text()();
  TextColumn get date => text()();

  /// The small form tried, e.g. "two steps holding the rail".
  TextColumn get attempt => text().nullable()();
  TextColumn get prediction => text().nullable()();
  TextColumn get outcome => text().nullable()();
  IntColumn get fearBefore => integer().nullable()();
  IntColumn get fearAfter => integer().nullable()();

  /// "I did it and nothing bad happened" — the evidence that changes the
  /// belief that pain means damage.
  BoolColumn get nothingBad => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
