import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../core/utils/id_gen.dart';
import '../../../domain/models/training_plan.dart';
import '../../../domain/services/plan_progress_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_providers.dart';
import '../../../providers/plan_providers.dart';
import 'widgets/plan_form.dart';

/// The Sunday check-in for the week starting [weekStart]. Counts come from
/// the logs; the person adds a win, a fear-list step and the decision,
/// which sets next week's ceiling.
Future<void> showCheckinSheet(BuildContext context, TrainingPlan plan, String weekStart) {
  return showCupertinoModalPopup(
    context: context,
    builder: (_) => _CheckinSheet(plan: plan, weekStart: weekStart),
  );
}

class _CheckinSheet extends ConsumerStatefulWidget {
  const _CheckinSheet({required this.plan, required this.weekStart});

  final TrainingPlan plan;
  final String weekStart;

  @override
  ConsumerState<_CheckinSheet> createState() => _CheckinSheetState();
}

class _CheckinSheetState extends ConsumerState<_CheckinSheet> {
  final _pemCause = TextEditingController();
  final _win = TextEditingController();
  final _fearStep = TextEditingController();
  WeekSummary? _summary;
  CheckinDecision? _decision;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    for (final c in [_pemCause, _win, _fearStep]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    final end = PlanProgressService.weekEnd(widget.weekStart);
    final sessions = await ref.read(planSessionsProvider(widget.plan.id).future);
    final logs = await ref
        .read(planRepositoryProvider)
        .getSessionLogs(widget.plan.id, widget.weekStart, end);
    final daily = await ref.read(dailyLogRepositoryProvider).getRange(widget.weekStart, end);
    final settings = await ref.read(settingsSnapshotProvider.future);
    final exposures = await ref.read(exposureLogsProvider.future);
    final items = await ref.read(fearItemsProvider.future);
    final weekTries = exposures
        .where((e) => e.date.compareTo(widget.weekStart) >= 0 && e.date.compareTo(end) <= 0)
        .map((e) => e.attempt ?? items.where((i) => i.id == e.fearItemId).firstOrNull?.name)
        .whereType<String>()
        .toSet();
    if (!mounted) return;
    setState(() {
      _summary = PlanProgressService.weekSummary(
        weekStart: widget.weekStart,
        sessions: sessions,
        logs: logs,
        dailyLogs: daily,
        proteinGoalG: settings.proteinGoalG,
      );
      if (_fearStep.text.isEmpty) _fearStep.text = weekTries.join(', ');
      // PEM means the ceiling doesn't go up this week.
      _decision ??= _summary!.hadPem ? CheckinDecision.keep : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final s = _summary;
    final ceiling = widget.plan.weeklyCeilingMin;
    const body = TextStyle(fontSize: 13.5);

    return PlanSheet(
      title: l10n.planCheckinTitle,
      onSave: _save,
      children: [
        if (s == null)
          const Padding(padding: EdgeInsets.all(24), child: CupertinoActivityIndicator())
        else ...[
          const SizedBox(height: 6),
          Text('1. ${l10n.planWeekSessions(s.sessionsDone, s.sessionsPlanned)}', style: body),
          const SizedBox(height: 6),
          Text('2. ${s.hadPem ? l10n.planCheckinPemYes : l10n.planCheckinPemNo}', style: body),
          if (s.hadPem)
            PlanField(
              label: l10n.planCheckinPemCauseLabel,
              controller: _pemCause,
              placeholder: l10n.planCheckinPemCauseHint,
              maxLines: 2,
            ),
          const SizedBox(height: 6),
          Text(
            '3. ${switch (s.jointsOk) {
              null => l10n.planCheckinJointsUnknown,
              true => l10n.planCheckinJointsOk,
              false => l10n.planCheckinJointsHigher,
            }}',
            style: body,
          ),
          const SizedBox(height: 6),
          Text(
            '4. ${s.weightKg == null ? l10n.planCheckinNoWeight : l10n.planCheckinWeight(s.weightKg!.toStringAsFixed(1))}',
            style: body,
          ),
          const SizedBox(height: 6),
          Text('5. ${l10n.planCheckinProtein(s.proteinDays)}', style: body),
          PlanField(
            label: '6. ${l10n.planCheckinWinLabel}',
            controller: _win,
            placeholder: l10n.planCheckinWinHint,
            maxLines: 2,
          ),
          PlanField(
            label: l10n.planCheckinFearLabel,
            controller: _fearStep,
            placeholder: l10n.planCheckinFearHint,
            maxLines: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 6),
            child: Text(
              '7. ${l10n.planCheckinDecisionLabel}',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          for (final d in CheckinDecision.values)
            _DecisionRow(
              label: d.label(l10n),
              detail: ceiling == null
                  ? null
                  : l10n.planCheckinCeilingTo(PlanProgressService.ceilingFor(ceiling, d)!),
              selected: _decision == d,
              enabled: !(d == CheckinDecision.raise && s.hadPem),
              onTap: () => setState(() => _decision = d),
            ),
          if (s.hadPem)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                l10n.planCheckinNoRaiseAfterPem,
                style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
              ),
            ),
        ],
      ],
    );
  }

  Future<bool> _save() async {
    final s = _summary;
    final decision = _decision;
    if (s == null || decision == null) return false;
    final before = widget.plan.weeklyCeilingMin;
    await ref
        .read(planReviewRepositoryProvider)
        .saveCheckin(
          PlanCheckin(
            id: newId(),
            planId: widget.plan.id,
            weekStart: widget.weekStart,
            sessionsDone: s.sessionsDone,
            sessionsPlanned: s.sessionsPlanned,
            hadPem: s.hadPem,
            pemCause: trimmedOrNull(_pemCause),
            jointsOk: s.jointsOk,
            proteinDays: s.proteinDays,
            weightKg: s.weightKg,
            win: trimmedOrNull(_win),
            fearStep: trimmedOrNull(_fearStep),
            decision: decision,
            ceilingBefore: before,
            ceilingAfter: PlanProgressService.ceilingFor(before, decision),
          ),
        );
    return true;
  }
}

class _DecisionRow extends StatelessWidget {
  const _DecisionRow({
    required this.label,
    required this.detail,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final String? detail;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1 : 0.4,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: selected ? ZebraColors.brandTeal.withValues(alpha: 0.18) : ZebraColors.paper,
            border: Border.all(color: selected ? ZebraColors.brandTeal : ZebraColors.cardBorder),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                selected ? CupertinoIcons.largecircle_fill_circle : CupertinoIcons.circle,
                size: 18,
                color: ZebraColors.brandTeal,
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
              if (detail != null)
                Text(
                  detail!,
                  style: const TextStyle(fontSize: 12.5, color: CupertinoColors.systemGrey),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
