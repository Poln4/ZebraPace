import '../../core/utils/date_utils.dart';
import '../models/challenge.dart';
import '../models/challenge_day.dart';
import '../models/challenge_entry.dart';

class ChallengeStanding {
  const ChallengeStanding({
    required this.entry,
    required this.totalMet,
    required this.weekMet,
    required this.week,
  });

  final ChallengeEntry entry;

  /// Days met across the whole challenge so far — this is the ranking.
  final int totalMet;

  /// Days met in the week being shown.
  final int weekMet;

  /// The 7 days of the week being shown, in order; null where the member
  /// has no row for that day (future days, or before they joined/synced).
  final List<ChallengeDay?> week;
}

/// Ranks members of a daily-goal challenge by how many days they met
/// their own goal. Ties keep the entries' incoming order, so the
/// leaderboard doesn't reshuffle between two members on equal points.
class ChallengeStandingsBuilder {
  ChallengeStandingsBuilder._();

  static List<ChallengeStanding> build({
    required Challenge challenge,
    required List<ChallengeEntry> entries,
    required List<ChallengeDay> days,
    required int weekIndex,
  }) {
    final weekKeys = [for (final d in challenge.daysOfWeek(weekIndex)) dateKey(d)];
    final standings = [
      for (final entry in entries) _standingFor(entry, days, weekKeys),
    ];
    final order = {for (var i = 0; i < entries.length; i++) entries[i].userId: i};
    standings.sort((a, b) {
      final byTotal = b.totalMet.compareTo(a.totalMet);
      return byTotal != 0 ? byTotal : order[a.entry.userId]!.compareTo(order[b.entry.userId]!);
    });
    return standings;
  }

  static ChallengeStanding _standingFor(
    ChallengeEntry entry,
    List<ChallengeDay> days,
    List<String> weekKeys,
  ) {
    final mine = {
      for (final day in days)
        if (day.userId == entry.userId) day.day: day,
    };
    final week = [for (final key in weekKeys) mine[key]];
    return ChallengeStanding(
      entry: entry,
      totalMet: mine.values.where((d) => d.goalMet).length,
      weekMet: week.where((d) => d?.goalMet ?? false).length,
      week: week,
    );
  }
}
