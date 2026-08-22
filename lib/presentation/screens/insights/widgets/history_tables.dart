import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/section_card.dart';
import 'insights_providers.dart';

class HistoryTables extends ConsumerWidget {
  const HistoryTables({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        const _AllTimeVitalsHistory(),
        _RecentList(
          title: l10n.historyTablesActivitiesTitle,
          provider: activitiesInRangeProvider,
          lineOf: (a) => l10n.historyTablesActivityLine(a.date, a.activityName, a.durationMin),
        ),
        _RecentList(
          title: l10n.historyTablesTherapiesTitle,
          provider: therapiesInRangeProvider,
          lineOf: (t) => l10n.historyTablesTherapyLine(t.date, t.therapyName, t.durationMin),
        ),
        _RecentList(
          title: l10n.historyTablesCalisthenicsTitle,
          provider: calisthenicsInRangeProvider,
          lineOf: (c) => l10n.historyTablesCalisthenicsLine(
              c.date, c.exercise.label(l10n), c.progression, c.comfortScore.toStringAsFixed(1)),
        ),
        _RecentList(
          title: l10n.historyTablesSorenessTitle,
          provider: sorenessChecksInRangeProvider,
          lineOf: (s) => l10n.historyTablesSorenessLine(s.date, s.verdictLabel),
        ),
      ],
    );
  }
}

class _AllTimeVitalsHistory extends ConsumerWidget {
  const _AllTimeVitalsHistory();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final allLogsAsync = ref.watch(_allDailyLogsProvider);
    return allLogsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (e, st) => const SizedBox.shrink(),
      data: (logs) {
        if (logs.isEmpty) return const SizedBox.shrink();
        return SectionCard(
          title: l10n.historyTablesVitalsTitle,
          caption: l10n.historyTablesVitalsCaption,
          child: SizedBox(
            height: 220,
            child: ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, i) {
                final l = logs[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                    l10n.historyTablesVitalsLine(
                          l.date,
                          l.steps,
                          l.waterMlCredit.round(),
                          l.mentalState?.emoji ?? '—',
                          l.bodyFeeling?.emoji ?? '—',
                        ) +
                        (l.isRestDay ? l10n.historyTablesVitalsRestSuffix : '') +
                        (l.isFlareDay ? l10n.historyTablesVitalsFlareSuffix : ''),
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

final _allDailyLogsProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(dailyLogRepositoryProvider).getAll();
});

class _RecentList<T> extends ConsumerWidget {
  const _RecentList({required this.title, required this.provider, required this.lineOf});

  final String title;
  final AutoDisposeFutureProvider<List<T>> provider;
  final String Function(T) lineOf;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(provider);
    return itemsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (e, st) => const SizedBox.shrink(),
      data: (items) {
        if (items.isEmpty) return const SizedBox.shrink();
        final recent = items.reversed.take(10).toList();
        return SectionCard(
          title: title,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: recent
                .map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(lineOf(item),
                          style: const TextStyle(fontSize: 12, color: ZebraColors.black)),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
