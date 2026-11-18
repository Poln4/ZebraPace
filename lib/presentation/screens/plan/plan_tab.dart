import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../core/utils/date_utils.dart';
import '../../../domain/models/daily_log.dart';
import '../../../domain/models/training_plan.dart';
import '../../../domain/services/plan_progress_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_providers.dart';
import '../../../providers/plan_providers.dart';
import '../../widgets/entry_actions.dart';
import '../../widgets/section_card.dart';
import '../movement/widgets/stop_signals_card.dart';
import 'checkin_sheet.dart';
import 'fear_ladder_screen.dart';
import 'phrases_screen.dart';
import 'plan_editor_screen.dart';
import 'session_log_screen.dart';
import 'tests_section.dart';
import 'widgets/day_stripe.dart';

/// The Plan tab: the person's own training plan (made in the editor) and
/// what they did with it today. Movement stays the log of everything.
class PlanTab extends ConsumerWidget {
  const PlanTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planAsync = ref.watch(activePlanProvider);
    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      child: SafeArea(
        child: planAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (e, _) => Center(child: Text('$e')),
          data: (plan) => plan == null ? const _NoPlan() : _PlanView(plan: plan),
        ),
      ),
    );
  }
}

class _NoPlan extends StatelessWidget {
  const _NoPlan();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _PhraseCard(),
        SectionCard(
          title: l10n.planEmptyTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.planEmptyBody, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: () => showPlanBasicsSheet(context),
                  child: Text(l10n.planCreateTitle),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.planEditorDisclaimer,
                style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
              ),
            ],
          ),
        ),
        const _FearCard(),
        const StopSignalsCard(),
      ],
    );
  }
}

class _PlanView extends ConsumerWidget {
  const _PlanView({required this.plan});

  final TrainingPlan plan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final date = ref.watch(selectedDateProvider);
    final week = PlanProgressService.weekNumber(plan, date);
    final phases = ref.watch(planPhasesProvider(plan.id)).valueOrNull ?? const [];
    final phase =
        phases.where((p) => p.id == plan.currentPhaseId).firstOrNull ?? phases.firstOrNull;
    final sessions = ref.watch(planSessionsProvider(plan.id)).valueOrNull ?? const [];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  [
                    if (phase != null) phase.name,
                    week == 0 ? l10n.planStartsLater : l10n.planWeekOf(week, plan.weeks),
                  ].join(' · '),
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 32),
                onPressed: () => Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (_) => PlanEditorScreen(planId: plan.id))),
                child: Text(l10n.planEditButton),
              ),
            ],
          ),
        ),
        const _PhraseCard(),
        _MorningCheckCard(plan: plan),
        if (sessions.isEmpty)
          SectionCard(
            title: l10n.planNoSessionsTitle,
            child: Text(l10n.planNoSessionsBody, style: const TextStyle(fontSize: 14)),
          )
        else
          _TodayCard(plan: plan, sessions: sessions, date: date),
        _CheckinCard(plan: plan, date: date),
        _WeekCard(plan: plan, sessions: sessions, date: date),
        if (phase != null) _PhaseCard(plan: plan, phase: phase, phases: phases, date: date),
        _StepUpCard(plan: plan, sessions: sessions),
        PlanTestsCard(plan: plan, date: date),
        const _FearCard(),
        const StopSignalsCard(),
      ],
    );
  }
}

// --- Phrases ---

/// All phrases: the person's own first, then the built-in ones.
List<String> allPhrases(AppLocalizations l10n, List<String> own) => [
  ...own,
  l10n.planPhrase1,
  l10n.planPhrase2,
  l10n.planPhrase3,
  l10n.planPhrase4,
  l10n.planPhrase5,
  l10n.planPhrase6,
  l10n.planPhrase7,
  l10n.planPhrase8,
];

