import '../../core/constants/enums.dart';
import '../../l10n/app_localizations.dart';
import '../models/daily_log.dart';

class MonthChapter {
  const MonthChapter(this.title, this.body);

  final String title;
  final String body;
}

/// Ported verbatim from app.py's build_month_chapter — a gentle narrative
/// recap, reflection not a scorecard. `activityCount`/`calisthenicsCount`/
/// `therapyCount` are counts for the same calendar month as `monthLogs`.
class MonthChapterService {
  MonthChapter build({
    required AppLocalizations l10n,
    required List<DailyLog> monthLogs,
    required int activityCount,
    required int calisthenicsCount,
    required int therapyCount,
  }) {
    if (monthLogs.isEmpty) {
      return MonthChapter(l10n.monthChapterQuietTitle, l10n.monthChapterQuietBody);
    }

    final checkins = monthLogs
        .where((l) => l.waterMlCredit > 0 || l.steps > 0 || l.isRestDay || l.isFlareDay)
        .length;
    if (checkins == 0) {
      return MonthChapter(l10n.monthChapterQuietTitle, l10n.monthChapterQuietBody);
    }

    final restN = monthLogs.where((l) => l.isRestDay).length;
    final flareN = monthLogs.where((l) => l.isFlareDay).length;
    final mentalScores = monthLogs.map((l) => l.mentalState?.score).whereType<int>().toList();
    final bodyScores = monthLogs.map((l) => l.bodyFeeling?.score).whereType<int>().toList();

    final String title;
    if ((flareN + restN) > 0 && (flareN + restN) >= (checkins ~/ 2).clamp(1, checkins)) {
      title = l10n.monthChapterTitleLearningToRest;
    } else if ((activityCount + calisthenicsCount) >= 8) {
      title = l10n.monthChapterTitleGentleExploration;
    } else if (checkins >= 15) {
      title = l10n.monthChapterTitleSteadyNoticing;
    } else {
      title = l10n.monthChapterTitleFindingTheRhythm;
    }

    final lines = <String>[l10n.monthChapterShowedUp(checkins)];

    if (restN > 0 || flareN > 0) {
      final bits = <String>[];
      if (restN > 0) bits.add(l10n.monthChapterRestDays(restN));
      if (flareN > 0) bits.add(l10n.monthChapterFlareDays(flareN));
      lines.add(l10n.monthChapterHonored(bits.join(l10n.monthChapterAnd)));
    }

    if (activityCount > 0 || calisthenicsCount > 0 || therapyCount > 0) {
      final bits = <String>[];
      if (activityCount > 0) bits.add(l10n.monthChapterActivityLogs(activityCount));
      if (calisthenicsCount > 0) {
        bits.add(l10n.monthChapterCalisthenicsSessions(calisthenicsCount));
      }
      if (therapyCount > 0) bits.add(l10n.monthChapterRecoverySessions(therapyCount));
      lines.add(l10n.monthChapterMovementSummary(bits.join(', ')));
    }

    if (mentalScores.isNotEmpty && bodyScores.isNotEmpty) {
      final minMental = mentalScores.reduce((a, b) => a < b ? a : b);
      final maxMental = mentalScores.reduce((a, b) => a > b ? a : b);
      final minBody = bodyScores.reduce((a, b) => a < b ? a : b);
      final maxBody = bodyScores.reduce((a, b) => a > b ? a : b);
      lines.add(l10n.monthChapterScoreRange(
        MentalState.values[minMental - 1].label(l10n),
        MentalState.values[maxMental - 1].label(l10n),
        BodyFeeling.values[minBody - 1].label(l10n),
        BodyFeeling.values[maxBody - 1].label(l10n),
      ));
    }

    return MonthChapter(title, lines.join(' '));
  }
}
