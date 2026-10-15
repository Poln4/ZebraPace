import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/domain/models/detected_sleep.dart';

void main() {
  final date = DateTime(2026, 10, 15);
  DateTime t(int day, int hour, [int minute = 0]) => DateTime(2026, 10, day, hour, minute);

  test('sums one night that crosses midnight', () {
    final sleep = DetectedSleep.fromSamples(date: date, asleep: [(t(14, 23), t(15, 7))]);
    expect(sleep!.asleepMinutes, 8 * 60);
  });

  test('merges overlapping stages from two sources instead of double-counting', () {
    final sleep = DetectedSleep.fromSamples(date: date, asleep: [
      (t(14, 23), t(15, 3)),
      (t(15, 2), t(15, 6)), // overlaps the first by an hour
      (t(15, 6), t(15, 7)), // touches the second
    ]);
    expect(sleep!.asleepMinutes, 8 * 60);
  });

  test('keeps gaps between separate stretches out of the total', () {
    final sleep = DetectedSleep.fromSamples(date: date, asleep: [
      (t(14, 23), t(15, 2)),
      (t(15, 3), t(15, 7)),
    ]);
    expect(sleep!.asleepMinutes, 7 * 60);
  });

  test('ignores an afternoon nap and the previous night', () {
    final sleep = DetectedSleep.fromSamples(date: date, asleep: [
      (t(14, 0), t(14, 7)), // belongs to the 14th
      (t(15, 14), t(15, 15)), // nap after noon
    ]);
    expect(sleep, isNull);
  });

  test('a nap ending after 6pm the day before counts toward this date', () {
    final sleep = DetectedSleep.fromSamples(date: date, asleep: [(t(14, 18), t(14, 19))]);
    expect(sleep!.asleepMinutes, 60);
  });

  test('heart rate range only uses samples taken while asleep', () {
    final sleep = DetectedSleep.fromSamples(
      date: date,
      asleep: [(t(14, 23), t(15, 2)), (t(15, 3), t(15, 7))],
      heartRate: [
        (t(14, 22), 90), // before bed
        (t(15, 1), 52),
        (t(15, 2, 30), 75), // awake gap
        (t(15, 5), 61),
        (t(15, 8), 80), // after waking
      ],
    );
    expect(sleep!.heartRateMinBpm, 52);
    expect(sleep.heartRateMaxBpm, 61);
  });

  test('no heart rate samples leaves the range empty', () {
    final sleep = DetectedSleep.fromSamples(date: date, asleep: [(t(14, 23), t(15, 7))]);
    expect(sleep!.heartRateMinBpm, isNull);
    expect(sleep.heartRateMaxBpm, isNull);
  });
}
