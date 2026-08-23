/// Ported verbatim from app.py's DEFAULT_SETTINGS + stripe gamification constants.
library;

class DefaultSettings {
  DefaultSettings._();

  static const growthGoalPct = 1.01; // 1% growth target over 7-day average
  static const cautionPct = 1.10; // gentle-caution threshold above average
  static const comfortThreshold = 3.8; // avg comfort score to unlock next progression
  static const waterGoalMl = 2000;
  static const proteinGoalG = 100;
  static const sleepGoalHours = 8.0;

  /// 'system' follows the OS locale; otherwise an app-supported language code.
  static const languageCode = 'system';

  /// Multiplier on top of the OS/browser's own text-scale setting — see
  /// textScaleProvider. 1.0 = no extra scaling beyond whatever the platform
  /// already applies.
  static const textScaleFactor = 1.0;
}

class SettingsKeys {
  SettingsKeys._();

  static const growthGoalPct = 'growth_goal_pct';
  static const cautionPct = 'caution_pct';
  static const comfortThreshold = 'comfort_threshold';
  static const waterGoalMl = 'water_goal_ml';
  static const proteinGoalG = 'protein_goal_g';
  static const sleepGoalHours = 'sleep_goal_hours';
  static const locationName = 'location_name';
  static const locationLat = 'location_lat';
  static const locationLon = 'location_lon';
  static const lastCelebratedStripes = 'last_celebrated_stripes';
  static const healthKitAuthStatus = 'healthkit_auth_status';
  static const languageCode = 'language_code';
  static const textScaleFactor = 'text_scale_factor';
  static const welcomeAcknowledged = 'welcome_acknowledged';
  static const userName = 'user_name';
  static const inviteCodeVerified = 'invite_code_verified';
}

class StripeConstants {
  StripeConstants._();

  static const interval = 5;
  static const slots = 20;
}

class PacingConstants {
  PacingConstants._();

  static const lookbackDays = 14;
  static const sampleSize = 7;
  static const lowStepsRatio = 0.85; // >15% below baseline triggers the gentle-low message
}

class AuthConstants {
  AuthConstants._();

  /// A fresh app start within this many minutes of the last time the app
  /// was seen unlocked skips the lock screen entirely — see
  /// AuthNotifier/SecureAuthStorage.setLastUnlockedAt. Long enough to
  /// survive a quick trip to Mail for a Supabase magic link or a mobile
  /// browser reloading a backgrounded tab; short enough that a phone left
  /// untouched for a while still re-locks.
  static const reLockGraceMinutes = 5;
}
