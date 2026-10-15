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
  final int? sleepHeartRateMax;

  /// Either flag collapses "optional" sections app-wide (matches app.py's
  /// is_low_energy_day) — flare takes UI precedence when both are set.
  bool get isLowEnergyDay => isRestDay || isFlareDay;

  DailyLog copyWith({
    double? weightKg,
    double? heightCm,
    double? fatPercentage,
    int? waterMlRaw,
    double? waterMlCredit,
    double? proteinG,
    double? creatineG,
    MentalState? mentalState,
    BodyFeeling? bodyFeeling,
    List<BraceType>? bracesUsed,
    int? braceComfort,
    int? steps,
    bool? isRestDay,
    bool? isFlareDay,
    double? sleepHours,
    SleepQuality? sleepQuality,
    int? sleepHeartRateMin,
    int? restingHeartRate,
    double? hrvMs,
    int? sleepHeartRateMax,
  }) {
    return DailyLog(
      id: id,
      date: date,
      weightKg: weightKg ?? this.weightKg,
      heightCm: heightCm ?? this.heightCm,
      fatPercentage: fatPercentage ?? this.fatPercentage,
      waterMlRaw: waterMlRaw ?? this.waterMlRaw,
      waterMlCredit: waterMlCredit ?? this.waterMlCredit,
      proteinG: proteinG ?? this.proteinG,
      creatineG: creatineG ?? this.creatineG,
      mentalState: mentalState ?? this.mentalState,
      bodyFeeling: bodyFeeling ?? this.bodyFeeling,
      bracesUsed: bracesUsed ?? this.bracesUsed,
      braceComfort: braceComfort ?? this.braceComfort,
      steps: steps ?? this.steps,
      isRestDay: isRestDay ?? this.isRestDay,
      isFlareDay: isFlareDay ?? this.isFlareDay,
      sleepHours: sleepHours ?? this.sleepHours,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      sleepHeartRateMin: sleepHeartRateMin ?? this.sleepHeartRateMin,
      restingHeartRate: restingHeartRate ?? this.restingHeartRate,
      hrvMs: hrvMs ?? this.hrvMs,
      sleepHeartRateMax: sleepHeartRateMax ?? this.sleepHeartRateMax,
    );
  }
}
