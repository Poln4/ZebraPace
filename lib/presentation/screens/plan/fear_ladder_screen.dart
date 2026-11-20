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
import '../../../core/constants/sources.dart';
import '../sources/sources_screen.dart';

/// Graded exposure: the movements the person avoids, least feared first.
/// Each week, one small, safe try of an item at about 3–4/10 — predict,
/// do, note what happened. Every "nothing bad happened" is kept as
/// evidence.
class FearLadderScreen extends ConsumerWidget {
  const FearLadderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final items = ref.watch(fearItemsProvider).valueOrNull ?? const [];
    final logs = ref.watch(exposureLogsProvider).valueOrNull ?? const [];
    final next = PlanProgressService.fearToTry(items);
    final evidence = logs.where((l) => l.nothingBad).toList();
    final open = items.where((i) => i.settledOn == null).toList();
    final settled = items.where((i) => i.settledOn != null).toList();

    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      navigationBar: CupertinoNavigationBar(
        middle: Text(l10n.planFearTitle),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _showItemSheet(context, ref, null),
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(l10n.planFearIntro, style: const TextStyle(fontSize: 13.5)),
            const SourcesLink([SourceTopic.fearExposure]),
            const SizedBox(height: 12),
            if (next != null)
              SectionCard(
                title: l10n.planFearThisWeek(next.name),
                caption: l10n.planFearThisWeekCaption,
                child: CupertinoButton.filled(
                  onPressed: () => showExposureSheet(context, ref, next),
                  child: Text(l10n.planFearLogTry),
                ),
              ),
            SectionCard(
              title: l10n.planFearListTitle,
              caption: items.isEmpty ? l10n.planFearEmpty : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final i in open) _ItemRow(item: i, logs: logs),
                  if (settled.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      l10n.planFearSettledTitle,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    for (final i in settled) _ItemRow(item: i, logs: logs),
                  ],
                  CupertinoButton(
                    padding: const EdgeInsets.only(top: 4),
                    minimumSize: const Size(0, 32),
                    onPressed: () => _showItemSheet(context, ref, null),
                    child: Text('+ ${l10n.planFearAdd}', style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
            SectionCard(
              title: l10n.planFearEvidenceTitle(evidence.length),
              caption: l10n.planFearEvidenceCaption,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final e in evidence)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        '✓ ${e.date} · ${e.attempt ?? items.where((i) => i.id == e.fearItemId).firstOrNull?.name ?? ''}'
                        '${e.outcome == null ? '' : ' — ${e.outcome}'}',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                ],
              ),
            ),
            Text(
              l10n.planFearSpikeNote,
              style: const TextStyle(fontSize: 12.5, color: CupertinoColors.systemGrey),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemRow extends ConsumerWidget {
  const _ItemRow({required this.item, required this.logs});

  final FearItem item;
  final List<ExposureLog> logs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tries = logs.where((l) => l.fearItemId == item.id).length;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _itemActions(context, ref),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ZebraColors.sand.withValues(alpha: 0.25 + item.fear * 0.06),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('${item.fear}', style: const TextStyle(fontWeight: FontWeight.w700)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: const TextStyle(fontSize: 14)),
                  Text(
                    l10n.planFearItemMeta(item.initialFear, tries),
                    style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _itemActions(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final repo = ref.read(planReviewRepositoryProvider);
    final action = await showCupertinoModalPopup<String>(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: Text(item.name),
        actions: [
          if (item.settledOn == null)
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(ctx).pop('try'),
              child: Text(l10n.planFearLogTry),
            ),
          if (item.settledOn == null && item.fear <= 2)
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(ctx).pop('settle'),
              child: Text(l10n.planFearMarkSettled),
            ),
          if (item.settledOn != null)
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(ctx).pop('reopen'),
              child: Text(l10n.planFearReopen),
            ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.of(ctx).pop('edit'),
            child: Text(l10n.commonEditButton),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(l10n.commonCancelButton),
        ),
      ),
    );
    if (!context.mounted) return;
    switch (action) {
      case 'try':
        await showExposureSheet(context, ref, item);
      case 'settle':
        await repo.updateFearItem(_copy(item, settledOn: todayKey()));
      case 'reopen':
        await repo.updateFearItem(_copy(item, settledOn: null));
      case 'edit':
        await _showItemSheet(context, ref, item);
    }
  }
}

