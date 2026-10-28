import 'package:flutter/cupertino.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/challenge.dart';
import '../../../../domain/services/challenge_standings_builder.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/section_card.dart';
import 'challenge_goal_format.dart';
import 'week_dots.dart';

/// Everyone in a daily-goal challenge, already ranked by days met
/// (ChallengeStandingsBuilder). Each row shows the member's own goal next
/// to their name, so a lower step count reads as "a different goal", not
/// "doing worse".
class DailyLeaderboardList extends StatelessWidget {
  const DailyLeaderboardList({
    required this.challenge,
    required this.standings,
    required this.weekIndex,
    required this.myUserId,
    super.key,
  });

  final Challenge challenge;
  final List<ChallengeStanding> standings;
  final int weekIndex;
  final String myUserId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dates = challenge.daysOfWeek(weekIndex);

    return SectionCard(
      title: l10n.challengeTabLeaderboardTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < standings.length; i++) ...[
            _Row(
              rank: i + 1,
              challenge: challenge,
              standing: standings[i],
              dates: dates,
              isMe: standings[i].entry.userId == myUserId,
            ),
            if (i != standings.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.rank,
    required this.challenge,
    required this.standing,
    required this.dates,
    required this.isMe,
  });

  final int rank;
  final Challenge challenge;
  final ChallengeStanding standing;
  final List<DateTime> dates;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final entry = standing.entry;
    final kind = challenge.kind;
    final String goalLabel;
    if (kind == ChallengeKind.logging) {
      goalLabel = l10n.challengeGoalLogging;
    } else if (entry.dailyGoal == null) {
      goalLabel = l10n.challengeTabNoGoalYet;
    } else {
      goalLabel = formatChallengeGoal(context, kind, entry.dailyGoal!);
    }

    return Row(
      children: [
        SizedBox(
          width: 22,
          child: Text('$rank',
              style: const TextStyle(fontSize: 13, color: CupertinoColors.systemGrey)),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isMe ? l10n.challengeTabYouLabel(entry.displayName) : entry.displayName,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
              Text(goalLabel,
                  style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey),
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              WeekDots(dates: dates, days: standing.week),
            ],
          ),
        ),
        Text(
          '${standing.totalMet}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: ZebraColors.success),
        ),
      ],
    );
  }
}
