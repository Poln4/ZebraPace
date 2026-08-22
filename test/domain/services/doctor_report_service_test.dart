import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/domain/models/calisthenics_set.dart';
import 'package:zebrapace_app/domain/models/daily_log.dart';
import 'package:zebrapace_app/domain/services/doctor_report_service.dart';
import 'package:zebrapace_app/domain/services/pem_service.dart';
import 'package:zebrapace_app/domain/services/weather_service.dart';
import 'package:zebrapace_app/l10n/app_localizations_en.dart';

void main() {
  final service = DoctorReportService();
  final l10n = AppLocalizationsEn();

  test('overview averages steps only over active days, water/protein over all logged days', () {
    final logs = [
      DailyLog(id: '1', date: '2026-01-01', steps: 1000, waterMlCredit: 500, proteinG: 20),
      DailyLog(id: '2', date: '2026-01-02', steps: 0, waterMlCredit: 1000, proteinG: 40, isRestDay: true),
      DailyLog(id: '3', date: '2026-01-03', steps: 3000, waterMlCredit: 1500, proteinG: 60),
    ];
    final overview = service.buildOverview(
      startDate: '2026-01-01',
      endDate: '2026-01-03',
      logsInRange: logs,
    );
    expect(overview.daysInRange, 3);
    expect(overview.daysLogged, 3);
    expect(overview.restDays, 1);
    expect(overview.avgSteps, 2000); // (1000+3000)/2, day 2 excluded (steps=0)
    expect(overview.avgWaterMl, closeTo(1000, 0.001)); // (500+1000+1500)/3
    expect(overview.avgProteinG, closeTo(40, 0.001));
  });

  test('calisthenics summary takes the last 3 sessions per exercise and the latest tier', () {
    final sets = [
      const CalisthenicsSet(
        id: '1', date: '2026-01-01', exercise: CalisthenicsExercise.pushups,
        progression: 'Wall Pushups (~35% BW)', sets: 3, reps: 10, comfortScore: 3.0,
      ),
      const CalisthenicsSet(
        id: '2', date: '2026-01-02', exercise: CalisthenicsExercise.pushups,
        progression: 'Incline Pushups (~50% BW)', sets: 3, reps: 10, comfortScore: 4.0,
      ),
      const CalisthenicsSet(
        id: '3', date: '2026-01-03', exercise: CalisthenicsExercise.pushups,
        progression: 'Incline Pushups (~50% BW)', sets: 3, reps: 10, comfortScore: 5.0,
      ),
    ];
    final summaries = service.summarizeCalisthenics(l10n, sets);
    expect(summaries, hasLength(1));
    expect(summaries.first.latestTier, 'Incline Pushups (~50% BW)');
    expect(summaries.first.last3AvgComfort, closeTo(4.0, 0.001)); // (3+4+5)/3
  });

  test('pemNote is null when there is not enough data', () {
    const result = PemResult(points: [], correlation: null, higherExertionAvgScore: null, typicalAvgScore: null);
    expect(service.buildPemNote(l10n, result, 1, 30), isNull);
  });

  test('weatherNote is null when correlation could not be computed', () {
    const correlation = WeatherCorrelation(days: [], correlation: null);
    expect(service.buildWeatherNote(l10n, correlation), isNull);
  });
}