class _PhraseCard extends ConsumerWidget {
  const _PhraseCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final own = ref.watch(ownPlanPhrasesProvider).valueOrNull ?? const [];
    final phrase = PlanProgressService.phraseFor(allPhrases(l10n, own), todayKey());
    if (phrase == null) return const SizedBox.shrink();
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const PhrasesScreen())),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ZebraColors.brandTeal.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Semantics(
          hint: l10n.planPhrasesEditHint,
          child: Text(
            '“$phrase”',
            style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, height: 1.35),
          ),
        ),
      ),
    );
  }
}

// --- Next-morning check ---

class _MorningCheckCard extends ConsumerWidget {
  const _MorningCheckCard({required this.plan});

  final TrainingPlan plan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final logs = ref.watch(planRecentLogsProvider(plan.id)).valueOrNull ?? const [];
    final pending = PlanProgressService.pendingMorningCheck(logs, todayKey());
    if (pending == null) return const SizedBox.shrink();
    final sessions = ref.watch(planSessionsProvider(plan.id)).valueOrNull ?? const [];
    final name =
        sessions.where((s) => s.id == pending.sessionId).firstOrNull?.name ??
        pending.mode.label(l10n);

    return SectionCard(
      title: l10n.planMorningTitle,
      caption: l10n.planMorningCaption(name),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final answer in NextMorning.values)
            CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: const Size(0, 36),
              color: answer == NextMorning.settled ? ZebraColors.teal : ZebraColors.sand,
              onPressed: () => ref.read(planRepositoryProvider).setNextMorning(pending.id, answer),
              child: Text(
                answer.label(l10n),
                style: const TextStyle(fontSize: 13, color: ZebraColors.onColor),
              ),
            ),
        ],
      ),
    );
  }
}

// --- Today ---

class _TodayCard extends ConsumerWidget {
  const _TodayCard({required this.plan, required this.sessions, required this.date});

  final TrainingPlan plan;
  final List<PlanSession> sessions;
  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final planned = PlanProgressService.sessionsFor(sessions, date);
    final weekLogs =
        ref.watch(planWeekLogsProvider((planId: plan.id, date: date))).valueOrNull ?? const [];
    final dayLogs = weekLogs.where((l) => l.date == date).toList();
    final dayLog = ref.watch(dailyLogProvider).valueOrNull;
    final recentFlare = ref.watch(_recentFlareProvider(date)).valueOrNull ?? false;
    final own = ref.watch(ownPlanPhrasesProvider).valueOrNull ?? const [];
    final resting = dayLog?.isRestDay == true || dayLog?.isFlareDay == true;
    final done = dayLogs.isNotEmpty || resting;

