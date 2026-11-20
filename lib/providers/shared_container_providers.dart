import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/defaults.dart';
import '../core/utils/date_utils.dart';
import '../data/shared/shared_container_bridge.dart';
import '../domain/services/shared_outbox_builder.dart';
import 'app_providers.dart';

final sharedContainerBridgeProvider = Provider((ref) => SharedContainerBridge());

/// Settings → Share with ZebraUp. Off until the person turns it on.
final shareWithZebraUpProvider = StreamProvider<bool>((ref) {
  return ref
      .watch(settingsRepositoryProvider)
      .watchAll()
      .map((m) => m[SettingsKeys.shareWithZebraUp] == '1');
});

Future<void> setShareWithZebraUp(WidgetRef ref, bool on) =>
    ref.read(settingsRepositoryProvider).set(SettingsKeys.shareWithZebraUp, on ? '1' : '0');

final _windowLogsProvider = StreamProvider.autoDispose.family((ref, String today) {
  final start = dateKey(dateFromKey(today)
      .subtract(const Duration(days: SharedOutboxBuilder.windowDays - 1)));
  return ref.watch(dailyLogRepositoryProvider).watchRange(start, today);
});

final _windowActivitiesProvider = StreamProvider.autoDispose.family((ref, String today) {
  final start = dateKey(dateFromKey(today)
      .subtract(const Duration(days: SharedOutboxBuilder.windowDays - 1)));
  return ref.watch(activityRepositoryProvider).watchRange(start, today);
});

/// Keeps the outbox in the shared container current while sharing is on,
/// and empties it when it's turned off. Watched by AppShell; resuming the
/// app invalidates it so a new day moves the window.
final sharedOutboxSyncProvider = FutureProvider.autoDispose<void>((ref) async {
  if (!SharedContainerBridge.supported) return;
  final bridge = ref.read(sharedContainerBridgeProvider);
  if (!await ref.watch(shareWithZebraUpProvider.future)) {
    await bridge.clear();
    return;
  }
  final now = DateTime.now();
  final today = dateKey(now);
  final logs = await ref.watch(_windowLogsProvider(today).future);
  final activities = await ref.watch(_windowActivitiesProvider(today).future);
  // Soreness checks have no range stream; today's re-runs this when one is
  // logged, and older ones don't change.
  ref.watch(sorenessChecksForDateProvider(today));
  final start = dateKey(
      now.subtract(const Duration(days: SharedOutboxBuilder.windowDays - 1)));
  final soreness = await ref.read(sorenessCheckRepositoryProvider).getRange(start, today);

  final json = const SharedOutboxBuilder().build(
    generatedAt: now,
    logs: logs,
    activities: activities,
    possibleCrashDates: {
      for (final c in soreness)
        if (c.verdict == 'possible_crash') c.date,
    },
    hrvMetricFromHealth: defaultTargetPlatform == TargetPlatform.iOS ? 'sdnn' : 'rmssd',
  );
  await bridge.publish(json);
});
