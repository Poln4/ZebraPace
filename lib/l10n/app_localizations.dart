import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('zh'),
    Locale('zh', 'TW'),
  ];

  /// App name, shown in the OS task switcher / window title.
  ///
  /// In en, this message translates to:
  /// **'ZebraPace'**
  String get appTitle;

  /// No description provided for @mentalStateExhausted.
  ///
  /// In en, this message translates to:
  /// **'Exhausted/Brain Fog'**
  String get mentalStateExhausted;

  /// No description provided for @mentalStateLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get mentalStateLow;

  /// No description provided for @mentalStateOkay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get mentalStateOkay;

  /// No description provided for @mentalStateGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get mentalStateGood;

  /// No description provided for @mentalStateEnergized.
  ///
  /// In en, this message translates to:
  /// **'Energized'**
  String get mentalStateEnergized;

  /// No description provided for @bodyFeelingSevere.
  ///
  /// In en, this message translates to:
  /// **'Severe Pain/Stiff'**
  String get bodyFeelingSevere;

  /// No description provided for @bodyFeelingAchy.
  ///
  /// In en, this message translates to:
  /// **'Achy'**
  String get bodyFeelingAchy;

  /// No description provided for @bodyFeelingManageable.
  ///
  /// In en, this message translates to:
  /// **'Manageable'**
  String get bodyFeelingManageable;

  /// No description provided for @bodyFeelingGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get bodyFeelingGood;

  /// No description provided for @bodyFeelingLooseStable.
  ///
  /// In en, this message translates to:
  /// **'Loose & Stable'**
  String get bodyFeelingLooseStable;

  /// No description provided for @contractionModeConcentric.
  ///
  /// In en, this message translates to:
  /// **'Concentric (lifting/pushing up)'**
  String get contractionModeConcentric;

  /// No description provided for @contractionModeEccentric.
  ///
  /// In en, this message translates to:
  /// **'Eccentric (lowering, controlled)'**
  String get contractionModeEccentric;

  /// No description provided for @contractionModeIsometric.
  ///
  /// In en, this message translates to:
  /// **'Isometric (held position)'**
  String get contractionModeIsometric;

  /// No description provided for @contractionModeMixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed / not sure'**
  String get contractionModeMixed;

  /// No description provided for @braceTypeWrist.
  ///
  /// In en, this message translates to:
  /// **'Wrist'**
  String get braceTypeWrist;

  /// No description provided for @braceTypeKnee.
  ///
  /// In en, this message translates to:
  /// **'Knee'**
  String get braceTypeKnee;

  /// No description provided for @braceTypeSiBelt.
  ///
  /// In en, this message translates to:
  /// **'SI Belt'**
  String get braceTypeSiBelt;

  /// No description provided for @braceTypeRingSplints.
  ///
  /// In en, this message translates to:
  /// **'Ring Splints'**
  String get braceTypeRingSplints;

  /// No description provided for @braceTypeAnkle.
  ///
  /// In en, this message translates to:
  /// **'Ankle'**
  String get braceTypeAnkle;

  /// No description provided for @braceTypeNeck.
  ///
  /// In en, this message translates to:
  /// **'Neck'**
  String get braceTypeNeck;

  /// No description provided for @drinkTypeWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get drinkTypeWater;

  /// No description provided for @drinkTypeTea.
  ///
  /// In en, this message translates to:
  /// **'Tea'**
  String get drinkTypeTea;

  /// No description provided for @drinkTypeCoffee.
  ///
  /// In en, this message translates to:
  /// **'Coffee'**
  String get drinkTypeCoffee;

  /// No description provided for @drinkTypeJuice.
  ///
  /// In en, this message translates to:
  /// **'Juice'**
  String get drinkTypeJuice;

  /// No description provided for @drinkTypeMilk.
  ///
  /// In en, this message translates to:
  /// **'Milk'**
  String get drinkTypeMilk;

  /// No description provided for @drinkTypeSportsDrink.
  ///
  /// In en, this message translates to:
  /// **'Sports Drink'**
  String get drinkTypeSportsDrink;

  /// No description provided for @drinkTypeEnergyDrink.
  ///
  /// In en, this message translates to:
  /// **'Energy Drink'**
  String get drinkTypeEnergyDrink;

  /// No description provided for @drinkTypeSoda.
  ///
  /// In en, this message translates to:
  /// **'Soda'**
  String get drinkTypeSoda;

  /// No description provided for @drinkTypeElectrolytes.
  ///
  /// In en, this message translates to:
  /// **'Electrolytes'**
  String get drinkTypeElectrolytes;

  /// No description provided for @drinkTypeProteinShake.
  ///
  /// In en, this message translates to:
  /// **'Protein Shake'**
  String get drinkTypeProteinShake;

  /// No description provided for @drinkTypeBrothSoup.
  ///
  /// In en, this message translates to:
  /// **'Broth/Soup'**
  String get drinkTypeBrothSoup;

  /// No description provided for @drinkTypeBeer.
  ///
  /// In en, this message translates to:
  /// **'Beer'**
  String get drinkTypeBeer;

  /// No description provided for @drinkTypeWine.
  ///
  /// In en, this message translates to:
  /// **'Wine'**
  String get drinkTypeWine;

  /// No description provided for @drinkTypeLiquor.
  ///
  /// In en, this message translates to:
  /// **'Liquor'**
  String get drinkTypeLiquor;

  /// No description provided for @drinkTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other (Type below)'**
  String get drinkTypeOther;

  /// No description provided for @proteinUnitGrams.
  ///
  /// In en, this message translates to:
  /// **'g'**
  String get proteinUnitGrams;

  /// No description provided for @proteinUnitScoop.
  ///
  /// In en, this message translates to:
  /// **'scoop (~30g)'**
  String get proteinUnitScoop;

  /// No description provided for @proteinUnitTbsp.
  ///
  /// In en, this message translates to:
  /// **'tbsp (~7g)'**
  String get proteinUnitTbsp;

  /// No description provided for @calisthenicsExercisePushups.
  ///
  /// In en, this message translates to:
  /// **'Pushups'**
  String get calisthenicsExercisePushups;

  /// No description provided for @calisthenicsExerciseSquats.
  ///
  /// In en, this message translates to:
  /// **'Squats'**
  String get calisthenicsExerciseSquats;

  /// No description provided for @calisthenicsExercisePullups.
  ///
  /// In en, this message translates to:
  /// **'Pullups'**
  String get calisthenicsExercisePullups;

  /// No description provided for @calisthenicsExerciseLegRaises.
  ///
  /// In en, this message translates to:
  /// **'Leg Raises'**
  String get calisthenicsExerciseLegRaises;

  /// No description provided for @calisthenicsExerciseBridges.
  ///
  /// In en, this message translates to:
  /// **'Bridges'**
  String get calisthenicsExerciseBridges;

  /// No description provided for @calisthenicsExerciseTwists.
  ///
  /// In en, this message translates to:
  /// **'Twists'**
  String get calisthenicsExerciseTwists;

  /// No description provided for @calisthenicsPushupsWall.
  ///
  /// In en, this message translates to:
  /// **'Wall Pushups (~35% BW)'**
  String get calisthenicsPushupsWall;

  /// No description provided for @calisthenicsPushupsIncline.
  ///
  /// In en, this message translates to:
  /// **'Incline Pushups (~50% BW)'**
  String get calisthenicsPushupsIncline;

  /// No description provided for @calisthenicsPushupsKnee.
  ///
  /// In en, this message translates to:
  /// **'Knee Pushups (~60% BW)'**
  String get calisthenicsPushupsKnee;

  /// No description provided for @calisthenicsPushupsFull.
  ///
  /// In en, this message translates to:
  /// **'Full Pushups (~70% BW)'**
  String get calisthenicsPushupsFull;

  /// No description provided for @calisthenicsSquatsJackknife.
  ///
  /// In en, this message translates to:
  /// **'Jackknife Squats'**
  String get calisthenicsSquatsJackknife;

  /// No description provided for @calisthenicsSquatsAssisted.
  ///
  /// In en, this message translates to:
  /// **'Assisted Squats'**
  String get calisthenicsSquatsAssisted;

  /// No description provided for @calisthenicsSquatsHalf.
  ///
  /// In en, this message translates to:
  /// **'Half Squats'**
  String get calisthenicsSquatsHalf;

  /// No description provided for @calisthenicsSquatsFull.
  ///
  /// In en, this message translates to:
  /// **'Full Squats'**
  String get calisthenicsSquatsFull;

  /// No description provided for @calisthenicsTier1.
  ///
  /// In en, this message translates to:
  /// **'Tier 1'**
  String get calisthenicsTier1;

  /// No description provided for @calisthenicsTier2.
  ///
  /// In en, this message translates to:
  /// **'Tier 2'**
  String get calisthenicsTier2;

  /// No description provided for @calisthenicsTier3.
  ///
  /// In en, this message translates to:
  /// **'Tier 3'**
  String get calisthenicsTier3;

  /// No description provided for @sorenessOnsetSameDay.
  ///
  /// In en, this message translates to:
  /// **'Same day'**
  String get sorenessOnsetSameDay;

  /// No description provided for @sorenessOnsetOneDayAfter.
  ///
  /// In en, this message translates to:
  /// **'1 day after'**
  String get sorenessOnsetOneDayAfter;

  /// No description provided for @sorenessOnsetTwoToThreeDaysAfter.
  ///
  /// In en, this message translates to:
  /// **'2-3 days after'**
  String get sorenessOnsetTwoToThreeDaysAfter;

  /// No description provided for @sorenessOnsetNotTiedOrUnsure.
  ///
  /// In en, this message translates to:
  /// **'Not tied to activity / not sure'**
  String get sorenessOnsetNotTiedOrUnsure;

  /// No description provided for @sorenessSpreadLocalized.
  ///
  /// In en, this message translates to:
  /// **'Localized to muscles worked'**
  String get sorenessSpreadLocalized;

  /// No description provided for @sorenessSpreadWidespread.
  ///
  /// In en, this message translates to:
  /// **'Widespread / systemic'**
  String get sorenessSpreadWidespread;

  /// No description provided for @sorenessTrendEasing.
  ///
  /// In en, this message translates to:
  /// **'Easing'**
  String get sorenessTrendEasing;

  /// No description provided for @sorenessTrendSame.
  ///
  /// In en, this message translates to:
  /// **'About the same'**
  String get sorenessTrendSame;

  /// No description provided for @sorenessTrendWorse.
  ///
  /// In en, this message translates to:
  /// **'Getting worse'**
  String get sorenessTrendWorse;

  /// No description provided for @injuryZoneAnkles.
  ///
  /// In en, this message translates to:
  /// **'Ankles'**
  String get injuryZoneAnkles;

  /// No description provided for @injuryZoneKnees.
  ///
  /// In en, this message translates to:
  /// **'Knees'**
  String get injuryZoneKnees;

  /// No description provided for @injuryZoneCalf.
  ///
  /// In en, this message translates to:
  /// **'Calf'**
  String get injuryZoneCalf;

  /// No description provided for @injuryZoneFrontThigh.
  ///
  /// In en, this message translates to:
  /// **'Front Thigh'**
  String get injuryZoneFrontThigh;

  /// No description provided for @injuryZoneBackThigh.
  ///
  /// In en, this message translates to:
  /// **'Back Thigh'**
  String get injuryZoneBackThigh;

  /// No description provided for @injuryZoneSide.
  ///
  /// In en, this message translates to:
  /// **'Side'**
  String get injuryZoneSide;

  /// No description provided for @injuryZoneUpperBack.
  ///
  /// In en, this message translates to:
  /// **'Upper Back'**
  String get injuryZoneUpperBack;

  /// No description provided for @injuryZoneLowerBack.
  ///
  /// In en, this message translates to:
  /// **'Lower Back'**
  String get injuryZoneLowerBack;

  /// No description provided for @injuryZoneShoulder.
  ///
  /// In en, this message translates to:
  /// **'Shoulder'**
  String get injuryZoneShoulder;

  /// No description provided for @injuryZoneWrist.
  ///
  /// In en, this message translates to:
  /// **'Wrist'**
  String get injuryZoneWrist;

  /// No description provided for @injuryZoneHand.
  ///
  /// In en, this message translates to:
  /// **'Hand'**
  String get injuryZoneHand;

  /// No description provided for @injuryZoneElbow.
  ///
  /// In en, this message translates to:
  /// **'Elbow'**
  String get injuryZoneElbow;

  /// No description provided for @injuryZoneHip.
  ///
  /// In en, this message translates to:
  /// **'Hip'**
  String get injuryZoneHip;

  /// No description provided for @injuryZoneNeck.
  ///
  /// In en, this message translates to:
  /// **'Neck'**
  String get injuryZoneNeck;

  /// No description provided for @injuryZoneFoot.
  ///
  /// In en, this message translates to:
  /// **'Foot'**
  String get injuryZoneFoot;

  /// No description provided for @injuryZoneOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get injuryZoneOther;

  /// No description provided for @injuryKindJoint.
  ///
  /// In en, this message translates to:
  /// **'Joint'**
  String get injuryKindJoint;

  /// No description provided for @injuryKindLigament.
  ///
  /// In en, this message translates to:
  /// **'Ligament'**
  String get injuryKindLigament;

  /// No description provided for @injuryKindMuscle.
  ///
  /// In en, this message translates to:
  /// **'Muscle'**
  String get injuryKindMuscle;

  /// No description provided for @injuryKindPainWithoutClearCause.
  ///
  /// In en, this message translates to:
  /// **'Pain Without Clear Structural Cause'**
  String get injuryKindPainWithoutClearCause;

  /// No description provided for @injuryTypeSubluxation.
  ///
  /// In en, this message translates to:
  /// **'Subluxation'**
  String get injuryTypeSubluxation;

  /// No description provided for @injuryTypeJointInstability.
  ///
  /// In en, this message translates to:
  /// **'Joint Instability'**
  String get injuryTypeJointInstability;

  /// No description provided for @injuryTypeJointPain.
  ///
  /// In en, this message translates to:
  /// **'Joint Pain'**
  String get injuryTypeJointPain;

  /// No description provided for @injuryTypeLigamentSprain.
  ///
  /// In en, this message translates to:
  /// **'Ligament Sprain'**
  String get injuryTypeLigamentSprain;

  /// No description provided for @injuryTypeMuscleStrain.
  ///
  /// In en, this message translates to:
  /// **'Muscle Strain'**
  String get injuryTypeMuscleStrain;

  /// No description provided for @injuryTypeMusclePainGeneral.
  ///
  /// In en, this message translates to:
  /// **'General Muscle Pain'**
  String get injuryTypeMusclePainGeneral;

  /// No description provided for @injuryTypeContracture.
  ///
  /// In en, this message translates to:
  /// **'Contracture'**
  String get injuryTypeContracture;

  /// No description provided for @injuryTypeKnownConditionFlare.
  ///
  /// In en, this message translates to:
  /// **'Known Condition Flare-Up'**
  String get injuryTypeKnownConditionFlare;

  /// No description provided for @injuryTypeUnclearStructuralCause.
  ///
  /// In en, this message translates to:
  /// **'Unclear Structural Cause'**
  String get injuryTypeUnclearStructuralCause;

  /// No description provided for @comparedToUsualWorse.
  ///
  /// In en, this message translates to:
  /// **'Worse'**
  String get comparedToUsualWorse;

  /// No description provided for @comparedToUsualAboutTheSame.
  ///
  /// In en, this message translates to:
  /// **'About the same'**
  String get comparedToUsualAboutTheSame;

  /// No description provided for @comparedToUsualBetter.
  ///
  /// In en, this message translates to:
  /// **'Better'**
  String get comparedToUsualBetter;

  /// No description provided for @comfortLabelBrilliant.
  ///
  /// In en, this message translates to:
  /// **'🤩 Brilliant/Stable'**
  String get comfortLabelBrilliant;

  /// No description provided for @comfortLabelComfortable.
  ///
  /// In en, this message translates to:
  /// **'🙂 Comfortable/Good'**
  String get comfortLabelComfortable;

  /// No description provided for @comfortLabelOkay.
  ///
  /// In en, this message translates to:
  /// **'😐 Okay/Stiff'**
  String get comfortLabelOkay;

  /// No description provided for @comfortLabelAchy.
  ///
  /// In en, this message translates to:
  /// **'🙁 Achy/Struggled'**
  String get comfortLabelAchy;

  /// No description provided for @comfortLabelPainful.
  ///
  /// In en, this message translates to:
  /// **'😣 Painful/Unstable'**
  String get comfortLabelPainful;

  /// No description provided for @calisthenicsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'🤸 Hybrid Calisthenics'**
  String get calisthenicsSectionTitle;

  /// No description provided for @calisthenicsSectionExerciseLabel.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get calisthenicsSectionExerciseLabel;

  /// No description provided for @calisthenicsSectionProgressionTierLabel.
  ///
  /// In en, this message translates to:
  /// **'Progression tier'**
  String get calisthenicsSectionProgressionTierLabel;

  /// No description provided for @calisthenicsSectionSetsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get calisthenicsSectionSetsPlaceholder;

  /// No description provided for @calisthenicsSectionRepsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Reps'**
  String get calisthenicsSectionRepsPlaceholder;

  /// No description provided for @calisthenicsSectionContractionModeLabel.
  ///
  /// In en, this message translates to:
  /// **'Contraction mode'**
  String get calisthenicsSectionContractionModeLabel;

  /// No description provided for @calisthenicsSectionComfortLabel.
  ///
  /// In en, this message translates to:
  /// **'Comfort: {value} — {label}'**
  String calisthenicsSectionComfortLabel(String value, String label);

  /// No description provided for @calisthenicsSectionMentalStateLabel.
  ///
  /// In en, this message translates to:
  /// **'Mental State'**
  String get calisthenicsSectionMentalStateLabel;

  /// No description provided for @calisthenicsSectionBodyFeelingLabel.
  ///
  /// In en, this message translates to:
  /// **'Body Feeling'**
  String get calisthenicsSectionBodyFeelingLabel;

  /// No description provided for @calisthenicsSectionLogButton.
  ///
  /// In en, this message translates to:
  /// **'Log Calisthenics'**
  String get calisthenicsSectionLogButton;

  /// No description provided for @calisthenicsSectionMilestoneCelebration.
  ///
  /// In en, this message translates to:
  /// **'🎈 3 comfortable sessions in a row for {exercise} — you could try the next tier when you\'re ready.'**
  String calisthenicsSectionMilestoneCelebration(String exercise);

  /// No description provided for @commonMentalStateLabel.
  ///
  /// In en, this message translates to:
  /// **'Mental State'**
  String get commonMentalStateLabel;

  /// No description provided for @commonBodyFeelingLabel.
  ///
  /// In en, this message translates to:
  /// **'Body Feeling'**
  String get commonBodyFeelingLabel;

  /// No description provided for @commonDurationMinPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Duration (min)'**
  String get commonDurationMinPlaceholder;

  /// No description provided for @activitiesSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'🚴‍♀️ Custom Activities'**
  String get activitiesSectionTitle;

  /// No description provided for @activitiesSectionNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Activity name'**
  String get activitiesSectionNamePlaceholder;

  /// No description provided for @activitiesSectionWeightPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Extra weight (kg)'**
  String get activitiesSectionWeightPlaceholder;

  /// No description provided for @activitiesSectionLogButton.
  ///
  /// In en, this message translates to:
  /// **'Log Activity'**
  String get activitiesSectionLogButton;

  /// No description provided for @activitiesSectionListItem.
  ///
  /// In en, this message translates to:
  /// **'{name} — {duration} min'**
  String activitiesSectionListItem(String name, int duration);

  /// No description provided for @injuriesSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'🩹 Injuries & Structural Events'**
  String get injuriesSectionTitle;

  /// No description provided for @injuriesSectionCaption.
  ///
  /// In en, this message translates to:
  /// **'For discrete, dateable injuries — separate from Flare Days, which are systemic.'**
  String get injuriesSectionCaption;

  /// No description provided for @injuriesSectionZoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Zone'**
  String get injuriesSectionZoneLabel;

  /// No description provided for @injuriesSectionKindLabel.
  ///
  /// In en, this message translates to:
  /// **'Kind'**
  String get injuriesSectionKindLabel;

  /// No description provided for @injuriesSectionTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get injuriesSectionTypeLabel;

  /// No description provided for @injuriesSectionNotePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'What happened, how it\'s limiting you'**
  String get injuriesSectionNotePlaceholder;

  /// No description provided for @injuriesSectionLogButton.
  ///
  /// In en, this message translates to:
  /// **'➕ Log this injury'**
  String get injuriesSectionLogButton;

  /// No description provided for @injuriesSectionActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get injuriesSectionActiveLabel;

  /// No description provided for @injuriesSectionActiveTitle.
  ///
  /// In en, this message translates to:
  /// **'{zone} — {kind} / {type}'**
  String injuriesSectionActiveTitle(String zone, String kind, String type);

  /// No description provided for @injuriesSectionStarted.
  ///
  /// In en, this message translates to:
  /// **'Started {date}'**
  String injuriesSectionStarted(String date);

  /// No description provided for @injuriesSectionStillPainful.
  ///
  /// In en, this message translates to:
  /// **'Still painful'**
  String get injuriesSectionStillPainful;

  /// No description provided for @injuriesSectionMarkResolved.
  ///
  /// In en, this message translates to:
  /// **'✅ Mark resolved'**
  String get injuriesSectionMarkResolved;

  /// No description provided for @injuriesSectionUpdate.
  ///
  /// In en, this message translates to:
  /// **'💾 Update'**
  String get injuriesSectionUpdate;

  /// No description provided for @therapiesSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'💆‍♀️ Recovery & Passive Therapies'**
  String get therapiesSectionTitle;

  /// No description provided for @therapiesSectionNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Therapy name'**
  String get therapiesSectionNamePlaceholder;

  /// No description provided for @therapiesSectionLogButton.
  ///
  /// In en, this message translates to:
  /// **'Log Therapy'**
  String get therapiesSectionLogButton;

  /// No description provided for @therapiesSectionListItem.
  ///
  /// In en, this message translates to:
  /// **'{name} — {duration} min'**
  String therapiesSectionListItem(String name, int duration);

  /// No description provided for @commonSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSaveButton;

  /// No description provided for @hydrationSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'☕ Hydration & Liquids'**
  String get hydrationSectionTitle;

  /// No description provided for @hydrationSectionProgress.
  ///
  /// In en, this message translates to:
  /// **'{credit} / {goal} ml'**
  String hydrationSectionProgress(int credit, int goal);

  /// No description provided for @hydrationSectionCustomLabelPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'What is it?'**
  String get hydrationSectionCustomLabelPlaceholder;

  /// No description provided for @hydrationSectionAmountPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Amount (ml)'**
  String get hydrationSectionAmountPlaceholder;

  /// No description provided for @hydrationSectionAddDrinkButton.
  ///
  /// In en, this message translates to:
  /// **'➕ Add drink'**
  String get hydrationSectionAddDrinkButton;

  /// No description provided for @hydrationSectionLogItem.
  ///
  /// In en, this message translates to:
  /// **'{name}: {amount} ml'**
  String hydrationSectionLogItem(String name, int amount);

  /// No description provided for @hydrationSectionResetButton.
  ///
  /// In en, this message translates to:
  /// **'Reset Today\'s Liquids'**
  String get hydrationSectionResetButton;

  /// No description provided for @nutritionSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'🥩 Nutrition & Supplements'**
  String get nutritionSectionTitle;

  /// No description provided for @nutritionSectionProteinProgress.
  ///
  /// In en, this message translates to:
  /// **'{protein}g / {goal}g protein'**
  String nutritionSectionProteinProgress(int protein, int goal);

  /// No description provided for @nutritionSectionCreatineToday.
  ///
  /// In en, this message translates to:
  /// **'Creatine today: {amount}g'**
  String nutritionSectionCreatineToday(String amount);

  /// No description provided for @nutritionSectionAmountPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get nutritionSectionAmountPlaceholder;

  /// No description provided for @nutritionSectionAddProteinButton.
  ///
  /// In en, this message translates to:
  /// **'Add protein'**
  String get nutritionSectionAddProteinButton;

  /// No description provided for @nutritionSectionSetTotalButton.
  ///
  /// In en, this message translates to:
  /// **'Set protein total'**
  String get nutritionSectionSetTotalButton;

  /// No description provided for @nutritionSectionSetTotalDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Set today\'s protein total (g)'**
  String get nutritionSectionSetTotalDialogTitle;

  /// No description provided for @nutritionSectionSetCreatineTotalButton.
  ///
  /// In en, this message translates to:
  /// **'Set creatine total'**
  String get nutritionSectionSetCreatineTotalButton;

  /// No description provided for @nutritionSectionSetCreatineTotalDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Set today\'s creatine total (g)'**
  String get nutritionSectionSetCreatineTotalDialogTitle;

  /// No description provided for @nutritionSectionAddCreatineButton.
  ///
  /// In en, this message translates to:
  /// **'+5g Creatine'**
  String get nutritionSectionAddCreatineButton;

  /// No description provided for @nutritionSectionResetButton.
  ///
  /// In en, this message translates to:
  /// **'Reset Nutrition'**
  String get nutritionSectionResetButton;

  /// No description provided for @mindBodyFormTitle.
  ///
  /// In en, this message translates to:
  /// **'🧠 Mind & Body'**
  String get mindBodyFormTitle;

  /// No description provided for @mindBodyFormCaption.
  ///
  /// In en, this message translates to:
  /// **'This is today\'s one official summary — it\'s what your baselines, trends, and PEM check are built on.'**
  String get mindBodyFormCaption;

  /// No description provided for @mindBodyFormBodyPainFeelingLabel.
  ///
  /// In en, this message translates to:
  /// **'Body / Pain Feeling'**
  String get mindBodyFormBodyPainFeelingLabel;

  /// No description provided for @mindBodyFormBracesUsedLabel.
  ///
  /// In en, this message translates to:
  /// **'Braces used today'**
  String get mindBodyFormBracesUsedLabel;

  /// No description provided for @mindBodyFormBraceComfort.
  ///
  /// In en, this message translates to:
  /// **'Brace comfort: {value}/10'**
  String mindBodyFormBraceComfort(int value);

  /// No description provided for @quickCheckinSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'📈 How are you feeling right now?'**
  String get quickCheckinSectionTitle;

  /// No description provided for @quickCheckinSectionCaption.
  ///
  /// In en, this message translates to:
  /// **'Log as many as you want through the day — they don\'t replace the summary above.'**
  String get quickCheckinSectionCaption;

  /// No description provided for @quickCheckinSectionMentalStateLabel.
  ///
  /// In en, this message translates to:
  /// **'Mental State right now'**
  String get quickCheckinSectionMentalStateLabel;

  /// No description provided for @quickCheckinSectionBodyPainLabel.
  ///
  /// In en, this message translates to:
  /// **'Body/Pain right now'**
  String get quickCheckinSectionBodyPainLabel;

  /// No description provided for @quickCheckinSectionNotePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Optional note — e.g. after lunch, mid-errand'**
  String get quickCheckinSectionNotePlaceholder;

  /// No description provided for @quickCheckinSectionLogButton.
  ///
  /// In en, this message translates to:
  /// **'➕ Log this moment'**
  String get quickCheckinSectionLogButton;

  /// No description provided for @quickCheckinSectionEmpty.
  ///
  /// In en, this message translates to:
  /// **'No check-ins logged yet today.'**
  String get quickCheckinSectionEmpty;

  /// No description provided for @sorenessCheckSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'🔍 Soreness or Crash? A quick check'**
  String get sorenessCheckSectionTitle;

  /// No description provided for @sorenessCheckSectionCaption.
  ///
  /// In en, this message translates to:
  /// **'Three quick questions to tell ordinary post-exercise soreness apart from a PEM pattern.'**
  String get sorenessCheckSectionCaption;

  /// No description provided for @sorenessCheckSectionOnsetLabel.
  ///
  /// In en, this message translates to:
  /// **'When did it start?'**
  String get sorenessCheckSectionOnsetLabel;

  /// No description provided for @sorenessCheckSectionSpreadLabel.
  ///
  /// In en, this message translates to:
  /// **'Where do you feel it?'**
  String get sorenessCheckSectionSpreadLabel;

  /// No description provided for @sorenessCheckSectionTrendLabel.
  ///
  /// In en, this message translates to:
  /// **'How is it trending?'**
  String get sorenessCheckSectionTrendLabel;

  /// No description provided for @sorenessCheckSectionCheckButton.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get sorenessCheckSectionCheckButton;

  /// No description provided for @sorenessVerdictCrashLabel.
  ///
  /// In en, this message translates to:
  /// **'🌩️ More consistent with a crash/PEM pattern'**
  String get sorenessVerdictCrashLabel;

  /// No description provided for @sorenessVerdictCrashMessage.
  ///
  /// In en, this message translates to:
  /// **'Widespread or worsening symptoms — rather than easing, localized muscle soreness — line up more with post-exertional malaise than ordinary exercise soreness. Consider treating today (and maybe tomorrow) as a Rest or Flare Day, and it\'s worth mentioning this pattern to your care team if it keeps happening.'**
  String get sorenessVerdictCrashMessage;

  /// No description provided for @sorenessVerdictDomsLabel.
  ///
  /// In en, this message translates to:
  /// **'💪 Sounds like ordinary post-exercise soreness (DOMS)'**
  String get sorenessVerdictDomsLabel;

  /// No description provided for @sorenessVerdictDomsMessage.
  ///
  /// In en, this message translates to:
  /// **'Localized soreness that peaks a day or two after effort and then eases is the typical pattern for delayed-onset muscle soreness — especially after eccentric (lowering/controlled) work. It\'s not usually a signal to worry, and it tends to lessen further with repeated, gentle exposure (the \'repeated bout effect\').'**
  String get sorenessVerdictDomsMessage;

  /// No description provided for @sorenessVerdictUnclearLabel.
  ///
  /// In en, this message translates to:
  /// **'🤔 No clear pattern yet'**
  String get sorenessVerdictUnclearLabel;

  /// No description provided for @sorenessVerdictUnclearMessage.
  ///
  /// In en, this message translates to:
  /// **'Not enough of a clear signal either way from these answers. Worth logging again tomorrow, and mentioning to your care team if this keeps recurring or feels different from your usual soreness.'**
  String get sorenessVerdictUnclearMessage;

  /// No description provided for @calisthenicsComfortChartEmpty.
  ///
  /// In en, this message translates to:
  /// **'No calisthenics logged in range.'**
  String get calisthenicsComfortChartEmpty;

  /// No description provided for @calisthenicsComfortChartUnspecified.
  ///
  /// In en, this message translates to:
  /// **'Unspecified'**
  String get calisthenicsComfortChartUnspecified;

  /// No description provided for @exportSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'📤 Export'**
  String get exportSectionTitle;

  /// No description provided for @exportSectionPdfButton.
  ///
  /// In en, this message translates to:
  /// **'🩺 Doctor Visit Report (PDF)'**
  String get exportSectionPdfButton;

  /// No description provided for @exportSectionCsvButton.
  ///
  /// In en, this message translates to:
  /// **'Download Vitals CSV (full history)'**
  String get exportSectionCsvButton;

  /// No description provided for @doctorReportNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'n/a'**
  String get doctorReportNotAvailable;

  /// No description provided for @doctorReportHeading.
  ///
  /// In en, this message translates to:
  /// **'ZebraPace - Pacing Summary'**
  String get doctorReportHeading;

  /// No description provided for @doctorReportRangeLine.
  ///
  /// In en, this message translates to:
  /// **'Range: {start} to {end}  |  Generated: {generated}'**
  String doctorReportRangeLine(String start, String end, String generated);

  /// No description provided for @doctorReportDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Patient-reported pacing data (PRO/EMA style). Not a diagnostic tool; intended to support, not replace, clinical judgment.'**
  String get doctorReportDisclaimer;

  /// No description provided for @doctorReportOverviewHeading.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get doctorReportOverviewHeading;

  /// No description provided for @doctorReportMovementHeading.
  ///
  /// In en, this message translates to:
  /// **'Movement & Recovery'**
  String get doctorReportMovementHeading;

  /// No description provided for @doctorReportMovementSummary.
  ///
  /// In en, this message translates to:
  /// **'Custom activities logged: {activityCount}   |   Passive therapy sessions: {therapyCount}'**
  String doctorReportMovementSummary(int activityCount, int therapyCount);

  /// No description provided for @doctorReportCalisthenicsHeading.
  ///
  /// In en, this message translates to:
  /// **'Calisthenics - latest status per exercise:'**
  String get doctorReportCalisthenicsHeading;

  /// No description provided for @doctorReportCalisthenicsLine.
  ///
  /// In en, this message translates to:
  /// **'  - {exercise}: current tier \'{tier}\', last-3-session avg comfort {comfort}/5'**
  String doctorReportCalisthenicsLine(
    String exercise,
    String tier,
    String comfort,
  );

  /// No description provided for @doctorReportCalisthenicsLineMode.
  ///
  /// In en, this message translates to:
  /// **', last mode: {mode}'**
  String doctorReportCalisthenicsLineMode(String mode);

  /// No description provided for @doctorReportPemHeading.
  ///
  /// In en, this message translates to:
  /// **'Delayed Symptom Pattern (patient-observed)'**
  String get doctorReportPemHeading;

  /// No description provided for @doctorReportWeatherHeading.
  ///
  /// In en, this message translates to:
  /// **'Weather Context'**
  String get doctorReportWeatherHeading;

  /// No description provided for @doctorReportTherapiesHeading.
  ///
  /// In en, this message translates to:
  /// **'Recent Passive Therapies'**
  String get doctorReportTherapiesHeading;

  /// No description provided for @doctorReportTherapyLine.
  ///
  /// In en, this message translates to:
  /// **'  {date}  -  {name} ({duration} min)  -  body: {body}'**
  String doctorReportTherapyLine(
    String date,
    String name,
    int duration,
    String body,
  );

  /// No description provided for @doctorReportInjuriesHeading.
  ///
  /// In en, this message translates to:
  /// **'Injuries / Structural Events'**
  String get doctorReportInjuriesHeading;

  /// No description provided for @doctorReportInjuryLine.
  ///
  /// In en, this message translates to:
  /// **'  - {zone} ({kind}/{type}), started {date} - {status}'**
  String doctorReportInjuryLine(
    String zone,
    String kind,
    String type,
    String date,
    String status,
  );

  /// No description provided for @doctorReportNoteSuffix.
  ///
  /// In en, this message translates to:
  /// **'. {note}'**
  String doctorReportNoteSuffix(String note);

  /// No description provided for @doctorReportMetsHeading.
  ///
  /// In en, this message translates to:
  /// **'Energy & METs (from confirmed Apple Health workout imports)'**
  String get doctorReportMetsHeading;

  /// No description provided for @doctorReportMetsLine.
  ///
  /// In en, this message translates to:
  /// **'MET-minutes: {metMinutes}   |   Active energy: {kcal} kcal'**
  String doctorReportMetsLine(String metMinutes, String kcal);

  /// No description provided for @doctorReportDaysInRange.
  ///
  /// In en, this message translates to:
  /// **'Days in range'**
  String get doctorReportDaysInRange;

  /// No description provided for @doctorReportDaysLogged.
  ///
  /// In en, this message translates to:
  /// **'Days logged'**
  String get doctorReportDaysLogged;

  /// No description provided for @doctorReportRestDays.
  ///
  /// In en, this message translates to:
  /// **'Rest days'**
  String get doctorReportRestDays;

  /// No description provided for @doctorReportFlareDays.
  ///
  /// In en, this message translates to:
  /// **'Flare / sick days'**
  String get doctorReportFlareDays;

  /// No description provided for @doctorReportAvgSteps.
  ///
  /// In en, this message translates to:
  /// **'Average daily steps (active days)'**
  String get doctorReportAvgSteps;

  /// No description provided for @doctorReportAvgLiquids.
  ///
  /// In en, this message translates to:
  /// **'Average liquids'**
  String get doctorReportAvgLiquids;

  /// No description provided for @doctorReportAvgProtein.
  ///
  /// In en, this message translates to:
  /// **'Average protein'**
  String get doctorReportAvgProtein;

  /// No description provided for @doctorReportAvgMental.
  ///
  /// In en, this message translates to:
  /// **'Average mental state (1-5)'**
  String get doctorReportAvgMental;

  /// No description provided for @doctorReportAvgBody.
  ///
  /// In en, this message translates to:
  /// **'Average body/pain feeling (1-5)'**
  String get doctorReportAvgBody;

  /// No description provided for @doctorReportMlValue.
  ///
  /// In en, this message translates to:
  /// **'{value} ml'**
  String doctorReportMlValue(String value);

  /// No description provided for @doctorReportGramsValue.
  ///
  /// In en, this message translates to:
  /// **'{value} g'**
  String doctorReportGramsValue(String value);

  /// No description provided for @doctorReportPemNote.
  ///
  /// In en, this message translates to:
  /// **'Comparing daily steps against body/pain score {lagDays} day(s) later over the last {rangeDays} days (n={n} pairs): correlation r={r}. Higher-exertion days averaged a body/pain score of {higher}/5 vs {typical}/5 for typical/lower days, {lagDays} day(s) later. Patient-observed pattern, not a clinical finding.'**
  String doctorReportPemNote(
    int lagDays,
    int rangeDays,
    int n,
    String r,
    String higher,
    String typical,
  );

  /// No description provided for @doctorReportWeatherNote.
  ///
  /// In en, this message translates to:
  /// **'Average atmospheric pressure over the period: {pressure} hPa. Correlation with same-day body/pain score: r={r}. Exploratory, patient-observed.'**
  String doctorReportWeatherNote(String pressure, String r);

  /// No description provided for @principleMovementQualityTitle.
  ///
  /// In en, this message translates to:
  /// **'Movement Quality > Movement Quantity'**
  String get principleMovementQualityTitle;

  /// No description provided for @principleMovementQualityFact.
  ///
  /// In en, this message translates to:
  /// **'For EDS/HSD, low-load exercise focused on motor control reduces pain and improves function more reliably than high-volume training.'**
  String get principleMovementQualityFact;

  /// No description provided for @principleMovementQualityInspiration.
  ///
  /// In en, this message translates to:
  /// **'Your joints don\'t need endless reps — they need mindful, precise control. Training proprioception is what stabilizes loose joints, not pushing them to their limit.'**
  String get principleMovementQualityInspiration;

  /// No description provided for @principleHealingClockTitle.
  ///
  /// In en, this message translates to:
  /// **'Respecting the Biological Healing Clock'**
  String get principleHealingClockTitle;

  /// No description provided for @principleHealingClockFact.
  ///
  /// In en, this message translates to:
  /// **'Tendons, ligaments, and joint capsules have limited blood supply and heal far slower than muscle — EDS extends this further.'**
  String get principleHealingClockFact;

  /// No description provided for @principleHealingClockInspiration.
  ///
  /// In en, this message translates to:
  /// **'\"Start low, go slow\" isn\'t a lack of progress — it\'s a clinical necessity that lets your nervous system rebuild stabilizing muscle without overstressing fragile ligaments.'**
  String get principleHealingClockInspiration;

  /// No description provided for @principleDelayedSorenessTitle.
  ///
  /// In en, this message translates to:
  /// **'Validating Delayed Soreness (DOMS)'**
  String get principleDelayedSorenessTitle;

  /// No description provided for @principleDelayedSorenessFact.
  ///
  /// In en, this message translates to:
  /// **'Hypermobile individuals experience significantly greater, more intense delayed-onset muscle soreness than non-hypermobile people after eccentric exercise.'**
  String get principleDelayedSorenessFact;

  /// No description provided for @principleDelayedSorenessInspiration.
  ///
  /// In en, this message translates to:
  /// **'Soreness days later doesn\'t mean you\'re broken — your muscles are working harder to stabilize loose joints. Extra recovery time is biology, not a failure of will.'**
  String get principleDelayedSorenessInspiration;

  /// No description provided for @principleAutoEscalationTitle.
  ///
  /// In en, this message translates to:
  /// **'Rejecting the Auto-Escalation Trap'**
  String get principleAutoEscalationTitle;

  /// No description provided for @principleAutoEscalationFact.
  ///
  /// In en, this message translates to:
  /// **'Commercial trackers that auto-raise goals after a big day can push chronic pain / dysautonomia patients past what their nervous system needs for recovery.'**
  String get principleAutoEscalationFact;

  /// No description provided for @principleAutoEscalationInspiration.
  ///
  /// In en, this message translates to:
  /// **'Rest isn\'t a missed day. Your capacity is a range that shifts daily with sleep, hydration, and pain — not an arbitrary target that only ever goes up. This is why this app\'s baseline excludes rest and flare days instead of averaging them in.'**
  String get principleAutoEscalationInspiration;

  /// No description provided for @principleCinderellaMusclesTitle.
  ///
  /// In en, this message translates to:
  /// **'Rescuing the \'Cinderella Muscles\''**
  String get principleCinderellaMusclesTitle;

  /// No description provided for @principleCinderellaMusclesFact.
  ///
  /// In en, this message translates to:
  /// **'Lax joints force stabilizing muscles into constant low-level contraction (the \'Cinderella hypothesis\'), causing metabolic overload and trigger points.'**
  String get principleCinderellaMusclesFact;

  /// No description provided for @principleCinderellaMusclesInspiration.
  ///
  /// In en, this message translates to:
  /// **'Your stabilizing muscles work a 24-hour shift just to hold you upright. Frequent gentle micro-breaks — twists, isometric holds — restore blood flow and break the pain cycle.'**
  String get principleCinderellaMusclesInspiration;

  /// No description provided for @principleStiffnessParadoxTitle.
  ///
  /// In en, this message translates to:
  /// **'The Stiffness Paradox'**
  String get principleStiffnessParadoxTitle;

  /// No description provided for @principleStiffnessParadoxFact.
  ///
  /// In en, this message translates to:
  /// **'Fascia can thicken (densify) to compensate for lax joints, creating stiffness despite loose ligaments — aggressive stretching can worsen instability.'**
  String get principleStiffnessParadoxFact;

  /// No description provided for @principleStiffnessParadoxInspiration.
  ///
  /// In en, this message translates to:
  /// **'Tightness is often your body protecting your joints. Gentle fascial gliding and core stabilization reassure your nervous system more safely than a deep stretch.'**
  String get principleStiffnessParadoxInspiration;

  /// No description provided for @principleEccentricWorkTitle.
  ///
  /// In en, this message translates to:
  /// **'Eccentric Work: More Strength for Fewer Spoons'**
  String get principleEccentricWorkTitle;

  /// No description provided for @principleEccentricWorkFact.
  ///
  /// In en, this message translates to:
  /// **'Eccentric (lengthening) contractions generate high force at a lower metabolic and cardiovascular cost than concentric (lifting) contractions of the same intensity — and unaccustomed muscle damage is largely preventable through gradual, low-intensity progression.'**
  String get principleEccentricWorkFact;

  /// No description provided for @principleEccentricWorkInspiration.
  ///
  /// In en, this message translates to:
  /// **'This is why \'Eccentric\' work is worth tagging separately here — it\'s a way to build real strength without spending spoons you don\'t have, especially useful if dysautonomia limits how much cardiovascular effort you can spare on a given day.'**
  String get principleEccentricWorkInspiration;

  /// No description provided for @principleRepeatedBoutEffectTitle.
  ///
  /// In en, this message translates to:
  /// **'Soreness Fades With Practice — the Repeated Bout Effect'**
  String get principleRepeatedBoutEffectTitle;

  /// No description provided for @principleRepeatedBoutEffectFact.
  ///
  /// In en, this message translates to:
  /// **'After an initial bout of eccentric exercise, the same movement causes markedly less soreness and muscle damage the next time — protection that can last weeks to months.'**
  String get principleRepeatedBoutEffectFact;

  /// No description provided for @principleRepeatedBoutEffectInspiration.
  ///
  /// In en, this message translates to:
  /// **'If a new eccentric exercise leaves you sore the first couple of times, that\'s expected and it\'s not a sign to stop — it typically eases on its own as your muscles adapt, faster than you might expect.'**
  String get principleRepeatedBoutEffectInspiration;

  /// No description provided for @principleMuscleDamageCaveatTitle.
  ///
  /// In en, this message translates to:
  /// **'An Important Caveat: Muscle Damage ≠ Joint Safety'**
  String get principleMuscleDamageCaveatTitle;

  /// No description provided for @principleMuscleDamageCaveatFact.
  ///
  /// In en, this message translates to:
  /// **'\"Muscle damage is usually fine\" research above was done in general and older-adult populations, not specifically in hypermobile connective tissue. That is not the same claim as \"joint and capsule loading is fine\" for EDS/HSD bodies.'**
  String get principleMuscleDamageCaveatFact;

  /// No description provided for @principleMuscleDamageCaveatInspiration.
  ///
  /// In en, this message translates to:
  /// **'Treat muscle soreness and joint/capsule signals as two separate things worth tracking separately — easing muscle soreness is a good sign, but pain, instability, or swelling around a joint is its own signal and deserves its own caution, regardless of what the muscle soreness is doing.'**
  String get principleMuscleDamageCaveatInspiration;

  /// No description provided for @restFactNoBehind.
  ///
  /// In en, this message translates to:
  /// **'There is no \'behind\' in a chronic condition. The only comparison that matters is you-today to you-yesterday, gently.'**
  String get restFactNoBehind;

  /// No description provided for @restFactEveryEntryCounts.
  ///
  /// In en, this message translates to:
  /// **'Every log entry — even \'I rested\' or \'I couldn\'t log anything\' — is useful data for you and your care team. It all counts.'**
  String get restFactEveryEntryCounts;

  /// No description provided for @restFactFlareExcluded.
  ///
  /// In en, this message translates to:
  /// **'A flare isn\'t a step backward in your data. Your averages are built to exclude flare days automatically, on purpose.'**
  String get restFactFlareExcluded;

  /// No description provided for @motivationLowSteps1.
  ///
  /// In en, this message translates to:
  /// **'Fewer steps today isn\'t a setback — bodies with connective tissue differences have real day-to-day variability. This is expected, not a failure.'**
  String get motivationLowSteps1;

  /// No description provided for @motivationLowSteps2.
  ///
  /// In en, this message translates to:
  /// **'Some days are recovery days even when you didn\'t plan them. Your nervous system is doing quiet work you can\'t see.'**
  String get motivationLowSteps2;

  /// No description provided for @motivationLowSteps3.
  ///
  /// In en, this message translates to:
  /// **'The trend over weeks matters far more than any single day. One quieter day doesn\'t undo your progress.'**
  String get motivationLowSteps3;

  /// No description provided for @motivationSteady1.
  ///
  /// In en, this message translates to:
  /// **'Showing up consistently, even at a steady pace, is exactly how sustainable progress with EDS/dysautonomia looks.'**
  String get motivationSteady1;

  /// No description provided for @motivationSteady2.
  ///
  /// In en, this message translates to:
  /// **'Maintaining your baseline is a genuine achievement — it means your pacing strategy is working.'**
  String get motivationSteady2;

  /// No description provided for @motivationGrowth1.
  ///
  /// In en, this message translates to:
  /// **'You gently expanded your capacity today. Small, sustainable growth is the whole strategy — no need to push further.'**
  String get motivationGrowth1;

  /// No description provided for @motivationGrowth2.
  ///
  /// In en, this message translates to:
  /// **'That\'s real progress. Consider this your cue to rest well tonight so your body can consolidate the gain.'**
  String get motivationGrowth2;

  /// No description provided for @principlesExpanderTitle.
  ///
  /// In en, this message translates to:
  /// **'📚 Why this app works this way'**
  String get principlesExpanderTitle;

  /// No description provided for @principlesExpanderHideButton.
  ///
  /// In en, this message translates to:
  /// **'Hide the research'**
  String get principlesExpanderHideButton;

  /// No description provided for @principlesExpanderShowButton.
  ///
  /// In en, this message translates to:
  /// **'Show the research'**
  String get principlesExpanderShowButton;

  /// No description provided for @stepsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'👣 Steps & The Gentle-Growth Rule'**
  String get stepsSectionTitle;

  /// No description provided for @stepsSectionBaselineLabel.
  ///
  /// In en, this message translates to:
  /// **'Baseline'**
  String get stepsSectionBaselineLabel;

  /// No description provided for @stepsSectionGrowthGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Growth goal'**
  String get stepsSectionGrowthGoalLabel;

  /// No description provided for @stepsSectionCautionLineLabel.
  ///
  /// In en, this message translates to:
  /// **'Caution line'**
  String get stepsSectionCautionLineLabel;

  /// No description provided for @stepsSectionTodayStepsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Today\'s steps'**
  String get stepsSectionTodayStepsPlaceholder;

  /// No description provided for @stepsSectionSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Steps'**
  String get stepsSectionSaveButton;

  /// No description provided for @stepsSectionMessageFlareNeutral.
  ///
  /// In en, this message translates to:
  /// **'Logged. No comparisons today — just resting and recovering matters.'**
  String get stepsSectionMessageFlareNeutral;

  /// No description provided for @stepsSectionMessageCaution.
  ///
  /// In en, this message translates to:
  /// **'💛 That\'s higher than your recent baseline. Consider extra rest, hydration and electrolytes.'**
  String get stepsSectionMessageCaution;

  /// No description provided for @stepsSectionMessageGoalCelebration.
  ///
  /// In en, this message translates to:
  /// **'🎉 {tip}'**
  String stepsSectionMessageGoalCelebration(String tip);

  /// No description provided for @stepsSectionMessageGentleLow.
  ///
  /// In en, this message translates to:
  /// **'🌤️ {tip}'**
  String stepsSectionMessageGentleLow(String tip);

  /// No description provided for @stepsSectionMessageSteady.
  ///
  /// In en, this message translates to:
  /// **'✅ {tip}'**
  String stepsSectionMessageSteady(String tip);

  /// No description provided for @stepsSectionMessageNoBaseline.
  ///
  /// In en, this message translates to:
  /// **'Logged. Every entry builds your baseline for next time.'**
  String get stepsSectionMessageNoBaseline;

  /// No description provided for @monthChapterQuietTitle.
  ///
  /// In en, this message translates to:
  /// **'A Quiet Chapter'**
  String get monthChapterQuietTitle;

  /// No description provided for @monthChapterQuietBody.
  ///
  /// In en, this message translates to:
  /// **'No entries logged yet this month — and that\'s alright. This chapter is still unwritten; pick it up whenever you\'re ready.'**
  String get monthChapterQuietBody;

  /// No description provided for @monthChapterTitleLearningToRest.
  ///
  /// In en, this message translates to:
  /// **'Learning to Rest'**
  String get monthChapterTitleLearningToRest;

  /// No description provided for @monthChapterTitleGentleExploration.
  ///
  /// In en, this message translates to:
  /// **'Gentle Exploration'**
  String get monthChapterTitleGentleExploration;

  /// No description provided for @monthChapterTitleSteadyNoticing.
  ///
  /// In en, this message translates to:
  /// **'Steady Noticing'**
  String get monthChapterTitleSteadyNoticing;

  /// No description provided for @monthChapterTitleFindingTheRhythm.
  ///
  /// In en, this message translates to:
  /// **'Finding the Rhythm'**
  String get monthChapterTitleFindingTheRhythm;

  /// No description provided for @monthChapterShowedUp.
  ///
  /// In en, this message translates to:
  /// **'You showed up **{count}** {count, plural, =1{time} other{times}} this month.'**
  String monthChapterShowedUp(int count);

  /// No description provided for @monthChapterRestDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} Rest Day} other{{count} Rest Days}}'**
  String monthChapterRestDays(int count);

  /// No description provided for @monthChapterFlareDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} Flare Day} other{{count} Flare Days}}'**
  String monthChapterFlareDays(int count);

  /// No description provided for @monthChapterAnd.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get monthChapterAnd;

  /// No description provided for @monthChapterHonored.
  ///
  /// In en, this message translates to:
  /// **'You honored {bits} — protecting your body counts as showing up too.'**
  String monthChapterHonored(String bits);

  /// No description provided for @monthChapterActivityLogs.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} activity log} other{{count} activity logs}}'**
  String monthChapterActivityLogs(int count);

  /// No description provided for @monthChapterCalisthenicsSessions.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} calisthenics session} other{{count} calisthenics sessions}}'**
  String monthChapterCalisthenicsSessions(int count);

  /// No description provided for @monthChapterRecoverySessions.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} recovery session} other{{count} recovery sessions}}'**
  String monthChapterRecoverySessions(int count);

  /// No description provided for @monthChapterMovementSummary.
  ///
  /// In en, this message translates to:
  /// **'Movement and recovery this month: {bits}.'**
  String monthChapterMovementSummary(String bits);

  /// No description provided for @monthChapterScoreRange.
  ///
  /// In en, this message translates to:
  /// **'Your mental state moved between **{minMental}** and **{maxMental}**, and body/pain between **{minBody}** and **{maxBody}**.'**
  String monthChapterScoreRange(
    String minMental,
    String maxMental,
    String minBody,
    String maxBody,
  );

  /// No description provided for @commonCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancelButton;

  /// No description provided for @commonCloseButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonCloseButton;

  /// No description provided for @kofiSupportButton.
  ///
  /// In en, this message translates to:
  /// **'☕ Support on Ko-fi'**
  String get kofiSupportButton;

  /// No description provided for @inviteCodeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'This app is invite-only 🦓'**
  String get inviteCodeScreenTitle;

  /// No description provided for @inviteCodeScreenBody.
  ///
  /// In en, this message translates to:
  /// **'ZebraPace is still finding its feet, so it\'s invite-only for now. If you don\'t have a code, you can ask for one on my website.'**
  String get inviteCodeScreenBody;

  /// No description provided for @inviteCodeScreenPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Invite code'**
  String get inviteCodeScreenPlaceholder;

  /// No description provided for @inviteCodeScreenSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get inviteCodeScreenSubmitButton;

  /// No description provided for @inviteCodeScreenError.
  ///
  /// In en, this message translates to:
  /// **'That code doesn\'t look right — try again.'**
  String get inviteCodeScreenError;

  /// No description provided for @inviteCodeScreenGetCodeButton.
  ///
  /// In en, this message translates to:
  /// **'Get a code'**
  String get inviteCodeScreenGetCodeButton;

  /// No description provided for @welcomeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to ZebraPace 🦓'**
  String get welcomeScreenTitle;

  /// No description provided for @welcomeScreenPurposeParagraph.
  ///
  /// In en, this message translates to:
  /// **'ZebraPace is a gentle, pacing-focused tool to help you stay informed about your own \"zebra body\" — EDS, PEM, Dysautonomia, and everything that rides along with them — without turning your health into a competition against yourself.'**
  String get welcomeScreenPurposeParagraph;

  /// No description provided for @welcomeScreenDisclaimerParagraph.
  ///
  /// In en, this message translates to:
  /// **'This app is not a medical device and does not diagnose or treat anything. It is not a substitute for your doctor, physical therapist, kinesiologist, or other care providers — please keep making those decisions with them, not instead of them.'**
  String get welcomeScreenDisclaimerParagraph;

  /// No description provided for @welcomeScreenPersonalParagraph.
  ///
  /// In en, this message translates to:
  /// **'ZebraPace is a personal project, built by one zebra for other zebras, and offered freely. If it\'s useful to you and you\'d like to help keep it going, you can support it on Ko-fi — completely optional, no pressure.'**
  String get welcomeScreenPersonalParagraph;

  /// No description provided for @welcomeScreenContinueButton.
  ///
  /// In en, this message translates to:
  /// **'I understand — Continue'**
  String get welcomeScreenContinueButton;

  /// No description provided for @settingsTabTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTabTitle;

  /// No description provided for @settingsTabGoalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Pacing goals & thresholds'**
  String get settingsTabGoalsTitle;

  /// No description provided for @settingsTabGrowthGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Growth goal (e.g. 1.01 = 1%)'**
  String get settingsTabGrowthGoalLabel;

  /// No description provided for @settingsTabCautionMultiplierLabel.
  ///
  /// In en, this message translates to:
  /// **'Caution multiplier (e.g. 1.10 = 10%)'**
  String get settingsTabCautionMultiplierLabel;

  /// No description provided for @settingsTabComfortThresholdLabel.
  ///
  /// In en, this message translates to:
  /// **'Calisthenics comfort threshold (1-5)'**
  String get settingsTabComfortThresholdLabel;

  /// No description provided for @settingsTabWaterGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Water goal (ml)'**
  String get settingsTabWaterGoalLabel;

  /// No description provided for @settingsTabProteinGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Protein goal (g)'**
  String get settingsTabProteinGoalLabel;

  /// No description provided for @settingsTabSleepGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Sleep goal (hours)'**
  String get settingsTabSleepGoalLabel;

  /// No description provided for @settingsTabLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get settingsTabLocationTitle;

  /// No description provided for @settingsTabLocationCaption.
  ///
  /// In en, this message translates to:
  /// **'Used for weather-correlation insights.'**
  String get settingsTabLocationCaption;

  /// No description provided for @settingsTabLocationSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search for a city or town'**
  String get settingsTabLocationSearchPlaceholder;

  /// No description provided for @settingsTabLocationSearchButton.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get settingsTabLocationSearchButton;

  /// No description provided for @settingsTabLocationManualHint.
  ///
  /// In en, this message translates to:
  /// **'Or enter latitude/longitude manually below:'**
  String get settingsTabLocationManualHint;

  /// No description provided for @settingsTabLocationNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Location name'**
  String get settingsTabLocationNameLabel;

  /// No description provided for @settingsTabLatitudeLabel.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get settingsTabLatitudeLabel;

  /// No description provided for @settingsTabLongitudeLabel.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get settingsTabLongitudeLabel;

  /// No description provided for @settingsTabSaveLocationButton.
  ///
  /// In en, this message translates to:
  /// **'Save Location'**
  String get settingsTabSaveLocationButton;

  /// No description provided for @settingsTabLocationNotFound.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t find that location — try a different search term.'**
  String get settingsTabLocationNotFound;

  /// No description provided for @settingsTabAppLockTitle.
  ///
  /// In en, this message translates to:
  /// **'🔒 App Lock'**
  String get settingsTabAppLockTitle;

  /// No description provided for @settingsTabLockNowButton.
  ///
  /// In en, this message translates to:
  /// **'Lock now'**
  String get settingsTabLockNowButton;

  /// No description provided for @settingsTabDataOwnershipTitle.
  ///
  /// In en, this message translates to:
  /// **'Data ownership'**
  String get settingsTabDataOwnershipTitle;

  /// No description provided for @settingsTabDataOwnershipCaption.
  ///
  /// In en, this message translates to:
  /// **'Export, import, or fully delete your data — no lock-in.'**
  String get settingsTabDataOwnershipCaption;

  /// No description provided for @settingsTabExportJsonButton.
  ///
  /// In en, this message translates to:
  /// **'Export all data (JSON)'**
  String get settingsTabExportJsonButton;

  /// No description provided for @settingsTabImportModeReplace.
  ///
  /// In en, this message translates to:
  /// **'Replace (wipe then load)'**
  String get settingsTabImportModeReplace;

  /// No description provided for @settingsTabImportModeMerge.
  ///
  /// In en, this message translates to:
  /// **'Merge (keep existing + add new)'**
  String get settingsTabImportModeMerge;

  /// No description provided for @settingsTabImportJsonButton.
  ///
  /// In en, this message translates to:
  /// **'Import data (JSON)'**
  String get settingsTabImportJsonButton;

  /// No description provided for @settingsTabImportComplete.
  ///
  /// In en, this message translates to:
  /// **'Import complete.'**
  String get settingsTabImportComplete;

  /// No description provided for @settingsTabImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t import that file: {error}'**
  String settingsTabImportFailed(String error);

  /// No description provided for @settingsTabDeleteLoggedDataLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete all logged data (keeps your goals/settings)'**
  String get settingsTabDeleteLoggedDataLabel;

  /// No description provided for @settingsTabDeleteAllButton.
  ///
  /// In en, this message translates to:
  /// **'Delete all my data'**
  String get settingsTabDeleteAllButton;

  /// No description provided for @settingsTabNameTitle.
  ///
  /// In en, this message translates to:
  /// **'👋 Your name'**
  String get settingsTabNameTitle;

  /// No description provided for @settingsTabNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get settingsTabNamePlaceholder;

  /// No description provided for @appShellGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name} 🦓'**
  String appShellGreeting(String name);

  /// No description provided for @appShellMoreDatesButton.
  ///
  /// In en, this message translates to:
  /// **'More dates'**
  String get appShellMoreDatesButton;

  /// No description provided for @settingsTabHealthKitTitle.
  ///
  /// In en, this message translates to:
  /// **'❤️ Apple Health'**
  String get settingsTabHealthKitTitle;

  /// No description provided for @settingsTabHealthKitConnectedCaption.
  ///
  /// In en, this message translates to:
  /// **'Connected — steps pre-fill and workouts are suggested for review.'**
  String get settingsTabHealthKitConnectedCaption;

  /// No description provided for @settingsTabHealthKitDisconnectedCaption.
  ///
  /// In en, this message translates to:
  /// **'Not connected. Steps and workout suggestions stay fully manual until you connect.'**
  String get settingsTabHealthKitDisconnectedCaption;

  /// No description provided for @settingsTabHealthKitOpenSettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Open iOS Settings to change access'**
  String get settingsTabHealthKitOpenSettingsButton;

  /// No description provided for @settingsTabHealthKitConnectButton.
  ///
  /// In en, this message translates to:
  /// **'Connect Apple Health'**
  String get settingsTabHealthKitConnectButton;

  /// No description provided for @settingsTabCloudSyncTitle.
  ///
  /// In en, this message translates to:
  /// **'☁️ Cloud Sync'**
  String get settingsTabCloudSyncTitle;

  /// No description provided for @settingsTabCloudSyncCaption.
  ///
  /// In en, this message translates to:
  /// **'Sign in to sync your data across devices. Nothing is synced yet — this connects your account.'**
  String get settingsTabCloudSyncCaption;

  /// No description provided for @settingsTabCloudSyncEmailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get settingsTabCloudSyncEmailPlaceholder;

  /// No description provided for @settingsTabCloudSyncSendLinkButton.
  ///
  /// In en, this message translates to:
  /// **'Send magic link'**
  String get settingsTabCloudSyncSendLinkButton;

  /// No description provided for @settingsTabCloudSyncLinkSent.
  ///
  /// In en, this message translates to:
  /// **'Check your email for a sign-in link.'**
  String get settingsTabCloudSyncLinkSent;

  /// No description provided for @settingsTabCloudSyncSignedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {email}'**
  String settingsTabCloudSyncSignedInAs(String email);

  /// No description provided for @settingsTabCloudSyncSignOutButton.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get settingsTabCloudSyncSignOutButton;

  /// No description provided for @settingsTabAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'ℹ️ About ZebraPace'**
  String get settingsTabAboutTitle;

  /// No description provided for @settingsTabAboutViewWelcomeButton.
  ///
  /// In en, this message translates to:
  /// **'View welcome & disclaimer'**
  String get settingsTabAboutViewWelcomeButton;

  /// No description provided for @settingsTabLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsTabLanguageTitle;

  /// No description provided for @settingsTabLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsTabLanguageSystem;

  /// No description provided for @settingsTabLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsTabLanguageEnglish;

  /// No description provided for @settingsTabLanguageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get settingsTabLanguageSpanish;

  /// No description provided for @settingsTabLanguageChineseTaiwan.
  ///
  /// In en, this message translates to:
  /// **'繁體中文（台灣）'**
  String get settingsTabLanguageChineseTaiwan;

  /// No description provided for @settingsTabTextSizeTitle.
  ///
  /// In en, this message translates to:
  /// **'Text Size'**
  String get settingsTabTextSizeTitle;

  /// No description provided for @settingsTabTextSizeCaption.
  ///
  /// In en, this message translates to:
  /// **'Adjust how large text appears throughout the app, on top of your device\'s own text-size setting.'**
  String get settingsTabTextSizeCaption;

  /// No description provided for @settingsTabTextSizeSemanticLabel.
  ///
  /// In en, this message translates to:
  /// **'Text size {percent}%'**
  String settingsTabTextSizeSemanticLabel(int percent);

  /// No description provided for @lockScreenSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up a password'**
  String get lockScreenSetupTitle;

  /// No description provided for @lockScreenSetupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This protects your health data on this device. You\'ll also be able to use Face ID/Touch ID once this is set.'**
  String get lockScreenSetupSubtitle;

  /// No description provided for @lockScreenPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get lockScreenPasswordPlaceholder;

  /// No description provided for @lockScreenConfirmPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get lockScreenConfirmPasswordPlaceholder;

  /// No description provided for @lockScreenSetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Set password'**
  String get lockScreenSetPasswordButton;

  /// No description provided for @lockScreenPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 4 characters.'**
  String get lockScreenPasswordTooShort;

  /// No description provided for @lockScreenPasswordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match.'**
  String get lockScreenPasswordsDontMatch;

  /// No description provided for @lockScreenOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get lockScreenOk;

  /// No description provided for @lockScreenLockedTitle.
  ///
  /// In en, this message translates to:
  /// **'ZebraPace is locked'**
  String get lockScreenLockedTitle;

  /// No description provided for @lockScreenCloudSyncSignedIn.
  ///
  /// In en, this message translates to:
  /// **'☁️ Signed in to Cloud Sync as {email}'**
  String lockScreenCloudSyncSignedIn(String email);

  /// No description provided for @lockScreenBiometricUnlockButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock with Face ID / Touch ID'**
  String get lockScreenBiometricUnlockButton;

  /// No description provided for @lockScreenUsePasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Use Password Instead'**
  String get lockScreenUsePasswordButton;

  /// No description provided for @lockScreenUnlockButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get lockScreenUnlockButton;

  /// No description provided for @authProviderNoPasswordSetUp.
  ///
  /// In en, this message translates to:
  /// **'No password set up yet.'**
  String get authProviderNoPasswordSetUp;

  /// No description provided for @authProviderIncorrectPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get authProviderIncorrectPassword;

  /// No description provided for @appShellTabVitals.
  ///
  /// In en, this message translates to:
  /// **'Vitals & Fuel'**
  String get appShellTabVitals;

  /// No description provided for @appShellTabMovement.
  ///
  /// In en, this message translates to:
  /// **'Movement'**
  String get appShellTabMovement;

  /// No description provided for @appShellTabInsights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get appShellTabInsights;

  /// No description provided for @appShellTabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get appShellTabSettings;

  /// No description provided for @appShellTodayButton.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get appShellTodayButton;

  /// No description provided for @appShellDoneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get appShellDoneButton;

  /// No description provided for @injuryBannerActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Active: {zones} — logged in Movement. Separate from Flare Days.'**
  String injuryBannerActiveLabel(String zones);

  /// No description provided for @movementTabTitle.
  ///
  /// In en, this message translates to:
  /// **'Movement & Calisthenics'**
  String get movementTabTitle;

  /// No description provided for @healthkitWorkoutSuggestionsConnectTitle.
  ///
  /// In en, this message translates to:
  /// **'❤️ Connect Apple Health'**
  String get healthkitWorkoutSuggestionsConnectTitle;

  /// No description provided for @healthkitWorkoutSuggestionsConnectCaption.
  ///
  /// In en, this message translates to:
  /// **'Pre-fill today\'s steps and review detected workouts automatically. You can turn this off any time in Settings.'**
  String get healthkitWorkoutSuggestionsConnectCaption;

  /// No description provided for @healthkitWorkoutSuggestionsConnectButton.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get healthkitWorkoutSuggestionsConnectButton;

  /// No description provided for @healthkitWorkoutSuggestionsDetectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Detected: {activityLabel}'**
  String healthkitWorkoutSuggestionsDetectedTitle(String activityLabel);

  /// No description provided for @healthkitWorkoutSuggestionsAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get healthkitWorkoutSuggestionsAddButton;

  /// No description provided for @healthkitWorkoutSuggestionsDismissButton.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get healthkitWorkoutSuggestionsDismissButton;

  /// No description provided for @vitalsTabTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Vitals & Fuel'**
  String get vitalsTabTitle;

  /// No description provided for @vitalsTabLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error loading today: {error}'**
  String vitalsTabLoadError(String error);

  /// No description provided for @vitalsTabFlareDayBanner.
  ///
  /// In en, this message translates to:
  /// **'Marked as a Flare/Sick Day. Rest and comparisons are paused today.'**
  String get vitalsTabFlareDayBanner;

  /// No description provided for @vitalsTabRestDayBanner.
  ///
  /// In en, this message translates to:
  /// **'Declared as a Rest Day. That counts as showing up.'**
  String get vitalsTabRestDayBanner;

  /// No description provided for @vitalsTabRestDayButton.
  ///
  /// In en, this message translates to:
  /// **'Declare Rest Day'**
  String get vitalsTabRestDayButton;

  /// No description provided for @vitalsTabRestDayButtonActive.
  ///
  /// In en, this message translates to:
  /// **'✓ Rest Day'**
  String get vitalsTabRestDayButtonActive;

  /// No description provided for @vitalsTabFlareDayButton.
  ///
  /// In en, this message translates to:
  /// **'Mark Flare/Sick Day'**
  String get vitalsTabFlareDayButton;

  /// No description provided for @vitalsTabFlareDayButtonActive.
  ///
  /// In en, this message translates to:
  /// **'✓ Flare/Sick Day'**
  String get vitalsTabFlareDayButtonActive;

  /// No description provided for @vitalsMetricsRowLiquidsLabel.
  ///
  /// In en, this message translates to:
  /// **'Liquids'**
  String get vitalsMetricsRowLiquidsLabel;

  /// No description provided for @vitalsMetricsRowStepsLabel.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get vitalsMetricsRowStepsLabel;

  /// No description provided for @vitalsMetricsRowProteinLabel.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get vitalsMetricsRowProteinLabel;

  /// No description provided for @bodyMetricsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'📏 Body Metrics'**
  String get bodyMetricsSectionTitle;

  /// No description provided for @bodyMetricsSectionWeightPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get bodyMetricsSectionWeightPlaceholder;

  /// No description provided for @bodyMetricsSectionHeightPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get bodyMetricsSectionHeightPlaceholder;

  /// No description provided for @bodyMetricsSectionBodyFatPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Body fat %'**
  String get bodyMetricsSectionBodyFatPlaceholder;

  /// No description provided for @bodyMetricsSectionSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Body Metrics'**
  String get bodyMetricsSectionSaveButton;

  /// No description provided for @sleepQualityPoor.
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get sleepQualityPoor;

  /// No description provided for @sleepQualityRestless.
  ///
  /// In en, this message translates to:
  /// **'Restless'**
  String get sleepQualityRestless;

  /// No description provided for @sleepQualityOkay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get sleepQualityOkay;

  /// No description provided for @sleepQualityGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get sleepQualityGood;

  /// No description provided for @sleepQualityRestorative.
  ///
  /// In en, this message translates to:
  /// **'Restorative'**
  String get sleepQualityRestorative;

  /// No description provided for @energyBatteryTitle.
  ///
  /// In en, this message translates to:
  /// **'🔋 Today\'s Energy'**
  String get energyBatteryTitle;

  /// No description provided for @energyBatteryNoData.
  ///
  /// In en, this message translates to:
  /// **'Log your sleep below to see today\'s energy.'**
  String get energyBatteryNoData;

  /// No description provided for @energyTierFull.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get energyTierFull;

  /// No description provided for @energyTierGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get energyTierGood;

  /// No description provided for @energyTierOkay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get energyTierOkay;

  /// No description provided for @energyTierLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get energyTierLow;

  /// No description provided for @energyTierEmpty.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get energyTierEmpty;

  /// No description provided for @sleepSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'😴 Sleep & Recovery'**
  String get sleepSectionTitle;

  /// No description provided for @sleepSectionDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get sleepSectionDurationLabel;

  /// No description provided for @sleepSectionDurationPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Tap to set'**
  String get sleepSectionDurationPlaceholder;

  /// No description provided for @sleepSectionDurationValue.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String sleepSectionDurationValue(int hours, int minutes);

  /// No description provided for @sleepSectionQualityLabel.
  ///
  /// In en, this message translates to:
  /// **'Sleep quality'**
  String get sleepSectionQualityLabel;

  /// No description provided for @sleepSectionHeartRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Heart rate while sleeping (bpm)'**
  String get sleepSectionHeartRateLabel;

  /// No description provided for @sleepSectionHeartRateMinPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Lowest'**
  String get sleepSectionHeartRateMinPlaceholder;

  /// No description provided for @sleepSectionHeartRateMaxPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Highest'**
  String get sleepSectionHeartRateMaxPlaceholder;

  /// No description provided for @sleepSectionSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Sleep'**
  String get sleepSectionSaveButton;

  /// No description provided for @weatherChartEmptyState.
  ///
  /// In en, this message translates to:
  /// **'No weather data cached yet.'**
  String get weatherChartEmptyState;

  /// No description provided for @weatherChartPressureLabel.
  ///
  /// In en, this message translates to:
  /// **'Pressure (hPa)'**
  String get weatherChartPressureLabel;

  /// No description provided for @weatherChartBodyPainScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Body/Pain score'**
  String get weatherChartBodyPainScoreLabel;

  /// No description provided for @stepsChartEmptyState.
  ///
  /// In en, this message translates to:
  /// **'No steps logged in range.'**
  String get stepsChartEmptyState;

  /// No description provided for @liquidsChartEmptyState.
  ///
  /// In en, this message translates to:
  /// **'No liquids logged in range.'**
  String get liquidsChartEmptyState;

  /// No description provided for @feelingTrendChartEmptyState.
  ///
  /// In en, this message translates to:
  /// **'No entries in range.'**
  String get feelingTrendChartEmptyState;

  /// No description provided for @pemChartInsufficientData.
  ///
  /// In en, this message translates to:
  /// **'Not enough data yet — need at least 4 matched days at this lag.'**
  String get pemChartInsufficientData;

  /// No description provided for @pemChartCorrelationCaption.
  ///
  /// In en, this message translates to:
  /// **'Pearson r = {correlation} ({strength}) · Higher-exertion avg score: {higherAvg} · Typical/lower avg score: {typicalAvg}'**
  String pemChartCorrelationCaption(
    String correlation,
    String strength,
    String higherAvg,
    String typicalAvg,
  );

  /// No description provided for @correlationStrengthWeak.
  ///
  /// In en, this message translates to:
  /// **'weak'**
  String get correlationStrengthWeak;

  /// No description provided for @correlationStrengthModerate.
  ///
  /// In en, this message translates to:
  /// **'moderate'**
  String get correlationStrengthModerate;

  /// No description provided for @correlationStrengthStrong.
  ///
  /// In en, this message translates to:
  /// **'strong'**
  String get correlationStrengthStrong;

  /// No description provided for @insightsTabTitle.
  ///
  /// In en, this message translates to:
  /// **'Insights & Trends'**
  String get insightsTabTitle;

  /// No description provided for @insightsTabStripesTitle.
  ///
  /// In en, this message translates to:
  /// **'🦓 All-time stripes'**
  String get insightsTabStripesTitle;

  /// No description provided for @insightsTabStripesCaption.
  ///
  /// In en, this message translates to:
  /// **'Not a streak — missing days never remove earned stripes.'**
  String get insightsTabStripesCaption;

  /// No description provided for @insightsTabLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String insightsTabLoadError(String error);

  /// No description provided for @insightsTabEmptyState.
  ///
  /// In en, this message translates to:
  /// **'No entries logged in this range yet.'**
  String get insightsTabEmptyState;

  /// No description provided for @insightsTabStepsTitle.
  ///
  /// In en, this message translates to:
  /// **'👣 Steps (7-day rolling avg)'**
  String get insightsTabStepsTitle;

  /// No description provided for @insightsTabLiquidsTitle.
  ///
  /// In en, this message translates to:
  /// **'☕ Liquids'**
  String get insightsTabLiquidsTitle;

  /// No description provided for @insightsTabMentalStateTitle.
  ///
  /// In en, this message translates to:
  /// **'🧠 Mental State trend'**
  String get insightsTabMentalStateTitle;

  /// No description provided for @insightsTabBodyPainTitle.
  ///
  /// In en, this message translates to:
  /// **'😣 Body/Pain trend'**
  String get insightsTabBodyPainTitle;

  /// No description provided for @insightsTabCheckinConsistencyTitle.
  ///
  /// In en, this message translates to:
  /// **'📅 Check-in Consistency'**
  String get insightsTabCheckinConsistencyTitle;

  /// No description provided for @insightsTabCalisthenicsComfortTitle.
  ///
  /// In en, this message translates to:
  /// **'🤸 Calisthenics Comfort by Exercise'**
  String get insightsTabCalisthenicsComfortTitle;

  /// No description provided for @insightsTabGroupByExercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get insightsTabGroupByExercise;

  /// No description provided for @insightsTabGroupByContractionMode.
  ///
  /// In en, this message translates to:
  /// **'Contraction mode'**
  String get insightsTabGroupByContractionMode;

  /// No description provided for @insightsTabPemTitle.
  ///
  /// In en, this message translates to:
  /// **'🔬 Delayed Symptom Patterns (PEM check)'**
  String get insightsTabPemTitle;

  /// No description provided for @insightsTabPemCaption.
  ///
  /// In en, this message translates to:
  /// **'Steps vs. body score N days later, split by higher vs. typical exertion days.'**
  String get insightsTabPemCaption;

  /// No description provided for @insightsTabPemLagLabel.
  ///
  /// In en, this message translates to:
  /// **'Lag: '**
  String get insightsTabPemLagLabel;

  /// No description provided for @insightsTabPemLagDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} day} other{{count} days}}'**
  String insightsTabPemLagDays(int count);

  /// No description provided for @insightsTabWeatherTitle.
  ///
  /// In en, this message translates to:
  /// **'🌦️ Weather Context'**
  String get insightsTabWeatherTitle;

  /// No description provided for @insightsTabWeatherNoLocation.
  ///
  /// In en, this message translates to:
  /// **'Set a location in Settings to see whether barometric pressure correlates with your body/pain score.'**
  String get insightsTabWeatherNoLocation;

  /// No description provided for @insightsTabWeatherCorrelation.
  ///
  /// In en, this message translates to:
  /// **'Pearson r = {correlation} ({strength}) — pressure vs. same-day body score'**
  String insightsTabWeatherCorrelation(String correlation, String strength);

  /// No description provided for @insightsTabWeatherInsufficientData.
  ///
  /// In en, this message translates to:
  /// **'Not enough overlapping days yet — need at least 4.'**
  String get insightsTabWeatherInsufficientData;

  /// No description provided for @insightsTabWeatherPressureRange.
  ///
  /// In en, this message translates to:
  /// **'Pressure ranged {min}–{max} hPa over this period (normalized above to line up with the 1–5 score scale).'**
  String insightsTabWeatherPressureRange(String min, String max);

  /// No description provided for @insightsTabDayMarkerLegend.
  ///
  /// In en, this message translates to:
  /// **'Shaded bands mark 🔴 flare days and 🟢 rest days'**
  String get insightsTabDayMarkerLegend;

  /// No description provided for @insightsTabCelebrationTitle.
  ///
  /// In en, this message translates to:
  /// **'🏅 Things worth celebrating'**
  String get insightsTabCelebrationTitle;

  /// No description provided for @insightsTabCheckinsLabel.
  ///
  /// In en, this message translates to:
  /// **'Check-ins'**
  String get insightsTabCheckinsLabel;

  /// No description provided for @insightsTabRestDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Rest days'**
  String get insightsTabRestDaysLabel;

  /// No description provided for @insightsTabFlareDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Flare days'**
  String get insightsTabFlareDaysLabel;

  /// No description provided for @insightsTabTherapySessionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Therapy sessions'**
  String get insightsTabTherapySessionsLabel;

  /// No description provided for @insightsTabMovementLogsLabel.
  ///
  /// In en, this message translates to:
  /// **'Movement logs'**
  String get insightsTabMovementLogsLabel;

  /// No description provided for @historyTablesActivitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'🚴‍♀️ Recent Activities'**
  String get historyTablesActivitiesTitle;

  /// No description provided for @historyTablesActivityLine.
  ///
  /// In en, this message translates to:
  /// **'{date} · {activityName} — {durationMin} min'**
  String historyTablesActivityLine(
    String date,
    String activityName,
    int durationMin,
  );

  /// No description provided for @historyTablesTherapiesTitle.
  ///
  /// In en, this message translates to:
  /// **'💆‍♀️ Recent Therapies'**
  String get historyTablesTherapiesTitle;

  /// No description provided for @historyTablesTherapyLine.
  ///
  /// In en, this message translates to:
  /// **'{date} · {therapyName} — {durationMin} min'**
  String historyTablesTherapyLine(
    String date,
    String therapyName,
    int durationMin,
  );

  /// No description provided for @historyTablesCalisthenicsTitle.
  ///
  /// In en, this message translates to:
  /// **'🤸 Recent Calisthenics'**
  String get historyTablesCalisthenicsTitle;

  /// No description provided for @historyTablesCalisthenicsLine.
  ///
  /// In en, this message translates to:
  /// **'{date} · {exercise} ({progression}) — comfort {comfort}'**
  String historyTablesCalisthenicsLine(
    String date,
    String exercise,
    String progression,
    String comfort,
  );

  /// No description provided for @historyTablesSorenessTitle.
  ///
  /// In en, this message translates to:
  /// **'🔍 Soreness Check History'**
  String get historyTablesSorenessTitle;

  /// No description provided for @historyTablesSorenessLine.
  ///
  /// In en, this message translates to:
  /// **'{date} · {verdict}'**
  String historyTablesSorenessLine(String date, String verdict);

  /// No description provided for @historyTablesVitalsTitle.
  ///
  /// In en, this message translates to:
  /// **'📋 Daily Vitals History'**
  String get historyTablesVitalsTitle;

  /// No description provided for @historyTablesVitalsCaption.
  ///
  /// In en, this message translates to:
  /// **'Full history, newest first.'**
  String get historyTablesVitalsCaption;

  /// No description provided for @historyTablesVitalsLine.
  ///
  /// In en, this message translates to:
  /// **'{date} · {steps} steps · {water}ml · {mentalEmoji} {bodyEmoji}'**
  String historyTablesVitalsLine(
    String date,
    int steps,
    int water,
    String mentalEmoji,
    String bodyEmoji,
  );

  /// No description provided for @historyTablesVitalsRestSuffix.
  ///
  /// In en, this message translates to:
  /// **' · Rest'**
  String get historyTablesVitalsRestSuffix;

  /// No description provided for @historyTablesVitalsFlareSuffix.
  ///
  /// In en, this message translates to:
  /// **' · Flare'**
  String get historyTablesVitalsFlareSuffix;

  /// No description provided for @metsSummaryWidgetTitle.
  ///
  /// In en, this message translates to:
  /// **'❤️‍🔥 Energy & METs'**
  String get metsSummaryWidgetTitle;

  /// No description provided for @metsSummaryWidgetCaption.
  ///
  /// In en, this message translates to:
  /// **'From confirmed Apple Health workout imports in this range.'**
  String get metsSummaryWidgetCaption;

  /// No description provided for @metsSummaryWidgetMetMinutesLabel.
  ///
  /// In en, this message translates to:
  /// **'MET-minutes'**
  String get metsSummaryWidgetMetMinutesLabel;

  /// No description provided for @metsSummaryWidgetActiveEnergyLabel.
  ///
  /// In en, this message translates to:
  /// **'Active energy'**
  String get metsSummaryWidgetActiveEnergyLabel;

  /// No description provided for @metsSummaryWidgetActiveEnergyValue.
  ///
  /// In en, this message translates to:
  /// **'{value} kcal'**
  String metsSummaryWidgetActiveEnergyValue(String value);

  /// No description provided for @insightsRangeFourteenDays.
  ///
  /// In en, this message translates to:
  /// **'14 days'**
  String get insightsRangeFourteenDays;

  /// No description provided for @insightsRangeThirtyDays.
  ///
  /// In en, this message translates to:
  /// **'30 days'**
  String get insightsRangeThirtyDays;

  /// No description provided for @insightsRangeNinetyDays.
  ///
  /// In en, this message translates to:
  /// **'90 days'**
  String get insightsRangeNinetyDays;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'TW':
            return AppLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
