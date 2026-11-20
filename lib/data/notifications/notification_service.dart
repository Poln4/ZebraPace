import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../../domain/services/reminder_planner.dart';
import '../../l10n/app_localizations.dart';

/// Scheduled local reminders (check-in, soreness, weekly). Pacing alerts
/// are posted natively instead — see pacing_alert_bridge.dart.
///
/// Never asks for permission on its own: only [requestPermission], called
/// when the person turns a reminder on in Settings.
class NotificationService {
  NotificationService([FlutterLocalNotificationsPlugin? plugin])
      : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  Future<void>? _init;

  /// Serializes reschedules so two quick changes can't interleave
  /// cancel/schedule calls.
  Future<void> _queue = Future.value();

  /// Payload of the notification the person tapped, as `tab:N` (tab index).
  final _taps = StreamController<String>.broadcast();
  Stream<String> get taps => _taps.stream;

  static bool get supported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  Future<void> ensureInitialized() => _init ??= _initialize();

  Future<void> _initialize() async {
    if (!supported) return;
    tzdata.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (_) {
      // Unknown zone name: tz.local stays UTC, so times would be off by the
      // UTC offset — better than not reminding at all, and rare.
    }
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_stat_zebrapace'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null) _taps.add(payload);
      },
    );
    final launch = await _plugin.getNotificationAppLaunchDetails();
    final payload = launch?.notificationResponse?.payload;
    if ((launch?.didNotificationLaunchApp ?? false) && payload != null) {
      // Delivered after listeners attach.
      scheduleMicrotask(() => _taps.add(payload));
    }
  }

  /// True when allowed (or already allowed).
  Future<bool> requestPermission() async {
    if (!supported) return false;
    await ensureInitialized();
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return await _plugin
              .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(alert: true, sound: true) ??
          false;
    }
    return await _plugin
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission() ??
        false;
  }

  /// Null when it can't be known (iOS before ever asking).
  Future<bool?> permissionGranted() async {
    if (!supported) return null;
    await ensureInitialized();
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final opts = await _plugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.checkPermissions();
      return opts?.isEnabled;
    }
    return _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled();
  }

  /// Replaces every pending reminder with [reminders].
  Future<void> replaceAll(List<PlannedReminder> reminders, AppLocalizations l10n) {
    return _queue = _queue.then((_) => _replaceAll(reminders, l10n)).catchError((Object e) {
      debugPrint('NotificationService.replaceAll failed: $e');
    });
  }

  /// The last plan sent, so an unrelated rebuild doesn't cancel and
  /// re-create ~30 identical notifications.
  String? _lastPlan;

  Future<void> _replaceAll(List<PlannedReminder> reminders, AppLocalizations l10n) async {
    if (!supported) return;
    await ensureInitialized();
    final plan = '${l10n.localeName}|${reminders.map((r) => '${r.id}@${r.at}').join(',')}';
    if (plan == _lastPlan) return;
    _lastPlan = null;
    final pending = await _plugin.pendingNotificationRequests();
    for (final p in pending) {
      if (ReminderPlanner.isReminderId(p.id)) await _plugin.cancel(id: p.id);
    }
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'reminders',
        l10n.notificationChannelReminders,
        icon: 'ic_stat_zebrapace',
      ),
      iOS: const DarwinNotificationDetails(threadIdentifier: 'reminders'),
    );
    for (final r in reminders) {
      final (title, body, tab) = switch (r.kind) {
        ReminderKind.checkin => (l10n.notificationCheckinTitle, l10n.notificationCheckinBody, 0),
        ReminderKind.soreness => (l10n.notificationSorenessTitle, l10n.notificationSorenessBody, 0),
        ReminderKind.weekly => (l10n.notificationWeeklyTitle, l10n.notificationWeeklyBody, 2),
      };
      await _plugin.zonedSchedule(
        id: r.id,
        scheduledDate: tz.TZDateTime(
            tz.local, r.at.year, r.at.month, r.at.day, r.at.hour, r.at.minute),
        notificationDetails: details,
        // Inexact: a reminder a few minutes late is fine, and it avoids
        // Android's exact-alarm permission.
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        title: title,
        body: body,
        payload: 'tab:$tab',
      );
    }
    // Only after everything is scheduled, so a failure retries next time.
    _lastPlan = plan;
  }
}