FearItem _copy(FearItem i, {String? name, int? fear, required String? settledOn}) => FearItem(
  id: i.id,
  name: name ?? i.name,
  fear: fear ?? i.fear,
  initialFear: i.initialFear,
  settledOn: settledOn,
);

Future<void> _showItemSheet(BuildContext context, WidgetRef ref, FearItem? item) {
  return showCupertinoModalPopup(
    context: context,
    builder: (_) => _FearItemSheet(item: item),
  );
}

class _FearItemSheet extends ConsumerStatefulWidget {
  const _FearItemSheet({required this.item});

  final FearItem? item;

  @override
  ConsumerState<_FearItemSheet> createState() => _FearItemSheetState();
}

class _FearItemSheetState extends ConsumerState<_FearItemSheet> {
  late final _name = TextEditingController(text: widget.item?.name ?? '');
  late int? _fear = widget.item?.fear;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final repo = ref.read(planReviewRepositoryProvider);
    return PlanSheet(
      title: widget.item?.name ?? l10n.planFearAdd,
      onSave: () async {
        final name = _name.text.trim();
        if (name.isEmpty || _fear == null) return false;
        final item = widget.item;
        if (item == null) {
          await repo.addFearItem(name, _fear!);
        } else {
          await repo.updateFearItem(
            _copy(item, name: name, fear: _fear, settledOn: item.settledOn),
          );
        }
        return true;
      },
      onDelete: widget.item == null
          ? null
          : () async {
              final ok = await confirmDelete(context, l10n);
              if (ok) await repo.deleteFearItem(widget.item!.id);
            },
      children: [
        PlanField(
          label: l10n.planFearItemLabel,
          controller: _name,
          placeholder: l10n.planFearItemHint,
        ),
        ScalePicker(
          label: l10n.planFearRatingLabel,
          value: _fear,
          onChanged: (v) => setState(() => _fear = v),
        ),
      ],
    );
  }
}

Future<void> showExposureSheet(BuildContext context, WidgetRef ref, FearItem item) {
  return showCupertinoModalPopup(
    context: context,
    builder: (_) => _ExposureSheet(item: item),
  );
}

class _ExposureSheet extends ConsumerStatefulWidget {
  const _ExposureSheet({required this.item});

  final FearItem item;

  @override
  ConsumerState<_ExposureSheet> createState() => _ExposureSheetState();
}

class _ExposureSheetState extends ConsumerState<_ExposureSheet> {
  final _attempt = TextEditingController();
  final _prediction = TextEditingController();
  final _outcome = TextEditingController();
  late int? _before = widget.item.fear;
  int? _after;
  bool _nothingBad = false;

  @override
  void dispose() {
    for (final c in [_attempt, _prediction, _outcome]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PlanSheet(
      title: widget.item.name,
      onSave: () async {
        await ref
            .read(planReviewRepositoryProvider)
            .addExposure(
              ExposureLog(
                id: newId(),
                fearItemId: widget.item.id,
                date: todayKey(),
                attempt: trimmedOrNull(_attempt),
                prediction: trimmedOrNull(_prediction),
                outcome: trimmedOrNull(_outcome),
                fearBefore: _before,
                fearAfter: _after,
                nothingBad: _nothingBad,
              ),
            );
        return true;
      },
      children: [
        PlanField(
          label: l10n.planFearAttemptLabel,
          controller: _attempt,
          placeholder: l10n.planFearAttemptHint,
          maxLines: 2,
        ),
        PlanField(
          label: l10n.planFearPredictionLabel,
          controller: _prediction,
          placeholder: l10n.planFearPredictionHint,
          maxLines: 2,
        ),
        ScalePicker(
          label: l10n.planFearBeforeLabel,
          value: _before,
          onChanged: (v) => setState(() => _before = v),
        ),
        PlanField(
          label: l10n.planFearOutcomeLabel,
          controller: _outcome,
          placeholder: l10n.planFearOutcomeHint,
          maxLines: 3,
        ),
        ScalePicker(
          label: l10n.planFearAfterLabel,
          value: _after,
          onChanged: (v) => setState(() => _after = v),
        ),
        PlanSwitchRow(
          label: l10n.planFearNothingBad,
          value: _nothingBad,
          onChanged: (v) => setState(() => _nothingBad = v),
        ),
      ],
    );
  }
}
