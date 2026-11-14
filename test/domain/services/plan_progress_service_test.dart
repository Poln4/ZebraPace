import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/domain/models/daily_log.dart';
import 'package:zebrapace_app/domain/models/training_plan.dart';
import 'package:zebrapace_app/domain/services/plan_progress_service.dart';

PlanSessionLog _session(String date,
        {NextMorning? morning, PlanSessionMode mode = PlanSessionMode.full, String? activityId, int? min}) =>
    PlanSessionLog(
      id: 's$date',
      planId: 'p',
      date: date,
      mode: mode,
      nextMorning: morning,
      activityId: activityId,
      durationMin: min,
    );

PlanSetLog _set({int? pain, bool sharp = false}) => PlanSetLog(
      id: 'x',
      sessionLogId: 's',
      exerciseId: 'e',
      stepId: 'st',
      setValues: const [8, 8],
      unit: SetUnit.reps,
      pain: pain,
      sharp: sharp,
    );

const _next = PlanStep(id: 'n', exerciseId: 'e', position: 1, name: 'Incline');

void main() {
  test('pain zones follow the pain-monitoring model', () {
    expect(PlanProgressService.painZone(null), PainZone.safe);
    expect(PlanProgressService.painZone(2), PainZone.safe);
    expect(PlanProgressService.painZone(3), PainZone.acceptable);
    expect(PlanProgressService.painZone(5), PainZone.acceptable);
    expect(PlanProgressService.painZone(6), PainZone.tooMuch);
    expect(PlanProgressService.painZone(1, sharp: true), PainZone.tooMuch);
  });

  test('week number is Monday-aligned from the start date', () {
    // 2026-11-18 is a Wednesday; its week starts Monday 2026-11-16.
    const plan = TrainingPlan(id: 'p', name: 'P', startDate: '2026-11-18', weeks: 12);
    expect(PlanProgressService.weekNumber(plan, '2026-11-15'), 0);
    expect(PlanProgressService.weekNumber(plan, '2026-11-16'), 1);
    expect(PlanProgressService.weekNumber(plan, '2026-11-22'), 1);
    expect(PlanProgressService.weekNumber(plan, '2026-11-23'), 2);
    expect(PlanProgressService.weekStart('2026-11-22'), '2026-11-16');
    expect(PlanProgressService.weekEnd('2026-11-18'), '2026-11-22');
  });

  group('readiness', () {
    final comfortable = [
      (_set(pain: 2), _session('2026-11-14', morning: NextMorning.settled)),
      (_set(pain: 4), _session('2026-11-12')),
      (_set(), _session('2026-11-10')),
    ];

    StepReadiness check(
      List<(PlanSetLog, PlanSessionLog)> recent, {
      PlanStep? next = _next,
      String? lastChange,
      bool redFlag = false,
    }) =>
        PlanProgressService.readiness(
          recent: recent,
          nextStep: next,
          today: '2026-11-15',
          lastChangeInPlan: lastChange,
          recentRedFlag: redFlag,
        );

    test('three comfortable sessions make the next step ready', () {
      expect(check(comfortable), StepReadiness.ready);
    });

    test('fewer than three, or one uncomfortable, is not yet', () {
      expect(check(comfortable.take(2).toList()), StepReadiness.notYet);
      expect(check([(_set(pain: 6), comfortable[0].$2), ...comfortable.skip(1)]),
          StepReadiness.notYet);
      expect(check([(_set(sharp: true), comfortable[0].$2), ...comfortable.skip(1)]),
          StepReadiness.notYet);
      expect(
          check([(comfortable[0].$1, _session('2026-11-14', morning: NextMorning.higher)),
            ...comfortable.skip(1)]),
          StepReadiness.notYet);
    });

    test('PEM or flare in the last 72 h waits', () {
      expect(check(comfortable, redFlag: true), StepReadiness.waitForRecovery);
    });

    test('only one change a week', () {
      expect(check(comfortable, lastChange: '2026-11-10'), StepReadiness.waitForWeek);
      expect(check(comfortable, lastChange: '2026-11-08'), StepReadiness.ready);
    });

    test('a locked next step needs clearance; cleared unlocks it', () {
      const locked = PlanStep(id: 'n', exerciseId: 'e', position: 1, name: 'Box squat', needsClearance: true);
      const cleared = PlanStep(
          id: 'n', exerciseId: 'e', position: 1, name: 'Box squat', needsClearance: true, clearedOn: '2026-11-01');
      expect(check(comfortable, next: locked), StepReadiness.needsClearance);
      expect(check(comfortable, next: cleared), StepReadiness.ready);
    });

    test('no next step is the top of the ladder', () {
      expect(check(comfortable, next: null), StepReadiness.topOfLadder);
    });
  });

  test('ceiling counts activities plus plan sessions that wrote none', () {
    final used = PlanProgressService.ceilingUsed(
      weekLogs: [
        _session('2026-11-16', min: 20), // strength, no activity row
        _session('2026-11-18', min: 25, activityId: 'a'), // cardio, already an activity
        _session('2026-11-19', mode: PlanSessionMode.floor, min: 5), // floor doesn't count
      ],
      activityMinutes: [25, 10],
    );
    expect(used, 55);
  });

  test('morning check asks about the latest training session from the last two days', () {
    final logs = [
      _session('2026-11-12'),
      _session('2026-11-13'),
      _session('2026-11-14', mode: PlanSessionMode.floor),
      _session('2026-11-15'),
    ];
    expect(PlanProgressService.pendingMorningCheck(logs, '2026-11-15')?.date, '2026-11-13');
    expect(
        PlanProgressService.pendingMorningCheck(
            [_session('2026-11-14', morning: NextMorning.settled)], '2026-11-15'),
        isNull);
    expect(PlanProgressService.pendingMorningCheck([_session('2026-11-11')], '2026-11-15'), isNull);
  });

  test('phrase is stable for a day and the offset moves on', () {
    const phrases = ['a', 'b', 'c'];
    final first = PlanProgressService.phraseFor(phrases, '2026-11-15');
    expect(PlanProgressService.phraseFor(phrases, '2026-11-15'), first);
    expect(PlanProgressService.phraseFor(phrases, '2026-11-15', offset: 1), isNot(first));
    expect(PlanProgressService.phraseFor(const [], '2026-11-15'), isNull);
  });

  group('review', () {
    PlanSessionLog log(String id, String date, {NextMorning? morning}) => PlanSessionLog(
        id: id, planId: 'p', date: date, mode: PlanSessionMode.full, nextMorning: morning);
    PlanSetLog set(String sessionId, int pain) => PlanSetLog(
        id: 'x$sessionId', sessionLogId: sessionId, exerciseId: 'e', stepId: 's',
        setValues: const [5], unit: SetUnit.reps, pain: pain);

    test('gate facts count comfortable sessions per week over 14 days', () {
      final facts = PlanProgressService.gateFacts(
        today: '2026-11-15',
        logs: [
          log('a', '2026-11-03'), log('b', '2026-11-05'), // earlier week
          log('c', '2026-11-10'), log('d', '2026-11-12'), log('e', '2026-11-14'), // latest week
          log('old', '2026-10-30'), // outside the window
        ],
        sets: [set('e', 7)], // e was too much
        dailyLogs: const [],
      );
      expect(facts.comfortableEarlierWeek, 2);
      expect(facts.comfortableLatestWeek, 2);
      expect(facts.sessionsMet, isTrue);
      expect(facts.noPemOrFlare, isTrue);
      expect(facts.painSettling, isTrue);

      final rough = PlanProgressService.gateFacts(
        today: '2026-11-15',
        logs: [log('a', '2026-11-10', morning: NextMorning.higher)],
        sets: const [],
        dailyLogs: const [DailyLog(id: 'd', date: '2026-11-04', isFlareDay: true)],
      );
      expect(rough.noPemOrFlare, isFalse);
      expect(rough.painSettling, isFalse);
      expect(rough.sessionsMet, isFalse);
    });

    test('week summary pre-fills the check-in from logs', () {
      final summary = PlanProgressService.weekSummary(
        weekStart: '2026-11-09',
        sessions: const [
          PlanSession(id: 'a', planId: 'p', position: 0, name: 'A', weekday: 1),
          PlanSession(id: 'b', planId: 'p', position: 1, name: 'B', weekday: 3),
          PlanSession(id: 'x', planId: 'p', position: 2, name: 'Any'),
        ],
        logs: [
          log('1', '2026-11-09', morning: NextMorning.settled),
          log('2', '2026-11-11', morning: NextMorning.pem),
          log('3', '2026-11-16'), // next week
        ],
        dailyLogs: const [
          DailyLog(id: '1', date: '2026-11-09', proteinG: 90, weightKg: 70.4),
          DailyLog(id: '2', date: '2026-11-12', proteinG: 60, weightKg: 70.1),
          DailyLog(id: '3', date: '2026-11-13', proteinG: 85),
        ],
        proteinGoalG: 85,
      );
      expect(summary.sessionsDone, 2);
      expect(summary.sessionsPlanned, 2);
      expect(summary.hadPem, isTrue);
      expect(summary.jointsOk, isFalse);
      expect(summary.proteinDays, 2);
      expect(summary.weightKg, 70.1);
    });

    test('ceiling moves about 10%, rounded to 5 minutes', () {
      expect(PlanProgressService.ceilingFor(75, CheckinDecision.raise), 85);
      expect(PlanProgressService.ceilingFor(75, CheckinDecision.keep), 75);
      expect(PlanProgressService.ceilingFor(75, CheckinDecision.stepBack), 70);
      expect(PlanProgressService.ceilingFor(null, CheckinDecision.raise), isNull);
    });

    test('fear to try is the least feared still at 3 or more', () {
      const items = [
        FearItem(id: 'a', name: 'Low', fear: 1, initialFear: 4),
        FearItem(id: 'b', name: 'Stairs', fear: 3, initialFear: 3),
        FearItem(id: 'c', name: 'Kneel', fear: 7, initialFear: 7),
        FearItem(id: 'd', name: 'Done', fear: 4, initialFear: 6, settledOn: '2026-11-01'),
      ];
      expect(PlanProgressService.fearToTry(items)?.name, 'Stairs');
      expect(PlanProgressService.fearToTry([items.first])?.name, 'Low');
      expect(PlanProgressService.fearToTry(const []), isNull);
    });

    test('retest weeks follow the plan setting', () {
      const plan = TrainingPlan(id: 'p', name: 'P', startDate: '2026-11-16', weeks: 12, testWeeks: '1, 6,12');
      expect(PlanProgressService.isRetestWeek(plan, '2026-11-18'), isTrue);
      expect(PlanProgressService.isRetestWeek(plan, '2026-11-25'), isFalse);
      expect(PlanProgressService.isRetestWeek(plan, '2026-12-21'), isTrue); // week 6
    });
  });
}
