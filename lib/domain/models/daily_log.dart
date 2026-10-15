import '../../core/constants/enums.dart';

class DailyLog {
  const DailyLog({
    required this.id,
    required this.date,
    this.weightKg,
    this.heightCm,
    this.fatPercentage,
    this.waterMlRaw = 0,
    this.waterMlCredit = 0,
    this.proteinG = 0,
    this.creatineG = 0,
    this.mentalState,
    this.bodyFeeling,
    this.bracesUsed = const [],
    this.braceComfort,
    this.steps = 0,
    this.isRestDay = false,
    this.isFlareDay = false,
    this.sleepHours,
    this.sleepQuality,
    this.sleepHeartRateMin,
    this.restingHeartRate,
    this.hrvMs,
    this.stepsSource,
    this.sleepSource,
    this.heartSource,
    this.sleepHeartRateMax,
  });

  final String id;
  final String date;
  final double? weightKg;
  final double? heightCm;
  final double? fatPercentage;
  final int waterMlRaw;
  final double waterMlCredit;
  final double proteinG;
  final double creatineG;
  final MentalState? mentalState;
  final BodyFeeling? bodyFeeling;
  final List<BraceType> bracesUsed;
  final int? braceComfort;
  final int steps;
  final bool isRestDay;
  final bool isFlareDay;
  final double? sleepHours;
  final SleepQuality? sleepQuality;
  final int? sleepHeartRateMin;

  /// Morning resting heart rate (bpm) and HRV (ms), from Health or typed in.
  final int? restingHeartRate;
  final double? hrvMs;

  /// Where steps / sleep / resting HR+HRV came from: [ValueSource.health]
  /// (synced) or [ValueSource.manual]. Null when nothing is recorded.
  final ValueSource? stepsSource;
  final ValueSource? sleepSource;
  final ValueSource? heartSource;
  final int? sleepHeartRateMax;

  /// Either flag collapses "optional" sections app-wide (matches app.py's
  /// is_low_energy_day) — flare takes UI precedence when both are set.
  bool get isLowEnergyDay => isRestDay || isFlareDay;

  /// Marks a nullable field as "not passed" in [copyWith], so passing
  /// null clears it (e.g. a field emptied before saving) while leaving it
  /// out keeps the current value.
  static const _keep = Object();

  DailyLog copyWith({
    Object? weightKg = _keep,
    Object? heightCm = _keep,
    Object? fatPercentage = _keep,
    int? waterMlRaw,
    double? waterMlCredit,
    double? proteinG,
    double? creatineG,
    Object? mentalState = _keep,
    Object? bodyFeeling = _keep,
    List<BraceType>? bracesUsed,
    Object? braceComfort = _keep,
    int? steps,
    bool? isRestDay,
    bool? isFlareDay,
    Object? sleepHours = _keep,
    Object? sleepQuality = _keep,
    Object? sleepHeartRateMin = _keep,
    Object? restingHeartRate = _keep,
    Object? hrvMs = _keep,
    Object? sleepHeartRateMax = _keep,
    Object? stepsSource = _keep,
    Object? sleepSource = _keep,
    Object? heartSource = _keep,
  }) {
    return DailyLog(
      id: id,
      date: date,
      weightKg: weightKg == _keep ? this.weightKg : weightKg as double?,
      heightCm: heightCm == _keep ? this.heightCm : heightCm as double?,
      fatPercentage: fatPercentage == _keep ? this.fatPercentage : fatPercentage as double?,
      waterMlRaw: waterMlRaw ?? this.waterMlRaw,
      waterMlCredit: waterMlCredit ?? this.waterMlCredit,
      proteinG: proteinG ?? this.proteinG,
      creatineG: creatineG ?? this.creatineG,
      mentalState: mentalState == _keep ? this.mentalState : mentalState as MentalState?,
      bodyFeeling: bodyFeeling == _keep ? this.bodyFeeling : bodyFeeling as BodyFeeling?,
      bracesUsed: bracesUsed ?? this.bracesUsed,
      braceComfort: braceComfort == _keep ? this.braceComfort : braceComfort as int?,
      steps: steps ?? this.steps,
      isRestDay: isRestDay ?? this.isRestDay,
      isFlareDay: isFlareDay ?? this.isFlareDay,
      sleepHours: sleepHours == _keep ? this.sleepHours : sleepHours as double?,
      sleepQuality: sleepQuality == _keep ? this.sleepQuality : sleepQuality as SleepQuality?,
      sleepHeartRateMin: sleepHeartRateMin == _keep ? this.sleepHeartRateMin : sleepHeartRateMin as int?,
      restingHeartRate: restingHeartRate == _keep ? this.restingHeartRate : restingHeartRate as int?,
      hrvMs: hrvMs == _keep ? this.hrvMs : hrvMs as double?,
      sleepHeartRateMax: sleepHeartRateMax == _keep ? this.sleepHeartRateMax : sleepHeartRateMax as int?,
      stepsSource: stepsSource == _keep ? this.stepsSource : stepsSource as ValueSource?,
      sleepSource: sleepSource == _keep ? this.sleepSource : sleepSource as ValueSource?,
      heartSource: heartSource == _keep ? this.heartSource : heartSource as ValueSource?,
    );
  }
}

/// Where a Health-backed value came from. Stored as its name.
enum ValueSource {
  health,
  manual;

  static ValueSource? fromDb(String? value) =>
      ValueSource.values.where((v) => v.name == value).firstOrNull;
}
