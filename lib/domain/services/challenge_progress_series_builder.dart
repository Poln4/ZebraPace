import '../models/weight_challenge_entry.dart';
import '../models/weight_challenge_weigh_in.dart';

class ChallengeProgressPoint {
  const ChallengeProgressPoint({required this.date, required this.percentLost});

  final DateTime date;

  /// Positive = weight lost, negative = weight gained — same convention as
  /// WeightChallengeEntry.percentLost.
  final double percentLost;
}

class ChallengeProgressSeries {
  const ChallengeProgressSeries({
    required this.userId,
    required this.displayName,
    required this.points,
  });

  final String userId;
  final String displayName;
  final List<ChallengeProgressPoint> points;
}

/// Turns each participant's raw weigh-in history into a percent-of-starting-
/// weight-lost series — plotting raw kg wouldn't be comparable across people
/// with different starting weights, but percent lost against each person's
/// own start puts everyone on the same 0-to-target axis.
class ChallengeProgressSeriesBuilder {
  ChallengeProgressSeriesBuilder._();

  static List<ChallengeProgressSeries> build(
    List<WeightChallengeEntry> entries,
    List<WeightChallengeWeighIn> history,
  ) {
    return [
      for (final entry in entries)
        ChallengeProgressSeries(
          userId: entry.userId,
          displayName: entry.displayName,
          points: _dailyPoints(entry, history),
        ),
    ];
  }

  /// One point per calendar day, using that day's *last* weigh-in — the
  /// chart shouldn't care what time of day a sync happened, and MyProgressCard
  /// can push more than one update in the same day as its computed average
  /// shifts, which would otherwise scatter several close-together points
  /// within a single day instead of showing one clean daily reading.
  static List<ChallengeProgressPoint> _dailyPoints(
    WeightChallengeEntry entry,
    List<WeightChallengeWeighIn> history,
  ) {
    final lastOfDay = <DateTime, WeightChallengeWeighIn>{};
    for (final weighIn in history) {
      if (weighIn.userId != entry.userId) continue;
      final day = DateTime(weighIn.loggedAt.year, weighIn.loggedAt.month, weighIn.loggedAt.day);
      final existing = lastOfDay[day];
      if (existing == null || weighIn.loggedAt.isAfter(existing.loggedAt)) {
        lastOfDay[day] = weighIn;
      }
    }

    final days = lastOfDay.keys.toList()..sort();
    return [
      for (final day in days)
        ChallengeProgressPoint(
          date: day,
          percentLost:
              (entry.startWeightKg - lastOfDay[day]!.weightKg) / entry.startWeightKg * 100,
        ),
    ];
  }
}
