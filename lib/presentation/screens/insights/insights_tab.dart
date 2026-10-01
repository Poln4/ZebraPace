import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/stats.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_providers.dart';
import '../../widgets/section_card.dart';
import '../../widgets/stripe_track.dart';
import 'widgets/body_metrics_chart.dart';
import 'widgets/calisthenics_comfort_chart.dart';
import 'widgets/checkin_consistency_strip.dart';
import 'widgets/chart_day_markers.dart';
import 'widgets/export_section.dart';
import 'widgets/feeling_trend_chart.dart';
import 'widgets/history_tables.dart';
import 'widgets/hr_exertion_chart.dart';
import 'widgets/insights_providers.dart';
import 'widgets/insights_range.dart';
import 'widgets/liquids_chart.dart';
import 'widgets/mets_summary_widget.dart';
import 'widgets/month_chapter_card.dart';
import 'widgets/pem_chart.dart';
import 'widgets/principles_expander.dart';
import 'widgets/steps_chart.dart';
import 'widgets/weather_chart.dart';

/// Split into four sub-views so no single scroll carries every chart:
/// Overview (stripes, this month's story, totals, principles), Trends (the
/// day-by-day charts), Patterns (lagged PEM/HR/weather checks behind one
/// shared "days later" control), and Records (exports + history tables).
/// The range control applies to all four.
class InsightsTab extends ConsumerWidget {
  const InsightsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final view = ref.watch(insightsViewProvider);
    final rangeOption = ref.watch(insightsRangeOptionProvider);

    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CupertinoSlidingSegmentedControl<InsightsView>(
              groupValue: view,
              children: {
                for (final v in InsightsView.values)
                  v: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(_viewLabel(l10n, v),
                        style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
                  ),
              },
              onValueChanged: (v) {
                if (v != null) ref.read(insightsViewProvider.notifier).state = v;
              },
            ),
            const SizedBox(height: 8),
            CupertinoSlidingSegmentedControl<InsightsRangeOption>(
              groupValue: rangeOption,
              children: {
                for (final o in InsightsRangeOption.values)
                  o: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(o.label(l10n), style: const TextStyle(fontSize: 12.5)),
                  ),
              },
              onValueChanged: (v) {
                if (v != null) ref.read(insightsRangeOptionProvider.notifier).state = v;
              },
            ),
            const SizedBox(height: 14),
            switch (view) {
              InsightsView.overview => const _OverviewView(),
              InsightsView.trends => const _TrendsView(),
              InsightsView.patterns => const _PatternsView(),
              InsightsView.records => const _RecordsView(),
            },
          ],
        ),
      ),
    );
  }

  String _viewLabel(AppLocalizations l10n, InsightsView v) => switch (v) {
        InsightsView.overview => l10n.insightsViewOverview,
        InsightsView.trends => l10n.insightsViewTrends,
        InsightsView.patterns => l10n.insightsViewPatterns,
        InsightsView.records => l10n.insightsViewRecords,
      };
}

class _OverviewView extends ConsumerWidget {
  const _OverviewView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final stripeStatus = ref.watch(stripeStatusProvider).valueOrNull;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (stripeStatus != null)
          SectionCard(
            title: l10n.insightsTabStripesTitle,
            caption: l10n.insightsTabStripesCaption,
            child: StripeTrack(stripesEarned: stripeStatus.stripesEarned),
          ),
        const MonthChapterCard(),
        const _CelebrationSection(),
        const PrinciplesExpander(),
      ],
    );
  }
}

class _TrendsView extends ConsumerWidget {
  const _TrendsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final range = ref.watch(insightsDateRangeProvider);
    final logsAsync = ref.watch(dailyLogsInRangeProvider);

    return logsAsync.when(
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
            if (anyDayMarked(logs))
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  l10n.insightsTabDayMarkerLegend,
                  style: const TextStyle(fontSize: 11.5, color: CupertinoColors.systemGrey),
                ),
              ),
            SectionCard(title: l10n.insightsTabStepsTitle, child: StepsChart(logs: logs)),
            const MetsSummaryWidget(),
            SectionCard(
              title: l10n.insightsTabLiquidsTitle,
              child: LiquidsChart(logs: logs, goalMl: settings?.waterGoalMl ?? 2000),
            ),
            SectionCard(
              title: l10n.insightsTabMentalStateTitle,
              child: FeelingTrendChart(
                logs: logs,
                scoreOf: (l) => l.mentalState?.score,
                color: ZebraColors.brandTeal,
              ),
            ),
            SectionCard(
              title: l10n.insightsTabBodyPainTitle,
              child: FeelingTrendChart(
                logs: logs,
                scoreOf: (l) => l.bodyFeeling?.score,
                color: ZebraColors.sand,
              ),
            ),
            SectionCard(
              title: l10n.insightsTabCheckinConsistencyTitle,
              child: CheckinConsistencyStrip(logs: logs, dates: dates),
            ),
            SectionCard(
              title: l10n.insightsTabBodyMetricsTitle,
              child: BodyMetricsChart(logs: logs),
            ),
            const _CalisthenicsComfortSection(),
          ],
        );
      },
    );
  }
}

