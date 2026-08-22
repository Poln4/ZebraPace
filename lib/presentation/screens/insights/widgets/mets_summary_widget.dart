import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/section_card.dart';
import 'insights_providers.dart';

/// Additive-only summary (plan §4) — never wired into the pacing algorithm.
/// Only shows once there's at least one activity with METs/energy data,
/// which today only comes from confirmed HealthKit workout imports.
class MetsSummaryWidget extends ConsumerWidget {
  const MetsSummaryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final summary = ref.watch(metsSummaryInRangeProvider);
    if (!summary.hasData) return const SizedBox.shrink();

    return SectionCard(
      title: l10n.metsSummaryWidgetTitle,
      caption: l10n.metsSummaryWidgetCaption,
      child: Row(
        children: [
          Expanded(
            child: _Stat(l10n.metsSummaryWidgetMetMinutesLabel, summary.totalMetMinutes.toStringAsFixed(0)),
          ),
          Expanded(
            child: _Stat(l10n.metsSummaryWidgetActiveEnergyLabel,
                l10n.metsSummaryWidgetActiveEnergyValue(summary.totalActiveEnergyKcal.toStringAsFixed(0))),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.w700, color: ZebraColors.brandTeal, fontSize: 16)),
        Text(label, style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
      ],
    );
  }
}
