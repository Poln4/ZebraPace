import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/domain/services/sleep_energy_service.dart';

void main() {
  final service = SleepEnergyService();

  test('both fields present averages duration-vs-goal and quality score', () {
    final energy = service.computeEnergyLevel(
      sleepHours: 6,
      sleepQuality: SleepQuality.good, // score 4/5 = 0.8
      sleepGoalHours: 8, // 6/8 = 0.75
    );
    expect(energy, closeTo((0.75 + 0.8) / 2, 0.001));
  });

  test('only duration logged uses just the duration score', () {
    final energy = service.computeEnergyLevel(
      sleepHours: 4,
      sleepQuality: null,
      sleepGoalHours: 8,
    );
    expect(energy, closeTo(0.5, 0.001));
  });

  test('only quality logged uses just the quality score', () {
    final energy = service.computeEnergyLevel(
      sleepHours: null,
      sleepQuality: SleepQuality.restorative, // score 5/5
      sleepGoalHours: 8,
    );
    expect(energy, closeTo(1.0, 0.001));
  });

  test('neither logged yields null, not a fabricated value', () {
    final energy = service.computeEnergyLevel(
      sleepHours: null,
      sleepQuality: null,
      sleepGoalHours: 8,
    );
    expect(energy, isNull);
  });

  test('sleeping past the goal clamps the duration score at 1.0', () {
    final energy = service.computeEnergyLevel(
      sleepHours: 12,
      sleepQuality: null,
      sleepGoalHours: 8,
    );
    expect(energy, 1.0);
  });
}
