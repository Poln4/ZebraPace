import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_providers.dart';
import 'widgets/body_metrics_section.dart';
import 'widgets/braces_section.dart';
import 'widgets/energy_battery_card.dart';
import 'widgets/hydration_section.dart';
import 'widgets/nutrition_section.dart';
import 'widgets/quick_checkin_section.dart';
import 'widgets/sleep_section.dart';
import 'widgets/soreness_check_section.dart';
import 'widgets/vitals_metrics_row.dart';

/// On Rest/Flare days ([DailyLog.isLowEnergyDay]) only the essentials —
/// the energy readout, the check-in, and sleep (which that readout is
/// derived from) — show by
/// default, with everything else one tap away behind "Show all sections".
/// That toggle is local UI state only, not persisted.
class VitalsTab extends ConsumerStatefulWidget {
  const VitalsTab({super.key});

  @override
  ConsumerState<VitalsTab> createState() => _VitalsTabState();
}

class _VitalsTabState extends ConsumerState<VitalsTab> {
  bool _showAllOnLowEnergyDay = false;

  // Jump targets for VitalsMetricsRow's tiles.
  final _checkinKey = GlobalKey();
  final _sleepKey = GlobalKey();
  final _hydrationKey = GlobalKey();
  final _nutritionKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final target = key.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final logAsync = ref.watch(dailyLogProvider);

    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      child: SafeArea(
        child: logAsync.when(
          loading: () => const Center(child: CupertinoActivityIndicator()),
          error: (e, st) => Center(child: Text(l10n.vitalsTabLoadError(e.toString()))),
          data: (log) {
            final essentialsOnly = log.isLowEnergyDay && !_showAllOnLowEnergyDay;
            final extras = <Widget>[
              BracesSection(log: log),
              const SorenessCheckSection(),
              KeyedSubtree(key: _hydrationKey, child: const HydrationSection()),
              KeyedSubtree(key: _nutritionKey, child: const NutritionSection()),
              const BodyMetricsSection(),
            ];
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const EnergyBatteryCard(),
                if (!log.isLowEnergyDay) ...[
                  VitalsMetricsRow(
                    log: log,
                    onTapCheckin: () => _scrollTo(_checkinKey),
                    onTapSleep: () => _scrollTo(_sleepKey),
                    onTapLiquids: () => _scrollTo(_hydrationKey),
                    onTapProtein: () => _scrollTo(_nutritionKey),
                  ),
                  const SizedBox(height: 14),
                ],
                KeyedSubtree(key: _checkinKey, child: QuickCheckinSection(log: log)),
                KeyedSubtree(key: _sleepKey, child: const SleepSection()),
                if (log.isLowEnergyDay) ...[
                  if (essentialsOnly)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        l10n.vitalsTabLowEnergyNote,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13, color: CupertinoColors.systemGrey),
                      ),
                    ),
                  CupertinoButton(
                    onPressed: () =>
                        setState(() => _showAllOnLowEnergyDay = !_showAllOnLowEnergyDay),
                    child: Text(
                      essentialsOnly ? l10n.vitalsTabShowAllButton : l10n.vitalsTabShowEssentialsButton,
                      style: const TextStyle(color: ZebraColors.brandTeal, fontSize: 15),
                    ),
                  ),
                ],
                if (!essentialsOnly) ...extras,
              ],
            );
          },
        ),
      ),
    );
  }
}
