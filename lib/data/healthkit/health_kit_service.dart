import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:health/health.dart';

import '../../core/errors/error_reporter.dart';
import '../../core/utils/date_utils.dart';
import '../../domain/models/detected_sleep.dart';
import '../../domain/models/detected_workout.dart';
import '../../domain/services/readiness_service.dart';

const List<HealthDataType> healthKitDataTypes = [
  HealthDataType.STEPS,
  HealthDataType.WORKOUT,
  HealthDataType.ACTIVE_ENERGY_BURNED,
  HealthDataType.HEART_RATE,
];

/// Health Connect reads a workout's distance and total calories along with
/// the exercise session itself, and fails the whole read without permission
/// for them — so Android asks for these two on top of [healthKitDataTypes].
/// Keep in sync with the READ_* permissions in AndroidManifest.xml.
List<HealthDataType> healthDataTypes() => [
      ...healthKitDataTypes,
      if (usesHealthConnect) ...[
        HealthDataType.DISTANCE_DELTA,
        HealthDataType.TOTAL_CALORIES_BURNED,
      ],
    ];

/// Autonomic readiness markers. Apple Health records HRV as SDNN, Health
/// Connect as RMSSD; readiness only compares each against its own history.
/// Requested alongside [healthDataTypes] but deliberately left out of
/// [HealthKitService.hasPermissions]: an install that connected before these
/// existed must not suddenly read as disconnected. Keep the Android ones in
/// sync with AndroidManifest.xml.
List<HealthDataType> readinessDataTypes() => [
      HealthDataType.RESTING_HEART_RATE,
      usesHealthConnect
          ? HealthDataType.HEART_RATE_VARIABILITY_RMSSD
          : HealthDataType.HEART_RATE_VARIABILITY_SDNN,
    ];

/// Asleep stages for the Sleep section's pre-fill. Older Apple Watches and
/// phones record a plain "asleep"; newer ones split it into core (LIGHT),
/// deep and REM. Health Connect only reports stages when the tracker
/// recorded them, so Android also reads whole sessions as a fallback.
/// Like [readinessDataTypes], left out of hasPermissions. Keep the Android
/// permission (READ_SLEEP) in AndroidManifest.xml.
List<HealthDataType> sleepDataTypes() => [
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.SLEEP_LIGHT,
      HealthDataType.SLEEP_DEEP,
      HealthDataType.SLEEP_REM,
      if (usesHealthConnect) HealthDataType.SLEEP_SESSION,
    ];

/// The one thing ZebraPace writes to Health: body weight typed into Vitals.
/// Like [readinessDataTypes], left out of hasPermissions. Keep the Android
/// permission (WRITE_WEIGHT) in AndroidManifest.xml.
const weightWriteTypes = [HealthDataType.WEIGHT];

/// True on Android, where health data comes from Health Connect instead of
/// Apple Health.
bool get usesHealthConnect => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

/// Thin wrapper over the `health` package. HealthKit is unavailable on the
/// iOS Simulator and on any platform other than iOS/Android — every method
/// here degrades to an empty/false result on error rather than throwing, so
/// the rest of the app never needs its own try/catch for "HealthKit isn't
/// there today." Denial and unavailability are first-class expected states,
/// not error conditions.
class HealthKitService {
  HealthKitService([Health? health]) : _health = health ?? Health();

  final Health _health;
  bool _configured = false;

  static const _healthSettingsChannel = MethodChannel('zebrapace/health_settings');

  Future<void> _ensureConfigured() async {
    if (_configured) return;
    try {
      await _health.configure();
      _configured = true;
    } catch (e, st) {
      ErrorReporter.report(e, st, where: 'health.configure');
      // Leave _configured false; every call below will then also fail
      // quietly and callers see "not available" rather than a crash.
    }
  }

  /// Always true on iOS. On Android, false until the Health Connect app is
  /// installed (or updated, on Android 13 and below) — see
  /// [installHealthConnect].
  Future<bool> isAvailable() async {
    if (!usesHealthConnect) return true;
    await _ensureConfigured();
    try {
      return await _health.isHealthConnectAvailable();
    } catch (_) {
      return false;
    }
  }

  /// Sends the user to the Play Store page for Health Connect.
  Future<void> installHealthConnect() async {
    await _ensureConfigured();
    try {
      await _health.installHealthConnect();
    } catch (_) {}
  }

