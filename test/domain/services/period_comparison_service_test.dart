import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/domain/models/daily_log.dart';
import 'package:zebrapace_app/domain/services/period_comparison_service.dart';

void main() {
  group('periods', () {
    test('recent period: N calendar months ending on the selected day', () {
      expect(PeriodComparisonService.recentPeriod('2026-11-22', 3),
          (start: '2026-08-23', end: '2026-11-22'));
      expect(PeriodComparisonService.recentPeriod('2026-03-31', 1),
          (start: '2026-03-01', end: '2026-03-31')); // month ends clamp, no roll-over
    });

    test('previous period sits right before, same length in months', () {
      expect(
        PeriodComparisonService.earlierPeriod('2026-11-22', 3, ComparisonTarget.previousPeriod),
        (start: '2026-05-23', end: '2026-08-22'),
      );
    });

    test('same time last year shifts both ends by a year', () {
      expect(
        PeriodComparisonService.earlierPeriod('2026-11-22', 3, ComparisonTarget.sameTimeLastYear),
        (start: '2025-08-23', end: '2025-11-22'),
      );
      // Leap day: a year before 2028-02-29 is 2027-02-28.
      expect(
        PeriodComparisonService.earlierPeriod('2028-02-29', 1, ComparisonTarget.sameTimeLastYear).end,
        '2027-02-28',
      );
    });
  });

  group('summarize', () {
    DailyLog log(String date, {int steps = 0, BodyFeeling? body, double? sleep, bool rest = false, bool flare = false}) =>
        DailyLog(
          id: date,
          date: date,
          steps: steps,
          bodyFeeling: body,
          sleepHours: sleep,
          isRestDay: rest,
          isFlareDay: flare,
        );

    test('averages only logged values, counts rest and flare days, ignores days outside', () {
      final s = PeriodComparisonService.summarize('2026-11-01', '2026-11-30', [
        log('2026-10-31', steps: 99999),
        log('2026-11-01', steps: 4000, body: BodyFeeling.good, sleep: 7),
        log('2026-11-02', steps: 0, body: BodyFeeling.achy, rest: true),
        log('2026-11-03', steps: 6000, flare: true),
      ]);
      expect(s.daysLogged, 3);
      expect(s.avgSteps, 5000); // the 0-step rest day isn't counted as 0
      expect(s.avgBodyScore, 3);
      expect(s.avgSleepHours, 7);
      expect(s.avgRestingHr, isNull);
      expect(s.restDays, 1);
      expect(s.flareDays, 1);
    });

    test('empty period', () {
      final s = PeriodComparisonService.summarize('2025-01-01', '2025-03-31', []);
      expect(s.daysLogged, 0);
      expect(s.avgSteps, isNull);
    });
  });
}
