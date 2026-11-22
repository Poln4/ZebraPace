import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/intl_locale.dart';
import '../../../../domain/services/period_comparison_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/plus_providers.dart';
import '../../../widgets/plus_gate.dart';
import '../../../widgets/section_card.dart';
import 'insights_providers.dart';

/// Zebras+: two periods side by side ("this winter vs. last"). Plain
/// numbers and differences — no good/bad colours, since more steps isn't
/// automatically better in pacing and rest days count.
class PeriodComparisonSection extends ConsumerWidget {
  const PeriodComparisonSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isPlus = ref.watch(isPlusProvider);
    return SectionCard(
      title: l10n.insightsCompareTitle,
      caption: l10n.insightsCompareCaption,
      child: isPlus
          ? const _Content()
          : PlusLockedTeaser(
              teaser: l10n.insightsCompareLocked,
              gateMessage: l10n.plusLockedCompareMessage,
            ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final months = ref.watch(comparisonMonthsProvider);
    final target = ref.watch(comparisonTargetProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoSlidingSegmentedControl<int>(
          groupValue: months,
          children: {
            for (final m in PeriodComparisonService.lengthsInMonths)
              m: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(l10n.insightsCompareMonths(m), style: const TextStyle(fontSize: 12.5)),
              ),
          },
          onValueChanged: (v) {
            if (v != null) ref.read(comparisonMonthsProvider.notifier).state = v;
          },
        ),
        const SizedBox(height: 6),
        CupertinoSlidingSegmentedControl<ComparisonTarget>(
          groupValue: target,
          children: {
            ComparisonTarget.previousPeriod: _segment(l10n.insightsCompareVsPrevious),
            ComparisonTarget.sameTimeLastYear: _segment(l10n.insightsCompareVsLastYear),
          },
          onValueChanged: (v) {
            if (v != null) ref.read(comparisonTargetProvider.notifier).state = v;
          },
        ),
        const SizedBox(height: 12),
        ref.watch(periodComparisonProvider).when(
              loading: () => const CupertinoActivityIndicator(),
              error: (e, st) => Text(l10n.insightsTabLoadError(e.toString())),
              data: (pair) => pair == null
                  ? const SizedBox.shrink()
                  : _Table(earlier: pair.earlier, recent: pair.recent),
            ),
      ],
    );
  }

  static Widget _segment(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(text, style: const TextStyle(fontSize: 12.5)),
      );
}

class _Table extends StatelessWidget {
  const _Table({required this.earlier, required this.recent});

  final PeriodSummary earlier;
  final PeriodSummary recent;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = intlLocaleOf(context);
    final whole = NumberFormat.decimalPattern(locale)..maximumFractionDigits = 0;
    final oneDecimal = NumberFormat.decimalPattern(locale)
      ..minimumFractionDigits = 1
      ..maximumFractionDigits = 1;
    final dates = DateFormat.yMMMd(locale);
    String span(PeriodSummary p) =>
        '${dates.format(dateFromKey(p.start))} – ${dates.format(dateFromKey(p.end))}';

    final rows = <_Row>[
      _Row(l10n.insightsCompareDaysLogged, earlier.daysLogged, recent.daysLogged, whole),
      _Row(l10n.insightsCompareSteps, earlier.avgSteps, recent.avgSteps, whole),
      _Row(l10n.insightsCompareBody, earlier.avgBodyScore, recent.avgBodyScore, oneDecimal),
      _Row(l10n.insightsCompareMental, earlier.avgMentalScore, recent.avgMentalScore, oneDecimal),
      _Row(l10n.insightsCompareSleep, earlier.avgSleepHours, recent.avgSleepHours, oneDecimal),
      _Row(l10n.insightsCompareRestingHr, earlier.avgRestingHr, recent.avgRestingHr, whole),
      _Row(l10n.insightsCompareHrv, earlier.avgHrvMs, recent.avgHrvMs, whole),
      _Row(l10n.insightsCompareRestDays, earlier.restDays, recent.restDays, whole),
      _Row(l10n.insightsCompareFlareDays, earlier.flareDays, recent.flareDays, whole),
    ];

    const header = TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: ZebraColors.black);
    const small = TextStyle(fontSize: 11, color: CupertinoColors.systemGrey);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${l10n.insightsCompareEarlier}: ${span(earlier)}', style: small),
        Text('${l10n.insightsCompareRecent}: ${span(recent)}', style: small),
        const SizedBox(height: 8),
        _line(const SizedBox.shrink(), Text(l10n.insightsCompareEarlier, style: header),
            Text(l10n.insightsCompareRecent, style: header),
            Text(l10n.insightsCompareChange, style: header)),
        for (final r in rows)
          _line(
            Text(r.label, style: const TextStyle(fontSize: 12.5)),
            Text(r.format(r.earlier), style: const TextStyle(fontSize: 12.5)),
            Text(r.format(r.recent),
                style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
            Text(r.change(), style: const TextStyle(fontSize: 12.5)),
          ),
        if (earlier.daysLogged == 0) ...[
          const SizedBox(height: 6),
          Text(l10n.insightsCompareNoEarlierData, style: small),
        ],
      ],
    );
  }

  static Widget _line(Widget label, Widget a, Widget b, Widget change) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Expanded(flex: 5, child: label),
            Expanded(flex: 3, child: Align(alignment: Alignment.centerRight, child: a)),
            Expanded(flex: 3, child: Align(alignment: Alignment.centerRight, child: b)),
            Expanded(flex: 3, child: Align(alignment: Alignment.centerRight, child: change)),
          ],
        ),
      );
}

class _Row {
  _Row(this.label, this.earlier, this.recent, this._format);

  final String label;
  final num? earlier;
  final num? recent;
  final NumberFormat _format;

  String format(num? v) => v == null ? '–' : _format.format(v);

  /// Signed difference, recent minus earlier; "–" when either is missing
  /// and "0" when the rounded values match.
  String change() {
    final a = earlier;
    final b = recent;
    if (a == null || b == null) return '–';
    final diff = b - a;
    final text = _format.format(diff.abs());
    if (text == _format.format(0)) return text;
    return '${diff > 0 ? '+' : '−'}$text';
  }
}
