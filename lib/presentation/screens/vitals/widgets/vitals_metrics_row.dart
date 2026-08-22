import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';

class VitalsMetricsRow extends ConsumerWidget {
  const VitalsMetricsRow({super.key, required this.log});

  final DailyLog log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsSnapshotProvider).valueOrNull;
    return Row(
      children: [
        _Metric(l10n.vitalsMetricsRowLiquidsLabel, '${log.waterMlCredit.round()} ml'),
        _Metric(l10n.vitalsMetricsRowStepsLabel, '${log.steps}'),
        _Metric(l10n.vitalsMetricsRowProteinLabel,
            '${log.proteinG}g / ${settings?.proteinGoalG ?? 100}g'),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: ZebraColors.paper,
          border: Border.all(color: ZebraColors.cardBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(fontWeight: FontWeight.w700, color: ZebraColors.brandTeal)),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
          ],
        ),
      ),
    );
  }
}
