/// Standardized scales and option lists, ported 1:1 from app.py / app2.py.
/// Values (the enum's `db` string) must never change once written data exists —
/// they are what's stored in SQLite and in JSON export/import payloads.
/// Display `label`/`progressions` are localized methods (not const fields) —
/// callers must pass an [AppLocalizations] instance.
library;

import '../../l10n/app_localizations.dart';

enum MentalState {
  exhausted('😫', 1),
  low('😔', 2),
  okay('😐', 3),
  good('🙂', 4),
  energized('⚡', 5);

  const MentalState(this.emoji, this.score);

  final String emoji;
  final int score;

  String get db => name;

  String label(AppLocalizations l10n) => switch (this) {
        MentalState.exhausted => l10n.mentalStateExhausted,
        MentalState.low => l10n.mentalStateLow,
        MentalState.okay => l10n.mentalStateOkay,
        MentalState.good => l10n.mentalStateGood,
        MentalState.energized => l10n.mentalStateEnergized,
      };

  static MentalState? fromDb(String? value) =>
      value == null ? null : MentalState.values.where((e) => e.name == value).firstOrNull;
}

enum BodyFeeling {
  severe('😫', 1),
  achy('😣', 2),
  manageable('😐', 3),
  good('🙂', 4),
  looseStable('🟢', 5);

  const BodyFeeling(this.emoji, this.score);

  final String emoji;
  final int score;

  String get db => name;

  String label(AppLocalizations l10n) => switch (this) {
        BodyFeeling.severe => l10n.bodyFeelingSevere,
        BodyFeeling.achy => l10n.bodyFeelingAchy,
        BodyFeeling.manageable => l10n.bodyFeelingManageable,
        BodyFeeling.good => l10n.bodyFeelingGood,
        BodyFeeling.looseStable => l10n.bodyFeelingLooseStable,
      };

  static BodyFeeling? fromDb(String? value) =>
      value == null ? null : BodyFeeling.values.where((e) => e.name == value).firstOrNull;
}

enum SleepQuality {
  poor('😩', 1),
  restless('😕', 2),
  okay('😐', 3),
  good('🙂', 4),
  restorative('😴', 5);

  const SleepQuality(this.emoji, this.score);

  final String emoji;
  final int score;

  String get db => name;

  String label(AppLocalizations l10n) => switch (this) {
        SleepQuality.poor => l10n.sleepQualityPoor,
        SleepQuality.restless => l10n.sleepQualityRestless,
        SleepQuality.okay => l10n.sleepQualityOkay,
        SleepQuality.good => l10n.sleepQualityGood,
        SleepQuality.restorative => l10n.sleepQualityRestorative,
      };

  static SleepQuality? fromDb(String? value) =>
      value == null ? null : SleepQuality.values.where((e) => e.name == value).firstOrNull;
}

enum ContractionMode {
  concentric,
  eccentric,
  isometric,
  mixed;

  String get db => name;

  String label(AppLocalizations l10n) => switch (this) {
        ContractionMode.concentric => l10n.contractionModeConcentric,
        ContractionMode.eccentric => l10n.contractionModeEccentric,
        ContractionMode.isometric => l10n.contractionModeIsometric,
        ContractionMode.mixed => l10n.contractionModeMixed,
      };

  static ContractionMode? fromDb(String? value) =>
      value == null ? null : ContractionMode.values.where((e) => e.name == value).firstOrNull;
}

enum BraceType {
  wrist,
  knee,
  siBelt,
  ringSplints,
  ankle,
  neck;

  String get db => name;

  String label(AppLocalizations l10n) => switch (this) {
        BraceType.wrist => l10n.braceTypeWrist,
        BraceType.knee => l10n.braceTypeKnee,
        BraceType.siBelt => l10n.braceTypeSiBelt,
        BraceType.ringSplints => l10n.braceTypeRingSplints,
        BraceType.ankle => l10n.braceTypeAnkle,
        BraceType.neck => l10n.braceTypeNeck,
      };

  static BraceType? fromDb(String value) =>
      BraceType.values.where((e) => e.name == value).firstOrNull;
}

/// Net hydration credit per ml of each drink, relative to plain water (1.0).
/// Caffeine/alcohol have a mild diuretic effect; electrolyte/milk-based drinks
/// retain slightly better. Estimate for personal pacing use only — not medical guidance.
enum DrinkType {
  water(1.0),
  tea(1.0),
  coffee(0.9),
  juice(1.0),
  milk(1.2),
  sportsDrink(1.2),
  energyDrink(1.0),
  soda(1.0),
  electrolytes(1.2),
  proteinShake(1.0),
  brothSoup(1.0),
  beer(0.9),
  wine(0.8),
  liquor(0.5),
  other(1.0);

