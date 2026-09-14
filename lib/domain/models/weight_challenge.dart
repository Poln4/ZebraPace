/// A named, code-gated weight-loss challenge (Supabase table
/// `weight_challenges`) — the group a set of `WeightChallengeEntry` rows
/// belongs to. Anyone with the code can join via
/// `WeightChallengeRepository.joinChallenge`; RLS scopes every entry and
/// weigh-in to members of the same challenge, so a new group never sees
/// another group's data.
class WeightChallenge {
  const WeightChallenge({
    required this.id,
    required this.name,
    required this.code,
    required this.targetPercent,
    required this.createdBy,
    required this.createdAt,
  });

  factory WeightChallenge.fromMap(Map<String, dynamic> map) {
    return WeightChallenge(
      id: map['id'] as String,
      name: map['name'] as String,
      code: map['code'] as String,
      targetPercent: (map['target_percent'] as num).toDouble(),
      createdBy: map['created_by'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  final String id;
  final String name;
  final String code;
  final double targetPercent;
  final String createdBy;
  final DateTime createdAt;
}
