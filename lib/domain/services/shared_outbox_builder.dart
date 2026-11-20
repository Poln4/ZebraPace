import 'dart:convert';

import '../models/activity.dart';
import '../models/daily_log.dart';

/// What ZebraPace publishes for ZebraUp to read (the "outbox"), carried by
/// the shared container: the App Group `group.com.paulina.zebras` on iOS,
/// SharedDataProvider on Android. ZebraUp reads it; it never writes here.
///
/// Draft v1 of the data contract — the fields ZebraPace owns:
/// steps, Rest/Flare days, possible-crash soreness verdicts, resting heart
/// rate, HRV and logged activity. Change the contract here and bump
/// [schemaVersion] when a field changes meaning or is removed; adding a
/// field is backwards compatible and doesn't need a bump.
class SharedOutboxBuilder {
  const SharedOutboxBuilder();

  static const schema = 'zebras.shared.outbox';
  static const schemaVersion = 1;
  static const windowDays = 30;

  /// [hrvMetricFromHealth] is what Apple Health ('sdnn') or Health Connect
  /// ('rmssd') reports; typed-in HRV has no known metric, so it's null.
  String build({
    required DateTime generatedAt,
    required List<DailyLog> logs,
    required List<Activity> activities,
    required Set<String> possibleCrashDates,
    required String hrvMetricFromHealth,
  }) {
    final byDate = <String, Map<String, Object?>>{};
    Map<String, Object?> day(String date) => byDate.putIfAbsent(date, () => {'date': date});

    for (final l in logs) {
      final d = day(l.date);
      if (l.steps > 0) {
        d['steps'] = l.steps;
        d['stepsSource'] = l.stepsSource?.name;
      }
      if (l.isRestDay) d['restDay'] = true;
      if (l.isFlareDay) d['flareDay'] = true;
      if (l.restingHeartRate != null) d['restingHeartRateBpm'] = l.restingHeartRate;
      if (l.hrvMs != null) {
        d['hrvMs'] = l.hrvMs;
        d['hrvMetric'] = l.heartSource == ValueSource.health ? hrvMetricFromHealth : null;
      }
    }
    for (final date in possibleCrashDates) {
      day(date)['possibleCrash'] = true;
    }
    for (final a in activities) {
      final d = day(a.date);
      d['activeMinutes'] = ((d['activeMinutes'] as int?) ?? 0) + a.durationMin;
      final met = a.metMinutes;
      if (met != null) d['metMinutes'] = ((d['metMinutes'] as double?) ?? 0) + met;
    }

    final days = byDate.values.where((d) => d.length > 1).toList()
      ..sort((a, b) => (a['date'] as String).compareTo(b['date'] as String));
    return jsonEncode({
      'schema': schema,
      'version': schemaVersion,
      'source': 'zebrapace',
      'generatedAt': generatedAt.toUtc().toIso8601String(),
      'windowDays': windowDays,
      'days': days,
    });
  }
}
