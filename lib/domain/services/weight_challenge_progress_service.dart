import '../../core/utils/date_utils.dart';
import '../../data/repositories/daily_log_repository.dart';

/// Computes the "current weight" a participant would push to the shared
/// challenge leaderboard: an outlier-trimmed average of resting-day
/// weigh-ins, rather than a single reading — resting-day weight is far
/// more stable than an active-day one (hydration/exercise swings), and
/// trimming the extremes keeps one unusually high or low weigh-in from
/// swinging the standings.
class WeightChallengeProgressService {
  WeightChallengeProgressService(this._repository);

  final DailyLogRepository _repository;

  /// Only weigh-ins from the last 7 days count, so standings reflect where
  /// someone is now rather than being diluted by readings from weeks ago.
  static const windowDays = 7;

  /// Below this many readings in the window, trimming a high and low would
  /// leave too little (or nothing) to average — so below the threshold,
  /// every reading counts instead.
  static const minReadingsToTrim = 5;

  /// Null when there are no resting-day weight logs in the window at all.
  Future<double?> computeCurrentWeightKg(String asOfDate) async {
    final start =
        dateKey(dateFromKey(asOfDate).subtract(const Duration(days: windowDays - 1)));
    final logs = await _repository.getRange(start, asOfDate);

    final weights = logs
        .where((log) => log.isRestDay && log.weightKg != null)
        .map((log) => log.weightKg!)
        .toList()
      ..sort();

    if (weights.isEmpty) return null;

    final trimmed =
        weights.length >= minReadingsToTrim ? weights.sublist(1, weights.length - 1) : weights;

    return trimmed.reduce((a, b) => a + b) / trimmed.length;
  }
}
