import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../core/utils/intl_locale.dart';
import '../../../../domain/services/long_term_pem_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/plus_providers.dart';
import '../../../widgets/plus_gate.dart';
import '../../../widgets/section_card.dart';
import 'insights_providers.dart';

/// Zebras+: the delayed-dip pattern across the whole history — which
/// delay dips usually follow, and whether they're shrinking month by
/// month. Free users see what it is and a way in. Today's warnings and
/// the 1–3 day check below stay free.
class LongTermPatternSection extends ConsumerWidget {
  const LongTermPatternSection({super.key});

  /// Months shown in the month-by-month bars (most recent).
  static const maxMonths = 12;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isPlus = ref.watch(isPlusProvider);
    return SectionCard(
      title: l10n.insightsLongTermTitle,
      caption: l10n.insightsLongTermCaption,
      child: isPlus ? const _Content() : const _Locked(),
    );
  }
}

class _Locked extends ConsumerWidget {
  const _Locked();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 2, right: 6),
              child: Icon(CupertinoIcons.lock_fill, size: 14, color: ZebraColors.brandTealText),
            ),
            Expanded(child: Text(l10n.insightsLongTermLocked)),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            color: ZebraColors.brandTeal,
            onPressed: () => openPlusGate(context, ref, message: l10n.plusLockedPatternMessage),
            child: Text(l10n.plusSeePlans, style: const TextStyle(color: ZebraColors.onColor)),
          ),
        ),
      ],
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return ref.watch(longTermPemProvider).when(
          loading: () => const CupertinoActivityIndicator(),
          error: (e, st) => Text(l10n.insightsTabLoadError(e.toString())),
          data: (pattern) {
            if (pattern == null) return const SizedBox.shrink();
            if (!pattern.hasEnoughHistory) {
              return Text(l10n.insightsLongTermNotEnough(pattern.daysCovered));
            }
            return _Pattern(pattern: pattern);
          },
        );
  }
}

class _Pattern extends StatelessWidget {
  const _Pattern({required this.pattern});

  final LongTermPemPattern pattern;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final usualLag = pattern.usualLagDays;
    final usualDip = pattern.usualDip;
    final monthFormat = DateFormat.MMM(intlLocaleOf(context));
    final months = pattern.months.length > LongTermPatternSection.maxMonths
        ? pattern.months.sublist(pattern.months.length - LongTermPatternSection.maxMonths)
        : pattern.months;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          usualLag != null && usualDip != null
              ? l10n.insightsLongTermUsual(
                  l10n.insightsTabPemLagDays(usualLag), usualDip.toStringAsFixed(1))
              : l10n.insightsLongTermNoClear,
          style: const TextStyle(fontWeight: FontWeight.w600, color: ZebraColors.black),
        ),
        const SizedBox(height: 12),
        _Label(l10n.insightsLongTermDelayTitle),
        _DipBars(bars: [
          for (final l in pattern.lags)
            _Bar(
              label: l10n.insightsTabPemLagDays(l.lagDays),
              value: l.dip,
              highlight: l.lagDays == usualLag,
            ),
        ]),
        if (usualLag != null && months.isNotEmpty) ...[
          const SizedBox(height: 14),
          _Label(l10n.insightsLongTermMonthsTitle(l10n.insightsTabPemLagDays(usualLag))),
          _DipBars(bars: [
            for (final m in months)
              _Bar(
                label: monthFormat.format(DateTime.parse('${m.month}-01')),
                value: m.dip,
                highlight: false,
              ),
          ]),
          if (pattern.trend != null) ...[
            const SizedBox(height: 8),
            Text(switch (pattern.trend!) {
              DipTrend.smaller => l10n.insightsLongTermTrendSmaller,
              DipTrend.bigger => l10n.insightsLongTermTrendBigger,
              DipTrend.similar => l10n.insightsLongTermTrendSimilar,
            }),
          ],
        ],
        const SizedBox(height: 10),
        Text(l10n.insightsLongTermFootnote,
            style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      );
}

class _Bar {
  const _Bar({required this.label, required this.value, required this.highlight});

  final String label;
  final double? value;
  final bool highlight;
}

/// Simple labelled bars: height = dip in points (no dip or a negative
/// one sits flat), value printed on top, "–" when there wasn't enough data.
class _DipBars extends StatelessWidget {
  const _DipBars({required this.bars});

  static const _maxHeight = 56.0;

  final List<_Bar> bars;

  @override
  Widget build(BuildContext context) {
    final peak = bars
        .map((b) => b.value ?? 0)
        .fold<double>(LongTermPemService.clearDip, (a, b) => b > a ? b : a);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final b in bars)
          Expanded(
            child: Semantics(
              label: '${b.label}: ${b.value?.toStringAsFixed(1) ?? '–'}',
              excludeSemantics: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(b.value?.toStringAsFixed(1) ?? '–', style: const TextStyle(fontSize: 11)),
                    const SizedBox(height: 2),
                    Container(
                      height: 2 + _maxHeight * ((b.value ?? 0).clamp(0, peak) / peak),
                      decoration: BoxDecoration(
                        color: b.highlight ? ZebraColors.brandTeal : ZebraColors.sand,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(b.label, style: const TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
