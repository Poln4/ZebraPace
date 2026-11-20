import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../l10n/app_localizations.dart';

/// Today's envelope, handed to the native step watchers
/// (ios/Runner/AppDelegate.swift → PacingAlertMonitor, android
/// PacingAlerts.kt). They compare Apple Health / Health Connect's step
/// total against it while ZebraPace is closed and post at most one goal
/// and one caution alert a day. All envelope rules stay here in Dart.
class PacingAlertSnapshot {
  const PacingAlertSnapshot({
    required this.enabled,
    required this.date,
    this.goalSteps = 0,
    this.cautionSteps = 0,
    this.baseGoalSteps = 0,
    this.baseCautionSteps = 0,
    this.skipToday = true,
  });

  const PacingAlertSnapshot.disabled() : this(enabled: false, date: '');

  final bool enabled;
  final String date;

  /// For [date], readiness already applied.
  final int goalSteps;
  final int cautionSteps;

  /// The plain baseline envelope, used for a day or two after [date] if the
  /// app isn't opened (readiness and Rest/Flare are day-specific).
  final int baseGoalSteps;
  final int baseCautionSteps;

  /// Rest/Flare day, steps typed in by hand, or no baseline yet.
  final bool skipToday;

  String toJson(AppLocalizations l10n) => jsonEncode({
        'enabled': enabled,
        'date': date,
        'goalSteps': goalSteps,
        'cautionSteps': cautionSteps,
        'baseGoalSteps': baseGoalSteps,
        'baseCautionSteps': baseCautionSteps,
        'skipToday': skipToday,
        'goalTitle': l10n.notificationPacingGoalTitle,
        'goalBody': l10n.notificationPacingGoalBody,
        'cautionTitle': l10n.notificationPacingCautionTitle,
        'cautionBody': l10n.notificationPacingCautionBody,
        'channelName': l10n.notificationChannelPacing,
      });

  @override
  bool operator ==(Object other) =>
      other is PacingAlertSnapshot &&
      other.enabled == enabled &&
      other.date == date &&
      other.goalSteps == goalSteps &&
      other.cautionSteps == cautionSteps &&
      other.baseGoalSteps == baseGoalSteps &&
      other.baseCautionSteps == baseCautionSteps &&
      other.skipToday == skipToday;

  @override
  int get hashCode => Object.hash(
      enabled, date, goalSteps, cautionSteps, baseGoalSteps, baseCautionSteps, skipToday);
}

class PacingAlertBridge {
  static const _channel = MethodChannel('zebrapace/pacing_alerts');

  String? _lastSent;

  Future<void> configure(PacingAlertSnapshot snapshot, AppLocalizations l10n) async {
    if (kIsWeb) return;
    final json = snapshot.toJson(l10n);
    if (json == _lastSent) return;
    try {
      await _channel.invokeMethod<void>('configure', {'snapshot': json});
      _lastSent = json;
    } on MissingPluginException {
      // Tests / platforms without the native side.
    } on PlatformException catch (e) {
      debugPrint('PacingAlertBridge.configure failed: $e');
    }
  }
}
