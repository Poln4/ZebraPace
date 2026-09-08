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
          points: [
            for (final weighIn in history)
              if (weighIn.userId == entry.userId)
                ChallengeProgressPoint(
                  date: weighIn.loggedAt,
                  percentLost:
                      (entry.startWeightKg - weighIn.weightKg) / entry.startWeightKg * 100,
                ),
          ]..sort((a, b) => a.date.compareTo(b.date)),
        ),
    ];
  }
}
