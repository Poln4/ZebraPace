import '../../data/repositories/calisthenics_repository.dart';

/// Ported from app.py's check_calisthenics_comfort. Advisory only — never
/// auto-advances the progression dropdown, the user always picks the next
/// tier manually on a later log.
class CalisthenicsService {
  CalisthenicsService(this._repository);

  final CalisthenicsRepository _repository;

  /// True iff exactly the 3 most-recent sessions for this exercise (on/before
  /// targetDate) exist and their comfort-score mean is >= comfortThreshold.
  /// Not "at least 3" — exactly 3, matching app.py's `len(df) == 3` check.
  Future<bool> checkComfortMilestone(
    String exerciseDb,
    String targetDate, {
    required double comfortThreshold,
  }) async {
    final scores = await _repository.getLastThreeComfortScores(exerciseDb, targetDate);
    if (scores.length != 3) return false;
    final mean = scores.reduce((a, b) => a + b) / scores.length;
    return mean >= comfortThreshold;
  }
}
