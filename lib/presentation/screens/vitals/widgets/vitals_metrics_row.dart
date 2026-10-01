import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';

/// The day at a glance: what's logged (✓), what's still open (○), and
/// progress toward the water/protein goals. Tapping a tile jumps to the
/// section that fills it in, so this doubles as the "what's left" list.
/// Steps are display-only — they're logged on the Movement tab.
class VitalsMetricsRow extends ConsumerWidget {
  const VitalsMetricsRow({
    super.key,
    required this.log,
    required this.onTapCheckin,
    required this.onTapSleep,
    required this.onTapLiquids,
    required this.onTapProtein,
  });

  final DailyLog log;
  final VoidCallback onTapCheckin;
  final VoidCallback onTapSleep;
  final VoidCallback onTapLiquids;
  final VoidCallback onTapProtein;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsSnapshotProvider).valueOrNull;
    final waterGoal = settings?.waterGoalMl ?? 2000;
    final proteinGoal = settings?.proteinGoalG ?? 100;
    final waterPct = waterGoal == 0 ? 0 : (log.waterMlCredit / waterGoal * 100).round();
    final proteinPct = proteinGoal == 0 ? 0 : (log.proteinG / proteinGoal * 100).round();

    return Row(
      children: [
        _Metric(
          label: l10n.vitalsMetricsRowCheckinLabel,
          value: log.mentalState != null ? '✓' : '○',
          done: log.mentalState != null,
          onTap: onTapCheckin,
        ),
        _Metric(
          label: l10n.vitalsMetricsRowSleepLabel,
          value: log.sleepHours != null ? '✓' : '○',
          done: log.sleepHours != null,
          onTap: onTapSleep,
        ),
        _Metric(
          label: l10n.vitalsMetricsRowLiquidsLabel,
          value: '$waterPct%',
          done: waterPct >= 100,
          onTap: onTapLiquids,
        ),
        _Metric(
          label: l10n.vitalsMetricsRowProteinLabel,
          value: '$proteinPct%',
          done: proteinPct >= 100,
          onTap: onTapProtein,
        ),
        _Metric(
          label: l10n.vitalsMetricsRowStepsLabel,
          value: '${log.steps}',
          done: false,
        ),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value, required this.done, this.onTap});

  final String label;
  final String value;
  final bool done;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: ZebraColors.paper,
            border: Border.all(
              color: done ? ZebraColors.success : ZebraColors.cardBorder,
              width: done ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Values stay near-black for contrast (success green and
              // brandTeal are both under 4.5:1 on paper at this size); the
              // "done" state is carried by the ✓/border instead.
              Text(value,
                  style: const TextStyle(fontWeight: FontWeight.w700, color: ZebraColors.black)),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
