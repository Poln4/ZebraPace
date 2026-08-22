import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../core/utils/date_utils.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_providers.dart';
import '../../widgets/section_card.dart';
import '../../widgets/stripe_track.dart';
import 'widgets/calisthenics_comfort_chart.dart';
import 'widgets/checkin_consistency_strip.dart';
import 'widgets/export_section.dart';
import 'widgets/feeling_trend_chart.dart';
import 'widgets/history_tables.dart';
import 'widgets/insights_providers.dart';
import 'widgets/insights_range.dart';
import 'widgets/liquids_chart.dart';
import 'widgets/mets_summary_widget.dart';
import 'widgets/month_chapter_card.dart';
import 'widgets/pem_chart.dart';
import 'widgets/principles_expander.dart';
import 'widgets/steps_chart.dart';
import 'widgets/weather_chart.dart';

class InsightsTab extends ConsumerWidget {
  const InsightsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final range = ref.watch(insightsDateRangeProvider);
    final rangeOption = ref.watch(insightsRangeOptionProvider);
    final logsAsync = ref.watch(dailyLogsInRangeProvider);
    final stripeStatus = ref.watch(stripeStatusProvider).valueOrNull;

    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      navigationBar: CupertinoNavigationBar(
        middle: Text(l10n.insightsTabTitle),
        backgroundColor: ZebraColors.paper,
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (stripeStatus != null) ...[
              SectionCard(
                title: l10n.insightsTabStripesTitle,
                caption: l10n.insightsTabStripesCaption,
                child: StripeTrack(stripesEarned: stripeStatus.stripesEarned),
              ),
            ],
            const MonthChapterCard(),
            const PrinciplesExpander(),
            CupertinoSlidingSegmentedControl<InsightsRangeOption>(
              groupValue: rangeOption,
              children: {
                for (final o in InsightsRangeOption.values)
                  o: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(o.label(l10n)),
                  ),
              },
              onValueChanged: (v) {
                if (v != null) ref.read(insightsRangeOptionProvider.notifier).state = v;
              },
            ),
            const SizedBox(height: 12),
            logsAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CupertinoActivityIndicator()),
              ),
              error: (e, st) => Text(l10n.insightsTabLoadError(e.toString())),
              data: (logs) {
                if (logs.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(l10n.insightsTabEmptyState),
                  );
                }
                final settings = ref.watch(settingsSnapshotProvider).valueOrNull;
                final dates = dateKeysBetween(range.start, range.end);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionCard(title: l10n.insightsTabStepsTitle, child: StepsChart(logs: logs)),
                    const MetsSummaryWidget(),
                    SectionCard(
                      title: l10n.insightsTabLiquidsTitle,
                      child: LiquidsChart(logs: logs, goalMl: settings?.waterGoalMl ?? 2000),
                    ),
                    SectionCard(
                      title: l10n.insightsTabMentalStateTitle,
                      child: FeelingTrendChart(
                        scores: logs.map((l) => l.mentalState?.score).toList(),
                        color: ZebraColors.brandTeal,
                      ),
                    ),
                    SectionCard(
                      title: l10n.insightsTabBodyPainTitle,
                      child: FeelingTrendChart(
                        scores: logs.map((l) => l.bodyFeeling?.score).toList(),
                        color: ZebraColors.sand,
                      ),
                    ),
                    SectionCard(
                      title: l10n.insightsTabCheckinConsistencyTitle,
                      child: CheckinConsistencyStrip(logs: logs, dates: dates),
                    ),
                    const _CalisthenicsComfortSection(),
                    const _PemSection(),
                    const _WeatherSection(),
                    const _CelebrationSection(),
                    const ExportSection(),
                    const HistoryTables(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CalisthenicsComfortSection extends ConsumerStatefulWidget {
  const _CalisthenicsComfortSection();

  @override
  ConsumerState<_CalisthenicsComfortSection> createState() => _CalisthenicsComfortSectionState();
}

class _CalisthenicsComfortSectionState extends ConsumerState<_CalisthenicsComfortSection> {
  ComfortGrouping _grouping = ComfortGrouping.exercise;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final setsAsync = ref.watch(calisthenicsInRangeProvider);
    final settings = ref.watch(settingsSnapshotProvider).valueOrNull;

    return setsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (e, st) => Text(l10n.insightsTabLoadError(e.toString())),
      data: (sets) {
        if (sets.isEmpty) return const SizedBox.shrink();
        return SectionCard(
          title: l10n.insightsTabCalisthenicsComfortTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoSlidingSegmentedControl<ComfortGrouping>(
                groupValue: _grouping,
                children: {
                  ComfortGrouping.exercise: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(l10n.insightsTabGroupByExercise, style: const TextStyle(fontSize: 12)),
                  ),
                  ComfortGrouping.contractionMode: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(l10n.insightsTabGroupByContractionMode, style: const TextStyle(fontSize: 12)),
                  ),
                },
                onValueChanged: (v) {
                  if (v != null) setState(() => _grouping = v);
                },
              ),
              const SizedBox(height: 8),
              CalisthenicsComfortChart(
                sets: sets,
                grouping: _grouping,
                comfortThreshold: settings?.comfortThreshold ?? 3.8,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PemSection extends ConsumerWidget {
  const _PemSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final lag = ref.watch(pemLagDaysProvider);
    final resultAsync = ref.watch(pemResultProvider);

    return SectionCard(
      title: l10n.insightsTabPemTitle,
      caption: l10n.insightsTabPemCaption,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(l10n.insightsTabPemLagLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
              for (final d in [1, 2, 3])
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  onPressed: () => ref.read(pemLagDaysProvider.notifier).state = d,
                  child: Text(
                    l10n.insightsTabPemLagDays(d),
                    style: TextStyle(
                      fontWeight: lag == d ? FontWeight.w700 : FontWeight.w400,
                      color: lag == d ? ZebraColors.brandTeal : ZebraColors.black,
                    ),
                  ),
                ),
            ],
          ),
          resultAsync.when(
            loading: () => const CupertinoActivityIndicator(),
            error: (e, st) => Text(l10n.insightsTabLoadError(e.toString())),
            data: (result) => PemChart(result: result),
          ),
        ],
      ),
    );
  }
}

