import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/enums.dart';
import '../../../core/theme/zebra_theme.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/id_gen.dart';
import '../../../core/utils/intl_locale.dart';
import '../../../domain/models/training_plan.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/plan_providers.dart';
import '../../widgets/entry_actions.dart';
import '../../widgets/section_card.dart';
import 'tests_section.dart';
import 'widgets/plan_form.dart';

/// Weekday name for 1 = Monday … 7 = Sunday. 2024-01-01 was a Monday.
String weekdayName(BuildContext context, int weekday, {bool short = false}) {
  final day = DateTime(2024, 1, weekday);
  final locale = intlLocaleOf(context);
  return short ? DateFormat.E(locale).format(day) : DateFormat.EEEE(locale).format(day);
}

// --- Plan basics (create + edit) ---

Future<void> showPlanBasicsSheet(BuildContext context, {TrainingPlan? plan}) {
  return showCupertinoModalPopup(
    context: context,
    builder: (_) => _PlanBasicsSheet(plan: plan),
  );
}

class _PlanBasicsSheet extends ConsumerStatefulWidget {
  const _PlanBasicsSheet({this.plan});

  final TrainingPlan? plan;

  @override
  ConsumerState<_PlanBasicsSheet> createState() => _PlanBasicsSheetState();
}

class _PlanBasicsSheetState extends ConsumerState<_PlanBasicsSheet> {
  late final _name = TextEditingController(text: widget.plan?.name ?? '');
  late final _weeks = TextEditingController(text: '${widget.plan?.weeks ?? 12}');
  late final _ceiling = TextEditingController(
    text: widget.plan?.weeklyCeilingMin?.toString() ?? '',
  );
  late final _floor = TextEditingController(text: widget.plan?.floorNote ?? '');
  late final _testWeeks = TextEditingController(text: widget.plan?.testWeeks ?? '');
  late DateTime _start = widget.plan == null ? DateTime.now() : dateFromKey(widget.plan!.startDate);

  @override
  void dispose() {
    for (final c in [_name, _weeks, _ceiling, _floor, _testWeeks]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = intlLocaleOf(context);
    return PlanSheet(
      title: widget.plan == null ? l10n.planCreateTitle : l10n.planEditBasicsTitle,
      onSave: _save,
      children: [
        PlanField(label: l10n.planNameLabel, controller: _name, placeholder: l10n.planNameHint),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  l10n.planStartLabel,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _pickStart,
                child: Text(DateFormat.yMMMd(locale).format(_start)),
              ),
            ],
          ),
        ),
        PlanField(label: l10n.planWeeksLabel, controller: _weeks, number: true),
        PlanField(
          label: l10n.planCeilingLabel,
          controller: _ceiling,
          number: true,
          placeholder: l10n.planCeilingHint,
        ),
        PlanField(
          label: l10n.planFloorLabel,
          controller: _floor,
          placeholder: l10n.planFloorHint,
          maxLines: 4,
        ),
        PlanField(
          label: l10n.planTestWeeksLabel,
          controller: _testWeeks,
          placeholder: l10n.planTestWeeksHint,
        ),
        const SizedBox(height: 12),
        Text(
          l10n.planEditorDisclaimer,
          style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
        ),
      ],
    );
  }

  Future<void> _pickStart() async {
    var picked = _start;
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (ctx) => Container(
        height: 260,
        color: ZebraColors.paper,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _start,
                onDateTimeChanged: (d) => picked = d,
              ),
            ),
            CupertinoButton(
              child: Text(AppLocalizations.of(ctx).appShellDoneButton),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      ),
    );
    setState(() => _start = picked);
  }

  Future<bool> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) return false;
    final weeks = (int.tryParse(_weeks.text) ?? 12).clamp(1, 104);
    final ceiling = int.tryParse(_ceiling.text);
    final repo = ref.read(planRepositoryProvider);
    final plan = widget.plan;
    if (plan == null) {
      await repo.createPlan(
        name: name,
        startDate: dateKey(_start),
        weeks: weeks,
        weeklyCeilingMin: ceiling,
        floorNote: trimmedOrNull(_floor),
        testWeeks: trimmedOrNull(_testWeeks),
      );
    } else {
      await repo.updatePlan(
        TrainingPlan(
          id: plan.id,
          name: name,
          startDate: dateKey(_start),
          weeks: weeks,
          weeklyCeilingMin: ceiling,
          floorNote: trimmedOrNull(_floor),
          currentPhaseId: plan.currentPhaseId,
          testWeeks: trimmedOrNull(_testWeeks),
        ),
      );
    }
    return true;
  }
}

