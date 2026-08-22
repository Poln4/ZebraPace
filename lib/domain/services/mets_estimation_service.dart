import 'package:health/health.dart';

import '../../core/constants/mets_compendium.dart';

enum MetsSource { metadata, estimatedFromEnergy, compendium, unknown }

class MetsEstimate {
  const MetsEstimate(this.value, this.source);

  final double? value;
  final MetsSource source;

  /// Metadata-sourced values are exact; the other two are approximations —
  /// label them with "~" in the UI, metadata-sourced shown plain.
  bool get isApproximate => source == MetsSource.estimatedFromEnergy || source == MetsSource.compendium;
}

/// Ported from the plan's METs fallback chain (§4): (1) HealthKit metadata
/// if present — never populated today, see mets_compendium.dart's doc
/// comment; (2) estimate from active energy / duration / bodyweight; (3)
/// static compendium lookup by workout type; (4) unknown, never blocks
/// saving duration/energy.
class MetsEstimationService {
  MetsEstimate estimate({
    double? metsFromMetadata,
    double? activeEnergyKcal,
    required Duration duration,
    double? bodyweightKg,
    required HealthWorkoutActivityType activityType,
  }) {
    if (metsFromMetadata != null) {
      return MetsEstimate(metsFromMetadata, MetsSource.metadata);
    }

    if (activeEnergyKcal != null && bodyweightKg != null && bodyweightKg > 0 && duration.inSeconds > 0) {
      final hours = duration.inSeconds / 3600.0;
      // METs = kcal / (hours * bodyweightKg * 1.05) — standard MET-to-energy
      // relationship (1 MET ≈ 1 kcal/kg/hr, with a small rounding correction).
      final mets = activeEnergyKcal / (hours * bodyweightKg * 1.05);
      if (mets.isFinite && mets > 0) {
        return MetsEstimate(mets, MetsSource.estimatedFromEnergy);
      }
    }

    final compendiumValue = metsForWorkoutType(activityType);
    if (compendiumValue != null) {
      return MetsEstimate(compendiumValue, MetsSource.compendium);
    }

    return const MetsEstimate(null, MetsSource.unknown);
  }
}
