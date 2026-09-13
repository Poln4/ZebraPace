import '../../core/utils/date_utils.dart';
import '../../core/utils/stats.dart';
import '../../data/repositories/activity_repository.dart';
import '../../data/repositories/calisthenics_repository.dart';
import '../../data/repositories/daily_log_repository.dart';
import 'pem_service.dart' show ExertionBucket;

class HrExertionDataPoint {
  const HrExertionDataPoint({
    required this.date,
    required this.maxHeartRateBpm,
    required this.laggedBodyScore,
    required this.bucket,
  });

  final String date;
  final int maxHeartRateBpm;
  final int laggedBodyScore;
  final ExertionBucket bucket;
}

class HrExertionResult {
  const HrExertionResult({
    required this.points,
    required this.correlation,
    required this.higherExertionAvgScore,
    required this.typicalAvgScore,
  });

  final List<HrExertionDataPoint> points;
  final double? correlation; // null if n < minSampleSize
  final double? higherExertionAvgScore;
  final double? typicalAvgScore;

  bool get hasEnoughData => correlation != null;
}

/// Same PEM-check shape as [PemService] (calendar-date lag, median-ish split
/// into higher/typical exertion, Pearson r against a lagged body score), but
/// keyed on the day's peak logged heart rate — across both Activities and
/// Calisthenics entries — instead of step count. Answers a different
/// question than the steps-based PEM check: "does how *hard* a day's
/// exertion ran (by heart rate), not just how much of it there was,
/// predict next-day symptoms?"
class HrExertionService {
  HrExertionService(this._activityRepository, this._calisthenicsRepository, this._dailyLogRepository);

  final ActivityRepository _activityRepository;
  final CalisthenicsRepository _calisthenicsRepository;
  final DailyLogRepository _dailyLogRepository;

  static const minSampleSize = 4;

  Future<HrExertionResult> analyze(String startDate, String endDate, {required int lagDays}) async {
    final activities = await _activityRepository.getRange(startDate, endDate);
    final calisthenics = await _calisthenicsRepository.getRange(startDate, endDate);
    final logs = await _dailyLogRepository.getRange(startDate, endDate);
    final logsByDate = {for (final l in logs) l.date: l};

    final maxHrByDate = <String, int>{};
    void trackMax(String date, int? bpm) {
      if (bpm == null) return;
      final current = maxHrByDate[date];
      if (current == null || bpm > current) maxHrByDate[date] = bpm;
    }

    for (final a in activities) {
      trackMax(a.date, a.heartRateMaxBpm);
    }
    for (final c in calisthenics) {
      trackMax(c.date, c.heartRateMaxBpm);
    }

    final candidates = <_RawPoint>[];
    maxHrByDate.forEach((date, maxHr) {
      final laggedDate = dateKey(dateFromKey(date).add(Duration(days: lagDays)));
      final laggedScore = logsByDate[laggedDate]?.bodyFeeling?.score;
      if (laggedScore == null) return;
      candidates.add(_RawPoint(date, maxHr, laggedScore));
    });

    if (candidates.length < minSampleSize) {
      return const HrExertionResult(
        points: [],
        correlation: null,
        higherExertionAvgScore: null,
        typicalAvgScore: null,
      );
    }

    final baseline = candidates.map((c) => c.maxHr).reduce((a, b) => a + b) / candidates.length;

    final points = candidates
        .map((c) => HrExertionDataPoint(
              date: c.date,
              maxHeartRateBpm: c.maxHr,
              laggedBodyScore: c.laggedScore,
              bucket: c.maxHr > baseline ? ExertionBucket.higher : ExertionBucket.typicalOrLower,
            ))
        .toList();

    final higher = points.where((p) => p.bucket == ExertionBucket.higher).toList();
    final typical = points.where((p) => p.bucket == ExertionBucket.typicalOrLower).toList();

    return HrExertionResult(
      points: points,
      correlation: pearsonCorrelation(
        points.map((p) => p.maxHeartRateBpm.toDouble()).toList(),
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
  const _RawPoint(this.date, this.maxHr, this.laggedScore);

  final String date;
  final int maxHr;
  final int laggedScore;
}
