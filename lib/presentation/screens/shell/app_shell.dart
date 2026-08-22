import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../core/utils/date_utils.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_providers.dart';
import '../../../providers/text_scale_providers.dart';
import '../insights/insights_tab.dart';
import '../movement/movement_tab.dart';
import '../settings/settings_tab.dart';
import '../vitals/vitals_tab.dart';
import 'injury_banner.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      child: SafeArea(
        child: Column(
          children: [
            const _GreetingRow(),
            const _CalendarStrip(),
            const _RestFlareRow(),
            const InjuryBanner(),
            Expanded(
              child: CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  backgroundColor: ZebraColors.paper,
                  activeColor: ZebraColors.brandTeal,
                  inactiveColor: CupertinoColors.systemGrey,
                  items: [
                    BottomNavigationBarItem(
                        icon: const Icon(CupertinoIcons.drop), label: l10n.appShellTabVitals),
                    BottomNavigationBarItem(
                        icon: const Icon(CupertinoIcons.flame), label: l10n.appShellTabMovement),
                    BottomNavigationBarItem(
                        icon: const Icon(CupertinoIcons.chart_bar), label: l10n.appShellTabInsights),
                  ],
                ),
                tabBuilder: (context, index) {
                  final page = switch (index) {
                    0 => const VitalsTab(),
                    1 => const MovementTab(),
                    _ => const InsightsTab(),
                  };
                  return CupertinoTabView(builder: (context) => page);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Personalized greeting (from Settings' "Your name" field, falls back to
/// the plain app title when unset) plus the two top-right shortcuts: a
/// one-tap text-size cycle and a push into the full Settings screen —
/// Settings no longer has its own bottom tab.
class _GreetingRow extends ConsumerWidget {
  const _GreetingRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final name = ref.watch(userNameProvider).valueOrNull ?? '';
    final greeting = name.isEmpty ? l10n.appTitle : l10n.appShellGreeting(name);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 4),
      child: Row(
        children: [
          const Text('🦓', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              greeting,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: ZebraColors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          CupertinoButton(
            padding: const EdgeInsets.all(8),
            onPressed: () => cycleTextScale(ref),
            child: Semantics(
              label: l10n.settingsTabTextSizeTitle,
              child: const Icon(CupertinoIcons.textformat_size,
                  color: ZebraColors.brandTeal, size: 22),
            ),
          ),
          CupertinoButton(
            padding: const EdgeInsets.all(8),
            onPressed: () => Navigator.of(context).push(
              CupertinoPageRoute(builder: (_) => const SettingsTab()),
            ),
            child: Semantics(
              label: l10n.settingsTabTitle,
              child: const Icon(CupertinoIcons.gear, color: ZebraColors.brandTeal, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}

/// The last 5 days (today included) as tappable chips, for quick recent-day
/// switching without opening the full date picker — which stays reachable
/// via the trailing calendar-icon button for anything older.
class _CalendarStrip extends ConsumerWidget {
  const _CalendarStrip();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final locale = Localizations.localeOf(context).toString();
    final today = dateFromKey(todayKey());
    final days = List.generate(5, (i) => today.subtract(Duration(days: 4 - i)));

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Row(
        children: [
          for (final day in days) ...[
            Expanded(child: _DayChip(day: day, locale: locale, selectedDate: selectedDate)),
            const SizedBox(width: 6),
          ],
          CupertinoButton(
            padding: const EdgeInsets.all(6),
            onPressed: () => _pickDate(context, ref, selectedDate),
            child: const Icon(CupertinoIcons.calendar, color: ZebraColors.brandTeal, size: 20),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate(BuildContext context, WidgetRef ref, String currentDate) async {
    final l10n = AppLocalizations.of(context);
    DateTime picked = dateFromKey(currentDate);
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => Container(
        height: 260,
        color: ZebraColors.paper,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: picked,
                maximumDate: DateTime.now(),
                onDateTimeChanged: (d) => picked = d,
              ),
            ),
            CupertinoButton(
              child: Text(l10n.appShellDoneButton),
              onPressed: () {
                ref.read(selectedDateProvider.notifier).state = dateKey(picked);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DayChip extends ConsumerWidget {
  const _DayChip({required this.day, required this.locale, required this.selectedDate});

  final DateTime day;
  final String locale;
  final String selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = dateKey(day);
    final selected = key == selectedDate;
    return GestureDetector(
      onTap: () => ref.read(selectedDateProvider.notifier).state = key,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: selected ? ZebraColors.brandTeal : ZebraColors.paper,
          border: Border.all(color: ZebraColors.cardBorder),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              DateFormat.E(locale).format(day),
              style: TextStyle(
                fontSize: 11,
                color: selected ? ZebraColors.onColor : CupertinoColors.systemGrey,
              ),
            ),
            Text(
              day.day.toString(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: selected ? ZebraColors.onColor : ZebraColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Rest/Flare Day quick-log — reachable from every tab, not just Vitals,
/// since pacing decisions ("should today be a rest day?") aren't specific
/// to any one screen. Moved here from vitals_tab.dart verbatim.
class _RestFlareRow extends ConsumerWidget {
  const _RestFlareRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final log = ref.watch(dailyLogProvider).valueOrNull;
    if (log == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Column(
        children: [
          if (log.isFlareDay)
            _StatusBanner(text: l10n.vitalsTabFlareDayBanner, color: ZebraColors.sand)
          else if (log.isRestDay)
            _StatusBanner(text: l10n.vitalsTabRestDayBanner, color: ZebraColors.teal),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  color: log.isRestDay ? ZebraColors.teal : ZebraColors.paper,
                  onPressed: () => _toggleRest(ref, log.isRestDay),
                  child: Text(
                    log.isRestDay ? l10n.vitalsTabRestDayButtonActive : l10n.vitalsTabRestDayButton,
                    style: const TextStyle(color: ZebraColors.onColor, fontSize: 13),
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
                    log.isFlareDay ? l10n.vitalsTabFlareDayButtonActive : l10n.vitalsTabFlareDayButton,
                    style: const TextStyle(color: ZebraColors.black, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ],
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
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }
}
