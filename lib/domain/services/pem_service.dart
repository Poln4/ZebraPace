import '../../core/utils/date_utils.dart';
import '../../core/utils/stats.dart';
import '../../data/repositories/daily_log_repository.dart';

enum ExertionBucket { higher, typicalOrLower }

class PemDataPoint {
  const PemDataPoint({
    required this.date,
    required this.steps,
    required this.laggedBodyScore,
    required this.bucket,
  });

  final String date;
  final int steps;
  final int laggedBodyScore;
  final ExertionBucket bucket;
}

class PemResult {
  const PemResult({
    required this.points,
    required this.correlation,
    required this.higherExertionAvgScore,
    required this.typicalAvgScore,
  });

  final List<PemDataPoint> points;
  final double? correlation; // null if n < minSampleSize
  final double? higherExertionAvgScore;
  final double? typicalAvgScore;

  bool get hasEnoughData => correlation != null;
}

/// Ported from app.py's PEM-check (Insights tab), with one deliberate
/// change from the original — see the plan's "PEM lag semantics" flag:
/// the original used a row-shift (`body_score.shift(-lag)` after sorting by
/// date), meaning "N rows later," not N calendar days — gaps in logging
/// silently compressed the lag. This port uses a true calendar-date lookup
/// instead: a day only contributes a data point if the exact date `lag`
/// days later was also logged. This can reduce sample size on gappy
/// histories compared to the original, but the lag it reports is always
/// what it says it is.
class PemService {
  PemService(this._dailyLogRepository);

  final DailyLogRepository _dailyLogRepository;

  static const minSampleSize = 4;

  Future<PemResult> analyze(String startDate, String endDate, {required int lagDays}) async {
    final logs = await _dailyLogRepository.getRange(startDate, endDate);
    final byDate = {for (final l in logs) l.date: l};

    final candidates = <_RawPoint>[];
    for (final log in logs) {
      if (log.steps <= 0) continue;
      final laggedDate = dateKey(dateFromKey(log.date).add(Duration(days: lagDays)));
      final laggedLog = byDate[laggedDate];
      final laggedScore = laggedLog?.bodyFeeling?.score;
      if (laggedScore == null) continue;
      candidates.add(_RawPoint(log.date, log.steps, laggedScore));
    }

    if (candidates.length < minSampleSize) {
      return const PemResult(
        points: [],
        correlation: null,
        higherExertionAvgScore: null,
        typicalAvgScore: null,
      );
    }

    final baseline =
        candidates.map((c) => c.steps).reduce((a, b) => a + b) / candidates.length;

    final points = candidates
        .map((c) => PemDataPoint(
              date: c.date,
              steps: c.steps,
              laggedBodyScore: c.laggedScore,
              bucket: c.steps > baseline ? ExertionBucket.higher : ExertionBucket.typicalOrLower,
            ))
        .toList();

    final higher = points.where((p) => p.bucket == ExertionBucket.higher).toList();
    final typical = points.where((p) => p.bucket == ExertionBucket.typicalOrLower).toList();

    return PemResult(
      points: points,
      correlation: pearsonCorrelation(
        points.map((p) => p.steps.toDouble()).toList(),
        points.map((p) => p.laggedBodyScore.toDouble()).toList(),
      ),
      higherExertionAvgScore: higher.isEmpty
          ? null
          : higher.map((p) => p.laggedBodyScore).reduce((a, b) => a + b) / higher.length,
      typicalAvgScore: typical.isEmpty
          ? null
          : typical.map((p) => p.laggedBodyScore).reduce((a, b) => a + b) / typical.length,
    );
  }
}

class _RawPoint {
  const _RawPoint(this.date, this.steps, this.laggedScore);

  final String date;
  final int steps;
  final int laggedScore;
}
