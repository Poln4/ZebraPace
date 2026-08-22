import 'package:health/health.dart';

/// A HealthKit workout not yet reviewed/confirmed into the Activities table.
/// Never saved to the local DB directly — see the plan's "Import with
/// review" flow: the user must tap Add/Edit to confirm before it becomes a
/// real Activity row.
class DetectedWorkout {
  const DetectedWorkout({
    required this.healthkitUuid,
    required this.activityType,
    required this.start,
    required this.end,
    this.activeEnergyKcal,
    this.metsFromMetadata,
  });

  final String healthkitUuid;
  final HealthWorkoutActivityType activityType;
  final DateTime start;
  final DateTime end;
  final double? activeEnergyKcal;

  /// Reserved for a future native-bridge source of HKMetadataKeyAverageMETs
  /// — always null today, since the `health` package doesn't surface
  /// workout metadata (confirmed by reading its iOS source; see plan notes).
  final double? metsFromMetadata;

  int get durationMin => end.difference(start).inMinutes;

  String get activityLabel =>
      activityType.name.replaceAll('_', ' ').toLowerCase().split(' ').map((w) {
        if (w.isEmpty) return w;
        return w[0].toUpperCase() + w.substring(1);
      }).join(' ');
}