// --- Plan editor ---

class PlanEditorScreen extends ConsumerWidget {
  const PlanEditorScreen({super.key, required this.planId});

  final String planId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final plan = ref.watch(activePlanProvider).valueOrNull;
    final phases = ref.watch(planPhasesProvider(planId)).valueOrNull ?? const [];
    final sessions = ref.watch(planSessionsProvider(planId)).valueOrNull ?? const [];

    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      navigationBar: CupertinoNavigationBar(middle: Text(l10n.planEditorTitle)),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (plan != null && plan.id == planId)
              SectionCard(
                title: plan.name,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      [
                        l10n.planBasicsSummary(plan.weeks),
                        if (plan.weeklyCeilingMin != null)
                          l10n.planCeilingSummary(plan.weeklyCeilingMin!),
                      ].join(' · '),
                      style: const TextStyle(fontSize: 13),
                    ),
                    if (plan.floorNote != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          l10n.planFloorSummary(plan.floorNote!),
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    _LinkButton(
                      label: l10n.planEditBasicsTitle,
                      onTap: () => showPlanBasicsSheet(context, plan: plan),
                    ),
                  ],
                ),
              ),
            SectionCard(
              title: l10n.planPhasesTitle,
              caption: l10n.planPhasesCaption,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final p in phases)
                    _Row(
                      title: '${p.position + 1}. ${p.name}',
                      subtitle: p.goal,
                      onTap: () => _showPhaseSheet(context, ref, planId, p, phases.length),
                    ),
                  _LinkButton(
                    label: l10n.planAddPhase,
                    onTap: () => _showPhaseSheet(context, ref, planId, null, phases.length),
                  ),
                ],
              ),
            ),
            SectionCard(
              title: l10n.planSessionsTitle,
              caption: l10n.planSessionsCaption,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final s in sessions)
                    _Row(
                      title: s.name,
                      subtitle: [
                        if (s.weekday != null) weekdayName(context, s.weekday!),
                        if (s.durationMin != null) l10n.planMinutes(s.durationMin!),
                        if (s.isCardio) l10n.planCardioTag,
                      ].join(' · '),
                      onTap: () => Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (_) => SessionEditorScreen(planId: planId, sessionId: s.id),
                        ),
                      ),
                    ),
                  _LinkButton(
                    label: l10n.planAddSession,
                    onTap: () => _showSessionSheet(context, planId, null, sessions.length),
                  ),
                ],
              ),
            ),
            PlanTestsEditorSection(planId: planId),
            if (plan != null && plan.id == planId)
              CupertinoButton(
                onPressed: () async {
                  final ok = await confirmDelete(context, l10n);
                  if (!ok) return;
                  await ref.read(planRepositoryProvider).deletePlan(planId);
                  if (context.mounted) Navigator.of(context).pop();
                },
                child: Text(
                  l10n.planDeletePlan,
                  style: const TextStyle(color: CupertinoColors.destructiveRed),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showPhaseSheet(
  BuildContext context,
  WidgetRef ref,
  String planId,
  PlanPhase? phase,
  int count,
) {
  final l10n = AppLocalizations.of(context);
  final name = TextEditingController(text: phase?.name ?? '');
  final goal = TextEditingController(text: phase?.goal ?? '');
  final effort = TextEditingController(text: phase?.effort ?? '');
  final cardio = TextEditingController(text: phase?.cardio ?? '');
  final gate = TextEditingController(text: phase?.gate ?? '');
  final repo = ref.read(planRepositoryProvider);
  return showCupertinoModalPopup(
    context: context,
    builder: (_) => PlanSheet(
      title: phase == null ? l10n.planAddPhase : phase.name,
      onSave: () async {
        if (name.text.trim().isEmpty) return false;
        await repo.savePhase(
          PlanPhase(
            id: phase?.id ?? newId(),
            planId: planId,
            position: phase?.position ?? count,
            name: name.text.trim(),
            goal: trimmedOrNull(goal),
            effort: trimmedOrNull(effort),
            cardio: trimmedOrNull(cardio),
            gate: trimmedOrNull(gate),
          ),
        );
        return true;
      },
      onDelete: phase == null ? null : () => repo.deletePhase(phase),
      children: [
        PlanField(
          label: l10n.planPhaseNameLabel,
          controller: name,
          placeholder: l10n.planPhaseNameHint,
        ),
        PlanField(label: l10n.planPhaseGoalLabel, controller: goal, maxLines: 3),
        PlanField(label: l10n.planPhaseEffortLabel, controller: effort, maxLines: 3),
        PlanField(label: l10n.planPhaseCardioLabel, controller: cardio, maxLines: 3),
        PlanField(
          label: l10n.planPhaseGateLabel,
          controller: gate,
          placeholder: l10n.planPhaseGateHint,
          maxLines: 4,
        ),
      ],
    ),
  );
}

Future<void> _showSessionSheet(
  BuildContext context,
  String planId,
  PlanSession? session,
  int count,
) {
  return showCupertinoModalPopup(
    context: context,
    builder: (_) => _SessionSheet(planId: planId, session: session, count: count),
  );
}

class _SessionSheet extends ConsumerStatefulWidget {
  const _SessionSheet({required this.planId, required this.session, required this.count});

  final String planId;
  final PlanSession? session;
  final int count;

  @override
  ConsumerState<_SessionSheet> createState() => _SessionSheetState();
}

class _SessionSheetState extends ConsumerState<_SessionSheet> {
  late final _name = TextEditingController(text: widget.session?.name ?? '');
  late final _duration = TextEditingController(text: widget.session?.durationMin?.toString() ?? '');
  late final _lowDay = TextEditingController(text: widget.session?.lowDayNote ?? '');
  late int? _weekday = widget.session?.weekday;
  late bool _cardio = widget.session?.isCardio ?? false;

  @override
  void dispose() {
    for (final c in [_name, _duration, _lowDay]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PlanSheet(
      title: widget.session?.name ?? l10n.planAddSession,
      onSave: _save,
      onDelete: widget.session == null
          ? null
          : () => ref.read(planRepositoryProvider).deleteSession(widget.session!.id),
      children: [
        PlanField(
          label: l10n.planSessionNameLabel,
          controller: _name,
          placeholder: l10n.planSessionNameHint,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            l10n.planSessionDayLabel,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _DayChoice(
              label: l10n.planAnyDay,
              selected: _weekday == null,
              onTap: () => setState(() => _weekday = null),
            ),
            for (var d = 1; d <= 7; d++)
              _DayChoice(
                label: weekdayName(context, d, short: true),
                selected: _weekday == d,
                onTap: () => setState(() => _weekday = d),
              ),
          ],
        ),
        PlanField(label: l10n.planSessionDurationLabel, controller: _duration, number: true),
        PlanField(
          label: l10n.planSessionLowDayLabel,
          controller: _lowDay,
          placeholder: l10n.planSessionLowDayHint,
          maxLines: 3,
        ),
        PlanSwitchRow(
          label: l10n.planSessionCardioLabel,
          caption: l10n.planSessionCardioCaption,
          value: _cardio,
          onChanged: (v) => setState(() => _cardio = v),
        ),
      ],
    );
  }

  Future<bool> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) return false;
    final s = widget.session;
    await ref
        .read(planRepositoryProvider)
        .saveSession(
          PlanSession(
            id: s?.id ?? newId(),
            planId: widget.planId,
            position: s?.position ?? widget.count,
            name: name,
            weekday: _weekday,
            durationMin: int.tryParse(_duration.text),
            lowDayNote: trimmedOrNull(_lowDay),
            isCardio: _cardio,
          ),
        );
    return true;
  }
}

