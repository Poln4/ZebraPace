import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_providers.dart';
import 'widgets/body_metrics_section.dart';
import 'widgets/hydration_section.dart';
import 'widgets/mind_body_form.dart';
import 'widgets/nutrition_section.dart';
import 'widgets/quick_checkin_section.dart';
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
              VitalsMetricsRow(log: log),
              const SizedBox(height: 14),
              if (log.isFlareDay)
                _StatusBanner(
                  text: l10n.vitalsTabFlareDayBanner,
                  color: ZebraColors.sand,
                )
              else if (log.isRestDay)
                _StatusBanner(
                  text: l10n.vitalsTabRestDayBanner,
                  color: ZebraColors.teal,
                ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: CupertinoButton(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      color: log.isRestDay ? ZebraColors.teal : ZebraColors.paper,
                      onPressed: () => _toggleRest(ref, log.isRestDay),
                      child: Text(
                        log.isRestDay
                            ? l10n.vitalsTabRestDayButtonActive
                            : l10n.vitalsTabRestDayButton,
                        style: const TextStyle(
                          // Black on both states: white-on-teal (the active
                          // state's background) is only 3.8:1, under WCAG
                          // AA's 4.5:1 — black clears 5.5:1 there and reads
                          // fine on paper too.
                          color: ZebraColors.onColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CupertinoButton(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      color: log.isFlareDay ? ZebraColors.sand : ZebraColors.paper,
                      onPressed: () => _toggleFlare(ref, log.isFlareDay),
                      child: Text(
                        log.isFlareDay
                            ? l10n.vitalsTabFlareDayButtonActive
                            : l10n.vitalsTabFlareDayButton,
                        style: TextStyle(
                          color: log.isFlareDay ? ZebraColors.black : ZebraColors.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              MindBodyForm(log: log),
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

  void _toggleRest(WidgetRef ref, bool current) {
    final date = ref.read(selectedDateProvider);
    final repo = ref.read(dailyLogRepositoryProvider);
    repo.getOrCreateDailyLog(date).then(
          (log) => repo.upsertDailyLog(log.copyWith(isRestDay: !current)),
        );
  }

  void _toggleFlare(WidgetRef ref, bool current) {
    final date = ref.read(selectedDateProvider);
    final repo = ref.read(dailyLogRepositoryProvider);
    repo.getOrCreateDailyLog(date).then(
          (log) => repo.upsertDailyLog(log.copyWith(isFlareDay: !current)),
        );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }
}
