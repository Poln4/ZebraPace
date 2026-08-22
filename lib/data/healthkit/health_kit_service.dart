import 'package:health/health.dart';

import '../../domain/models/detected_workout.dart';

const List<HealthDataType> healthKitDataTypes = [
  HealthDataType.STEPS,
  HealthDataType.WORKOUT,
  HealthDataType.ACTIVE_ENERGY_BURNED,
];

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

  Future<void> _ensureConfigured() async {
    if (_configured) return;
    try {
      await _health.configure();
      _configured = true;
    } catch (_) {
      // Leave _configured false; every call below will then also fail
      // quietly and callers see "not available" rather than a crash.
    }
  }

  Future<bool> requestAuthorization() async {
    await _ensureConfigured();
    try {
      return await _health.requestAuthorization(healthKitDataTypes);
    } catch (_) {
      return false;
    }
  }

  Future<bool> hasPermissions() async {
    await _ensureConfigured();
    try {
      return await _health.hasPermissions(healthKitDataTypes) ?? false;
    } catch (_) {
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
    } catch (_) {
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
        workouts.add(DetectedWorkout(
          healthkitUuid: point.uuid,
          activityType: value.workoutActivityType,
          start: point.dateFrom,
          end: point.dateTo,
          activeEnergyKcal: value.totalEnergyBurned?.toDouble(),
        ));
      }
      return workouts;
    } catch (_) {
      return [];
    }
  }
}
