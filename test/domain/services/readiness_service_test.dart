import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/core/utils/date_utils.dart';
import 'package:zebrapace_app/data/db/app_database.dart' show AppDatabase;
import 'package:zebrapace_app/data/repositories/daily_log_repository.dart';
import 'package:zebrapace_app/domain/models/soreness_check.dart';
import 'package:zebrapace_app/domain/services/pacing_service.dart';
import 'package:zebrapace_app/domain/services/readiness_service.dart';

const today = '2026-03-22';

String daysAgo(int n) => dateKey(dateFromKey(today).subtract(Duration(days: n)));

/// 14 baseline days alternating around [rhr] bpm / [hrv] ms, plus today.
Map<String, AutonomicReading> readings({
  double rhr = 60,
  double hrv = 50,
  double? todayRhr,
  double? todayHrv,
}) =>
    {
      for (var i = 1; i <= 14; i++)
        daysAgo(i): AutonomicReading(
          restingHeartRate: rhr + (i.isEven ? 1 : -1),
          hrvMs: hrv + (i.isEven ? 2 : -2),
        ),
      today: AutonomicReading(restingHeartRate: todayRhr, hrvMs: todayHrv),
    };

SorenessCheck check(String date, SorenessTrend trend, {String verdict = 'likely_doms'}) =>
    SorenessCheck(
      id: date,
      date: date,
      onset: SorenessOnset.oneDayAfter,
      spread: SorenessSpread.localized,
      trend: trend,
      verdict: verdict,
      verdictLabel: verdict,
    );

void main() {
  final service = ReadinessService();

  test('unknown without enough history', () {
    final result = service.evaluate(
      date: today,
      readings: {today: const AutonomicReading(restingHeartRate: 70, hrvMs: 20)},
      sorenessChecks: const [],
    );
    expect(result.level, ReadinessLevel.unknown);
  });

  test('steady when markers sit in the personal range', () {
    final result = service.evaluate(
      date: today,
      readings: readings(todayRhr: 61, todayHrv: 49),
      sorenessChecks: const [],
    );
    expect(result.level, ReadinessLevel.steady);
    expect(result.reasons, isEmpty);
  });

  test('resting HR a few bpm up lowers readiness; far up makes it low', () {
    final lower = service.evaluate(
      date: today,
      readings: readings(todayRhr: 64),
      sorenessChecks: const [],
    );
    expect(lower.level, ReadinessLevel.lower);
    expect(lower.reasons, {ReadinessReason.restingHeartRateUp});
    expect(lower.restingHeartRateDelta, closeTo(4, 0.01));

    final low = service.evaluate(
      date: today,
      readings: readings(todayRhr: 68),
      sorenessChecks: const [],
    );
    expect(low.level, ReadinessLevel.low);
  });

  test('HRV below the personal range lowers readiness', () {
    final lower = service.evaluate(
      date: today,
      readings: readings(todayHrv: 46),
      sorenessChecks: const [],
    );
    expect(lower.level, ReadinessLevel.lower);
    expect(lower.reasons, {ReadinessReason.hrvDown});
    expect(lower.hrvPercentBelow, greaterThan(5));

    final low = service.evaluate(
      date: today,
      readings: readings(todayHrv: 35),
      sorenessChecks: const [],
    );
    expect(low.level, ReadinessLevel.low);
  });

  test('soreness still not easing after 72h exceeds the recovery window', () {
    final result = service.evaluate(
      date: today,
      readings: const {},
      sorenessChecks: [
        check(daysAgo(3), SorenessTrend.same),
        check(today, SorenessTrend.same),
      ],
    );
    expect(result.level, ReadinessLevel.lower);
    expect(result.reasons, {ReadinessReason.recoveryWindowExceeded});
  });

  test('easing soreness inside the window is fine', () {
    final result = service.evaluate(
      date: today,
      readings: const {},
      sorenessChecks: [
        check(daysAgo(3), SorenessTrend.same),
        check(today, SorenessTrend.easing),
      ],
    );
    expect(result.level, ReadinessLevel.unknown);
    expect(result.reasons, isEmpty);
  });

  test('a recent possible crash makes readiness low', () {
    final result = service.evaluate(
      date: today,
      readings: readings(todayRhr: 60, todayHrv: 50),
      sorenessChecks: [check(daysAgo(1), SorenessTrend.worse, verdict: 'possible_crash')],
    );
    expect(result.level, ReadinessLevel.low);
    expect(result.reasons, contains(ReadinessReason.possibleCrash));
  });

  group('envelope', () {
    final db = AppDatabase(NativeDatabase.memory());
    final pacing = PacingService(DailyLogRepository(db));
    tearDownAll(db.close);
    const base = PacingEvaluation(avgSteps: 5000, goalSteps: 5050, cautionSteps: 5500);

    test('lower holds at baseline with a narrower caution line', () {
      final e = pacing.applyReadiness(
        base,
        const ReadinessResult(level: ReadinessLevel.lower),
        cautionPct: 1.10,
      );
      expect(e.goalSteps, 5000);
      expect(e.cautionSteps, 5250);
      expect(e.isReduced, isTrue);
    });

    test('low drops the goal and puts the caution line at baseline', () {
      final e = pacing.applyReadiness(
        base,
        const ReadinessResult(level: ReadinessLevel.low),
        cautionPct: 1.10,
      );
      expect(e.goalSteps, 4250);
      expect(e.cautionSteps, 5000);
    });

    test('steady leaves the usual envelope', () {
      final e = pacing.applyReadiness(
        base,
        const ReadinessResult(level: ReadinessLevel.steady),
        cautionPct: 1.10,
      );
      expect(e.goalSteps, 5050);
      expect(e.cautionSteps, 5500);
      expect(e.isReduced, isFalse);
    });

    test('under a reduced goal is honoured, not a gentle-low nudge', () {
      final e = pacing.applyReadiness(
        base,
        const ReadinessResult(level: ReadinessLevel.low),
        cautionPct: 1.10,
      );
      expect(
        pacing.evaluateStepsMessage(steps: 2000, isFlareDay: false, evaluation: e),
        PacingMessageKind.readinessHonored,
      );
      expect(
        pacing.evaluateStepsMessage(steps: 5200, isFlareDay: false, evaluation: e),
        PacingMessageKind.caution,
      );
    });
  });
}
