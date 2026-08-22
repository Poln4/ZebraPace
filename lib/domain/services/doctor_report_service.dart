import '../../core/utils/date_utils.dart';
import '../../l10n/app_localizations.dart';
import '../models/activity.dart';
import '../models/calisthenics_set.dart';
import '../models/daily_log.dart';
import '../models/injury.dart';
import '../models/therapy.dart';
import 'mets_summary_service.dart';
import 'pem_service.dart';
import 'weather_service.dart';

class CalisthenicsExerciseSummary {
  const CalisthenicsExerciseSummary({
    required this.exerciseLabel,
    required this.latestTier,
    required this.last3AvgComfort,
    required this.lastContractionMode,
  });

  final String exerciseLabel;
  final String latestTier;
  final double last3AvgComfort;
  final String? lastContractionMode;
}

class DoctorReportOverview {
  const DoctorReportOverview({
    required this.daysInRange,
    required this.daysLogged,
    required this.restDays,
    required this.flareDays,
    required this.avgSteps,
    required this.avgWaterMl,
    required this.avgProteinG,
    required this.avgMentalScore,
    required this.avgBodyScore,
  });

  final int daysInRange;
  final int daysLogged;
  final int restDays;
  final int flareDays;
  final double? avgSteps;
  final double avgWaterMl;
  final double avgProteinG;
  final double? avgMentalScore;
  final double? avgBodyScore;
}

class DoctorReportData {
  const DoctorReportData({
    required this.startDate,
    required this.endDate,
    required this.generatedAt,
    required this.overview,
    required this.activityCount,
    required this.therapySessionCount,
    required this.calisthenicsSummaries,
    required this.recentTherapies,
    required this.relevantInjuries,
    required this.metsSummary,
    this.pemNote,
    this.weatherNote,
  });

  final String startDate;
  final String endDate;
  final String generatedAt;
  final DoctorReportOverview overview;
  final int activityCount;
  final int therapySessionCount;
  final List<CalisthenicsExerciseSummary> calisthenicsSummaries;
  final List<Therapy> recentTherapies;
  final List<Injury> relevantInjuries;
  final MetsSummary metsSummary;
  final String? pemNote;
  final String? weatherNote;
}

/// Ported from app.py's generate_doctor_pdf data-gathering (the PDF layout
/// itself lives in the presentation layer's DoctorReportPdf) plus the
/// pem_note/weather_note string formats from the Insights tab.
class DoctorReportService {
  DoctorReportOverview buildOverview({
    required String startDate,
    required String endDate,
    required List<DailyLog> logsInRange,
  }) {
    final daysSpan = dateFromKey(endDate).difference(dateFromKey(startDate)).inDays + 1;
    final daysLogged = logsInRange.length;
    final restDays = logsInRange.where((l) => l.isRestDay).length;
    final flareDays = logsInRange.where((l) => l.isFlareDay).length;

    final activeSteps = logsInRange.where((l) => l.steps > 0).map((l) => l.steps).toList();
    final avgSteps = activeSteps.isEmpty
        ? null
        : activeSteps.reduce((a, b) => a + b) / activeSteps.length;

    final avgWater = daysLogged == 0
        ? 0.0
        : logsInRange.map((l) => l.waterMlCredit).reduce((a, b) => a + b) / daysLogged;
    final avgProtein = daysLogged == 0
        ? 0.0
        : logsInRange.map((l) => l.proteinG).reduce((a, b) => a + b) / daysLogged;

    final mentalScores = logsInRange.map((l) => l.mentalState?.score).whereType<int>().toList();
    final bodyScores = logsInRange.map((l) => l.bodyFeeling?.score).whereType<int>().toList();

    return DoctorReportOverview(
      daysInRange: daysSpan < 1 ? 1 : daysSpan,
      daysLogged: daysLogged,
      restDays: restDays,
      flareDays: flareDays,
      avgSteps: avgSteps,
      avgWaterMl: avgWater,
      avgProteinG: avgProtein,
      avgMentalScore:
          mentalScores.isEmpty ? null : mentalScores.reduce((a, b) => a + b) / mentalScores.length,
      avgBodyScore:
          bodyScores.isEmpty ? null : bodyScores.reduce((a, b) => a + b) / bodyScores.length,
    );
  }

  List<CalisthenicsExerciseSummary> summarizeCalisthenics(
      AppLocalizations l10n, List<CalisthenicsSet> sets) {
    final sorted = [...sets]..sort((a, b) => a.date.compareTo(b.date));
    final byExercise = <String, List<CalisthenicsSet>>{};
    for (final s in sorted) {
      byExercise.putIfAbsent(s.exercise.label(l10n), () => []).add(s);
    }
    return byExercise.entries.map((entry) {
      final group = entry.value;
      final last3 = group.length <= 3 ? group : group.sublist(group.length - 3);
      final avgComfort = last3.map((s) => s.comfortScore).reduce((a, b) => a + b) / last3.length;
      final latest = group.last;
      return CalisthenicsExerciseSummary(
        exerciseLabel: entry.key,
        latestTier: latest.progression,
        last3AvgComfort: avgComfort,
        lastContractionMode: latest.contractionMode?.label(l10n),
      );
    }).toList();
  }

  String? buildPemNote(AppLocalizations l10n, PemResult result, int lagDays, int rangeDays) {
    if (!result.hasEnoughData) return null;
    return l10n.doctorReportPemNote(
      lagDays,
      rangeDays,
      result.points.length,
      result.correlation!.toStringAsFixed(2),
      result.higherExertionAvgScore?.toStringAsFixed(1) ?? l10n.doctorReportNotAvailable,
      result.typicalAvgScore?.toStringAsFixed(1) ?? l10n.doctorReportNotAvailable,
    );
  }

  String? buildWeatherNote(AppLocalizations l10n, WeatherCorrelation correlation) {
    if (!correlation.hasEnoughData) return null;
    final pressures = correlation.days.map((d) => d.pressureHpa).whereType<double>().toList();
    if (pressures.isEmpty) return null;
    final avgPressure = pressures.reduce((a, b) => a + b) / pressures.length;
    return l10n.doctorReportWeatherNote(
      avgPressure.toStringAsFixed(1),
      correlation.correlation!.toStringAsFixed(2),
    );
  }

  DoctorReportData build({
    required AppLocalizations l10n,
    required String startDate,
    required String endDate,
    required List<DailyLog> logsInRange,
    required List<Activity> activitiesInRange,
    required List<Therapy> therapiesInRange,
    required List<CalisthenicsSet> calisthenicsInRange,
    required List<Injury> relevantInjuries,
    String? pemNote,
    String? weatherNote,
  }) {
    final recentTherapies = [...therapiesInRange]
      ..sort((a, b) => b.date.compareTo(a.date));

    return DoctorReportData(
      startDate: startDate,
      endDate: endDate,
      generatedAt: todayKey(),
      overview: buildOverview(startDate: startDate, endDate: endDate, logsInRange: logsInRange),
      activityCount: activitiesInRange.length,
      therapySessionCount: therapiesInRange.length,
      calisthenicsSummaries: summarizeCalisthenics(l10n, calisthenicsInRange),
      recentTherapies: recentTherapies.take(10).toList(),
      relevantInjuries: relevantInjuries,
      metsSummary: MetsSummaryService().summarize(activitiesInRange),
      pemNote: pemNote,
      weatherNote: weatherNote,
    );
  }
}