class _WeatherSection extends ConsumerWidget {
  const _WeatherSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsSnapshotProvider).valueOrNull;
    if (settings == null || !settings.hasLocation) {
      return SectionCard(
        title: l10n.insightsTabWeatherTitle,
        child: Text(
          l10n.insightsTabWeatherNoLocation,
          style: const TextStyle(fontSize: 12.5, color: CupertinoColors.systemGrey),
        ),
      );
    }

    final correlationAsync = ref.watch(weatherCorrelationProvider);
    return SectionCard(
      title: l10n.insightsTabWeatherTitle,
      child: correlationAsync.when(
        loading: () => const CupertinoActivityIndicator(),
        error: (e, st) => Text(l10n.insightsTabLoadError(e.toString())),
        data: (correlation) {
          if (correlation == null) return const SizedBox.shrink();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeatherChart(weatherDays: correlation.days, logs: const []),
              const SizedBox(height: 8),
              Text(
                correlation.hasEnoughData
                    ? l10n.insightsTabWeatherCorrelation(correlation.correlation!.toStringAsFixed(2))
                    : l10n.insightsTabWeatherInsufficientData,
                style: const TextStyle(fontSize: 11.5, color: CupertinoColors.systemGrey),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CelebrationSection extends ConsumerWidget {
  const _CelebrationSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final logsAsync = ref.watch(dailyLogsInRangeProvider);
    final activitiesAsync = ref.watch(activitiesInRangeProvider);
    final therapiesAsync = ref.watch(therapiesInRangeProvider);
    final calisthenicsAsync = ref.watch(calisthenicsInRangeProvider);

    final logs = logsAsync.valueOrNull ?? const [];
    final restDays = logs.where((l) => l.isRestDay).length;
    final flareDays = logs.where((l) => l.isFlareDay).length;
    final checkins = logs
        .where((l) => l.waterMlCredit > 0 || l.steps > 0 || l.isRestDay || l.isFlareDay)
        .length;
    final movementLogs =
        (activitiesAsync.valueOrNull?.length ?? 0) + (calisthenicsAsync.valueOrNull?.length ?? 0);
    final therapySessions = therapiesAsync.valueOrNull?.length ?? 0;

    return SectionCard(
      title: l10n.insightsTabCelebrationTitle,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _Stat(l10n.insightsTabCheckinsLabel, '$checkins'),
          _Stat(l10n.insightsTabRestDaysLabel, '$restDays'),
          _Stat(l10n.insightsTabFlareDaysLabel, '$flareDays'),
          _Stat(l10n.insightsTabTherapySessionsLabel, '$therapySessions'),
          _Stat(l10n.insightsTabMovementLogsLabel, '$movementLogs'),
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
    return SizedBox(
      width: 90,
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(fontWeight: FontWeight.w700, color: ZebraColors.brandTeal, fontSize: 18)),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
        ],
      ),
    );
  }
}
