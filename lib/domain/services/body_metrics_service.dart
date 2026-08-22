import '../../data/repositories/daily_log_repository.dart';
import '../models/daily_log.dart';

/// Ported from app.py's get_latest_body_metrics: used only to pre-fill a
/// date's Body Metrics form. Editing a past date never ripples forward —
/// this only ever affects what's shown as "latest" for dates after it.
class BodyMetricsService {
  BodyMetricsService(this._repository);

  final DailyLogRepository _repository;

  Future<DailyLog?> getCarryForward(String beforeOrOnDate) {
    return _repository.getLatestBodyMetrics(beforeOrOnDate);
  }
}