// --- Session editor: its exercises ---

class SessionEditorScreen extends ConsumerWidget {
  const SessionEditorScreen({super.key, required this.planId, required this.sessionId});

  final String planId;
  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final sessions = ref.watch(planSessionsProvider(planId)).valueOrNull ?? const [];
    final session = sessions.where((s) => s.id == sessionId).firstOrNull;
    final exercises = ref.watch(planExercisesProvider(sessionId)).valueOrNull ?? const [];
    final steps = ref.watch(_sessionStepsProvider(sessionId)).valueOrNull ?? const [];

    if (session == null) {
      // Deleted from its own sheet — nothing left to edit here.
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(),
        child: Center(child: Text(l10n.planSessionGone)),
      );
    }

    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      navigationBar: CupertinoNavigationBar(middle: Text(session.name)),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SectionCard(
              title: l10n.planSessionDetailsTitle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    [
                      session.weekday == null
                          ? l10n.planAnyDay
                          : weekdayName(context, session.weekday!),
                      if (session.durationMin != null) l10n.planMinutes(session.durationMin!),
                      if (session.isCardio) l10n.planCardioTag,
                    ].join(' · '),
                    style: const TextStyle(fontSize: 13),
                  ),
                  if (session.lowDayNote != null)
                    Text(
                      l10n.planLowDaySummary(session.lowDayNote!),
                      style: const TextStyle(fontSize: 13),
                    ),
                  _LinkButton(
                    label: l10n.commonEditButton,
                    onTap: () => _showSessionSheet(context, planId, session, sessions.length),
                  ),
                ],
              ),
            ),
            SectionCard(
              title: l10n.planExercisesTitle,
              caption: l10n.planExercisesCaption,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final e in exercises)
                    _Row(
                      title: e.name,
                      subtitle:
                          steps
                              .where((st) => st.id == e.currentStepId)
                              .map((st) => [st.name, if (st.dose != null) st.dose].join(' · '))
                              .firstOrNull ??
                          l10n.planNoStepsYet,
                      onTap: () => Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (_) =>
                              ExerciseEditorScreen(sessionId: sessionId, exerciseId: e.id),
                        ),
                      ),
                    ),
                  _LinkButton(
                    label: l10n.planAddExercise,
                    onTap: () => showExerciseSheet(context, ref, sessionId, null, exercises.length),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final _sessionStepsProvider = StreamProvider.family<List<PlanStep>, String>(
  (ref, sessionId) => ref.watch(planRepositoryProvider).watchStepsForSession(sessionId),
);

Future<void> showExerciseSheet(
  BuildContext context,
  WidgetRef ref,
  String sessionId,
  PlanExercise? exercise,
  int count,
) {
  final l10n = AppLocalizations.of(context);
  final name = TextEditingController(text: exercise?.name ?? '');
  final cue = TextEditingController(text: exercise?.cue ?? '');
  final repo = ref.read(planRepositoryProvider);
  return showCupertinoModalPopup(
    context: context,
    builder: (_) => PlanSheet(
      title: exercise?.name ?? l10n.planAddExercise,
      onSave: () async {
        if (name.text.trim().isEmpty) return false;
        await repo.saveExercise(
          PlanExercise(
            id: exercise?.id ?? newId(),
            sessionId: sessionId,
            position: exercise?.position ?? count,
            name: name.text.trim(),
            cue: trimmedOrNull(cue),
            currentStepId: exercise?.currentStepId,
            stepChangedOn: exercise?.stepChangedOn,
          ),
        );
        return true;
      },
      onDelete: exercise == null ? null : () => repo.deleteExercise(exercise.id),
      children: [
        PlanField(
          label: l10n.planExerciseNameLabel,
          controller: name,
          placeholder: l10n.planExerciseNameHint,
        ),
        PlanField(
          label: l10n.planExerciseCueLabel,
          controller: cue,
          placeholder: l10n.planExerciseCueHint,
          maxLines: 3,
        ),
      ],
    ),
  );
}

// --- Exercise editor: its ladder of steps ---

class ExerciseEditorScreen extends ConsumerWidget {
  const ExerciseEditorScreen({super.key, required this.sessionId, required this.exerciseId});

  final String sessionId;
  final String exerciseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final exercises = ref.watch(planExercisesProvider(sessionId)).valueOrNull ?? const [];
    final exercise = exercises.where((e) => e.id == exerciseId).firstOrNull;
    final steps = ref.watch(planStepsProvider(exerciseId)).valueOrNull ?? const [];
    final repo = ref.read(planRepositoryProvider);

    if (exercise == null) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(),
        child: Center(child: Text(l10n.planSessionGone)),
      );
    }

    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      navigationBar: CupertinoNavigationBar(
        middle: Text(exercise.name),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => showExerciseSheet(context, ref, sessionId, exercise, exercises.length),
          child: Text(l10n.commonEditButton),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (exercise.cue != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(exercise.cue!, style: const TextStyle(fontSize: 13)),
              ),
            SectionCard(
              title: l10n.planStepsTitle,
              caption: l10n.planStepsCaption,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final s in steps)
                    _Row(
                      leading: s.id == exercise.currentStepId
                          ? CupertinoIcons.largecircle_fill_circle
                          : CupertinoIcons.circle,
                      onLeadingTap: () => repo.setCurrentStep(exerciseId, s.id),
                      title: '${s.position + 1}. ${s.name}${s.isLocked ? ' 🔒' : ''}',
                      subtitle: [if (s.dose != null) s.dose!, s.unit.label(l10n)].join(' · '),
                      onTap: () => _showStepSheet(context, ref, exercise, s, steps.length),
                    ),
                  _LinkButton(
                    label: l10n.planAddStep,
                    onTap: () => _showStepSheet(context, ref, exercise, null, steps.length),
                  ),
                ],
              ),
            ),
            Text(
              l10n.planCurrentStepHint,
              style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showStepSheet(
  BuildContext context,
  WidgetRef ref,
  PlanExercise exercise,
  PlanStep? step,
  int count,
) {
  return showCupertinoModalPopup(
    context: context,
    builder: (_) => _StepSheet(exercise: exercise, step: step, count: count),
  );
}

class _StepSheet extends ConsumerStatefulWidget {
  const _StepSheet({required this.exercise, required this.step, required this.count});

  final PlanExercise exercise;
  final PlanStep? step;
  final int count;

  @override
  ConsumerState<_StepSheet> createState() => _StepSheetState();
}

class _StepSheetState extends ConsumerState<_StepSheet> {
  late final _name = TextEditingController(text: widget.step?.name ?? '');
  late final _dose = TextEditingController(text: widget.step?.dose ?? '');
  late SetUnit _unit = widget.step?.unit ?? SetUnit.reps;
  late bool _needsClearance = widget.step?.needsClearance ?? false;
  late bool _cleared = widget.step?.clearedOn != null;

  @override
  void dispose() {
    _name.dispose();
    _dose.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final repo = ref.read(planRepositoryProvider);
    return PlanSheet(
      title: widget.step?.name ?? l10n.planAddStep,
      onSave: _save,
      onDelete: widget.step == null ? null : () => repo.deleteStep(widget.step!.id),
      children: [
        PlanField(
          label: l10n.planStepNameLabel,
          controller: _name,
          placeholder: l10n.planStepNameHint,
        ),
        PlanField(
          label: l10n.planStepDoseLabel,
          controller: _dose,
          placeholder: l10n.planStepDoseHint,
        ),
        const SizedBox(height: 10),
        CupertinoSlidingSegmentedControl<SetUnit>(
          groupValue: _unit,
          children: {for (final u in SetUnit.values) u: Text(u.label(l10n))},
          onValueChanged: (v) => setState(() => _unit = v ?? _unit),
        ),
        PlanSwitchRow(
          label: l10n.planStepClearanceLabel,
          caption: l10n.planStepClearanceCaption,
          value: _needsClearance,
          onChanged: (v) => setState(() => _needsClearance = v),
        ),
        if (_needsClearance)
          PlanSwitchRow(
            label: l10n.planStepClearedLabel,
            value: _cleared,
            onChanged: (v) => setState(() => _cleared = v),
          ),
      ],
    );
  }

  Future<bool> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) return false;
    final repo = ref.read(planRepositoryProvider);
    final s = widget.step;
    final id = s?.id ?? newId();
    await repo.saveStep(
      PlanStep(
        id: id,
        exerciseId: widget.exercise.id,
        position: s?.position ?? widget.count,
        name: name,
        dose: trimmedOrNull(_dose),
        unit: _unit,
        needsClearance: _needsClearance,
        clearedOn: !_needsClearance || !_cleared ? null : (s?.clearedOn ?? todayKey()),
      ),
    );
    // The first step added becomes where the exercise starts.
    if (widget.exercise.currentStepId == null) {
      await repo.setCurrentStep(widget.exercise.id, id);
    }
    return true;
  }
}

