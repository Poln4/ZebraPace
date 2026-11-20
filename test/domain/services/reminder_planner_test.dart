import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/domain/models/reminder_settings.dart';
import 'package:zebrapace_app/domain/services/reminder_planner.dart';

void main() {
  const planner = ReminderPlanner();
  // A Thursday.
  final now = DateTime(2026, 11, 19, 9, 0);

  List<PlannedReminder> plan(ReminderSettings s, [ReminderFacts f = const ReminderFacts()]) =>
      planner.plan(now: now, settings: s, facts: f);

  List<PlannedReminder> ofKind(List<PlannedReminder> all, ReminderKind k) =>
      all.where((r) => r.kind == k).toList();

  group('quick check-in', () {
    const s = ReminderSettings(checkinEnabled: true, checkinMinutes: [13 * 60, 19 * 60]);

    test('every chosen time on every day of the horizon', () {
      final r = plan(s);
      expect(r, hasLength(2 * ReminderPlanner.horizonDays));
      expect(r.first.at, DateTime(2026, 11, 19, 13));
    });

    test('times already past today are left out', () {
      final r = planner.plan(
          now: DateTime(2026, 11, 19, 14), settings: s, facts: const ReminderFacts());
      expect(r.first.at, DateTime(2026, 11, 19, 19));
    });

    test('a check-in in the two hours before covers that slot today only', () {
      final r = plan(s, const ReminderFacts(todayCheckinTimes: ['11:30']));
      expect(r.first.at, DateTime(2026, 11, 19, 19));
      expect(r.where((x) => x.at == DateTime(2026, 11, 20, 13)), hasLength(1));
    });

    test('a check-in more than two hours before does not cover it', () {
      final r = plan(s, const ReminderFacts(todayCheckinTimes: ['10:30']));
      expect(r.first.at, DateTime(2026, 11, 19, 13));
    });

    test('a check-in after the slot time does not cover it', () {
      final r = plan(s, const ReminderFacts(todayCheckinTimes: ['13:30']));
      expect(r.first.at, DateTime(2026, 11, 19, 13));
    });
  });

  test('nothing on Rest/Flare days', () {
    const s = ReminderSettings(checkinEnabled: true, sorenessEnabled: true);
    final r = plan(
        s,
        const ReminderFacts(
          lowEnergyDates: {'2026-11-19', '2026-11-21'},
          movementDates: {'2026-11-18'},
        ));
    final days = r.map((x) => x.at.day).toSet();
    expect(days.contains(19), isFalse);
    expect(days.contains(21), isFalse);
    expect(days.contains(20), isTrue);
  });

  group('soreness', () {
    const s = ReminderSettings(sorenessEnabled: true, sorenessMinute: 10 * 60);

    test('first and second day after movement', () {
      final r = ofKind(plan(s, const ReminderFacts(movementDates: {'2026-11-19'})),
          ReminderKind.soreness);
      expect(r.map((x) => x.at), [DateTime(2026, 11, 20, 10), DateTime(2026, 11, 21, 10)]);
    });

    test('movement two days ago still reminds today', () {
      final r = ofKind(plan(s, const ReminderFacts(movementDates: {'2026-11-17'})),
          ReminderKind.soreness);
      expect(r.map((x) => x.at), [DateTime(2026, 11, 19, 10)]);
    });

    test('not once today\'s soreness check is logged', () {
      final r = ofKind(
          plan(
              s,
              const ReminderFacts(
                  movementDates: {'2026-11-18', '2026-11-19'}, sorenessCheckedToday: true)),
          ReminderKind.soreness);
      expect(r.map((x) => x.at.day), [20, 21]);
    });

    test('no movement, no reminder', () {
      expect(ofKind(plan(s), ReminderKind.soreness), isEmpty);
    });
  });

  group('weekly', () {
    const s = ReminderSettings(weeklyEnabled: true, weeklyMinute: 18 * 60);

    test('Sundays while a plan is active', () {
      final r = ofKind(plan(s, const ReminderFacts(planActive: true)), ReminderKind.weekly);
      expect(r.map((x) => x.at), [DateTime(2026, 11, 22, 18), DateTime(2026, 11, 29, 18)]);
    });

    test('not without a plan', () {
      expect(ofKind(plan(s), ReminderKind.weekly), isEmpty);
    });

    test('skips a week already reviewed', () {
      final r = ofKind(
          plan(s,
              const ReminderFacts(planActive: true, planCheckinWeekStarts: {'2026-11-16'})),
          ReminderKind.weekly);
      expect(r.map((x) => x.at.day), [29]);
    });
  });

  test('ids are unique and in the reminder range', () {
    const s = ReminderSettings(
      checkinEnabled: true,
      checkinMinutes: [480, 600, 720, 840, 960, 1080],
      sorenessEnabled: true,
      weeklyEnabled: true,
    );
    final r = plan(s, const ReminderFacts(movementDates: {'2026-11-19'}, planActive: true));
    final ids = r.map((x) => x.id).toList();
    expect(ids.toSet(), hasLength(ids.length));
    expect(ids.every(ReminderPlanner.isReminderId), isTrue);
  });

  group('ReminderSettings', () {
    test('round-trips through JSON', () {
      const s = ReminderSettings(
          checkinEnabled: true, checkinMinutes: [600, 1200], pacingEnabled: true);
      final back = ReminderSettings.fromJson(s.toJson());
      expect(back.checkinEnabled, isTrue);
      expect(back.checkinMinutes, [600, 1200]);
      expect(back.pacingEnabled, isTrue);
      expect(back.sorenessEnabled, isFalse);
    });

    test('garbage falls back to everything off', () {
      expect(ReminderSettings.fromJson('not json').anyEnabled, isFalse);
      expect(ReminderSettings.fromJson(null).anyEnabled, isFalse);
    });

    test('times are sorted, de-duplicated and capped', () {
      final s = const ReminderSettings()
          .copyWith(checkinMinutes: [900, 600, 600, 60, 120, 180, 240, 300, 2000]);
      expect(s.checkinMinutes, [60, 120, 180, 240, 300, 600]);
    });
  });
}