    return SectionCard(
      title: planned.isEmpty ? l10n.planTodayNoSession : planned.map((s) => s.name).join(' · '),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (recentFlare) _Banner(text: l10n.planFlareNote, color: ZebraColors.sand),
          if (done)
            _Banner(
              text: PlanProgressService.phraseFor(allPhrases(l10n, own), date, offset: 1) ?? '',
              color: ZebraColors.teal,
            ),
          for (final log in dayLogs)
            GestureDetector(
              onTap: () => _onLoggedTap(context, ref, log),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '✓ ${[sessions.where((s) => s.id == log.sessionId).firstOrNull?.name, log.mode.label(l10n), if (log.durationMin != null) l10n.planMinutes(log.durationMin!)].whereType<String>().join(' · ')}',
                  style: const TextStyle(fontSize: 13.5, decoration: TextDecoration.underline),
                ),
              ),
            ),
          if (resting)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                '✓ ${dayLog!.isFlareDay ? l10n.planFlareLogged : l10n.planRestLogged}',
                style: const TextStyle(fontSize: 13.5),
              ),
            ),
          for (final s in planned) ...[
            if (planned.length > 1)
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 4),
                child: Text(s.name, style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
            _ModeButtons(plan: plan, session: s, date: date),
          ],
          if (planned.isEmpty) _ModeButtons(plan: plan, session: null, date: date),
          if (_others(planned, dayLogs).isNotEmpty)
            CupertinoButton(
              padding: const EdgeInsets.only(top: 6),
              minimumSize: const Size(0, 30),
              onPressed: () => _pickOtherSession(context, _others(planned, dayLogs)),
              child: Text(l10n.planOtherSession, style: const TextStyle(fontSize: 14)),
            ),
          const SizedBox(height: 6),
          Text(
            l10n.planRestHint,
            style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
          ),
          if (plan.floorNote != null) ...[
            const SizedBox(height: 6),
            Text(l10n.planFloorSummary(plan.floorNote!), style: const TextStyle(fontSize: 12.5)),
          ],
        ],
      ),
    );
  }

  /// A full or low-day session can be reopened and edited; a floor day has
  /// nothing to edit, so it only offers delete.
  Future<void> _onLoggedTap(BuildContext context, WidgetRef ref, PlanSessionLog log) async {
    final l10n = AppLocalizations.of(context);
    final session = sessions.where((s) => s.id == log.sessionId).firstOrNull;
    if (session == null || log.mode == PlanSessionMode.floor) {
      final ok = await confirmDelete(context, l10n);
      if (ok) await ref.read(planRepositoryProvider).deleteSessionLog(log);
      return;
    }
    final action = await showEntryActionSheet(context, l10n);
    if (action == null || !context.mounted) return;
    switch (action) {
      case EntryAction.edit:
        await openSessionLog(context, plan.id, session, log.mode, log.date, existing: log);
      case EntryAction.delete:
        final ok = await confirmDelete(context, l10n);
        if (ok) await ref.read(planRepositoryProvider).deleteSessionLog(log);
    }
  }

  /// Sessions not planned for today and not already done today — never
  /// doubling up.
  List<PlanSession> _others(List<PlanSession> planned, List<PlanSessionLog> dayLogs) => sessions
      .where((s) => !planned.contains(s) && !dayLogs.any((l) => l.sessionId == s.id))
      .toList();

  Future<void> _pickOtherSession(BuildContext context, List<PlanSession> others) async {
    final l10n = AppLocalizations.of(context);
    final picked = await showCupertinoModalPopup<PlanSession>(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: Text(l10n.planOtherSession),
        message: Text(l10n.planNoDoubleUp),
        actions: [
          for (final s in others)
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(ctx).pop(s),
              child: Text(s.name),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(l10n.commonCancelButton),
        ),
      ),
    );
    if (picked == null || !context.mounted) return;
    await openSessionLog(context, plan.id, picked, PlanSessionMode.full, date);
  }
}

Future<void> openSessionLog(
  BuildContext context,
  String planId,
  PlanSession session,
  PlanSessionMode mode,
  String date, {
  PlanSessionLog? existing,
}) {
  return Navigator.of(context).push(
    CupertinoPageRoute(
      builder: (_) => SessionLogScreen(
        planId: planId,
        session: session,
        mode: mode,
        date: date,
        existing: existing,
      ),
    ),
  );
}

class _ModeButtons extends ConsumerWidget {
  const _ModeButtons({required this.plan, required this.session, required this.date});

  final TrainingPlan plan;
  final PlanSession? session;
  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final s = session;
    return Row(
      children: [
        if (s != null) ...[
          Expanded(
            child: _ModeButton(
              label: PlanSessionMode.full.label(l10n),
              color: ZebraColors.brandTeal,
              onTap: () => openSessionLog(context, plan.id, s, PlanSessionMode.full, date),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _ModeButton(
              label: PlanSessionMode.lowDay.label(l10n),
              color: ZebraColors.teal,
              onTap: () => openSessionLog(context, plan.id, s, PlanSessionMode.lowDay, date),
            ),
          ),
          const SizedBox(width: 6),
        ],
        Expanded(
          child: _ModeButton(
            label: PlanSessionMode.floor.label(l10n),
            color: ZebraColors.sand,
            onTap: () => ref
                .read(planRepositoryProvider)
                .logSession(planId: plan.id, date: date, mode: PlanSessionMode.floor, session: s),
          ),
        ),
      ],
    );
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({required this.label, required this.color, required this.onTap});

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      color: color,
      onPressed: onTap,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 13, color: ZebraColors.onColor),
      ),
    );
  }
}

