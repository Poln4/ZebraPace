import '../../core/constants/defaults.dart';

/// One participant's row in the shared weight-loss challenge (Supabase
/// table `weight_challenge_entries`) — not a local/drift model, since this
/// data is inherently shared across the 3 participants' own accounts.
class WeightChallengeEntry {
  const WeightChallengeEntry({
    required this.userId,
    required this.displayName,
    required this.startWeightKg,
    required this.currentWeightKg,
    required this.updatedAt,
  });

  factory WeightChallengeEntry.fromMap(Map<String, dynamic> map) {
    return WeightChallengeEntry(
      userId: map['user_id'] as String,
      displayName: map['display_name'] as String,
      startWeightKg: (map['start_weight_kg'] as num).toDouble(),
      currentWeightKg: (map['current_weight_kg'] as num).toDouble(),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  final String userId;
  final String displayName;
  final double startWeightKg;
  final double currentWeightKg;
  final DateTime updatedAt;

  /// Positive = weight lost, negative = weight gained. Not clamped — the
  /// leaderboard is honest about the whole range; only the progress *bar*
  /// clamps to the 0–target window.
  double get percentLost => (startWeightKg - currentWeightKg) / startWeightKg * 100;

  bool get goalReached => percentLost >= WeightChallengeDefaults.targetPercent;
}
