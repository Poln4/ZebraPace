/// One historical data point in the shared weight-loss challenge (Supabase
/// table `weight_challenge_weigh_ins`) — append-only, one row per "join" or
/// "update my weight" action, unlike `weight_challenge_entries` which only
/// ever holds each person's single current snapshot. This is what the
/// progress-over-time chart is built from.
class WeightChallengeWeighIn {
  const WeightChallengeWeighIn({
    required this.userId,
    required this.weightKg,
    required this.loggedAt,
  });

  factory WeightChallengeWeighIn.fromMap(Map<String, dynamic> map) {
    return WeightChallengeWeighIn(
      userId: map['user_id'] as String,
      weightKg: (map['weight_kg'] as num).toDouble(),
      loggedAt: DateTime.parse(map['logged_at'] as String),
    );
  }

  final String userId;
  final double weightKg;
  final DateTime loggedAt;
}