/// A flare day today or in the two days before — floor mode for about
/// three days, then the last comfortable level, never a restart from zero.
final _recentFlareProvider = StreamProvider.family<bool, String>((ref, date) {
  final start = dateKey(dateFromKey(date).subtract(const Duration(days: 2)));
  return ref
      .watch(dailyLogRepositoryProvider)
      .watchRange(start, date)
      .map((logs) => logs.any((l) => l.isFlareDay));
});

// --- This week ---

final _weekDailyLogsProvider = StreamProvider.family<List<DailyLog>, String>((ref, date) {
  return ref
      .watch(dailyLogRepositoryProvider)
      .watchRange(PlanProgressService.weekStart(date), PlanProgressService.weekEnd(date));
});

class _WeekCard extends ConsumerWidget {
  const _WeekCard({required this.plan, required this.sessions, required this.date});

  final TrainingPlan plan;
  final List<PlanSession> sessions;
  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final logs =
        ref.watch(planWeekLogsProvider((planId: plan.id, date: date))).valueOrNull ?? const [];
    final dailyLogs = ref.watch(_weekDailyLogsProvider(date)).valueOrNull ?? const [];
    final activityMinutes = ref.watch(weekActivityMinutesProvider(date)).valueOrNull ?? const [];
    final used = PlanProgressService.ceilingUsed(weekLogs: logs, activityMinutes: activityMinutes);
    final ceiling = plan.weeklyCeilingMin;
    final monday = dateFromKey(PlanProgressService.weekStart(date));
    final planned = sessions.where((s) => s.weekday != null).length;
    final trained = logs.where((l) => l.mode.isTraining).length;

    return SectionCard(
      title: l10n.planWeekTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              for (var i = 0; i < 7; i++)
                Expanded(
                  child: _DayCell(
                    weekday: i + 1,
                    dayKey: dateKey(monday.add(Duration(days: i))),
                    selected: dateKey(monday.add(Duration(days: i))) == date,
                    logs: logs,
                    dailyLogs: dailyLogs,
                    hasSession: sessions.any((s) => s.weekday == i + 1),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              for (final kind in DayStripeKind.values)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DayStripe(kind: kind, width: 24, height: 12),
                    const SizedBox(width: 4),
                    Text(
                      _stripeLabel(l10n, kind),
                      style: const TextStyle(fontSize: 11.5, color: CupertinoColors.systemGrey),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 10),
          if (planned > 0)
            Text(l10n.planWeekSessions(trained, planned), style: const TextStyle(fontSize: 13)),
          if (ceiling != null && ceiling > 0) ...[
            const SizedBox(height: 8),
            Text(l10n.planCeilingUsed(used, ceiling), style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                height: 8,
                child: Stack(
                  children: [
                    Container(color: ZebraColors.cardBorder),
                    FractionallySizedBox(
                      widthFactor: (used / ceiling).clamp(0.0, 1.0),
                      child: Container(
                        color: used > ceiling ? ZebraColors.sand : ZebraColors.brandTeal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (used >= ceiling)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(l10n.planCeilingReached, style: const TextStyle(fontSize: 12.5)),
              ),
          ],
        ],
      ),
    );
  }
}

String _stripeLabel(AppLocalizations l10n, DayStripeKind kind) => switch (kind) {
  DayStripeKind.full => l10n.planModeFull,
  DayStripeKind.lowDay => l10n.planModeLowDay,
  DayStripeKind.floor => l10n.planModeFloor,
  DayStripeKind.rest => l10n.planRestLogged,
};

/// One day of the week. Same shapes as the stripes idea: solid = full
/// session, dashed = low day, wave = floor, double line = rest or flare.
/// Equal weight, so a rest day never looks lesser.
class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.weekday,
    required this.dayKey,
    required this.selected,
    required this.logs,
    required this.dailyLogs,
    required this.hasSession,
  });

