import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_providers.dart';
import 'widgets/body_metrics_section.dart';
import 'widgets/energy_battery_card.dart';
import 'widgets/hydration_section.dart';
import 'widgets/mind_body_form.dart';
import 'widgets/nutrition_section.dart';
import 'widgets/quick_checkin_section.dart';
import 'widgets/sleep_section.dart';
import 'widgets/soreness_check_section.dart';
import 'widgets/vitals_metrics_row.dart';

class VitalsTab extends ConsumerWidget {
  const VitalsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final logAsync = ref.watch(dailyLogProvider);

    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      navigationBar: CupertinoNavigationBar(
        middle: Text(l10n.vitalsTabTitle),
        backgroundColor: ZebraColors.paper,
      ),
      child: SafeArea(
        child: logAsync.when(
          loading: () => const Center(child: CupertinoActivityIndicator()),
          error: (e, st) => Center(child: Text(l10n.vitalsTabLoadError(e.toString()))),
          data: (log) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const EnergyBatteryCard(),
              VitalsMetricsRow(log: log),
              const SizedBox(height: 14),
              MindBodyForm(log: log),
              const SleepSection(),
              const QuickCheckinSection(),
              const SorenessCheckSection(),
              const HydrationSection(),
              const NutritionSection(),
              const BodyMetricsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