  const DrinkType(this.hydrationFactor);

  final double hydrationFactor;

  String get db => name;

  String label(AppLocalizations l10n) => switch (this) {
        DrinkType.water => l10n.drinkTypeWater,
        DrinkType.tea => l10n.drinkTypeTea,
        DrinkType.coffee => l10n.drinkTypeCoffee,
        DrinkType.juice => l10n.drinkTypeJuice,
        DrinkType.milk => l10n.drinkTypeMilk,
        DrinkType.sportsDrink => l10n.drinkTypeSportsDrink,
        DrinkType.energyDrink => l10n.drinkTypeEnergyDrink,
        DrinkType.soda => l10n.drinkTypeSoda,
        DrinkType.electrolytes => l10n.drinkTypeElectrolytes,
        DrinkType.proteinShake => l10n.drinkTypeProteinShake,
        DrinkType.brothSoup => l10n.drinkTypeBrothSoup,
        DrinkType.beer => l10n.drinkTypeBeer,
        DrinkType.wine => l10n.drinkTypeWine,
        DrinkType.liquor => l10n.drinkTypeLiquor,
        DrinkType.other => l10n.drinkTypeOther,
      };

  static DrinkType? fromDb(String? value) =>
      value == null ? null : DrinkType.values.where((e) => e.name == value).firstOrNull;
}

enum ProteinUnit {
  grams(1.0),
  scoop(30.0),
  tbsp(7.0);

  const ProteinUnit(this.gramsPerUnit);

  final double gramsPerUnit;

  String label(AppLocalizations l10n) => switch (this) {
        ProteinUnit.grams => l10n.proteinUnitGrams,
        ProteinUnit.scoop => l10n.proteinUnitScoop,
        ProteinUnit.tbsp => l10n.proteinUnitTbsp,
      };
}

enum CalisthenicsExercise {
  pushups,
  squats,
  pullups,
  legRaises,
  bridges,
  twists;

  String get db => name;

  String label(AppLocalizations l10n) => switch (this) {
        CalisthenicsExercise.pushups => l10n.calisthenicsExercisePushups,
        CalisthenicsExercise.squats => l10n.calisthenicsExerciseSquats,
        CalisthenicsExercise.pullups => l10n.calisthenicsExercisePullups,
        CalisthenicsExercise.legRaises => l10n.calisthenicsExerciseLegRaises,
        CalisthenicsExercise.bridges => l10n.calisthenicsExerciseBridges,
        CalisthenicsExercise.twists => l10n.calisthenicsExerciseTwists,
      };

  static CalisthenicsExercise? fromDb(String? value) =>
      value == null ? null : CalisthenicsExercise.values.where((e) => e.name == value).firstOrNull;
}

enum SorenessOnset {
  sameDay,
  oneDayAfter,
  twoToThreeDaysAfter,
  notTiedOrUnsure;

  String get db => name;

  String label(AppLocalizations l10n) => switch (this) {
        SorenessOnset.sameDay => l10n.sorenessOnsetSameDay,
        SorenessOnset.oneDayAfter => l10n.sorenessOnsetOneDayAfter,
        SorenessOnset.twoToThreeDaysAfter => l10n.sorenessOnsetTwoToThreeDaysAfter,
        SorenessOnset.notTiedOrUnsure => l10n.sorenessOnsetNotTiedOrUnsure,
      };
}

enum SorenessSpread {
  localized,
  widespread;

  String get db => name;

  String label(AppLocalizations l10n) => switch (this) {
        SorenessSpread.localized => l10n.sorenessSpreadLocalized,
        SorenessSpread.widespread => l10n.sorenessSpreadWidespread,
      };
}

enum SorenessTrend {
  easing,
  same,
  worse;

  String get db => name;

  String label(AppLocalizations l10n) => switch (this) {
        SorenessTrend.easing => l10n.sorenessTrendEasing,
        SorenessTrend.same => l10n.sorenessTrendSame,
        SorenessTrend.worse => l10n.sorenessTrendWorse,
      };
}

/// Zone/kind/type vocabulary deliberately mirrors ZebraUp's structuralHistory
/// field (exact snake_case wire values, ported from app2.py's
/// INJURY_ZONES/INJURY_KINDS/INJURY_TYPES) so the two apps speak the same
/// language, even without syncing data.
enum InjuryZone {
  ankles('ankles'),
  knees('knees'),
  calf('calf'),
  frontThigh('front_thigh'),
  backThigh('back_thigh'),
  side('side'),
  upperBack('upper_back'),
  lowerBack('lower_back'),
  shoulder('shoulder'),
  wrist('wrist'),
  hand('hand'),
  elbow('elbow'),
  hip('hip'),
  neck('neck'),
  foot('foot'),
  other('other');

