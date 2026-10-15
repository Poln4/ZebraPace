import '../models/daily_log.dart';
import '../models/detected_sleep.dart';
import 'readiness_service.dart';

/// Decides what Apple Health / Health Connect writes into a day's log.
/// Each group (steps, sleep, resting HR + HRV) follows Health until the
/// person edits it: a [ValueSource.manual] group is never touched. Health
/// only ever adds or updates — a missing reading never clears a value.
class HealthSyncService {
  /// The log with Health's values applied, or null when nothing changes.
  DailyLog? apply(
    DailyLog log, {
    int? steps,
    DetectedSleep? sleep,
    AutonomicReading? heart,
  }) {
    var next = log;

    if (log.stepsSource != ValueSource.manual && steps != null && steps > 0) {
      next = next.copyWith(steps: steps, stepsSource: ValueSource.health);
    }

    if (log.sleepSource != ValueSource.manual && sleep != null) {
      next = next.copyWith(
        sleepHours: sleep.asleepMinutes / 60.0,
        sleepHeartRateMin: sleep.heartRateMinBpm,
        sleepHeartRateMax: sleep.heartRateMaxBpm,
        sleepSource: ValueSource.health,
      );
    }

    final resting = heart?.restingHeartRate;
    final hrv = heart?.hrvMs;
    if (log.heartSource != ValueSource.manual && (resting != null || hrv != null)) {
      next = next.copyWith(
        restingHeartRate: resting?.round(),
        hrvMs: hrv,
        heartSource: ValueSource.health,
      );
    }

    return _same(log, next) ? null : next;
  }

  static bool _same(DailyLog a, DailyLog b) =>
      a.steps == b.steps &&
      a.stepsSource == b.stepsSource &&
      a.sleepHours == b.sleepHours &&
      a.sleepHeartRateMin == b.sleepHeartRateMin &&
      a.sleepHeartRateMax == b.sleepHeartRateMax &&
      a.sleepSource == b.sleepSource &&
      a.restingHeartRate == b.restingHeartRate &&
      a.hrvMs == b.hrvMs &&
      a.heartSource == b.heartSource;
}