  final int weekday;
  final String dayKey;
  final bool selected;
  final List<PlanSessionLog> logs;
  final List<DailyLog> dailyLogs;
  final bool hasSession;

  @override
  Widget build(BuildContext context) {
    final day = logs.where((l) => l.date == dayKey).map((l) => l.mode).toSet();
    final daily = dailyLogs.where((l) => l.date == dayKey).firstOrNull;
    final kind = day.contains(PlanSessionMode.full)
        ? DayStripeKind.full
        : day.contains(PlanSessionMode.lowDay)
        ? DayStripeKind.lowDay
        : day.contains(PlanSessionMode.floor)
        ? DayStripeKind.floor
        : (daily?.isRestDay == true || daily?.isFlareDay == true)
        ? DayStripeKind.rest
        : null;
    final l10n = AppLocalizations.of(context);
    return Semantics(
      label: [weekdayName(context, weekday), if (kind != null) _stripeLabel(l10n, kind)].join(', '),
      excludeSemantics: true,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: selected ? ZebraColors.brandTeal : ZebraColors.cardBorder),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              weekdayName(context, weekday, short: true),
              style: TextStyle(
                fontSize: 11,
                fontWeight: hasSession ? FontWeight.w700 : FontWeight.w400,
                color: hasSession ? ZebraColors.black : CupertinoColors.systemGrey,
              ),
            ),
            SizedBox(
              height: 22,
              child: Center(child: kind == null ? null : DayStripe(kind: kind)),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Phase ---

class _PhaseCard extends ConsumerWidget {
  const _PhaseCard({
    required this.plan,
    required this.phase,
    required this.phases,
    required this.date,
  });

  final TrainingPlan plan;
  final PlanPhase phase;
  final List<PlanPhase> phases;
  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final index = phases.indexOf(phase);
    final next = index + 1 < phases.length ? phases[index + 1] : null;
    String? line(String label, String? value) => value == null ? null : '$label: $value';
    final lines = [
      line(l10n.planPhaseGoalLabel, phase.goal),
      line(l10n.planPhaseEffortLabel, phase.effort),
      line(l10n.planPhaseCardioLabel, phase.cardio),
    ].whereType<String>();

    return SectionCard(
      title: l10n.planPhaseCardTitle(phase.name),
      collapsible: true,
      initiallyExpanded: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final l in lines)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(l, style: const TextStyle(fontSize: 13)),
            ),
          if (phase.gate != null)
            _Banner(text: l10n.planGateSummary(phase.gate!), color: ZebraColors.brandTeal),
          _GateFactsView(planId: plan.id, date: date),
          Text(
            l10n.planRepeatIsSuccess,
            style: const TextStyle(fontSize: 12.5, color: CupertinoColors.systemGrey),
          ),
          Row(
            children: [
              if (index > 0)
                CupertinoButton(
                  padding: const EdgeInsets.only(top: 6, right: 16),
                  minimumSize: const Size(0, 30),
                  onPressed: () => ref
                      .read(planRepositoryProvider)
                      .setCurrentPhase(plan.id, phases[index - 1].id),
                  child: Text(l10n.planPhaseBack, style: const TextStyle(fontSize: 14)),
                ),
              if (next != null)
                CupertinoButton(
                  padding: const EdgeInsets.only(top: 6),
                  minimumSize: const Size(0, 30),
                  onPressed: () => _confirmNext(context, ref, next),
                  child: Text(l10n.planPhaseNext(next.name), style: const TextStyle(fontSize: 14)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _confirmNext(BuildContext context, WidgetRef ref, PlanPhase next) async {
    final l10n = AppLocalizations.of(context);
    final ok = await showCupertinoDialog<bool>(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(l10n.planPhaseNext(next.name)),
        content: Text(
          phase.gate == null ? l10n.planPhaseNextConfirm : l10n.planGateSummary(phase.gate!),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.planNotYet),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.planGatePassed),
          ),
        ],
      ),
    );
    if (ok == true) await ref.read(planRepositoryProvider).setCurrentPhase(plan.id, next.id);
  }
}

/// What the logs say about the usual gate over the last 14 days. Facts
/// only — whether the gate is passed stays the person's call.
class _GateFactsView extends ConsumerWidget {
  const _GateFactsView({required this.planId, required this.date});