  /// Android only: opens Health Connect's own settings, the only place to
  /// change access once it's granted. Returns false if it couldn't open.
  Future<bool> openHealthConnectSettings() async {
    try {
      return await _healthSettingsChannel.invokeMethod<bool>('open') ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> requestAuthorization() async {
    await _ensureConfigured();
    try {
      final reads = [...healthDataTypes(), ...readinessDataTypes(), ...sleepDataTypes()];
      return await _health.requestAuthorization(
        [...reads, ...weightWriteTypes],
        permissions: [
          for (final _ in reads) HealthDataAccess.READ,
          for (final _ in weightWriteTypes) HealthDataAccess.WRITE,
        ],
      );
    } catch (e, st) {
      ErrorReporter.report(e, st, where: 'health.authorize');
      return false;
    }
  }

  /// Asks for just the weight write permission, for installs that connected
  /// Health before ZebraPace wrote anything.
  Future<bool> requestWeightWrite() async {
    await _ensureConfigured();
    try {
      return await _health.requestAuthorization(
        weightWriteTypes,
        permissions: [for (final _ in weightWriteTypes) HealthDataAccess.WRITE],
      );
    } catch (e, st) {
      ErrorReporter.report(e, st, where: 'health.authorizeWeight');
      return false;
    }
  }

  /// Makes Health's weight for [day] match the one typed in ZebraPace: the
  /// sample ZebraPace wrote for that day earlier (if any) is replaced, or
  /// removed when [kg] is null. Health only lets an app delete its own
  /// samples, so a scale's or another app's readings are never touched.
  /// Today's weight is stamped now; a past day's at noon.
  Future<bool> writeWeight(DateTime day, double? kg) async {
    await _ensureConfigured();
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    final now = DateTime.now();
    final at = now.isAfter(start) && now.isBefore(end) ? now : start.add(const Duration(hours: 12));
    try {
      await _health.delete(type: HealthDataType.WEIGHT, startTime: start, endTime: end);
      if (kg == null) return true;
      return await _health.writeHealthData(
        value: kg,
        unit: HealthDataUnit.KILOGRAM,
        type: HealthDataType.WEIGHT,
        startTime: at,
        endTime: at,
        recordingMethod: RecordingMethod.manual,
      );
    } catch (e, st) {
      ErrorReporter.report(e, st, where: 'health.writeWeight');
      return false;
    }
  }

  /// null means "unknown", not "denied": iOS deliberately never reveals
  /// whether *read* access was granted, so the `health` package answers
  /// null for read-only types even after the user allowed everything.
  /// Health Connect on Android does answer true/false.
  /// Callers must fall back to their own record of having asked — see
  /// healthKitEnabledProvider.
  Future<bool?> hasPermissions() async {
    await _ensureConfigured();
    try {
      return await _health.hasPermissions(healthDataTypes());
    } catch (e, st) {
      ErrorReporter.report(e, st, where: 'health.permissions');
      return false;
    }
  }

  /// Pacing alerts read steps while the app is closed. Android 14+ asks for
  /// that separately from the normal read permission; iOS needs nothing
  /// extra (background delivery is an entitlement). True when allowed, or
  /// when the device has no separate permission for it.
  Future<bool> requestBackgroundRead() async {
    if (!usesHealthConnect) return true;
    await _ensureConfigured();
    try {
      if (!await _health.isHealthDataInBackgroundAvailable()) return true;
      if (await _health.isHealthDataInBackgroundAuthorized()) return true;
      return await _health.requestHealthDataInBackgroundAuthorization();
    } catch (e, st) {
      ErrorReporter.report(e, st, where: 'health.backgroundRead');
      return false;
    }
  }

  /// Total steps for the given local calendar day, or null if unavailable
  /// (permission denied, HealthKit missing, or zero recorded — callers
  /// treat null and 0 the same way: nothing to pre-fill).
  Future<int?> getStepsForDate(DateTime date) async {
    await _ensureConfigured();
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    try {
      return await _health.getTotalStepsInInterval(start, end);
    } catch (e, st) {
      ErrorReporter.report(e, st, where: 'health.steps');
      return null;
    }
  }

  /// Workouts wholly or partly within the given local calendar day.
  Future<List<DetectedWorkout>> getWorkoutsForDate(DateTime date) async {
    await _ensureConfigured();
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    try {
      final points = await _health.getHealthDataFromTypes(
        types: [HealthDataType.WORKOUT],
        startTime: start,
        endTime: end,
      );
      final workouts = <DetectedWorkout>[];
      for (final point in points) {
        final value = point.value;
        if (value is! WorkoutHealthValue) continue;
        final hrRange = await getHeartRateRange(point.dateFrom, point.dateTo);
        workouts.add(DetectedWorkout(
          healthkitUuid: point.uuid,
          activityType: value.workoutActivityType,
          start: point.dateFrom,
          end: point.dateTo,
          activeEnergyKcal: value.totalEnergyBurned?.toDouble(),
          heartRateMinBpm: hrRange?.$1,
          heartRateMaxBpm: hrRange?.$2,
        ));
      }
      return workouts;
    } catch (e, st) {
      ErrorReporter.report(e, st, where: 'health.workouts');
      return [];
    }
  }

  /// Min/max HEART_RATE (bpm) recorded within [start, end], or null when
  /// there's no heart rate data for that window (no watch worn, permission
  /// denied, etc — treated as "nothing to pre-fill", same as other methods
  /// here).
  Future<(int min, int max)?> getHeartRateRange(DateTime start, DateTime end) async {
    await _ensureConfigured();
    try {
      final points = await _health.getHealthDataFromTypes(
        types: [HealthDataType.HEART_RATE],
        startTime: start,
        endTime: end,
      );
      int? min;
      int? max;
      for (final point in points) {
        final value = point.value;
        if (value is! NumericHealthValue) continue;
        final bpm = value.numericValue.round();
        if (min == null || bpm < min) min = bpm;
        if (max == null || bpm > max) max = bpm;
      }
      if (min == null || max == null) return null;
      return (min, max);
    } catch (e, st) {
      ErrorReporter.report(e, st, where: 'health.heartRate');
      return null;
    }
  }

  /// The night belonging to [date] (see [DetectedSleep.windowFor]), or null
  /// when nothing asleep was recorded or access wasn't granted.
  Future<DetectedSleep?> getSleepForDate(DateTime date) async {
    await _ensureConfigured();
    final (windowStart, windowEnd) = DetectedSleep.windowFor(date);
    // Samples are matched by overlap, so start early enough to catch a
    // stretch that began well before the window but ends inside it.
    final queryStart = windowStart.subtract(const Duration(hours: 18));

    Future<List<(DateTime, DateTime)>> intervals(List<HealthDataType> types) async {
      final out = <(DateTime, DateTime)>[];
      for (final type in types) {
        try {
          final points = await _health.getHealthDataFromTypes(
            types: [type],
            startTime: queryStart,
            endTime: windowEnd,
          );
          out.addAll([for (final p in points) (p.dateFrom, p.dateTo)]);
        } catch (_) {
          // A type the device doesn't record shouldn't hide the others.
        }
      }
      return out;
    }

    final rem = await intervals([HealthDataType.SLEEP_REM]);
    final deep = await intervals([HealthDataType.SLEEP_DEEP]);
    final others = sleepDataTypes()
        .where((t) => !const [
              HealthDataType.SLEEP_SESSION,
              HealthDataType.SLEEP_REM,
              HealthDataType.SLEEP_DEEP,
            ].contains(t))
        .toList();
    var asleep = [...await intervals(others), ...rem, ...deep];
    if (asleep.isEmpty && usesHealthConnect) {
      asleep = await intervals([HealthDataType.SLEEP_SESSION]);
    }
    if (asleep.isEmpty) return null;

    final night = DetectedSleep.fromSamples(date: date, asleep: asleep, rem: rem, deep: deep);
    if (night == null) return null;

    var heartRate = <(DateTime, int)>[];
    try {
      final first = asleep.map((i) => i.$1).reduce((a, b) => a.isBefore(b) ? a : b);
      final points = await _health.getHealthDataFromTypes(
        types: [HealthDataType.HEART_RATE],
        startTime: first.isBefore(queryStart) ? queryStart : first,
        endTime: windowEnd,
      );
      heartRate = [
        for (final p in points)
          if (p.value case NumericHealthValue(:final numericValue)) (p.dateFrom, numericValue.round()),
      ];
    } catch (_) {
      // No heart rate is fine; the duration still pre-fills.
    }
    return DetectedSleep.fromSamples(
      date: date,
      asleep: asleep,
      rem: rem,
      deep: deep,
      heartRate: heartRate,
    );
  }

  /// Resting HR and HRV per local calendar day between [start] and [end],
  /// keyed by date. Several samples on one day are averaged. Empty when
  /// there's no watch data or no permission.
  Future<Map<String, AutonomicReading>> getAutonomicReadings(DateTime start, DateTime end) async {
    await _ensureConfigured();
    final types = readinessDataTypes();
    final rhr = <String, List<double>>{};
    final hrv = <String, List<double>>{};
    for (final type in types) {
      try {
        final points = await _health.getHealthDataFromTypes(
          types: [type],
          startTime: start,
          endTime: end,
        );
        final bucket = type == HealthDataType.RESTING_HEART_RATE ? rhr : hrv;
        for (final point in points) {
          final value = point.value;
          if (value is! NumericHealthValue) continue;
          bucket.putIfAbsent(dateKey(point.dateFrom), () => []).add(value.numericValue.toDouble());
        }
      } catch (_) {
        // One type denied shouldn't hide the other.
      }
    }
    double? mean(List<double>? xs) =>
        xs == null || xs.isEmpty ? null : xs.reduce((a, b) => a + b) / xs.length;
    return {
      for (final date in {...rhr.keys, ...hrv.keys})
        date: AutonomicReading(restingHeartRate: mean(rhr[date]), hrvMs: mean(hrv[date])),
    };
  }
}
