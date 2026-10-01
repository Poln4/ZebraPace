import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/platform/standalone_app.dart';
import '../../../core/theme/zebra_theme.dart';
import '../../../core/utils/date_utils.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_providers.dart';
import '../../../providers/cloud_sync_providers.dart';
import '../../../providers/text_scale_providers.dart';
import '../challenge/challenge_tab.dart';
import '../insights/insights_tab.dart';
import '../movement/movement_tab.dart';
import '../settings/settings_tab.dart';
import '../vitals/vitals_tab.dart';
import 'injury_banner.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  final _tabController = CupertinoTabController();
  final _isStandaloneWebApp = isStandaloneWebApp();

  /// Whether the day-chip strip is expanded under the header. Collapsed by
  /// default so the header stays one line; local UI state only.
  bool _calendarOpen = false;

  /// Vitals and Movement log against the selected date; Insights and
  /// Together don't, so the date picker and Rest/Flare toggles (which act
  /// on the selected date) are hidden there rather than silently acting
  /// on a date the user can't see.
  bool get _isDateTab => _tabController.index <= 1;

  @override
  void initState() {
    super.initState();
    _tabController.addListener(() => setState(() {}));
    // Covers the case where a Cloud Sync sign-in completed while the invite
    // code, welcome, or lock screen was still showing — the flag was
    // already true before AppShell ever built, so a build-time ref.listen
    // alone wouldn't retroactively catch it.
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeGoToCloudSync());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _maybeGoToCloudSync() {
    if (!mounted) return;
    if (ref.read(pendingCloudSyncNavigationProvider)) {
      ref.read(pendingCloudSyncNavigationProvider.notifier).state = false;
      Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const SettingsTab()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Covers the case where sign-in completes while AppShell is already
    // mounted (e.g. the redirect lands in the same already-open tab).
    ref.listen(pendingCloudSyncNavigationProvider, (previous, next) {
      if (next) {
        ref.read(pendingCloudSyncNavigationProvider.notifier).state = false;
        Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const SettingsTab()));
      }
    });
    final l10n = AppLocalizations.of(context);
    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      child: SafeArea(
        child: Column(
          children: [
            _GreetingRow(
              showDate: _isDateTab,
              calendarOpen: _calendarOpen,
              onToggleCalendar: () => setState(() => _calendarOpen = !_calendarOpen),
            ),
            if (_isDateTab && _calendarOpen)
              _CalendarStrip(onDayPicked: () => setState(() => _calendarOpen = false)),
            if (_isDateTab) _RestFlareRow(showBanner: _tabController.index == 0),
            const InjuryBanner(),
            Expanded(
              // CupertinoTabBar reserves its own bottom clearance from
              // MediaQuery.viewPaddingOf(context).bottom directly — it does
              // NOT go through the outer SafeArea above (SafeArea only
              // touches MediaQuery.padding, not viewPadding). As an iOS
              // home-screen standalone PWA, the browser still reports 0 for
              // that inset even with web/index.html's viewport-fit=cover — a
              // known rough edge in how Flutter Web surfaces
              // env(safe-area-inset-bottom) — so the bar would sit under the
              // home indicator. There, and only there, force a floor of 34
              // (Apple's standard home-indicator height); a device that
              // reports a larger value still wins. In a normal browser tab
              // or on desktop the browser's own chrome is below the page, so
              // the floor would just be dead space.
              child: Builder(
                builder: (context) {
                  final mediaQuery = MediaQuery.of(context);
                  final floorBottom = _isStandaloneWebApp && mediaQuery.viewPadding.bottom < 34.0
                      ? 34.0
                      : mediaQuery.viewPadding.bottom;
                  return MediaQuery(
                    data: mediaQuery.copyWith(
                      viewPadding: mediaQuery.viewPadding.copyWith(bottom: floorBottom),
                    ),
                    child: CupertinoTabScaffold(
                      controller: _tabController,
                      tabBar: CupertinoTabBar(
                        backgroundColor: ZebraColors.paper,
                        activeColor: ZebraColors.brandTeal,
                        inactiveColor: CupertinoColors.systemGrey,
                        items: [
                          BottomNavigationBarItem(
                              icon: const Icon(CupertinoIcons.drop),
                              label: l10n.appShellTabVitals),
                          BottomNavigationBarItem(
                              icon: const Icon(CupertinoIcons.flame),
                              label: l10n.appShellTabMovement),
                          BottomNavigationBarItem(
                              icon: const Icon(CupertinoIcons.chart_bar),
                              label: l10n.appShellTabInsights),
                          BottomNavigationBarItem(
                              icon: const Icon(CupertinoIcons.person_3_fill),
                              label: l10n.appShellTabChallenge),
                        ],
                      ),
                      tabBuilder: (context, index) {
                        final page = switch (index) {
                          0 => const VitalsTab(),
                          1 => const MovementTab(),
                          2 => const InsightsTab(),
                          _ => const ChallengeTab(),
                        };
                        return CupertinoTabView(builder: (context) => page);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// One compact header line: personalized greeting (from Settings' "Your
/// name" field, falls back to the plain app title when unset), the selected
/// date as a tap-to-expand button on date-bound tabs, and the two top-right
/// shortcuts: a one-tap text-size cycle and a push into the full Settings
/// screen — Settings no longer has its own bottom tab.
class _GreetingRow extends ConsumerWidget {
  const _GreetingRow({
    required this.showDate,
    required this.calendarOpen,
    required this.onToggleCalendar,
  });

  final bool showDate;
  final bool calendarOpen;
  final VoidCallback onToggleCalendar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final name = ref.watch(userNameProvider).valueOrNull ?? '';
    final greeting = name.isEmpty ? l10n.appTitle : l10n.appShellGreeting(name);
    final selectedDate = ref.watch(selectedDateProvider);
    final locale = Localizations.localeOf(context).toString();
    final dateLabel = selectedDate == todayKey()
        ? l10n.appShellTodayButton
        : DateFormat.MMMEd(locale).format(dateFromKey(selectedDate));

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 4, 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              // The l10n greeting already carries the 🦓; the plain title
              // fallback gets it prepended so the header looks the same.
              name.isEmpty ? '🦓 $greeting' : greeting,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: ZebraColors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (showDate)
            CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              onPressed: onToggleCalendar,
              child: Semantics(
                label: l10n.appShellMoreDatesButton,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      dateLabel,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: ZebraColors.brandTeal,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      calendarOpen ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down,
                      size: 14,
                      color: ZebraColors.brandTeal,
                    ),
                  ],
                ),
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
/// via the trailing calendar-icon button for anything older. Shown only
/// while the header's date button is expanded; picking a day collapses it.
class _CalendarStrip extends ConsumerWidget {
  const _CalendarStrip({required this.onDayPicked});

  final VoidCallback onDayPicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final locale = Localizations.localeOf(context).toString();
    final today = dateFromKey(todayKey());
    final days = List.generate(5, (i) => today.subtract(Duration(days: 4 - i)));

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 4),
      child: Row(
        children: [
          for (final day in days) ...[
            Expanded(
              child: _DayChip(
                day: day,
                locale: locale,
                selectedDate: selectedDate,
                onPicked: onDayPicked,
              ),
            ),
            const SizedBox(width: 6),
          ],
          CupertinoButton(
            padding: const EdgeInsets.all(6),
            onPressed: () async {
              await _pickDate(context, ref, selectedDate);
              onDayPicked();
            },
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
  const _DayChip({
    required this.day,
    required this.locale,
    required this.selectedDate,
    required this.onPicked,
  });

  final DateTime day;
  final String locale;
  final String selectedDate;
  final VoidCallback onPicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = dateKey(day);
    final selected = key == selectedDate;
    return GestureDetector(
      onTap: () {
        ref.read(selectedDateProvider.notifier).state = key;
        onPicked();
      },
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

/// Rest/Flare Day quick-log — shared by Vitals and Movement (the tabs that
/// log against the selected date), since pacing decisions ("should today be
/// a rest day?") aren't specific to either one. The explanatory banner only
/// shows on Vitals; elsewhere the button's own "✓" state is enough.
class _RestFlareRow extends ConsumerWidget {
  const _RestFlareRow({required this.showBanner});

  final bool showBanner;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final log = ref.watch(dailyLogProvider).valueOrNull;
    if (log == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Column(
        children: [
          if (showBanner && log.isFlareDay) ...[
            _StatusBanner(text: l10n.vitalsTabFlareDayBanner, color: ZebraColors.sand),
            const SizedBox(height: 6),
          ] else if (showBanner && log.isRestDay) ...[
            _StatusBanner(text: l10n.vitalsTabRestDayBanner, color: ZebraColors.teal),
            const SizedBox(height: 6),
          ],
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
