import 'package:flutter_test/flutter_test.dart';
import 'package:health/health.dart';
import 'package:zebrapace_app/domain/services/mets_estimation_service.dart';

void main() {
  final service = MetsEstimationService();

  test('metadata value wins when present, regardless of other inputs', () {
    final result = service.estimate(
      metsFromMetadata: 4.2,
      activeEnergyKcal: 999,
      duration: const Duration(minutes: 30),
      bodyweightKg: 70,
      activityType: HealthWorkoutActivityType.RUNNING,
    );
    expect(result.value, 4.2);
    expect(result.source, MetsSource.metadata);
    expect(result.isApproximate, isFalse);
  });

  test('estimates from active energy, duration, and bodyweight when metadata is absent', () {
    // METs = kcal / (hours * kg * 1.05)
    // 210 kcal over 0.5h at 70kg => 210 / (0.5 * 70 * 1.05) = 5.71...
    final result = service.estimate(
      activeEnergyKcal: 210,
      duration: const Duration(minutes: 30),
      bodyweightKg: 70,
      activityType: HealthWorkoutActivityType.RUNNING,
    );
    expect(result.source, MetsSource.estimatedFromEnergy);
    expect(result.value, closeTo(5.71, 0.01));
    expect(result.isApproximate, isTrue);
  });

  test('falls back to the compendium when bodyweight is unknown', () {
    final result = service.estimate(
      activeEnergyKcal: 210,
      duration: const Duration(minutes: 30),
      bodyweightKg: null,
      activityType: HealthWorkoutActivityType.WALKING,
    );
    expect(result.source, MetsSource.compendium);
    expect(result.value, 3.5);
  });

  test('falls back to the compendium when duration is zero (division-by-zero guard)', () {
    final result = service.estimate(
      activeEnergyKcal: 210,
      duration: Duration.zero,
      bodyweightKg: 70,
      activityType: HealthWorkoutActivityType.WALKING,
    );
    expect(result.source, MetsSource.compendium);
  });

  test('returns unknown when the activity type has no compendium entry and no other data', () {
    final result = service.estimate(
      duration: const Duration(minutes: 30),
      activityType: HealthWorkoutActivityType.WATER_POLO, // deliberately absent from the compendium
    );
    expect(result.value, isNull);
    expect(result.source, MetsSource.unknown);
  });
}
