import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/enums.dart';
import '../../../core/theme/zebra_theme.dart';
import '../../../core/utils/date_utils.dart';
import '../../../domain/models/training_plan.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/plan_providers.dart';
import '../../widgets/section_card.dart';
import '../movement/widgets/set_values_editor.dart';
import 'widgets/plan_form.dart';

/// Logging a full or low-day session: each exercise at its current step,
/// with its sets and the highest pain felt. Exercises left blank aren't
/// saved — skipping one is fine.
class SessionLogScreen extends ConsumerStatefulWidget {
  const SessionLogScreen({
    super.key,
    required this.planId,
    required this.session,
    required this.mode,
    required this.date,
  });

  final String planId;
  final PlanSession session;
  final PlanSessionMode mode;
  final String date;

  @override
  ConsumerState<SessionLogScreen> createState() => _SessionLogScreenState();
}

class _Draft {
  List<int> values = const [];
  SetUnit? unit;
  int? pain;
  bool sharp = false;

  bool get isEmpty => values.isEmpty && pain == null && !sharp;
}

class _SessionLogScreenState extends ConsumerState<SessionLogScreen> {
  late final _duration = TextEditingController(text: widget.session.durationMin?.toString() ?? '');
  final _note = TextEditingController();
  final _drafts = <String, _Draft>{};
  bool _saving = false;

  @override
  void dispose() {
    _duration.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final exercises = ref.watch(planExercisesProvider(widget.session.id)).valueOrNull ?? const [];
    final steps = ref.watch(_stepsProvider(widget.session.id)).valueOrNull ?? const [];
    final lowDay = widget.mode == PlanSessionMode.lowDay;

    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      navigationBar: CupertinoNavigationBar(
        middle: Text('${widget.session.name} · ${widget.mode.label(l10n)}'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _saving ? null : () => _save(steps),
          child: Text(l10n.commonSaveButton),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (lowDay)
              _Note(
                text: widget.session.lowDayNote == null
                    ? l10n.planLowDayDefault
                    : l10n.planLowDaySummary(widget.session.lowDayNote!),
              ),
            _Note(text: l10n.planSessionTempoNote),
            for (final e in exercises) _exerciseCard(context, l10n, e, steps),
            SectionCard(
              title: l10n.planSessionWrapUpTitle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PlanField(
                    label: l10n.planSessionDurationLabel,
                    controller: _duration,
                    number: true,
                  ),
                  if (widget.session.isCardio)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        l10n.planCardioSavesActivity,
                        style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
                      ),
                    ),
                  PlanField(label: l10n.planNoteLabel, controller: _note, maxLines: 3),
                ],
              ),
            ),
            CupertinoButton.filled(
              onPressed: _saving ? null : () => _save(steps),
              child: Text(l10n.planSaveSession),
            ),
          ],
        ),
      ),
    );
  }

  Widget _exerciseCard(
    BuildContext context,
    AppLocalizations l10n,
    PlanExercise e,
    List<PlanStep> steps,
  ) {
    final step =
        steps.where((s) => s.id == e.currentStepId).firstOrNull ??
        steps.where((s) => s.exerciseId == e.id).firstOrNull;
    final draft = _drafts.putIfAbsent(e.id, _Draft.new);
    return SectionCard(
      title: e.name,
      caption: step == null
          ? l10n.planNoStepsYet
          : [step.name, if (step.dose != null) step.dose].join(' · '),
      child: step == null
          ? const SizedBox.shrink()
          : step.isLocked
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.planStepLockedNote, style: const TextStyle(fontSize: 13)),
                CupertinoButton(
                  padding: const EdgeInsets.only(top: 6),
                  minimumSize: const Size(0, 30),
                  onPressed: () =>
                      ref.read(planRepositoryProvider).setStepCleared(step.id, todayKey()),
                  child: Text(l10n.planMarkCleared, style: const TextStyle(fontSize: 14)),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (e.cue != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(e.cue!, style: const TextStyle(fontSize: 12.5)),
                  ),
                SetValuesEditor(
                  initialValues: const [null],
                  unit: draft.unit ?? step.unit,
                  onUnitChanged: (u) => setState(() => draft.unit = u),
                  onChanged: (v) => draft.values = v,
                ),
                const SizedBox(height: 10),
                PainPicker(
                  pain: draft.pain,
                  sharp: draft.sharp,
                  onPainChanged: (p) => setState(() => draft.pain = p),
                  onSharpChanged: (v) => setState(() => draft.sharp = v),
                ),
              ],
            ),
    );
  }

  Future<void> _save(List<PlanStep> steps) async {
    setState(() => _saving = true);
    final exercises = ref.read(planExercisesProvider(widget.session.id)).valueOrNull ?? const [];
    final entries = <PlanSetEntry>[];
    for (final e in exercises) {
      final draft = _drafts[e.id];
      if (draft == null || draft.isEmpty) continue;
      final step =
          steps.where((s) => s.id == e.currentStepId).firstOrNull ??
          steps.where((s) => s.exerciseId == e.id).firstOrNull;
      if (step == null || step.isLocked) continue;
      entries.add(
        PlanSetEntry(
          exerciseId: e.id,
          stepId: step.id,
          setValues: draft.values,
          unit: draft.unit ?? step.unit,
          pain: draft.pain,
          sharp: draft.sharp,
        ),
      );
    }
    await ref
        .read(planRepositoryProvider)
        .logSession(
          planId: widget.planId,
          date: widget.date,
          mode: widget.mode,
          session: widget.session,
          durationMin: int.tryParse(_duration.text),
          note: trimmedOrNull(_note),
          entries: entries,
        );
    if (mounted) Navigator.of(context).pop(true);
  }
}

final _stepsProvider = StreamProvider.family<List<PlanStep>, String>(
  (ref, sessionId) => ref.watch(planRepositoryProvider).watchStepsForSession(sessionId),
);

class _Note extends StatelessWidget {
  const _Note({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ZebraColors.teal.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }
}
