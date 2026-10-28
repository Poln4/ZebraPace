import '../../core/utils/date_utils.dart';

/// One member's result for one day of a daily-goal challenge (Supabase
/// table `challenge_days`). Each member's app computes these from its own
/// local logs (ChallengeDayService) and upserts them, so friends only ever
/// see the day's value and whether it met the goal — never the underlying
/// health log.
class ChallengeDay {
  const ChallengeDay({
    required this.challengeId,
    required this.userId,
    required this.day,
    required this.value,
    required this.goalMet,
    required this.restDay,
  });

  factory ChallengeDay.fromMap(Map<String, dynamic> map) {
    return ChallengeDay(
      challengeId: map['challenge_id'] as String,
      userId: map['user_id'] as String,
      day: map['day'] as String,
      value: (map['value'] as num).toDouble(),
      goalMet: map['goal_met'] as bool,
      restDay: map['rest_day'] as bool,
    );
  }

  final String challengeId;
  final String userId;

  /// 'yyyy-MM-dd', the member's local calendar date.
  final String day;
  final double value;
  final bool goalMet;
  final bool restDay;

  DateTime get date => dateFromKey(day);

  Map<String, dynamic> toMap() => {
        'challenge_id': challengeId,
        'user_id': userId,
        'day': day,
        'value': value,
        'goal_met': goalMet,
        'rest_day': restDay,
        'updated_at': nowIso(),
      };
}
