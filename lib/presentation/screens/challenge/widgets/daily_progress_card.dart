import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/challenge.dart';
import '../../../../domain/services/challenge_standings_builder.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../../providers/challenge_providers.dart';
import '../../../widgets/section_card.dart';
import 'challenge_goal_format.dart';
import 'week_dots.dart';

/// The daily-goal counterpart of MyProgressCard: the member's own goal,
/// this week's dots and their running total. Like MyProgressCard it's
/// passive — nothing is entered here — and it's also what pushes the
/// member's days to the shared table: once when shown, and again whenever
/// today's log or activities change locally (todayChallengeInputsProvider).
class DailyProgressCard extends ConsumerStatefulWidget {
  const DailyProgressCard({
    required this.challenge,
    required this.standing,
    required this.weekIndex,
    required this.onChangeGoal,
    super.key,
  });

  final Challenge challenge;
  final ChallengeStanding standing;
  final int weekIndex;
  final VoidCallback onChangeGoal;

  @override
  ConsumerState<DailyProgressCard> createState() => _DailyProgressCardState();
}

class _DailyProgressCardState extends ConsumerState<DailyProgressCard> {
  bool _syncing = false;
  bool _syncAgain = false;

  @override
  void initState() {
    super.initState();
    _sync();
  }

  @override
  void didUpdateWidget(DailyProgressCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // A changed goal re-scores every past day, not just today.
    if (oldWidget.standing.entry.dailyGoal != widget.standing.entry.dailyGoal ||
        oldWidget.challenge.id != widget.challenge.id) {
      _sync();
    }
  }

  /// Serialized: a trigger arriving mid-sync queues exactly one more run
  /// instead of racing two upserts of the same rows.
  Future<void> _sync() async {
    if (_syncing) {
      _syncAgain = true;
      return;
    }
    _syncing = true;
    try {
      do {
        _syncAgain = false;
        final entry = widget.standing.entry;
        final days = await ref.read(challengeDayServiceProvider).computeDays(
              challenge: widget.challenge,
              userId: entry.userId,
              dailyGoal: entry.dailyGoal,
              today: DateTime.now(),
            );
        await ref.read(challengeRepositoryProvider).upsertDays(days);
      } while (_syncAgain && mounted);
    } catch (_) {
      // Best effort, like MyProgressCard's weight sync — the next trigger
      // retries the whole range anyway.
    } finally {
      _syncing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    ref.listen(todayChallengeInputsProvider, (_, _) => _sync());

    final kind = widget.challenge.kind;
    final standing = widget.standing;
    final goal = standing.entry.dailyGoal ?? 1;

    return SectionCard(
      title: l10n.challengeTabMyProgressTitle,
      caption: l10n.challengeTabTotalDays(standing.totalMet),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  kind == ChallengeKind.logging
                      ? l10n.challengeGoalLogging
                      : l10n.challengeTabMyGoalLabel(formatChallengeGoal(context, kind, goal)),
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: ZebraColors.black),
                ),
              ),
              if (kind.needsDailyGoal)
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(32, 32),
                  onPressed: widget.onChangeGoal,
                  child: Text(l10n.challengeTabChangeGoalButton,
                      style: const TextStyle(fontSize: 13, color: ZebraColors.brandTeal)),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              WeekDots(
                dates: widget.challenge.daysOfWeek(widget.weekIndex),
                days: standing.week,
                showLetters: true,
              ),
              const Spacer(),
              Text(
                l10n.challengeTabThisWeekLabel(standing.weekMet),
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            [
              l10n.challengeTabDailySyncHint,
              if (kind == ChallengeKind.logging) l10n.challengeTabLoggingHint,
              if (kind.restDayCountsAsMet) l10n.challengeTabRestDayHint,
            ].join(' '),
            style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey),
          ),
        ],
      ),
    );
  }
}
