import '../../core/constants/enums.dart';

enum ActivitySource { manual, healthkit }

class Activity {
  const Activity({
    required this.id,
    required this.date,
    required this.activityName,
    required this.durationMin,
    this.extraWeightKg = 0,
    this.mentalState,
    this.bodyFeeling,
    this.source = ActivitySource.manual,
    this.healthkitUuid,
    this.metsAvg,
    this.activeEnergyKcal,
  });

  final String id;
  final String date;
  final String activityName;
  final int durationMin;
  final double extraWeightKg;
  final MentalState? mentalState;
  final BodyFeeling? bodyFeeling;
  final ActivitySource source;
  final String? healthkitUuid;
  final double? metsAvg;
  final double? activeEnergyKcal;

  double? get metMinutes => metsAvg == null ? null : metsAvg! * durationMin;
}