class _PatternsView extends ConsumerWidget {
  const _PatternsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final lag = ref.watch(patternLagDaysProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.insightsTabPemLagLabel,
            style: const TextStyle(fontWeight: FontWeight.w600, color: ZebraColors.black)),
        const SizedBox(height: 6),
        CupertinoSlidingSegmentedControl<int>(
          groupValue: lag,
          children: {
            for (final d in [1, 2, 3])
              d: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(l10n.insightsTabPemLagDays(d), style: const TextStyle(fontSize: 12.5)),
              ),
          },
          onValueChanged: (v) {
            if (v != null) ref.read(patternLagDaysProvider.notifier).state = v;
          },
        ),
        const SizedBox(height: 14),
        const _PemSection(),
        const _HrExertionSection(),
        const _WeatherSection(),
      ],
    );
  }
}

class _RecordsView extends StatelessWidget {
  const _RecordsView();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ExportSection(), HistoryTables()],
    );
  }
}

/// Plain-language read of a lagged pattern check, shown above its chart so
/// the takeaway doesn't require reading a scatter plot or a Pearson r.
/// Body scores run 1 (severe) to 5 (loose & stable), so "lower" is worse; a
/// gap under [_dipThreshold] points is treated as no clear dip.
class _PatternHeadline extends StatelessWidget {
  const _PatternHeadline({
    required this.higherAvg,
    required this.typicalAvg,
    required this.lagDays,
  });

  static const _dipThreshold = 0.3;

  final double? higherAvg;
  final double? typicalAvg;
  final int lagDays;

  @override
  Widget build(BuildContext context) {
    final higher = higherAvg;
    final typical = typicalAvg;
    if (higher == null || typical == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final lag = l10n.insightsTabPemLagDays(lagDays);
    final h = higher.toStringAsFixed(1);
    final t = typical.toStringAsFixed(1);
    final text = typical - higher >= _dipThreshold
        ? l10n.insightsPatternHeadlineLower(lag, h, t)
        : l10n.insightsPatternHeadlineNoDip(lag, h, t);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text,
          style: const TextStyle(fontWeight: FontWeight.w600, color: ZebraColors.black)),
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
    final lag = ref.watch(patternLagDaysProvider);
    final resultAsync = ref.watch(pemResultProvider);

    return SectionCard(
      title: l10n.insightsTabPemTitle,
      caption: l10n.insightsTabPemCaption,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          resultAsync.when(
            loading: () => const CupertinoActivityIndicator(),
            error: (e, st) => Text(l10n.insightsTabLoadError(e.toString())),
            data: (result) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (result.hasEnoughData)
                  _PatternHeadline(
                    higherAvg: result.higherExertionAvgScore,
                    typicalAvg: result.typicalAvgScore,
                    lagDays: lag,
                  ),
                PemChart(result: result),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HrExertionSection extends ConsumerWidget {
  const _HrExertionSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final lag = ref.watch(patternLagDaysProvider);
    final resultAsync = ref.watch(hrExertionResultProvider);

    return SectionCard(
      title: l10n.insightsTabHrExertionTitle,
      caption: l10n.insightsTabHrExertionCaption,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          resultAsync.when(
            loading: () => const CupertinoActivityIndicator(),
            error: (e, st) => Text(l10n.insightsTabLoadError(e.toString())),
            data: (result) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (result.hasEnoughData)
                  _PatternHeadline(
                    higherAvg: result.higherExertionAvgScore,
                    typicalAvg: result.typicalAvgScore,
                    lagDays: lag,
                  ),
                HrExertionChart(result: result),
              ],
            ),
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
    final logs = ref.watch(dailyLogsInRangeProvider).valueOrNull ?? const [];
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
              WeatherChart(weatherDays: correlation.days, logs: logs),
              const SizedBox(height: 8),
              Text(
                correlation.hasEnoughData
                    ? l10n.insightsTabWeatherCorrelation(
                        correlation.correlation!.toStringAsFixed(2),
                        classifyCorrelationStrength(correlation.correlation!).label(l10n),
                      )
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
