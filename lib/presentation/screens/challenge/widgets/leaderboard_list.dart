import 'package:flutter/cupertino.dart';

import '../../../../core/constants/defaults.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/weight_challenge_entry.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/section_card.dart';

/// Everyone's current standing, one vertical bar per person side by side —
/// each bar starts full (no progress yet) and drains from the top down as
/// weight is lost, so the fill visually goes down the same way the number
/// on the scale does. Sorted by percent lost (descending) by the
/// repository already; this widget just renders that order left to right.
class LeaderboardList extends StatelessWidget {
  const LeaderboardList({required this.entries, required this.myUserId, super.key});

  final List<WeightChallengeEntry> entries;
  final String? myUserId;

  static const _barHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SectionCard(
      title: l10n.challengeTabLeaderboardTitle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final entry in entries)
            _ParticipantBar(entry: entry, isMe: entry.userId == myUserId),
        ],
      ),
    );
  }
}

class _ParticipantBar extends StatelessWidget {
  const _ParticipantBar({required this.entry, required this.isMe});

  final WeightChallengeEntry entry;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final percent = entry.percentLost;
    final percentLabel = '${percent >= 0 ? '-' : '+'}${percent.abs().toStringAsFixed(1)}%';
    // 0 = no progress (tank still full), 1 = goal reached (tank empty).
    final progress =
        (percent / WeightChallengeDefaults.targetPercent).clamp(0.0, 1.0).toDouble();
    final fillColor = entry.goalReached ? ZebraColors.success : ZebraColors.brandTeal;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (entry.goalReached) const Text('🎉', style: TextStyle(fontSize: 14)),
        Text(
          percentLabel,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: percent >= 0 ? ZebraColors.success : CupertinoColors.systemGrey,
          ),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: 28,
            height: LeaderboardList._barHeight,
            color: ZebraColors.cardBorder,
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 1 - progress,
              child: Container(color: fillColor),
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 64,
          child: Text(
            isMe ? l10n.challengeTabYouLabel(entry.displayName) : entry.displayName,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
          ),
        ),
      ],
    );
  }
}
