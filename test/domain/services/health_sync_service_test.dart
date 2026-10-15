import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/domain/models/daily_log.dart';
import 'package:zebrapace_app/domain/models/detected_sleep.dart';
import 'package:zebrapace_app/domain/services/health_sync_service.dart';
import 'package:zebrapace_app/domain/services/readiness_service.dart';

void main() {
  final sync = HealthSyncService();
  const empty = DailyLog(id: 'a', date: '2026-10-15');
  const night = DetectedSleep(asleepMinutes: 450, heartRateMinBpm: 52, heartRateMaxBpm: 70);

  test('fills an empty day from Health and marks it as synced', () {
    final next = sync.apply(
      empty,
      steps: 4200,
      sleep: night,
      heart: const AutonomicReading(restingHeartRate: 57.6, hrvMs: 44),
    )!;
    expect(next.steps, 4200);
    expect(next.stepsSource, ValueSource.health);
    expect(next.sleepHours, 7.5);
    expect(next.sleepHeartRateMin, 52);
    expect(next.sleepSource, ValueSource.health);
    expect(next.restingHeartRate, 58);
    expect(next.hrvMs, 44);
    expect(next.heartSource, ValueSource.health);
  });

  test('keeps following Health as the day goes on', () {
    final synced = empty.copyWith(steps: 8000, stepsSource: ValueSource.health);
    expect(sync.apply(synced, steps: 8008)!.steps, 8008);
  });

  test('never overwrites a group the person edited', () {
    final edited = empty.copyWith(
      steps: 5000,
      stepsSource: ValueSource.manual,
      sleepHours: 6.0,
      sleepSource: ValueSource.manual,
      restingHeartRate: 60,
      heartSource: ValueSource.manual,
    );
    expect(
      sync.apply(edited,
          steps: 9000, sleep: night, heart: const AutonomicReading(restingHeartRate: 55)),
      isNull,
    );
  });

  test('edits are per group: an edited sleep still lets steps sync', () {
    final edited = empty.copyWith(sleepHours: 6.0, sleepSource: ValueSource.manual);
    final next = sync.apply(edited, steps: 3000, sleep: night)!;
    expect(next.steps, 3000);
    expect(next.sleepHours, 6.0);
  });

  test('missing Health data never clears what is there', () {
    final synced = empty.copyWith(steps: 8000, stepsSource: ValueSource.health);
    expect(sync.apply(synced), isNull);
    expect(sync.apply(synced, steps: 0), isNull);
  });

  test('no change means no write', () {
    final synced = empty.copyWith(steps: 8000, stepsSource: ValueSource.health);
    expect(sync.apply(synced, steps: 8000), isNull);
  });
}
