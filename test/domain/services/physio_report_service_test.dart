import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/domain/models/activity.dart';
import 'package:zebrapace_app/domain/models/calisthenics_set.dart';
import 'package:zebrapace_app/domain/models/daily_log.dart';
import 'package:zebrapace_app/domain/models/soreness_check.dart';
import 'package:zebrapace_app/domain/models/therapy.dart';
import 'package:zebrapace_app/domain/services/physio_report_service.dart';

DailyLog _log(String date, {int steps = 3000, BodyFeeling? body}) =>
    DailyLog(id: date, date: date, steps: steps, bodyFeeling: body);

SorenessCheck _check(String date, String verdict) => SorenessCheck(
      id: date + verdict,
      date: date,
      onset: SorenessOnset.oneDayAfter,
      spread: SorenessSpread.localized,
      trend: SorenessTrend.easing,
      verdict: verdict,
      verdictLabel: verdict,
    );

PhysioReportData _build({
  List<DailyLog> logs = const [],
  List<Activity> activities = const [],
  List<CalisthenicsSet> calisthenics = const [],
  List<Therapy> therapies = const [],
  List<SorenessCheck> checks = const [],
  String questions = '',
}) =>
    PhysioReportService.build(
      name: ' Pau ',
      startDate: '2026-11-01',
      endDate: '2026-11-30',
      generatedAt: '2026-11-30 10:00',
      allLogs: logs,
      activities: activities,
      calisthenics: calisthenics,
      therapies: therapies,
      exerciseLabel: (c) => c.exercise.name,
      sorenessChecks: checks,
      questions: questions,
    );

void main() {
  test('previous window: same number of days right before', () {
    expect(PhysioReportService.previousWindow('2026-11-01', '2026-11-30'),
        (start: '2026-10-02', end: '2026-10-31'));
  });

  test('session follow-up: body score on the day, +1 and +2, even past the period end', () {
    final r = _build(
      logs: [
        _log('2026-11-29', body: BodyFeeling.good),
        _log('2026-11-30', body: BodyFeeling.manageable),
        _log('2026-12-01', body: BodyFeeling.achy),
      ],
      activities: [
        const Activity(id: 'a', date: '2026-11-29', activityName: 'Walk', durationMin: 20),
        const Activity(id: 'b', date: '2026-11-29', activityName: 'Walk', durationMin: 10),
      ],
      calisthenics: [
        const CalisthenicsSet(
            id: 'c', date: '2026-11-29', exercise: CalisthenicsExercise.squats, progression: 'wall', setValues: [8]),
      ],
      therapies: [const Therapy(id: 't', date: '2026-11-10', therapyName: 'Massage', durationMin: 30)],
    );
    expect(r.followUps.map((f) => f.date), ['2026-11-29', '2026-11-10']); // newest first
    final f = r.followUps.first;
    expect(f.sessions, ['Walk', 'squats']); // de-duplicated
    expect([f.scoreSameDay, f.scoreDay1, f.scoreDay2], [4, 3, 2]);
    expect(r.followUps.last.scoreSameDay, isNull);
  });

  test('sessions outside the period are ignored; follow-ups are capped', () {
    final r = _build(activities: [
      const Activity(id: 'x', date: '2026-10-31', activityName: 'Swim', durationMin: 20),
      for (var d = 1; d <= 15; d++)
        Activity(id: '$d', date: '2026-11-${d.toString().padLeft(2, '0')}', activityName: 'Walk', durationMin: 20),
    ]);
    expect(r.followUps.length, PhysioReportService.maxFollowUps);
    expect(r.followUps.any((f) => f.sessions.contains('Swim')), isFalse);
  });

  test('soreness tally and newest checks, within the period only', () {
    final r = _build(checks: [
      _check('2026-10-20', 'possible_crash'),
      _check('2026-11-02', 'likely_doms'),
      _check('2026-11-05', 'possible_crash'),
      _check('2026-11-07', 'unclear'),
    ]);
    expect(r.sorenessTally.likelySoreness, 1);
    expect(r.sorenessTally.possibleCrash, 1);
    expect(r.sorenessTally.unclear, 1);
    expect(r.recentChecks.first.date, '2026-11-07');
  });

  test('summary and previous period come from the same log', () {
    final r = _build(logs: [
      _log('2026-10-15', steps: 6000),
      _log('2026-11-15', steps: 4000),
    ]);
    expect(r.current.avgSteps, 4000);
    expect(r.previous.avgSteps, 6000);
    expect(r.daysInRange, 30);
    expect(r.name, 'Pau');
  });

  test('questions are trimmed and capped', () {
    expect(_build(questions: '  Can I add a walk?  ').questions, 'Can I add a walk?');
    final long = _build(questions: 'x' * 1000).questions;
    expect(long.length, PhysioReportService.maxQuestionsLength + 1);
    expect(long.endsWith('…'), isTrue);
  });
}
