import '../../core/utils/date_utils.dart';
import '../models/reminder_settings.dart';
import 'plan_progress_service.dart';

enum ReminderKind { checkin, soreness, weekly }

class PlannedReminder {
  const PlannedReminder({required this.id, required this.kind, required this.at});

  /// Stable per (kind, day, slot), so re-planning replaces rather than
  /// duplicates.
  final int id;
  final ReminderKind kind;

  /// Local wall-clock time.
  final DateTime at;

  @override
  String toString() => 'PlannedReminder($id, $kind, $at)';
}

/// What the planner needs to know about the person's data. Facts about
/// future days can't be known yet (a check-in not logged, a flare not
/// marked), so only today's are used for skipping.
class ReminderFacts {
  const ReminderFacts({
    this.lowEnergyDates = const {},
    this.todayCheckinTimes = const [],
    this.movementDates = const {},
    this.sorenessCheckedToday = false,
    this.planActive = false,
    this.planCheckinWeekStarts = const {},
  });

  /// Days marked Rest or Flare (today, or any day marked ahead).
  final Set<String> lowEnergyDates;

  /// Today's check-ins, 'HH:mm'.
  final List<String> todayCheckinTimes;

  /// Days with logged movement (activities, calisthenics, plan sessions).
  final Set<String> movementDates;
  final bool sorenessCheckedToday;
  final bool planActive;

  /// weekStart (Monday) of every week that already has a Sunday check-in.
  final Set<String> planCheckinWeekStarts;
}

/// Turns reminder settings plus today's facts into the concrete
/// notifications to schedule over the next [horizonDays]. Pure, so it's
/// re-run from scratch whenever anything relevant changes.
///
/// Rules:
/// - Nothing on Rest/Flare days.
/// - Quick check-in: each chosen time, skipped today when a check-in was
///   already logged in the [checkinCoverMinutes] before it.
/// - Soreness: the first and second day after logged movement (the
///   24–72 h window where PEM or DOMS shows up), not once a soreness check
///   is logged that day.
/// - Weekly: Sundays while a plan is active, unless that week's check-in
///   is already done.
class ReminderPlanner {
  const ReminderPlanner();

  static const horizonDays = 14;
  static const checkinCoverMinutes = 120;

  List<PlannedReminder> plan({
    required DateTime now,
    required ReminderSettings settings,
    required ReminderFacts facts,
  }) {
    final out = <PlannedReminder>[];
    final today = DateTime(now.year, now.month, now.day);
    final todayKeyStr = dateKey(today);

    for (var offset = 0; offset < horizonDays; offset++) {
      final day = DateTime(today.year, today.month, today.day + offset);
      final key = dateKey(day);
      if (facts.lowEnergyDates.contains(key)) continue;
      final isToday = key == todayKeyStr;

      DateTime at(int minute) => DateTime(day.year, day.month, day.day, minute ~/ 60, minute % 60);
      void add(ReminderKind kind, int slot, int minute) {
        final when = at(minute);
        if (!when.isAfter(now)) return;
        out.add(PlannedReminder(id: _id(kind, offset, slot), kind: kind, at: when));
      }

      if (settings.checkinEnabled) {
        for (var slot = 0; slot < settings.checkinMinutes.length; slot++) {
          final minute = settings.checkinMinutes[slot];
          if (isToday && _coveredByCheckin(minute, facts.todayCheckinTimes)) continue;
          add(ReminderKind.checkin, slot, minute);
        }
      }

      if (settings.sorenessEnabled && !(isToday && facts.sorenessCheckedToday)) {
        final dayBefore = dateKey(DateTime(day.year, day.month, day.day - 1));
        final twoBefore = dateKey(DateTime(day.year, day.month, day.day - 2));
        if (facts.movementDates.contains(dayBefore) || facts.movementDates.contains(twoBefore)) {
          add(ReminderKind.soreness, 0, settings.sorenessMinute);
        }
      }

      if (settings.weeklyEnabled &&
          facts.planActive &&
          day.weekday == DateTime.sunday &&
          !facts.planCheckinWeekStarts.contains(PlanProgressService.weekStart(key))) {
        add(ReminderKind.weekly, 0, settings.weeklyMinute);
      }
    }
    out.sort((a, b) => a.at.compareTo(b.at));
    return out;
  }

  /// Ids live in 100000–399999, clear of anything else that posts
  /// notifications (native pacing alerts use their own identifiers).
  static int _id(ReminderKind kind, int dayOffset, int slot) =>
      100000 * (kind.index + 1) + dayOffset * 10 + slot;

  static bool isReminderId(int id) => id >= 100000 && id < 400000;

  static bool _coveredByCheckin(int minute, List<String> checkinTimes) {
    for (final t in checkinTimes) {
      final parts = t.split(':');
      if (parts.length != 2) continue;
      final m = (int.tryParse(parts[0]) ?? -1) * 60 + (int.tryParse(parts[1]) ?? 0);
      if (m < 0) continue;
      if (m <= minute && minute - m <= checkinCoverMinutes) return true;
    }
    return false;
  }
}
