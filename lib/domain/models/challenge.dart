import '../../core/utils/date_utils.dart';
import '../../l10n/app_localizations.dart';

/// What a challenge measures. The `db` string is what's stored in
/// `weight_challenges.kind` (see 007_challenge_kinds.sql) and must never
/// change once rows exist.
enum ChallengeKind {
  weight('⚖️'),
  steps('👟'),
  logging('📝'),
  sleep('😴'),
  activity('🏃');

  const ChallengeKind(this.emoji);

  final String emoji;

  String get db => name;

  /// Every kind except weight is scored the same way: one point per day
  /// the member's own daily goal was met (challenge_days).
  bool get isDaily => this != ChallengeKind.weight;

  /// Logging has a fixed goal (log something that day), so there's
  /// nothing for the member to choose.
  bool get needsDailyGoal => isDaily && this != ChallengeKind.logging;

  /// Resting is part of pacing, so on a Rest/Flare day the movement kinds
  /// count the day as met instead of penalizing it. Sleep and logging
  /// still make sense on those days, so they're scored normally.
  bool get restDayCountsAsMet => this == ChallengeKind.steps || this == ChallengeKind.activity;

  String label(AppLocalizations l10n) => switch (this) {
        ChallengeKind.weight => l10n.challengeKindWeight,
        ChallengeKind.steps => l10n.challengeKindSteps,
        ChallengeKind.logging => l10n.challengeKindLogging,
        ChallengeKind.sleep => l10n.challengeKindSleep,
        ChallengeKind.activity => l10n.challengeKindActivity,
      };

  /// Rows written before 007 have no kind column value other than the
  /// default, so anything unrecognized falls back to weight.
  static ChallengeKind fromDb(String? value) =>
      ChallengeKind.values.where((e) => e.name == value).firstOrNull ?? ChallengeKind.weight;
}

/// A named, code-gated challenge (Supabase table `weight_challenges` — the
/// name predates non-weight kinds) — the group a set of `ChallengeEntry`
/// rows belongs to. Anyone with the code can join via
/// `ChallengeRepository.joinChallenge`; RLS scopes every entry, weigh-in
/// and challenge day to members of the same challenge, so a new group
/// never sees another group's data.
class Challenge {
  const Challenge({
    required this.id,
    required this.name,
    required this.code,
    required this.kind,
    required this.targetPercent,
    required this.createdBy,
    required this.createdAt,
    this.startsOn,
    this.weeks,
  });

  factory Challenge.fromMap(Map<String, dynamic> map) {
    final startsOn = map['starts_on'] as String?;
    return Challenge(
      id: map['id'] as String,
      name: map['name'] as String,
      code: map['code'] as String,
      kind: ChallengeKind.fromDb(map['kind'] as String?),
      targetPercent: (map['target_percent'] as num).toDouble(),
      createdBy: map['created_by'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      startsOn: startsOn == null ? null : dateFromKey(startsOn),
      weeks: map['weeks'] as int?,
    );
  }

  final String id;
  final String name;
  final String code;
  final ChallengeKind kind;

  /// Only meaningful for weight challenges.
  final double targetPercent;
  final String createdBy;
  final DateTime createdAt;

  /// Local calendar date the challenge began. Null (together with
  /// [weeks]) for the open-ended weight challenges created before 007.
  final DateTime? startsOn;
  final int? weeks;

  bool get isFixedLength => startsOn != null && weeks != null;

  /// Last day (inclusive), or null when open-ended.
  DateTime? get endsOn {
    if (!isFixedLength) return null;
    return DateTime(startsOn!.year, startsOn!.month, startsOn!.day + weeks! * 7 - 1);
  }

  bool isFinished(DateTime today) => endsOn != null && _day(today).isAfter(endsOn!);

  /// Zero-based week the given date falls in, clamped to the challenge's
  /// length — after it ends, this stays on the last week.
  int weekIndexFor(DateTime date) {
    if (!isFixedLength) return 0;
    final days = _day(date).difference(startsOn!).inDays;
    return (days ~/ 7).clamp(0, weeks! - 1);
  }

  /// The 7 calendar days of week [index].
  List<DateTime> daysOfWeek(int index) => [
        for (var i = 0; i < 7; i++)
          DateTime(startsOn!.year, startsOn!.month, startsOn!.day + index * 7 + i),
      ];

  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);
}