  final String planId;
  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final facts = ref.watch(gateFactsProvider((planId: planId, date: date))).valueOrNull;
    if (facts == null) return const SizedBox.shrink();
    Widget line(bool ok, String text) => Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        '${ok ? '✓' : '·'} $text',
        style: TextStyle(
          fontSize: 13,
          color: ok ? ZebraColors.success : CupertinoColors.systemGrey,
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.planGateFactsTitle,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          line(
            facts.sessionsMet,
            l10n.planGateFactsSessions(facts.comfortableEarlierWeek, facts.comfortableLatestWeek),
          ),
          line(facts.noPemOrFlare, l10n.planGateFactsNoPem),
          line(facts.painSettling, l10n.planGateFactsPain),
        ],
      ),
    );
  }
}

// --- Sunday check-in ---

/// Shown on Sundays for the current week, and on Monday/Tuesday for the
/// week before if it wasn't done. Once saved, shows what was decided.
class _CheckinCard extends ConsumerWidget {
  const _CheckinCard({required this.plan, required this.date});

  final TrainingPlan plan;
  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final weekday = dateFromKey(date).weekday;
    final String weekStart;
    if (weekday == DateTime.sunday) {
      weekStart = PlanProgressService.weekStart(date);
    } else if (weekday <= DateTime.tuesday) {
      weekStart = PlanProgressService.weekStart(
        dateKey(dateFromKey(date).subtract(const Duration(days: 7))),
      );
    } else {
      return const SizedBox.shrink();
    }
    // Nothing to review yet on the day the plan starts.
    if (weekStart.compareTo(PlanProgressService.weekStart(plan.startDate)) < 0 ||
        plan.startDate.compareTo(date) >= 0) {
      return const SizedBox.shrink();
    }
    final checkins = ref.watch(planCheckinsProvider(plan.id)).valueOrNull;
    if (checkins == null) return const SizedBox.shrink();
    final done = checkins.where((c) => c.weekStart == weekStart).firstOrNull;
    // Monday/Tuesday: only a reminder if last week's is still missing.
    if (done != null && weekday != DateTime.sunday) return const SizedBox.shrink();

    return SectionCard(
      title: l10n.planCheckinTitle,
      caption: done == null ? l10n.planCheckinCaption : null,
      child: done == null
          ? SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                color: ZebraColors.brandTeal,
                onPressed: () => showCheckinSheet(context, plan, weekStart),
                child: Text(
                  l10n.planCheckinStart,
                  style: const TextStyle(color: ZebraColors.onColor),
                ),
              ),
            )
          : GestureDetector(
              onTap: () => showCheckinSheet(context, plan, weekStart),
              child: Text(
                [
                  '✓ ${done.decision.label(l10n)}',
                  if (done.ceilingAfter != null) l10n.planCeilingSummary(done.ceilingAfter!),
                  if (done.win != null) l10n.planCheckinWinSummary(done.win!),
                ].join(' · '),
                style: const TextStyle(fontSize: 13.5),
              ),
            ),
    );
  }
}

// --- Fear ladder ---

