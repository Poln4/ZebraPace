import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/domain/models/activity.dart';
import 'package:zebrapace_app/domain/models/daily_log.dart';
import 'package:zebrapace_app/domain/services/shared_outbox_builder.dart';

void main() {
  Map<String, dynamic> build({
    List<DailyLog> logs = const [],
    List<Activity> activities = const [],
    Set<String> crash = const {},
  }) =>
      jsonDecode(const SharedOutboxBuilder().build(
        generatedAt: DateTime.utc(2026, 11, 20, 12),
        logs: logs,
        activities: activities,
        possibleCrashDates: crash,
        hrvMetricFromHealth: 'sdnn',
      )) as Map<String, dynamic>;

  test('header names the schema, version and source', () {
    final out = build();
    expect(out['schema'], 'zebras.shared.outbox');
    expect(out['version'], 1);
    expect(out['source'], 'zebrapace');
    expect(out['generatedAt'], '2026-11-20T12:00:00.000Z');
    expect(out['days'], isEmpty);
  });

  test('one entry per day with only the fields that have values, sorted', () {
    final out = build(
      logs: const [
        DailyLog(id: 'b', date: '2026-11-19', steps: 4200, stepsSource: ValueSource.health,
            restingHeartRate: 61, hrvMs: 42.5, heartSource: ValueSource.health),
        DailyLog(id: 'a', date: '2026-11-18', isFlareDay: true, hrvMs: 30, heartSource: ValueSource.manual),
        DailyLog(id: 'c', date: '2026-11-17'),
      ],
      activities: const [
        Activity(id: '1', date: '2026-11-19', activityName: 'Walk', durationMin: 20, metsAvg: 3),
        Activity(id: '2', date: '2026-11-19', activityName: 'Yoga', durationMin: 15),
      ],
      crash: {'2026-11-18'},
    );
    final days = (out['days'] as List).cast<Map<String, dynamic>>();
    expect(days.map((d) => d['date']), ['2026-11-18', '2026-11-19']);
    expect(days[0], {
      'date': '2026-11-18',
      'flareDay': true,
      'hrvMs': 30.0,
      'hrvMetric': null,
      'possibleCrash': true,
    });
    expect(days[1], {
      'date': '2026-11-19',
      'steps': 4200,
      'stepsSource': 'health',
      'restingHeartRateBpm': 61,
      'hrvMs': 42.5,
      'hrvMetric': 'sdnn',
      'activeMinutes': 35,
      'metMinutes': 60.0,
    });
  });
}
