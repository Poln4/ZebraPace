import 'dart:convert';

/// Reminders and pacing alerts (Settings → Reminders & alerts). All off
/// until the person turns one on; times are minutes after local midnight.
/// Stored as one JSON string under SettingsKeys.reminderSettings.
class ReminderSettings {
  const ReminderSettings({
    this.checkinEnabled = false,
    this.checkinMinutes = const [13 * 60, 19 * 60],
    this.sorenessEnabled = false,
    this.sorenessMinute = 10 * 60,
    this.weeklyEnabled = false,
    this.weeklyMinute = 18 * 60,
    this.pacingEnabled = false,
  });

  final bool checkinEnabled;

  /// Sorted, distinct.
  final List<int> checkinMinutes;
  final bool sorenessEnabled;
  final int sorenessMinute;
  final bool weeklyEnabled;
  final int weeklyMinute;
  final bool pacingEnabled;

  static const maxCheckinTimes = 6;

  bool get anyScheduled => checkinEnabled || sorenessEnabled || weeklyEnabled;
  bool get anyEnabled => anyScheduled || pacingEnabled;

  ReminderSettings copyWith({
    bool? checkinEnabled,
    List<int>? checkinMinutes,
    bool? sorenessEnabled,
    int? sorenessMinute,
    bool? weeklyEnabled,
    int? weeklyMinute,
    bool? pacingEnabled,
  }) {
    return ReminderSettings(
      checkinEnabled: checkinEnabled ?? this.checkinEnabled,
      checkinMinutes: checkinMinutes == null ? this.checkinMinutes : _normalize(checkinMinutes),
      sorenessEnabled: sorenessEnabled ?? this.sorenessEnabled,
      sorenessMinute: sorenessMinute ?? this.sorenessMinute,
      weeklyEnabled: weeklyEnabled ?? this.weeklyEnabled,
      weeklyMinute: weeklyMinute ?? this.weeklyMinute,
      pacingEnabled: pacingEnabled ?? this.pacingEnabled,
    );
  }

  String toJson() => jsonEncode({
        'checkinEnabled': checkinEnabled,
        'checkinMinutes': checkinMinutes,
        'sorenessEnabled': sorenessEnabled,
        'sorenessMinute': sorenessMinute,
        'weeklyEnabled': weeklyEnabled,
        'weeklyMinute': weeklyMinute,
        'pacingEnabled': pacingEnabled,
      });

  /// Anything unreadable falls back to the defaults (everything off).
  static ReminderSettings fromJson(String? raw) {
    if (raw == null || raw.isEmpty) return const ReminderSettings();
    try {
      final m = jsonDecode(raw) as Map<String, dynamic>;
      const d = ReminderSettings();
      int minute(Object? v, int fallback) =>
          v is int && v >= 0 && v < 24 * 60 ? v : fallback;
      final times = (m['checkinMinutes'] as List?)?.whereType<int>().toList();
      return ReminderSettings(
        checkinEnabled: m['checkinEnabled'] == true,
        checkinMinutes: times == null ? d.checkinMinutes : _normalize(times),
        sorenessEnabled: m['sorenessEnabled'] == true,
        sorenessMinute: minute(m['sorenessMinute'], d.sorenessMinute),
        weeklyEnabled: m['weeklyEnabled'] == true,
        weeklyMinute: minute(m['weeklyMinute'], d.weeklyMinute),
        pacingEnabled: m['pacingEnabled'] == true,
      );
    } catch (_) {
      return const ReminderSettings();
    }
  }

  static List<int> _normalize(List<int> minutes) {
    final sorted = minutes.where((v) => v >= 0 && v < 24 * 60).toSet().toList()..sort();
    return sorted.take(maxCheckinTimes).toList();
  }
}