class _FearCard extends ConsumerWidget {
  const _FearCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final items = ref.watch(fearItemsProvider).valueOrNull ?? const [];
    final evidence = (ref.watch(exposureLogsProvider).valueOrNull ?? const [])
        .where((l) => l.nothingBad)
        .length;
    final next = PlanProgressService.fearToTry(items);
    return SectionCard(
      title: l10n.planFearTitle,
      collapsible: true,
      initiallyExpanded: false,
      collapsedSummary: evidence == 0 ? null : l10n.planFearEvidenceShort(evidence),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            items.isEmpty
                ? l10n.planFearEmpty
                : next == null
                ? l10n.planFearAllSettled
                : l10n.planFearThisWeek(next.name),
            style: const TextStyle(fontSize: 13.5),
          ),
          if (evidence > 0)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                l10n.planFearEvidenceShort(evidence),
                style: const TextStyle(fontSize: 13, color: ZebraColors.success),
              ),
            ),
          CupertinoButton(
            padding: const EdgeInsets.only(top: 6),
            minimumSize: const Size(0, 30),
            onPressed: () =>
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (_) => const FearLadderScreen())),
            child: Text(l10n.planFearOpen, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}

// --- Ready for the next step ---

class _StepUpCard extends ConsumerWidget {
  const _StepUpCard({required this.plan, required this.sessions});

  final TrainingPlan plan;
  final List<PlanSession> sessions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final rows = <Widget>[
      for (final s in sessions)
        for (final e
            in ref.watch(planExercisesProvider(s.id)).valueOrNull ?? const <PlanExercise>[])
          _StepUpRow(plan: plan, exercise: e),
    ];
    if (rows.isEmpty) return const SizedBox.shrink();
    return SectionCard(
      title: l10n.planStepUpTitle,
      caption: l10n.planStepUpCaption,
      collapsible: true,
      initiallyExpanded: false,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows),
    );
  }
}

class _StepUpRow extends ConsumerWidget {
  const _StepUpRow({required this.plan, required this.exercise});

  final TrainingPlan plan;
  final PlanExercise exercise;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final steps = ref.watch(planStepsProvider(exercise.id)).valueOrNull ?? const [];
    if (steps.isEmpty) return const SizedBox.shrink();
    final current = steps.where((s) => s.id == exercise.currentStepId).firstOrNull ?? steps.first;
    final index = steps.indexOf(current);
    final next = index + 1 < steps.length ? steps[index + 1] : null;
    final previous = index > 0 ? steps[index - 1] : null;
    final readiness =
        ref.watch(stepReadinessProvider((planId: plan.id, exerciseId: exercise.id))).valueOrNull ??
        StepReadiness.notYet;
    final repo = ref.read(planRepositoryProvider);

    final status = switch (readiness) {
      StepReadiness.notYet => l10n.planReadinessNotYet,
      StepReadiness.ready => l10n.planReadinessReady(next?.name ?? ''),
      StepReadiness.waitForWeek => l10n.planReadinessWaitWeek,
      StepReadiness.waitForRecovery => l10n.planReadinessWaitRecovery,
      StepReadiness.needsClearance => l10n.planReadinessNeedsClearance(next?.name ?? ''),
      StepReadiness.topOfLadder => l10n.planReadinessTop,
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${exercise.name} · ${current.name}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 12.5,
              color: readiness == StepReadiness.ready
                  ? ZebraColors.success
                  : CupertinoColors.systemGrey,
            ),
          ),
          Wrap(
            spacing: 14,
            children: [
              if (readiness == StepReadiness.ready && next != null)
                _SmallLink(
                  label: l10n.planMoveUp,
                  onTap: () => repo.setCurrentStep(exercise.id, next.id, changedOn: todayKey()),
                ),
              if (readiness == StepReadiness.needsClearance && next != null)
                _SmallLink(
                  label: l10n.planMarkCleared,
                  onTap: () => repo.setStepCleared(next.id, todayKey()),
                ),
              if (previous != null)
                _SmallLink(
                  label: l10n.planStepBack,
                  onTap: () => repo.setCurrentStep(exercise.id, previous.id, changedOn: todayKey()),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmallLink extends StatelessWidget {
  const _SmallLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.only(top: 4),
      minimumSize: const Size(0, 28),
      onPressed: onTap,
      child: Text(label, style: const TextStyle(fontSize: 13.5)),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }
}
