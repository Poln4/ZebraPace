import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/progress_bar.dart';
import '../../../widgets/section_card.dart';

/// The "Spoon Battery" — a purely informational readout of how rested today
/// looks, derived from SleepEnergyService. Never feeds back into
/// PacingService's step goal/caution math (see that service's doc comment).
class EnergyBatteryCard extends ConsumerWidget {
  const EnergyBatteryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final log = ref.watch(dailyLogProvider).valueOrNull;
    final sleepGoalHours =
        ref.watch(settingsSnapshotProvider).valueOrNull?.sleepGoalHours ?? 8.0;
    final energy = ref.watch(sleepEnergyServiceProvider).computeEnergyLevel(
          sleepHours: log?.sleepHours,
          sleepQuality: log?.sleepQuality,
          sleepGoalHours: sleepGoalHours,
        );

    return SectionCard(
      title: l10n.energyBatteryTitle,
      child: energy == null
          ? Text(l10n.energyBatteryNoData,
              style: const TextStyle(fontSize: 12.5, color: CupertinoColors.systemGrey))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: energy),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, _) => ProgressBar(
                    progress: value,
                    height: 14,
                    fadeColor: CupertinoColors.systemGrey3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${_tierLabel(l10n, energy)} · ${(energy * 100).round()}%',
                  style: const TextStyle(fontSize: 12.5, color: CupertinoColors.systemGrey),
                ),
              ],
            ),
    );
  }

  String _tierLabel(AppLocalizations l10n, double energy) {
    if (energy >= 0.8) return l10n.energyTierFull;
    if (energy >= 0.6) return l10n.energyTierGood;
    if (energy >= 0.4) return l10n.energyTierOkay;
    if (energy >= 0.2) return l10n.energyTierLow;
    return l10n.energyTierEmpty;
  }
}
