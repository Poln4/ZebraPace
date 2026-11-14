import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/defaults.dart';
import '../core/utils/date_utils.dart';
import '../data/repositories/plan_repository.dart';
import '../data/repositories/plan_review_repository.dart';
import '../domain/models/training_plan.dart';
import '../domain/services/plan_progress_service.dart';
import 'app_providers.dart';

final planRepositoryProvider = Provider<PlanRepository>(
  (ref) => PlanRepository(ref.watch(appDatabaseProvider)),
);

final activePlanProvider = StreamProvider<TrainingPlan?>(
  (ref) => ref.watch(planRepositoryProvider).watchActivePlan(),
);

final planPhasesProvider = StreamProvider.family<List<PlanPhase>, String>(
  (ref, planId) => ref.watch(planRepositoryProvider).watchPhases(planId),
);

final planSessionsProvider = StreamProvider.family<List<PlanSession>, String>(
  (ref, planId) => ref.watch(planRepositoryProvider).watchSessions(planId),
);

final planExercisesProvider = StreamProvider.family<List<PlanExercise>, String>(
  (ref, sessionId) => ref.watch(planRepositoryProvider).watchExercises(sessionId),
);

final planStepsProvider = StreamProvider.family<List<PlanStep>, String>(
  (ref, exerciseId) => ref.watch(planRepositoryProvider).watchSteps(exerciseId),
);

/// Session logs of the plan in the week (Mon–Sun) containing the date.
final planWeekLogsProvider =
    StreamProvider.family<List<PlanSessionLog>, ({String planId, String date})>((ref, key) {
  return ref.watch(planRepositoryProvider).watchSessionLogs(
        key.planId,
        PlanProgressService.weekStart(key.date),
        PlanProgressService.weekEnd(key.date),
      );
});

/// The last 30 days of plan logs up to today — feeds the morning check and
/// the readiness checks, and refreshes them whenever something is logged.
final planRecentLogsProvider =
    StreamProvider.family<List<PlanSessionLog>, String>((ref, planId) {
  final today = todayKey();
  final start = dateKey(dateFromKey(today).subtract(const Duration(days: 30)));
  return ref.watch(planRepositoryProvider).watchSessionLogs(planId, start, today);
});

/// Activity minutes in the week containing the date (everything counts
/// toward the ceiling, not only plan sessions).
final weekActivityMinutesProvider = StreamProvider.family<List<int>, String>((ref, date) {
  return ref
      .watch(activityRepositoryProvider)
      .watchRange(PlanProgressService.weekStart(date), PlanProgressService.weekEnd(date))
      .map((list) => list.map((a) => a.durationMin).toList());
});

/// The person's own motivational phrases, newest first. Built-in ones are
/// added by the UI from the translations.
final ownPlanPhrasesProvider = StreamProvider<List<String>>((ref) {
  return ref.watch(settingsRepositoryProvider).watchAll().map((all) {
    final raw = all[SettingsKeys.planPhrases];
    if (raw == null || raw.isEmpty) return const <String>[];
    try {
      return (jsonDecode(raw) as List).cast<String>();
    } catch (_) {
      return const <String>[];
    }
  });
});

Future<void> saveOwnPlanPhrases(WidgetRef ref, List<String> phrases) =>
    ref.read(settingsRepositoryProvider).set(SettingsKeys.planPhrases, jsonEncode(phrases));

/// Advice for one exercise: can it move to its next step?
final stepReadinessProvider =
    FutureProvider.autoDispose.family<StepReadiness, ({String planId, String exerciseId})>(
        (ref, key) async {
  final repo = ref.watch(planRepositoryProvider);
  // Recompute whenever logs or the ladder change.
  final recentLogs = await ref.watch(planRecentLogsProvider(key.planId).future);
  final steps = await ref.watch(planStepsProvider(key.exerciseId).future);
  final exercises = await repo.getExercisesForPlan(key.planId);
  final exercise = exercises.where((e) => e.id == key.exerciseId).firstOrNull;
  if (exercise == null || steps.isEmpty) return StepReadiness.notYet;

  final current = steps.where((s) => s.id == exercise.currentStepId).firstOrNull ?? steps.first;
  final index = steps.indexOf(current);
  final next = index + 1 < steps.length ? steps[index + 1] : null;

  final today = todayKey();
  final windowStart = dateKey(
      dateFromKey(today).subtract(const Duration(days: PlanProgressService.recoveryWindowDays)));
  final dailyLogs = await ref.watch(dailyLogRepositoryProvider).getRange(windowStart, today);
  // PEM is answered the morning after, so look one day further back.
  final pemStart = dateKey(dateFromKey(windowStart).subtract(const Duration(days: 1)));
  final redFlag = dailyLogs.any((l) => l.isFlareDay) ||
      recentLogs.any((l) => l.nextMorning == NextMorning.pem && l.date.compareTo(pemStart) >= 0);

  final changes = exercises.map((e) => e.stepChangedOn).whereType<String>().toList()..sort();

  return PlanProgressService.readiness(
    recent: await repo.recentAtStep(exercise.id, current.id),
    nextStep: next,
    today: today,
    lastChangeInPlan: changes.lastOrNull,
    recentRedFlag: redFlag,
  );
});

// --- Review: check-ins, tests, fear list ---

final planReviewRepositoryProvider = Provider<PlanReviewRepository>(
  (ref) => PlanReviewRepository(ref.watch(appDatabaseProvider)),
);

final planCheckinsProvider = StreamProvider.family<List<PlanCheckin>, String>(
  (ref, planId) => ref.watch(planReviewRepositoryProvider).watchCheckins(planId),
);

final planTestsProvider = StreamProvider.family<List<PlanTest>, String>(
  (ref, planId) => ref.watch(planReviewRepositoryProvider).watchTests(planId),
);

final planTestResultsProvider = StreamProvider.family<List<PlanTestResult>, String>(
  (ref, planId) => ref.watch(planReviewRepositoryProvider).watchResults(planId),
);

final fearItemsProvider = StreamProvider<List<FearItem>>(
  (ref) => ref.watch(planReviewRepositoryProvider).watchFearItems(),
);

final exposureLogsProvider = StreamProvider<List<ExposureLog>>(
  (ref) => ref.watch(planReviewRepositoryProvider).watchExposures(),
);

/// Gate facts over the 14 days ending on the date.
final gateFactsProvider =
    FutureProvider.autoDispose.family<GateFacts, ({String planId, String date})>((ref, key) async {
  final start = dateKey(dateFromKey(key.date).subtract(const Duration(days: 13)));
  final repo = ref.watch(planRepositoryProvider);
  // Recompute whenever the plan's logs change.
  ref.watch(planRecentLogsProvider(key.planId));
  final logs = await repo.getSessionLogs(key.planId, start, key.date);
  final sets = await repo.getSetLogsFor(logs.map((l) => l.id));
  final daily = await ref.watch(dailyLogRepositoryProvider).getRange(start, key.date);
  return PlanProgressService.gateFacts(today: key.date, logs: logs, sets: sets, dailyLogs: daily);
});
