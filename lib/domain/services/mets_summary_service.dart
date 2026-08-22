import '../models/activity.dart';

class MetsSummary {
  const MetsSummary({required this.totalMetMinutes, required this.totalActiveEnergyKcal});

  final double totalMetMinutes;
  final double totalActiveEnergyKcal;

  bool get hasData => totalMetMinutes > 0 || totalActiveEnergyKcal > 0;
}

/// Additive-only, per the plan (§4): never wired into the pacing/caution-line
/// algorithm, which stays steps-based only.
class MetsSummaryService {
  MetsSummary summarize(List<Activity> activities) {
    double metMinutes = 0;
    double energyKcal = 0;
    for (final a in activities) {
      final mm = a.metMinutes;
      if (mm != null) metMinutes += mm;
      if (a.activeEnergyKcal != null) energyKcal += a.activeEnergyKcal!;
    }
    return MetsSummary(totalMetMinutes: metMinutes, totalActiveEnergyKcal: energyKcal);
  }
}
