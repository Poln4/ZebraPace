import '../../core/constants/defaults.dart';
import '../../data/repositories/daily_log_repository.dart';
import '../../data/repositories/settings_repository.dart';

class StripeStatus {
  const StripeStatus({required this.stripesEarned, required this.justUnlocked});

  final int stripesEarned;

  /// True exactly once, the first time this status is read after crossing a
  /// new stripe — the caller (a provider) must call StripeService.acknowledge
  /// after showing the celebration so it doesn't refire.
  final bool justUnlocked;
}

/// Ported from app.py's stripe gamification (STRIPE_INTERVAL=5, STRIPE_SLOTS=20).
/// Fix over the original: the "just unlocked" marker is persisted in Settings
/// instead of Streamlit session state, so it survives across app launches —
/// the Python version only tracked this per-session, so a stripe crossed
/// between sessions never celebrated. The marker is written immediately when
/// a new stripe is detected (before the UI shows the toast) so a crash
/// mid-celebration can't cause a duplicate on next launch.
class StripeService {
  StripeService(this._dailyLogRepository, this._settingsRepository);

  final DailyLogRepository _dailyLogRepository;
  final SettingsRepository _settingsRepository;

  Future<StripeStatus> checkStatus() async {
    final total = await _dailyLogRepository.countTotalCheckins();
    final earned = (total ~/ StripeConstants.interval).clamp(0, StripeConstants.slots);
    final lastCelebrated =
        await _settingsRepository.getInt(SettingsKeys.lastCelebratedStripes, 0);

    if (earned > lastCelebrated) {
      await _settingsRepository.set(SettingsKeys.lastCelebratedStripes, earned.toString());
      return StripeStatus(stripesEarned: earned, justUnlocked: true);
    }
    return StripeStatus(stripesEarned: earned, justUnlocked: false);
  }
}
