import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/section_card.dart';

/// Ported from app.py's "Soreness or Crash? A quick check" — a descriptive
/// self-report heuristic (DOMS vs. PEM/crash pattern), not a diagnostic tool.
class SorenessCheckSection extends ConsumerStatefulWidget {
  const SorenessCheckSection({super.key});

  @override
  ConsumerState<SorenessCheckSection> createState() => _SorenessCheckSectionState();
}

class _SorenessCheckSectionState extends ConsumerState<SorenessCheckSection> {
  SorenessOnset _onset = SorenessOnset.oneDayAfter;
  SorenessSpread _spread = SorenessSpread.localized;
  SorenessTrend _trend = SorenessTrend.easing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = ref.watch(selectedDateProvider);
    final checksAsync = ref.watch(_sorenessForDateProvider(date));

    return SectionCard(
      title: l10n.sorenessCheckSectionTitle,
      caption: l10n.sorenessCheckSectionCaption,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RadioGroup<SorenessOnset>(
            label: l10n.sorenessCheckSectionOnsetLabel,
            options: SorenessOnset.values,
            labelOf: (o) => o.label(l10n),
            value: _onset,
            onChanged: (v) => setState(() => _onset = v),
          ),
          const SizedBox(height: 10),
          _RadioGroup<SorenessSpread>(
            label: l10n.sorenessCheckSectionSpreadLabel,
            options: SorenessSpread.values,
            labelOf: (o) => o.label(l10n),
            value: _spread,
            onChanged: (v) => setState(() => _spread = v),
          ),
          const SizedBox(height: 10),
          _RadioGroup<SorenessTrend>(
            label: l10n.sorenessCheckSectionTrendLabel,
            options: SorenessTrend.values,
            labelOf: (o) => o.label(l10n),
            value: _trend,
            onChanged: (v) => setState(() => _trend = v),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.brandTeal,
              onPressed: _submit,
              child: Text(l10n.sorenessCheckSectionCheckButton,
                  style: const TextStyle(color: ZebraColors.onColor)),
            ),
          ),
          const SizedBox(height: 10),
          checksAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (e, st) => Text('$e'),
            data: (checks) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: checks.reversed
                  .map((c) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(c.verdictLabel, style: const TextStyle(fontSize: 13)),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final date = ref.read(selectedDateProvider);
    final verdict = ref.read(sorenessCheckServiceProvider).evaluate(
          l10n: l10n,
          onset: _onset,
          spread: _spread,
          trend: _trend,
        );
    await ref.read(sorenessCheckRepositoryProvider).insert(
          date: date,
          onset: _onset,
          spread: _spread,
          trend: _trend,
          verdict: verdict.key,
          verdictLabel: verdict.label,
        );
  }
}

class _RadioGroup<T> extends StatelessWidget {
  const _RadioGroup({
    required this.label,
    required this.options,
    required this.labelOf,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final List<T> options;
  final String Function(T) labelOf;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        ...options.map((o) => GestureDetector(
              onTap: () => onChanged(o),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Icon(
                      o == value ? CupertinoIcons.circle_fill : CupertinoIcons.circle,
                      size: 18,
                      color: ZebraColors.brandTeal,
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(labelOf(o), style: const TextStyle(fontSize: 13))),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}

final _sorenessForDateProvider = StreamProvider.family((ref, String date) {
  return ref.watch(sorenessCheckRepositoryProvider).watchForDate(date);
});
