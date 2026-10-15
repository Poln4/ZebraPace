import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/domain/models/daily_log.dart';

void main() {
  const log = DailyLog(
    id: 'a',
    date: '2026-10-15',
    weightKg: 60,
    sleepHours: 7.5,
    sleepQuality: SleepQuality.good,
    restingHeartRate: 58,
    hrvMs: 45,
  );

  test('leaving a field out keeps it', () {
    final updated = log.copyWith(steps: 3000);
    expect(updated.weightKg, 60);
    expect(updated.restingHeartRate, 58);
    expect(updated.hrvMs, 45);
    expect(updated.sleepQuality, SleepQuality.good);
  });

  test('passing null clears a field emptied before saving', () {
    final updated = log.copyWith(restingHeartRate: null, hrvMs: null, weightKg: null);
    expect(updated.restingHeartRate, isNull);
    expect(updated.hrvMs, isNull);
    expect(updated.weightKg, isNull);
    expect(updated.sleepHours, 7.5);
  });

  test('passing a value replaces it', () {
    final updated = log.copyWith(restingHeartRate: 61, sleepHours: 6.0);
    expect(updated.restingHeartRate, 61);
    expect(updated.sleepHours, 6.0);
  });
}
