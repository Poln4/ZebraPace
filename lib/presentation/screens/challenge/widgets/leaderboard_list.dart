import 'package:flutter/cupertino.dart';

import '../../../../core/constants/defaults.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/weight_challenge_entry.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/section_card.dart';

/// All participants, already sorted by percent lost (descending) by the
/// repository — this widget just renders that order.
class LeaderboardList extends StatelessWidget {
  const LeaderboardList({required this.entries, required this.myUserId, super.key});

  final List<WeightChallengeEntry> entries;
  final String? myUserId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SectionCard(
      title: l10n.challengeTabLeaderboardTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final entry in entries) ...[
            _LeaderboardRow(entry: entry, isMe: entry.userId == myUserId),
            if (entry != entries.last) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _LeaderboardRow extends StatelessWidget {
  const _LeaderboardRow({required this.entry, required this.isMe});

  final WeightChallengeEntry entry;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final percent = entry.percentLost;
    final percentLabel = '${percent >= 0 ? '-' : '+'}${percent.abs().toStringAsFixed(1)}%';
    final progress =
        (percent / WeightChallengeDefaults.targetPercent).clamp(0.0, 1.0).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                isMe ? l10n.challengeTabYouLabel(entry.displayName) : entry.displayName,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (entry.goalReached) ...[
              const Text('🎉', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 4),
            ],
            Text(
              percentLabel,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: percent >= 0 ? ZebraColors.success : CupertinoColors.systemGrey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            height: 8,
            color: ZebraColors.cardBorder,
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                color: entry.goalReached ? ZebraColors.success : ZebraColors.brandTeal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