// --- Small shared bits ---

class _Row extends StatelessWidget {
  const _Row({
    required this.title,
    this.subtitle,
    required this.onTap,
    this.leading,
    this.onLeadingTap,
  });

  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final IconData? leading;
  final VoidCallback? onLeadingTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          if (leading != null)
            CupertinoButton(
              padding: const EdgeInsets.only(right: 8),
              minimumSize: const Size(32, 32),
              onPressed: onLeadingTap,
              child: Icon(leading, size: 20, color: ZebraColors.brandTeal),
            ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  if (subtitle != null && subtitle!.isNotEmpty)
                    Text(
                      subtitle!,
                      style: const TextStyle(fontSize: 12.5, color: CupertinoColors.systemGrey),
                    ),
                ],
              ),
            ),
          ),
          const Icon(CupertinoIcons.chevron_right, size: 14, color: CupertinoColors.systemGrey),
        ],
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.only(top: 4),
      minimumSize: const Size(0, 32),
      onPressed: onTap,
      child: Text('+ $label', style: const TextStyle(fontSize: 14, color: ZebraColors.brandTeal)),
    );
  }
}

class _DayChoice extends StatelessWidget {
  const _DayChoice({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? ZebraColors.brandTeal : ZebraColors.paper,
          border: Border.all(color: ZebraColors.cardBorder),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: selected ? ZebraColors.onColor : ZebraColors.black,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
