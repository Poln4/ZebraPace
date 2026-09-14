/// One participant's row in one challenge (Supabase table
/// `weight_challenge_entries`) — not a local/drift model, since this data
/// is inherently shared across every member of that challenge. A user can
/// have one row per challenge they've joined (primary key is
/// `(challenge_id, user_id)`), so `userId` alone no longer identifies a row.
class WeightChallengeEntry {
  const WeightChallengeEntry({
    required this.challengeId,
    required this.userId,
    required this.displayName,
    required this.startWeightKg,
    required this.currentWeightKg,
    required this.updatedAt,
  });

  factory WeightChallengeEntry.fromMap(Map<String, dynamic> map) {
    return WeightChallengeEntry(
      challengeId: map['challenge_id'] as String,
      userId: map['user_id'] as String,
      displayName: map['display_name'] as String,
      startWeightKg: (map['start_weight_kg'] as num).toDouble(),
      currentWeightKg: (map['current_weight_kg'] as num).toDouble(),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  final String challengeId;
  final String userId;
  final String displayName;
  final double startWeightKg;
  final double currentWeightKg;
  final DateTime updatedAt;

  /// Positive = weight lost, negative = weight gained. Not clamped — the
  /// leaderboard is honest about the whole range; only the progress *bar*
  /// clamps to the 0–target window.
  double get percentLost => (startWeightKg - currentWeightKg) / startWeightKg * 100;

  /// Takes the target explicitly rather than reading a global constant —
  /// each challenge can in principle have its own target_percent.
  bool goalReached(double targetPercent) => percentLost >= targetPercent;
}
