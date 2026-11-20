import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/defaults.dart';
import '../core/utils/date_utils.dart';
import '../data/notifications/notification_service.dart';
import '../data/notifications/pacing_alert_bridge.dart';
import '../domain/models/daily_log.dart';
import '../domain/models/reminder_settings.dart';
import '../domain/services/readiness_service.dart';
import '../domain/services/reminder_planner.dart';
import '../l10n/app_localizations.dart';
import 'app_providers.dart';
import 'locale_providers.dart';
import 'plan_providers.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) => NotificationService());

final pacingAlertBridgeProvider = Provider<PacingAlertBridge>((ref) => PacingAlertBridge());

final reminderSettingsProvider = StreamProvider<ReminderSettings>((ref) {
  return ref
      .watch(settingsRepositoryProvider)
      .watchAll()
      .map((m) => ReminderSettings.fromJson(m[SettingsKeys.reminderSettings]));
});

Future<void> saveReminderSettings(WidgetRef ref, ReminderSettings settings) {
  return ref.read(settingsRepositoryProvider).set(SettingsKeys.reminderSettings, settings.toJson());
}

/// The language the app is showing, for text written while no
/// BuildContext is around (notifications are composed ahead of time).
AppLocalizations reminderLocalizations(Locale? chosen) {
  final resolved = basicLocaleListResolution(
    [chosen ?? PlatformDispatcher.instance.locale],
    AppLocalizations.supportedLocales,
  );
  return lookupAppLocalizations(resolved);
}

// --- What the planner reacts to. Keyed by today's date so a resume on a
// new day (which invalidates reminderSyncProvider) reads fresh ranges. ---

final _upcomingLogsProvider = StreamProvider.autoDispose.family((ref, String today) {
  final end = dateKey(dateFromKey(today).add(const Duration(days: ReminderPlanner.horizonDays)));
  return ref.watch(dailyLogRepositoryProvider).watchRange(today, end);
});

final _todayCheckinsProvider = StreamProvider.autoDispose.family((ref, String today) {
  return ref.watch(checkinRepositoryProvider).watchForDate(today);
});

final _recentActivitiesProvider = StreamProvider.autoDispose.family((ref, String today) {
  final start = dateKey(dateFromKey(today).subtract(const Duration(days: 2)));
  return ref.watch(activityRepositoryProvider).watchRange(start, today);
});

final _todayCalisthenicsProvider = StreamProvider.autoDispose.family((ref, String today) {
  return ref.watch(calisthenicsRepositoryProvider).watchForDate(today);
});

/// Re-plans every scheduled reminder and refreshes the pacing-alert
/// snapshot whenever settings, today's log, check-ins, soreness checks,
/// logged movement or the plan change. Watched by AppShell; resuming the
/// app invalidates it so a new day is picked up.
final reminderSyncProvider = FutureProvider.autoDispose<void>((ref) async {
  if (!NotificationService.supported) return;
  final settings = await ref.watch(reminderSettingsProvider.future);
  final l10n = reminderLocalizations(ref.watch(localeProvider));
  final notifications = ref.read(notificationServiceProvider);
  final bridge = ref.read(pacingAlertBridgeProvider);
  final now = DateTime.now();
  final today = dateKey(now);

  await notifications.ensureInitialized();

  // Pacing first: it doesn't depend on the planner's inputs.
  await bridge.configure(await _pacingSnapshot(ref, settings, today), l10n);

  if (!settings.anyScheduled) {
    await notifications.replaceAll(const [], l10n);
    return;
  }

  final logs = await ref.watch(_upcomingLogsProvider(today).future);
  final checkins = await ref.watch(_todayCheckinsProvider(today).future);
  final soreness = await ref.watch(sorenessChecksForDateProvider(today).future);
  final activities = await ref.watch(_recentActivitiesProvider(today).future);
  ref.watch(_todayCalisthenicsProvider(today));
  final plan = await ref.watch(activePlanProvider.future);

  final start = dateKey(now.subtract(const Duration(days: 2)));
  final movementDates = <String>{
    for (final a in activities) a.date,
    for (final c in await ref.read(calisthenicsRepositoryProvider).getRange(start, today)) c.date,
  };
  var weekStarts = <String>{};
  if (plan != null) {
    final logsForPlan = await ref.watch(planRecentLogsProvider(plan.id).future);
    movementDates.addAll(
        logsForPlan.where((l) => l.date.compareTo(start) >= 0).map((l) => l.date));
    weekStarts = (await ref.read(planReviewRepositoryProvider).watchCheckins(plan.id).first)
        .map((c) => c.weekStart)
        .toSet();
  }

  final planned = const ReminderPlanner().plan(
    now: now,
    settings: settings,
    facts: ReminderFacts(
      lowEnergyDates: {for (final l in logs) if (l.isLowEnergyDay) l.date},
      todayCheckinTimes: checkins.map((c) => c.loggedAt).toList(),
      movementDates: movementDates,
      sorenessCheckedToday: soreness.isNotEmpty,
      planActive: plan != null,
      planCheckinWeekStarts: weekStarts,
    ),
  );
  await notifications.replaceAll(planned, l10n);
});

Future<PacingAlertSnapshot> _pacingSnapshot(
    Ref ref, ReminderSettings settings, String today) async {
  if (!settings.pacingEnabled) return const PacingAlertSnapshot.disabled();
  if (!await ref.watch(healthKitEnabledProvider.future)) {
    return const PacingAlertSnapshot.disabled();
  }
  final snapshotSettings = await ref.watch(settingsSnapshotProvider.future);
  final pacing = ref.read(pacingServiceProvider);
  final base = await pacing.evaluateForDate(
    today,
    growthGoalPct: snapshotSettings.growthGoalPct,
    cautionPct: snapshotSettings.cautionPct,
  );
  ReadinessResult readiness;
  try {
    readiness = await ref.watch(readinessProvider(today).future);
  } catch (_) {
    readiness = ReadinessResult.unknown;
  }
  final todays = pacing.applyReadiness(base, readiness, cautionPct: snapshotSettings.cautionPct);
  // Read-only: no log row is created just for this.
  final logs = await ref.read(dailyLogRepositoryProvider).getRange(today, today);
  final DailyLog? log = logs.isEmpty ? null : logs.first;
  return PacingAlertSnapshot(
    enabled: true,
    date: today,
    goalSteps: todays.goalSteps,
    cautionSteps: todays.cautionSteps,
    baseGoalSteps: base.goalSteps,
    baseCautionSteps: base.cautionSteps,
    skipToday: (log?.isLowEnergyDay ?? false) ||
        log?.stepsSource == ValueSource.manual ||
        !base.hasBaseline,
  );
}
