import '../../core/utils/date_utils.dart';
import '../models/activity.dart';
import '../models/calisthenics_set.dart';
import '../models/daily_log.dart';
import '../models/soreness_check.dart';
import '../models/therapy.dart';
import 'long_term_pem_service.dart';
import 'period_comparison_service.dart';

/// Body score on a session day and the two days after (null = not logged).
class SessionFollowUp {
  const SessionFollowUp({
    required this.date,
    required this.sessions,
    required this.scoreSameDay,
    required this.scoreDay1,
    required this.scoreDay2,
  });

  final String date;

  /// What was done that day, already labelled (activity, exercise or
  /// therapy names), de-duplicated in order.
  final List<String> sessions;
  final int? scoreSameDay;
  final int? scoreDay1;
  final int? scoreDay2;
}

class SorenessTally {
  const SorenessTally({required this.likelySoreness, required this.possibleCrash, required this.unclear});

  final int likelySoreness;
  final int possibleCrash;
  final int unclear;

  int get total => likelySoreness + possibleCrash + unclear;
}

class PhysioReportData {
  const PhysioReportData({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.generatedAt,
    required this.current,
    required this.previous,
    required this.sorenessTally,
    required this.recentChecks,
    required this.followUps,
    required this.usualLagDays,
    required this.questions,
  });

  final String name;
  final String startDate;
  final String endDate;
  final String generatedAt;
  final PeriodSummary current;

  /// The same number of days right before, for the changes in the summary.
  final PeriodSummary previous;
  final SorenessTally sorenessTally;

  /// Most recent first, at most [PhysioReportService.maxChecks].
  final List<SorenessCheck> recentChecks;

  /// Most recent first, at most [PhysioReportService.maxFollowUps].
  final List<SessionFollowUp> followUps;

  /// From the whole history (LongTermPemService); null when unclear.
  final int? usualLagDays;
  final String questions;

  int get daysInRange => dateFromKey(endDate).difference(dateFromKey(startDate)).inDays + 1;
}

/// Zebras+ physio report (business_plan.md: informe para kinesiología o
/// fisiatría): a two-page template on top of the free PDF summary.
/// Pure — the caller fetches the data and labels the sessions.
class PhysioReportService {
  PhysioReportService._();

  /// Table caps that keep the PDF within two pages.
  static const maxChecks = 8;
  static const maxFollowUps = 10;
  static const maxQuestionsLength = 600;

  /// The window right before [startDate] with the same number of days.
  static ({String start, String end}) previousWindow(String startDate, String endDate) {
    final start = dateFromKey(startDate);
    final days = dateFromKey(endDate).difference(start).inDays + 1;
    return (
      start: dateKey(DateTime(start.year, start.month, start.day - days)),
      end: dateKey(DateTime(start.year, start.month, start.day - 1)),
    );
  }

  static PhysioReportData build({
    required String name,
    required String startDate,
    required String endDate,
    required String generatedAt,
    required List<DailyLog> allLogs,
    required List<Activity> activities,
    required List<CalisthenicsSet> calisthenics,
    required List<Therapy> therapies,
    required String Function(CalisthenicsSet) exerciseLabel,
    required List<SorenessCheck> sorenessChecks,
    required String questions,
  }) {
    final prev = previousWindow(startDate, endDate);
    final byDate = {for (final l in allLogs) l.date: l};

    bool inRange(String date) => date.compareTo(startDate) >= 0 && date.compareTo(endDate) <= 0;

    final sessionsByDay = <String, List<String>>{};
    void add(String date, String label) {
      if (!inRange(date) || label.trim().isEmpty) return;
      final list = sessionsByDay.putIfAbsent(date, () => []);
      if (!list.contains(label)) list.add(label);
    }

    for (final a in activities) {
      add(a.date, a.activityName);
    }
    for (final c in calisthenics) {
      add(c.date, exerciseLabel(c));
    }
    for (final t in therapies) {
      add(t.date, t.therapyName);
    }

    int? scoreOn(String date, int plusDays) {
      final d = dateFromKey(date);
      return byDate[dateKey(DateTime(d.year, d.month, d.day + plusDays))]?.bodyFeeling?.score;
    }

    final followUps = (sessionsByDay.keys.toList()..sort((a, b) => b.compareTo(a)))
        .take(maxFollowUps)
        .map((date) => SessionFollowUp(
              date: date,
              sessions: sessionsByDay[date]!,
              scoreSameDay: scoreOn(date, 0),
              scoreDay1: scoreOn(date, 1),
              scoreDay2: scoreOn(date, 2),
            ))
        .toList();

    final checks = sorenessChecks.where((c) => inRange(c.date)).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    int count(String verdict) => checks.where((c) => c.verdict == verdict).length;

    final pattern = LongTermPemService.analyze(allLogs);

    final trimmed = questions.trim();
    return PhysioReportData(
      name: name.trim(),
      startDate: startDate,
      endDate: endDate,
      generatedAt: generatedAt,
      current: PeriodComparisonService.summarize(startDate, endDate, allLogs),
      previous: PeriodComparisonService.summarize(prev.start, prev.end, allLogs),
      sorenessTally: SorenessTally(
        likelySoreness: count('likely_doms'),
        possibleCrash: count('possible_crash'),
        unclear: checks.length - count('likely_doms') - count('possible_crash'),
      ),
      recentChecks: checks.take(maxChecks).toList(),
      followUps: followUps,
      usualLagDays: pattern.hasEnoughHistory ? pattern.usualLagDays : null,
      questions: trimmed.length > maxQuestionsLength
          ? '${trimmed.substring(0, maxQuestionsLength)}…'
          : trimmed,
    );
  }
}
