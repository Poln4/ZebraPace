import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/id_gen.dart';
import '../../../domain/models/training_plan.dart';
import '../../../domain/services/plan_progress_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/plan_providers.dart';
import '../../widgets/entry_actions.dart';
import '../../widgets/section_card.dart';
import 'widgets/plan_form.dart';

String _fmt(double v) => v == v.roundToDouble() ? v.toInt().toString() : v.toStringAsFixed(1);

/// Baseline tests on the Plan tab: first result → latest, and a way to add
/// a result. Highlighted in the weeks the person chose to retest.
class PlanTestsCard extends ConsumerWidget {
  const PlanTestsCard({super.key, required this.plan, required this.date});

  final TrainingPlan plan;
  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tests = ref.watch(planTestsProvider(plan.id)).valueOrNull ?? const [];
    if (tests.isEmpty) return const SizedBox.shrink();
    final results = ref.watch(planTestResultsProvider(plan.id)).valueOrNull ?? const [];
    final retest = PlanProgressService.isRetestWeek(plan, date);

    return SectionCard(
      title: l10n.planTestsTitle,
      caption: retest ? l10n.planTestsRetestWeek : l10n.planTestsCaption,
      collapsible: true,
      initiallyExpanded: retest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final t in tests)
            _TestRow(test: t, results: results.where((r) => r.testId == t.id).toList()),
        ],
      ),
    );
  }
}

class _TestRow extends ConsumerWidget {
  const _TestRow({required this.test, required this.results});

  final PlanTest test;
  final List<PlanTestResult> results;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final unit = test.unit == null ? '' : ' ${test.unit}';
    final summary = switch (results.length) {
      0 => l10n.planTestsNoResult,
      1 => l10n.planTestsFirst('${_fmt(results.first.value)}$unit', results.first.date),
      _ => l10n.planTestsChange(
        '${_fmt(results.first.value)}$unit',
        '${_fmt(results.last.value)}$unit',
        results.last.date,
      ),
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: results.isEmpty ? null : () => _history(context, ref),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    test.name,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  Text(
                    summary,
                    style: const TextStyle(fontSize: 12.5, color: CupertinoColors.systemGrey),
                  ),
                ],
              ),
            ),
          ),
          CupertinoButton(
            padding: const EdgeInsets.only(left: 8),
            minimumSize: const Size(0, 30),
            onPressed: () => _addResult(context, ref),
            child: Text(l10n.planTestsAddResult, style: const TextStyle(fontSize: 13.5)),
          ),
        ],
      ),
    );
  }

  Future<void> _addResult(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final value = TextEditingController();
    final note = TextEditingController();
    return showCupertinoModalPopup(
      context: context,
      builder: (_) => PlanSheet(
        title: test.name,
        onSave: () async {
          final v = double.tryParse(value.text.replaceAll(',', '.'));
          if (v == null) return false;
          await ref
              .read(planReviewRepositoryProvider)
              .addResult(testId: test.id, date: todayKey(), value: v, note: trimmedOrNull(note));
          return true;
        },
        children: [
          PlanField(
            label: test.unit == null
                ? l10n.planTestsValueLabel
                : '${l10n.planTestsValueLabel} (${test.unit})',
            controller: value,
            number: true,
          ),
          PlanField(label: l10n.planNoteLabel, controller: note, maxLines: 2),
          const SizedBox(height: 10),
          Text(
            l10n.planTestsStopIfUnsure,
            style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
          ),
        ],
      ),
    );
  }

  Future<void> _history(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final unit = test.unit == null ? '' : ' ${test.unit}';
    final picked = await showCupertinoModalPopup<PlanTestResult>(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: Text(test.name),
        message: Text(l10n.planTestsTapToDelete),
        actions: [
          for (final r in results.reversed)
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(ctx).pop(r),
              child: Text('${r.date} · ${_fmt(r.value)}$unit'),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(l10n.commonCancelButton),
        ),
      ),
    );
    if (picked == null || !context.mounted) return;
    if (await confirmDelete(context, l10n)) {
      await ref.read(planReviewRepositoryProvider).deleteResult(picked.id);
    }
  }
}

/// The plan editor's list of tests.
class PlanTestsEditorSection extends ConsumerWidget {
  const PlanTestsEditorSection({super.key, required this.planId});

  final String planId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tests = ref.watch(planTestsProvider(planId)).valueOrNull ?? const [];
    return SectionCard(
      title: l10n.planTestsTitle,
      caption: l10n.planTestsEditorCaption,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final t in tests)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _testSheet(context, ref, t, tests.length),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        [t.name, if (t.unit != null) t.unit].join(' · '),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const Icon(
                      CupertinoIcons.chevron_right,
                      size: 14,
                      color: CupertinoColors.systemGrey,
                    ),
                  ],
                ),
              ),
            ),
          CupertinoButton(
            padding: const EdgeInsets.only(top: 4),
            minimumSize: const Size(0, 32),
            onPressed: () => _testSheet(context, ref, null, tests.length),
            child: Text(
              '+ ${l10n.planTestsAdd}',
              style: const TextStyle(fontSize: 14, color: ZebraColors.brandTeal),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _testSheet(BuildContext context, WidgetRef ref, PlanTest? test, int count) {
    final l10n = AppLocalizations.of(context);
    final name = TextEditingController(text: test?.name ?? '');
    final unit = TextEditingController(text: test?.unit ?? '');
    final repo = ref.read(planReviewRepositoryProvider);
    return showCupertinoModalPopup(
      context: context,
      builder: (_) => PlanSheet(
        title: test?.name ?? l10n.planTestsAdd,
        onSave: () async {
          if (name.text.trim().isEmpty) return false;
          await repo.saveTest(
            PlanTest(
              id: test?.id ?? newId(),
              planId: planId,
              position: test?.position ?? count,
              name: name.text.trim(),
              unit: trimmedOrNull(unit),
            ),
          );
          return true;
        },
        onDelete: test == null ? null : () => repo.deleteTest(test.id),
        children: [
          PlanField(
            label: l10n.planTestsNameLabel,
            controller: name,
            placeholder: l10n.planTestsNameHint,
          ),
          PlanField(
            label: l10n.planTestsUnitLabel,
            controller: unit,
            placeholder: l10n.planTestsUnitHint,
          ),
        ],
      ),
    );
  }
}
