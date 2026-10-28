import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/domain/models/challenge.dart';
import 'package:zebrapace_app/domain/models/challenge_day.dart';
import 'package:zebrapace_app/domain/models/challenge_entry.dart';
import 'package:zebrapace_app/domain/services/challenge_standings_builder.dart';

void main() {
  final challenge = Challenge(
    id: 'c1',
    name: 'Steps',
    code: 'CODE',
    kind: ChallengeKind.steps,
    targetPercent: 5,
    createdBy: 'alice',
    createdAt: DateTime(2026, 3, 2),
    startsOn: DateTime(2026, 3, 2),
    weeks: 2,
  );

  ChallengeEntry entry(String id) => ChallengeEntry(
        challengeId: 'c1',
        userId: id,
        displayName: id,
        dailyGoal: 3000,
        updatedAt: DateTime(2026, 3, 2),
      );

  ChallengeDay day(String user, String date, {bool met = true}) => ChallengeDay(
        challengeId: 'c1',
        userId: user,
        day: date,
        value: 0,
        goalMet: met,
        restDay: false,
      );

  test('ranks by total days met across all weeks', () {
    final standings = ChallengeStandingsBuilder.build(
      challenge: challenge,
      entries: [entry('alice'), entry('bob')],
      days: [
        day('alice', '2026-03-02'),
        day('bob', '2026-03-02'),
        day('bob', '2026-03-03'),
        day('bob', '2026-03-09'),
      ],
      weekIndex: 1,
    );
    expect(standings.map((s) => s.entry.userId), ['bob', 'alice']);
    expect(standings.first.totalMet, 3);
    expect(standings.first.weekMet, 1);
  });

  test('week has 7 slots, null where there is no row, and unmet days do not score', () {
    final standings = ChallengeStandingsBuilder.build(
      challenge: challenge,
      entries: [entry('alice')],
      days: [day('alice', '2026-03-02'), day('alice', '2026-03-03', met: false)],
      weekIndex: 0,
    );
    final alice = standings.single;
    expect(alice.week.length, 7);
    expect(alice.week[0]!.goalMet, isTrue);
    expect(alice.week[1]!.goalMet, isFalse);
    expect(alice.week.sublist(2), everyElement(isNull));
    expect(alice.totalMet, 1);
  });

  test('ties keep the incoming order', () {
    final standings = ChallengeStandingsBuilder.build(
      challenge: challenge,
      entries: [entry('alice'), entry('bob')],
      days: [day('alice', '2026-03-02'), day('bob', '2026-03-02')],
      weekIndex: 0,
    );
    expect(standings.map((s) => s.entry.userId), ['alice', 'bob']);
  });

  test('week index clamps to the challenge length and finishes after the last day', () {
    expect(challenge.weekIndexFor(DateTime(2026, 3, 8)), 0);
    expect(challenge.weekIndexFor(DateTime(2026, 3, 9)), 1);
    expect(challenge.weekIndexFor(DateTime(2026, 5, 1)), 1);
    expect(challenge.endsOn, DateTime(2026, 3, 15));
    expect(challenge.isFinished(DateTime(2026, 3, 15, 23)), isFalse);
    expect(challenge.isFinished(DateTime(2026, 3, 16)), isTrue);
  });
}
