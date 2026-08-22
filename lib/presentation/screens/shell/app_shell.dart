import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../core/utils/date_utils.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_providers.dart';
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
            const _DatePickerRow(),
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
                    BottomNavigationBarItem(
                        icon: const Icon(CupertinoIcons.settings), label: l10n.appShellTabSettings),
                  ],
                ),
                tabBuilder: (context, index) {
                  final page = switch (index) {
                    0 => const VitalsTab(),
                    1 => const MovementTab(),
                    2 => const InsightsTab(),
                    _ => const SettingsTab(),
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

class _DatePickerRow extends ConsumerWidget {
  const _DatePickerRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          const Text('🦓', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              l10n.appTitle,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: ZebraColors.black,
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => _pickDate(context, ref, selectedDate),
            child: Text(selectedDate, style: const TextStyle(color: ZebraColors.brandTeal)),
          ),
          if (selectedDate != todayKey())
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => ref.read(selectedDateProvider.notifier).state = todayKey(),
              child: Text(l10n.appShellTodayButton, style: const TextStyle(color: ZebraColors.brandTeal)),
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
