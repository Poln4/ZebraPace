import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/domain/models/activity.dart';
import 'package:zebrapace_app/domain/services/mets_summary_service.dart';

void main() {
  final service = MetsSummaryService();

  test('sums MET-minutes and active energy across activities, skipping missing values', () {
    final activities = [
      const Activity(
          id: '1', date: '2026-01-01', activityName: 'Walk', durationMin: 30,
          metsAvg: 3.5, activeEnergyKcal: 120),
      const Activity(
          id: '2', date: '2026-01-01', activityName: 'Yoga', durationMin: 20,
          metsAvg: 2.5, activeEnergyKcal: 60),
      // No METs/energy data (manual entry, never estimated) — must not crash.
      const Activity(id: '3', date: '2026-01-02', activityName: 'Gardening', durationMin: 15),
    ];

    final summary = service.summarize(activities);
    expect(summary.totalMetMinutes, closeTo(3.5 * 30 + 2.5 * 20, 0.001));
    expect(summary.totalActiveEnergyKcal, closeTo(180, 0.001));
    expect(summary.hasData, isTrue);
  });

  test('empty list has no data', () {
    final summary = service.summarize(const []);
    expect(summary.hasData, isFalse);
  });
}
