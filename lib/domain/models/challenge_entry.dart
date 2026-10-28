/// One participant's row in one challenge (Supabase table
/// `weight_challenge_entries`) — not a local/drift model, since this data
/// is inherently shared across every member of that challenge. A user can
/// have one row per challenge they've joined (primary key is
/// `(challenge_id, user_id)`), so `userId` alone no longer identifies a row.
///
/// Which fields are filled depends on the challenge's kind: weight
/// challenges use the weight columns, every other kind uses [dailyGoal].
/// Both start out null right after joining (join_challenge takes no
/// kind-specific data) until the member finishes ChallengeSetupCard.
class ChallengeEntry {
  const ChallengeEntry({
    required this.challengeId,
    required this.userId,
    required this.displayName,
    required this.updatedAt,
    this.startWeightKg,
    this.currentWeightKg,
    this.dailyGoal,
  });

  factory ChallengeEntry.fromMap(Map<String, dynamic> map) {
    return ChallengeEntry(
      challengeId: map['challenge_id'] as String,
      userId: map['user_id'] as String,
      displayName: map['display_name'] as String,
      startWeightKg: (map['start_weight_kg'] as num?)?.toDouble(),
      currentWeightKg: (map['current_weight_kg'] as num?)?.toDouble(),
      dailyGoal: (map['daily_goal'] as num?)?.toDouble(),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  final String challengeId;
  final String userId;
  final String displayName;
  final double? startWeightKg;
  final double? currentWeightKg;

  /// Steps, hours of sleep or active minutes, depending on the kind.
  final double? dailyGoal;
  final DateTime updatedAt;

  bool get hasStartWeight => startWeightKg != null && currentWeightKg != null;

  /// Positive = weight lost, negative = weight gained. Not clamped — the
  /// leaderboard is honest about the whole range; only the progress *bar*
  /// clamps to the 0–target window. Zero until a starting weight is set.
  double get percentLost {
    if (!hasStartWeight) return 0;
    return (startWeightKg! - currentWeightKg!) / startWeightKg! * 100;
  }

  /// Takes the target explicitly rather than reading a global constant —
  /// each challenge can in principle have its own target_percent.
  bool goalReached(double targetPercent) => percentLost >= targetPercent;
}
