/// Last night's sleep as read from Apple Health / Health Connect, used only
/// to pre-fill the Sleep section's empty fields. Never saved on its own —
/// the user still taps Save, as with HealthKit steps.
class DetectedSleep {
  const DetectedSleep({
    required this.asleepMinutes,
    this.heartRateMinBpm,
    this.heartRateMaxBpm,
  });

  final int asleepMinutes;

  /// Min/max heart rate recorded while asleep, or null without watch data.
  final int? heartRateMinBpm;
  final int? heartRateMaxBpm;

  /// The night that belongs to [date]: asleep time ending between 6pm the
  /// day before and noon on [date], so a nap after noon isn't counted and a
  /// late bedtime still lands on the morning it ends.
  static (DateTime start, DateTime end) windowFor(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    return (day.subtract(const Duration(hours: 6)), day.add(const Duration(hours: 12)));
  }

  /// Builds the night from raw asleep intervals (any stage) and heart rate
  /// samples. Intervals ending outside [windowFor] are dropped, and
  /// overlapping ones are merged first, since a watch and a phone often
  /// both record the same night. Heart rate only counts samples taken
  /// inside the merged asleep time. Null when nothing was asleep.
  static DetectedSleep? fromSamples({
    required DateTime date,
    required List<(DateTime, DateTime)> asleep,
    List<(DateTime, int)> heartRate = const [],
  }) {
    final (windowStart, windowEnd) = windowFor(date);
    final inWindow = [
      for (final (start, end) in asleep)
        if (end.isAfter(start) && end.isAfter(windowStart) && !end.isAfter(windowEnd)) (start, end),
    ]..sort((a, b) => a.$1.compareTo(b.$1));
    if (inWindow.isEmpty) return null;

    final merged = <(DateTime, DateTime)>[];
    for (final (start, end) in inWindow) {
      if (merged.isNotEmpty && !start.isAfter(merged.last.$2)) {
        final last = merged.removeLast();
        merged.add((last.$1, end.isAfter(last.$2) ? end : last.$2));
      } else {
        merged.add((start, end));
      }
    }

    final minutes = merged.fold<int>(0, (sum, i) => sum + i.$2.difference(i.$1).inMinutes);
    if (minutes <= 0) return null;

    int? hrMin;
    int? hrMax;
    for (final (at, bpm) in heartRate) {
      final asleepThen = merged.any((i) => !at.isBefore(i.$1) && !at.isAfter(i.$2));
      if (!asleepThen) continue;
      if (hrMin == null || bpm < hrMin) hrMin = bpm;
      if (hrMax == null || bpm > hrMax) hrMax = bpm;
    }

    return DetectedSleep(asleepMinutes: minutes, heartRateMinBpm: hrMin, heartRateMaxBpm: hrMax);
  }
}
