import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/weight_challenge_entry.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/weight_challenge_providers.dart';
import '../../../widgets/section_card.dart';

/// Shown once the signed-in user has joined. Fully passive on purpose —
/// having both this and Vitals as separate places to enter the same weight
/// was confusing, so there's no field or button here anymore. It just
/// displays the same 7-day trimmed resting-day average Vitals already
/// produces, and quietly pushes it to the shared table whenever that
/// average changes — the only "entry point" for weight stays Vitals.
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
      if ((computed - entry.currentWeightKg).abs() < _syncThresholdKg) return;
      ref.read(weightChallengeRepositoryProvider).updateCurrentWeight(
            userId: entry.userId,
            currentWeightKg: computed,
          );
    });

    final percent = entry.percentLost;
    final percentLabel = '${percent >= 0 ? '-' : '+'}${percent.abs().toStringAsFixed(1)}%';
    final displayWeight = computedAsync.valueOrNull ?? entry.currentWeightKg;

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
                ? l10n.challengeTabWeightNoRecentRestDayHint
                : l10n.challengeTabWeightAutoSyncHint,
            style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey),
          ),
        ],
      ),
    );
  }
}
