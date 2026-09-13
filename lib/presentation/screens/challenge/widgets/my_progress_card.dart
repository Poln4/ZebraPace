import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/defaults.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/weight_challenge_entry.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/weight_challenge_providers.dart';
import '../../../widgets/section_card.dart';

/// Shown once the signed-in user has joined. Fully passive on purpose —
/// having both this and Vitals as separate places to enter the same weight
/// was confusing, so there's no field or button here anymore. It just
/// displays the same 7-day trimmed average Vitals already produces, and
/// quietly pushes it to the shared table whenever that average changes —
/// the only "entry point" for weight stays Vitals.
///
/// Always logs a history point when a computed value is available, even
/// when it's unchanged from last time — a run of identical days is real
/// progress-chart information (a plateau), not "nothing to record", and
/// skipping the log on no-change days was leaving gaps in that chart. Only
/// the shared snapshot's current_weight_kg/updated_at are skipped when
/// nothing's actually different, since those don't need to churn for a
/// value that hasn't moved.
class MyProgressCard extends ConsumerWidget {
  const MyProgressCard({required this.entry, super.key});

  final WeightChallengeEntry entry;

  static const _syncThresholdKg = 0.05;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final computedAsync = ref.watch(computedChallengeWeightProvider);

    ref.listen(computedChallengeWeightProvider, (previous, next) {
      final computed = next.valueOrNull;
      if (computed == null) return;
      final repo = ref.read(weightChallengeRepositoryProvider);
      if ((computed - entry.currentWeightKg).abs() < _syncThresholdKg) {
        repo.logWeighIn(userId: entry.userId, weightKg: computed);
      } else {
        repo.updateCurrentWeight(userId: entry.userId, currentWeightKg: computed);
      }
    });

    final percent = entry.percentLost;
    final percentLabel = '${percent >= 0 ? '-' : '+'}${percent.abs().toStringAsFixed(1)}%';
    final displayWeight = computedAsync.valueOrNull ?? entry.currentWeightKg;
    final goalWeightKg =
        entry.startWeightKg * (1 - WeightChallengeDefaults.targetPercent / 100);

    return SectionCard(
      title: l10n.challengeTabMyProgressTitle,
      caption: l10n.challengeTabMyProgressCaption(percentLabel),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${displayWeight.toStringAsFixed(1)} kg',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: ZebraColors.black),
          ),
          const SizedBox(height: 4),
          Text(
            computedAsync.valueOrNull == null
                ? l10n.challengeTabWeightNoRecentEntryHint
                : l10n.challengeTabWeightAutoSyncHint,
            style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _GoalStat(
                  label: l10n.challengeTabStartWeightLabel,
                  value: entry.startWeightKg,
                ),
              ),
              const Icon(CupertinoIcons.arrow_right, size: 14, color: CupertinoColors.systemGrey),
              Expanded(
                child: _GoalStat(
                  label: l10n.challengeTabGoalWeightLabel,
                  value: goalWeightKg,
                  color: ZebraColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GoalStat extends StatelessWidget {
  const _GoalStat({required this.label, required this.value, this.color = ZebraColors.black});

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: CupertinoColors.systemGrey)),
        Text(
          '${value.toStringAsFixed(1)} kg',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color),
        ),
      ],
    );
  }
}