  const InjuryZone(this.db);

  final String db;

  String label(AppLocalizations l10n) => switch (this) {
        InjuryZone.ankles => l10n.injuryZoneAnkles,
        InjuryZone.knees => l10n.injuryZoneKnees,
        InjuryZone.calf => l10n.injuryZoneCalf,
        InjuryZone.frontThigh => l10n.injuryZoneFrontThigh,
        InjuryZone.backThigh => l10n.injuryZoneBackThigh,
        InjuryZone.side => l10n.injuryZoneSide,
        InjuryZone.upperBack => l10n.injuryZoneUpperBack,
        InjuryZone.lowerBack => l10n.injuryZoneLowerBack,
        InjuryZone.shoulder => l10n.injuryZoneShoulder,
        InjuryZone.wrist => l10n.injuryZoneWrist,
        InjuryZone.hand => l10n.injuryZoneHand,
        InjuryZone.elbow => l10n.injuryZoneElbow,
        InjuryZone.hip => l10n.injuryZoneHip,
        InjuryZone.neck => l10n.injuryZoneNeck,
        InjuryZone.foot => l10n.injuryZoneFoot,
        InjuryZone.other => l10n.injuryZoneOther,
      };

  static InjuryZone fromDb(String value) => InjuryZone.values.firstWhere((e) => e.db == value);
}

enum InjuryKind {
  joint('joint'),
  ligament('ligament'),
  muscle('muscle'),
  painWithoutClearCause('painWithoutClearCause');

  const InjuryKind(this.db);

  final String db;

  String label(AppLocalizations l10n) => switch (this) {
        InjuryKind.joint => l10n.injuryKindJoint,
        InjuryKind.ligament => l10n.injuryKindLigament,
        InjuryKind.muscle => l10n.injuryKindMuscle,
        InjuryKind.painWithoutClearCause => l10n.injuryKindPainWithoutClearCause,
      };

  static InjuryKind fromDb(String value) => InjuryKind.values.firstWhere((e) => e.db == value);
}

enum InjuryType {
  subluxation,
  jointInstability,
  jointPain,
  ligamentSprain,
  muscleStrain,
  musclePainGeneral,
  contracture,
  knownConditionFlare,
  unclearStructuralCause;

  static const _dbValues = {
    InjuryType.subluxation: 'subluxation',
    InjuryType.jointInstability: 'joint_instability',
    InjuryType.jointPain: 'joint_pain',
    InjuryType.ligamentSprain: 'ligament_sprain',
    InjuryType.muscleStrain: 'muscle_strain',
    InjuryType.musclePainGeneral: 'muscle_pain_general',
    InjuryType.contracture: 'contracture',
    InjuryType.knownConditionFlare: 'known_condition_flare',
    InjuryType.unclearStructuralCause: 'unclear_structural_cause',
  };

  String get db => _dbValues[this]!;

  String label(AppLocalizations l10n) => switch (this) {
        InjuryType.subluxation => l10n.injuryTypeSubluxation,
        InjuryType.jointInstability => l10n.injuryTypeJointInstability,
        InjuryType.jointPain => l10n.injuryTypeJointPain,
        InjuryType.ligamentSprain => l10n.injuryTypeLigamentSprain,
        InjuryType.muscleStrain => l10n.injuryTypeMuscleStrain,
        InjuryType.musclePainGeneral => l10n.injuryTypeMusclePainGeneral,
        InjuryType.contracture => l10n.injuryTypeContracture,
        InjuryType.knownConditionFlare => l10n.injuryTypeKnownConditionFlare,
        InjuryType.unclearStructuralCause => l10n.injuryTypeUnclearStructuralCause,
      };

  static InjuryType fromDb(String value) =>
      InjuryType.values.firstWhere((e) => e.db == value);
}

enum ComparedToUsual {
  worse,
  aboutTheSame,
  better;

  String get db => name;

  String label(AppLocalizations l10n) => switch (this) {
        ComparedToUsual.worse => l10n.comparedToUsualWorse,
        ComparedToUsual.aboutTheSame => l10n.comparedToUsualAboutTheSame,
        ComparedToUsual.better => l10n.comparedToUsualBetter,
      };

  static ComparedToUsual? fromDb(String? value) =>
      value == null ? null : ComparedToUsual.values.where((e) => e.name == value).firstOrNull;
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
