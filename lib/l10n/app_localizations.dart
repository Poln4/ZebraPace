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

  /// No description provided for @braceTypeShoulder.
  ///
  /// In en, this message translates to:
  /// **'Shoulder'**
  String get braceTypeShoulder;

  /// No description provided for @braceTypeElbow.
  ///
  /// In en, this message translates to:
  /// **'Elbow'**
  String get braceTypeElbow;

  /// No description provided for @braceTypeThumb.
  ///
  /// In en, this message translates to:
  /// **'Thumb / finger'**
  String get braceTypeThumb;

  /// No description provided for @braceTypeBack.
  ///
  /// In en, this message translates to:
  /// **'Back / lumbar'**
  String get braceTypeBack;

  /// No description provided for @braceTypeAchilles.
  ///
  /// In en, this message translates to:
  /// **'Achilles / heel'**
  String get braceTypeAchilles;

  /// No description provided for @braceTypeCompression.
  ///
  /// In en, this message translates to:
  /// **'Compression garments'**
  String get braceTypeCompression;

  /// No description provided for @braceSideLeft.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get braceSideLeft;

  /// No description provided for @braceSideRight.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get braceSideRight;

  /// No description provided for @braceSideBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get braceSideBoth;

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

  /// No description provided for @calisthenicsExerciseHolds.
  ///
  /// In en, this message translates to:
  /// **'Holds'**
  String get calisthenicsExerciseHolds;

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

  /// No description provided for @calisthenicsPushupsAdvancedIncline.
  ///
  /// In en, this message translates to:
  /// **'Advanced Incline Pushups'**
  String get calisthenicsPushupsAdvancedIncline;

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

  /// No description provided for @calisthenicsPushupsNarrow.
  ///
  /// In en, this message translates to:
  /// **'Narrow Pushups'**
  String get calisthenicsPushupsNarrow;

  /// No description provided for @calisthenicsPushupsSideStaggered.
  ///
  /// In en, this message translates to:
  /// **'Side-Staggered Pushups'**
  String get calisthenicsPushupsSideStaggered;

  /// No description provided for @calisthenicsPushupsArcher.
  ///
  /// In en, this message translates to:
  /// **'Archer Pushups'**
  String get calisthenicsPushupsArcher;

  /// No description provided for @calisthenicsPushupsSlidingOneArm.
  ///
  /// In en, this message translates to:
  /// **'Sliding One-Arm Pushups'**
  String get calisthenicsPushupsSlidingOneArm;

  /// No description provided for @calisthenicsPushupsOneArm.
  ///
  /// In en, this message translates to:
  /// **'One-Arm Pushups'**
  String get calisthenicsPushupsOneArm;

  /// No description provided for @calisthenicsPushupsAdvancedOneArm.
  ///
  /// In en, this message translates to:
  /// **'Advanced One-Arm Pushups'**
  String get calisthenicsPushupsAdvancedOneArm;

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

  /// No description provided for @calisthenicsSquatsNarrow.
  ///
  /// In en, this message translates to:
  /// **'Narrow Squats'**
  String get calisthenicsSquatsNarrow;

  /// No description provided for @calisthenicsSquatsSideStaggered.
  ///
  /// In en, this message translates to:
  /// **'Side Staggered Squats'**
  String get calisthenicsSquatsSideStaggered;

  /// No description provided for @calisthenicsSquatsFrontStaggered.
  ///
  /// In en, this message translates to:
  /// **'Front Staggered Squats'**
  String get calisthenicsSquatsFrontStaggered;

  /// No description provided for @calisthenicsSquatsAssistedOneLeg.
  ///
  /// In en, this message translates to:
  /// **'Assisted One Leg Squats'**
  String get calisthenicsSquatsAssistedOneLeg;

  /// No description provided for @calisthenicsSquatsOneLegChair.
  ///
  /// In en, this message translates to:
  /// **'One Leg Chair Squats'**
  String get calisthenicsSquatsOneLegChair;

  /// No description provided for @calisthenicsSquatsOneLeg.
  ///
  /// In en, this message translates to:
  /// **'One Leg Squats'**
  String get calisthenicsSquatsOneLeg;

  /// No description provided for @calisthenicsPullupsWall.
  ///
  /// In en, this message translates to:
  /// **'Wall Pullups'**
  String get calisthenicsPullupsWall;

  /// No description provided for @calisthenicsPullupsHorizontal.
  ///
  /// In en, this message translates to:
  /// **'Horizontal Pullups'**
  String get calisthenicsPullupsHorizontal;

  /// No description provided for @calisthenicsPullupsAdvancedHorizontal.
  ///
  /// In en, this message translates to:
  /// **'Advanced Horizontal Pullups'**
  String get calisthenicsPullupsAdvancedHorizontal;

  /// No description provided for @calisthenicsPullupsJackknife.
  ///
  /// In en, this message translates to:
  /// **'Jackknife Pullups'**
  String get calisthenicsPullupsJackknife;

  /// No description provided for @calisthenicsPullupsFull.
  ///
  /// In en, this message translates to:
  /// **'Full Pullups'**
  String get calisthenicsPullupsFull;

  /// No description provided for @calisthenicsPullupsNarrow.
  ///
  /// In en, this message translates to:
  /// **'Narrow Pullups'**
  String get calisthenicsPullupsNarrow;

  /// No description provided for @calisthenicsPullupsOneHand.
  ///
  /// In en, this message translates to:
  /// **'One Hand Pullups'**
  String get calisthenicsPullupsOneHand;

  /// No description provided for @calisthenicsPullupsAdvancedOneHand.
  ///
  /// In en, this message translates to:
  /// **'Advanced One Hand Pullups'**
  String get calisthenicsPullupsAdvancedOneHand;

  /// No description provided for @calisthenicsPullupsArcher.
  ///
  /// In en, this message translates to:
  /// **'Archer Pullups'**
  String get calisthenicsPullupsArcher;

  /// No description provided for @calisthenicsPullupsOneArm.
  ///
  /// In en, this message translates to:
  /// **'One Arm Pullups'**
  String get calisthenicsPullupsOneArm;

  /// No description provided for @calisthenicsLegRaisesKnee.
  ///
  /// In en, this message translates to:
  /// **'Knee Raises'**
  String get calisthenicsLegRaisesKnee;

  /// No description provided for @calisthenicsLegRaisesAdvancedKnee.
  ///
  /// In en, this message translates to:
  /// **'Advanced Knee Raises'**
  String get calisthenicsLegRaisesAdvancedKnee;

  /// No description provided for @calisthenicsLegRaisesAlternating.
  ///
  /// In en, this message translates to:
  /// **'Alternating Leg Raises'**
  String get calisthenicsLegRaisesAlternating;

  /// No description provided for @calisthenicsLegRaisesFull.
  ///
  /// In en, this message translates to:
  /// **'Full Leg Raises'**
  String get calisthenicsLegRaisesFull;

  /// No description provided for @calisthenicsLegRaisesTuckPlow.
  ///
  /// In en, this message translates to:
  /// **'Tuck Plow Raises'**
  String get calisthenicsLegRaisesTuckPlow;

  /// No description provided for @calisthenicsLegRaisesPlow.
  ///
  /// In en, this message translates to:
  /// **'Plow Raises'**
  String get calisthenicsLegRaisesPlow;

  /// No description provided for @calisthenicsLegRaisesHangingKnee.
  ///
  /// In en, this message translates to:
  /// **'Hanging Knee Raises'**
  String get calisthenicsLegRaisesHangingKnee;

  /// No description provided for @calisthenicsLegRaisesAdvancedHangingKnee.
  ///
  /// In en, this message translates to:
  /// **'Advanced Hanging Knee Raises'**
  String get calisthenicsLegRaisesAdvancedHangingKnee;

  /// No description provided for @calisthenicsLegRaisesHanging.
  ///
  /// In en, this message translates to:
  /// **'Hanging Leg Raises'**
  String get calisthenicsLegRaisesHanging;

  /// No description provided for @calisthenicsLegRaisesToeToBar.
  ///
  /// In en, this message translates to:
  /// **'Toe to Bars'**
  String get calisthenicsLegRaisesToeToBar;

  /// No description provided for @calisthenicsBridgesGlute.
  ///
  /// In en, this message translates to:
  /// **'Glute Bridges'**
  String get calisthenicsBridgesGlute;

  /// No description provided for @calisthenicsBridgesStraight.
  ///
  /// In en, this message translates to:
  /// **'Straight Bridges'**
  String get calisthenicsBridgesStraight;

  /// No description provided for @calisthenicsBridgesWall.
  ///
  /// In en, this message translates to:
  /// **'Wall Bridges'**
  String get calisthenicsBridgesWall;

  /// No description provided for @calisthenicsBridgesIncline.
  ///
  /// In en, this message translates to:
  /// **'Incline Bridges'**
  String get calisthenicsBridgesIncline;

  /// No description provided for @calisthenicsBridgesHead.
  ///
  /// In en, this message translates to:
  /// **'Head Bridges'**
  String get calisthenicsBridgesHead;

  /// No description provided for @calisthenicsBridgesFull.
  ///
  /// In en, this message translates to:
  /// **'Full Bridges'**
  String get calisthenicsBridgesFull;

  /// No description provided for @calisthenicsBridgesWheel.
  ///
  /// In en, this message translates to:
  /// **'Wheel Bridges'**
  String get calisthenicsBridgesWheel;

  /// No description provided for @calisthenicsBridgesTap.
  ///
  /// In en, this message translates to:
  /// **'Tap Bridges'**
  String get calisthenicsBridgesTap;

  /// No description provided for @calisthenicsBridgesWallWalking.
  ///
  /// In en, this message translates to:
  /// **'Wall Walking Bridges'**
  String get calisthenicsBridgesWallWalking;

  /// No description provided for @calisthenicsBridgesStandToStand.
  ///
  /// In en, this message translates to:
  /// **'Stand to Stand Bridges'**
  String get calisthenicsBridgesStandToStand;

  /// No description provided for @calisthenicsTwistsStraightLeg.
  ///
  /// In en, this message translates to:
  /// **'Straight Leg Twists'**
  String get calisthenicsTwistsStraightLeg;

  /// No description provided for @calisthenicsTwistsBentLeg.
  ///
  /// In en, this message translates to:
  /// **'Bent Leg Twists'**
  String get calisthenicsTwistsBentLeg;

  /// No description provided for @calisthenicsTwistsFull.
  ///
  /// In en, this message translates to:
  /// **'Full Twists'**
  String get calisthenicsTwistsFull;

  /// No description provided for @calisthenicsHoldsPlank.
  ///
  /// In en, this message translates to:
  /// **'Plank'**
  String get calisthenicsHoldsPlank;

  /// No description provided for @calisthenicsHoldsSidePlank.
  ///
  /// In en, this message translates to:
  /// **'Side Plank'**
  String get calisthenicsHoldsSidePlank;

  /// No description provided for @calisthenicsHoldsWallSit.
  ///
  /// In en, this message translates to:
  /// **'Wall Sit'**
  String get calisthenicsHoldsWallSit;

  /// No description provided for @calisthenicsHoldsGluteBridge.
  ///
  /// In en, this message translates to:
  /// **'Glute Bridge Hold'**
  String get calisthenicsHoldsGluteBridge;

  /// No description provided for @calisthenicsHoldsHollowBody.
  ///
  /// In en, this message translates to:
  /// **'Hollow Body Hold'**
  String get calisthenicsHoldsHollowBody;

  /// No description provided for @calisthenicsHoldsDeadHang.
  ///
  /// In en, this message translates to:
  /// **'Dead Hang'**
  String get calisthenicsHoldsDeadHang;

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

  /// No description provided for @calisthenicsSectionUnitSeconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get calisthenicsSectionUnitSeconds;

  /// No description provided for @calisthenicsSectionSetFieldPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Set {number}'**
  String calisthenicsSectionSetFieldPlaceholder(int number);

  /// No description provided for @calisthenicsSectionAddSet.
  ///
  /// In en, this message translates to:
  /// **'+ Set'**
  String get calisthenicsSectionAddSet;

  /// No description provided for @calisthenicsSectionRemoveSet.
  ///
  /// In en, this message translates to:
  /// **'− Set'**
  String get calisthenicsSectionRemoveSet;

  /// No description provided for @calisthenicsSetValuesReps.
  ///
  /// In en, this message translates to:
  /// **'{values} reps'**
  String calisthenicsSetValuesReps(String values);

  /// No description provided for @calisthenicsSetValueSeconds.
  ///
  /// In en, this message translates to:
  /// **'{seconds}s'**
  String calisthenicsSetValueSeconds(int seconds);

  /// No description provided for @calisthenicsSectionGoalUnitMismatch.
  ///
  /// In en, this message translates to:
  /// **'Logging in a different unit than this level\'s goal — goal tracking is paused.'**
  String get calisthenicsSectionGoalUnitMismatch;

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

  /// No description provided for @calisthenicsSectionLogIssueToggle.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Log an issue with this set'**
  String get calisthenicsSectionLogIssueToggle;

  /// No description provided for @calisthenicsSectionIssueLoggedConfirmation.
  ///
  /// In en, this message translates to:
  /// **'🩹 Issue logged — see it under Injuries & Structural Events.'**
  String get calisthenicsSectionIssueLoggedConfirmation;

  /// No description provided for @calisthenicsSectionGoalReps.
  ///
  /// In en, this message translates to:
  /// **'Goal: {sets} sets × {reps} reps'**
  String calisthenicsSectionGoalReps(int sets, int reps);

  /// No description provided for @calisthenicsSectionGoalRepsBothSides.
  ///
  /// In en, this message translates to:
  /// **'Goal: {sets} sets × {reps} reps (each side)'**
  String calisthenicsSectionGoalRepsBothSides(int sets, int reps);

  /// No description provided for @calisthenicsSectionGoalHold.
  ///
  /// In en, this message translates to:
  /// **'Goal: {sets} holds × {seconds}s'**
  String calisthenicsSectionGoalHold(int sets, int seconds);

  /// No description provided for @calisthenicsSectionGoalHoldBothSides.
  ///
  /// In en, this message translates to:
  /// **'Goal: {sets} holds × {seconds}s (each side)'**
  String calisthenicsSectionGoalHoldBothSides(int sets, int seconds);

  /// No description provided for @calisthenicsSectionGoalMetBadge.
  ///
  /// In en, this message translates to:
  /// **'🎯 Goal met!'**
  String get calisthenicsSectionGoalMetBadge;

  /// No description provided for @calisthenicsSectionGoalMilestoneCelebration.
  ///
  /// In en, this message translates to:
  /// **'🌟 3 sessions in a row hitting the goal for {exercise} — ready to try the next level whenever you are.'**
  String calisthenicsSectionGoalMilestoneCelebration(String exercise);

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

  /// No description provided for @calisthenicsSectionEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Set'**
  String get calisthenicsSectionEditTitle;

  /// No description provided for @calisthenicsSectionListItem.
  ///
  /// In en, this message translates to:
  /// **'{exercise} ({progression}) — {detail}'**
  String calisthenicsSectionListItem(
    String exercise,
    String progression,
    String detail,
  );

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

  /// No description provided for @commonHeartRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Heart Rate Range (bpm)'**
  String get commonHeartRateLabel;

  /// No description provided for @commonHeartRateMinPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Min bpm'**
  String get commonHeartRateMinPlaceholder;

  /// No description provided for @commonHeartRateMaxPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Max bpm'**
  String get commonHeartRateMaxPlaceholder;

  /// No description provided for @commonHeartRateRangeLabel.
  ///
  /// In en, this message translates to:
  /// **'HR {min}-{max} bpm'**
  String commonHeartRateRangeLabel(int min, int max);

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

  /// No description provided for @activitiesSectionEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Activity'**
  String get activitiesSectionEditTitle;

  /// No description provided for @injuriesSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'🩹 Injuries & Structural Events'**
  String get injuriesSectionTitle;

  /// No description provided for @sectionCollapsedLoggedCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 logged} other{{count} logged}}'**
  String sectionCollapsedLoggedCount(int count);

  /// No description provided for @sectionCollapsedActiveCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 active} other{{count} active}}'**
  String sectionCollapsedActiveCount(int count);

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

  /// No description provided for @therapiesSectionEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Therapy'**
  String get therapiesSectionEditTitle;

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

  /// No description provided for @commonEditButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEditButton;

  /// No description provided for @commonDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDeleteButton;

  /// No description provided for @commonDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this entry?'**
  String get commonDeleteConfirmTitle;

  /// No description provided for @commonDeleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This can\'t be undone.'**
  String get commonDeleteConfirmMessage;

  /// No description provided for @hydrationSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'☕ Hydration & Liquids'**
  String get hydrationSectionTitle;

  /// No description provided for @hydrationSectionEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Drink'**
  String get hydrationSectionEditTitle;

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
  String nutritionSectionProteinProgress(String protein, int goal);

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
  /// **'Log as often as you like — your latest check-in is the day\'s summary for trends and the PEM check.'**
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

  /// No description provided for @quickCheckinSectionSummary.
  ///
  /// In en, this message translates to:
  /// **'Day summary: {mental} · {body}'**
  String quickCheckinSectionSummary(String mental, String body);

  /// No description provided for @bracesSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'🦾 Braces'**
  String get bracesSectionTitle;

  /// No description provided for @bracesSectionAddOwn.
  ///
  /// In en, this message translates to:
  /// **'+ Add your own'**
  String get bracesSectionAddOwn;

  /// No description provided for @bracesSectionAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a brace'**
  String get bracesSectionAddTitle;

  /// No description provided for @bracesSectionAddPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Name, e.g. night splint'**
  String get bracesSectionAddPlaceholder;

  /// No description provided for @bracesSectionAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get bracesSectionAddButton;

  /// No description provided for @bracesSectionRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove “{name}” from your list?'**
  String bracesSectionRemoveTitle(String name);

  /// No description provided for @bracesSectionRemoveMessage.
  ///
  /// In en, this message translates to:
  /// **'Days you already logged keep it.'**
  String get bracesSectionRemoveMessage;

  /// No description provided for @bracesSectionRemoveButton.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get bracesSectionRemoveButton;

  /// No description provided for @bracesSectionCustomHint.
  ///
  /// In en, this message translates to:
  /// **'Long-press one of your own braces to remove it from the list.'**
  String get bracesSectionCustomHint;

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
  /// **'PDF summary'**
  String get exportSectionPdfButton;

  /// No description provided for @exportSectionPdfRangeTitle.
  ///
  /// In en, this message translates to:
  /// **'PDF summary period'**
  String get exportSectionPdfRangeTitle;

  /// No description provided for @exportSectionPdfRangeMessage.
  ///
  /// In en, this message translates to:
  /// **'Exporting is always free, for any period. It ends on the day selected at the top.'**
  String get exportSectionPdfRangeMessage;

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

  /// No description provided for @doctorReportMetsHeadingHealthConnect.
  ///
  /// In en, this message translates to:
  /// **'Energy & METs (from confirmed Health Connect workout imports)'**
  String get doctorReportMetsHeadingHealthConnect;

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

  /// No description provided for @principleNoBalanceNumberTitle.
  ///
  /// In en, this message translates to:
  /// **'Two Sides, Never One \"Balance\" Number'**
  String get principleNoBalanceNumberTitle;

  /// No description provided for @principleNoBalanceNumberFact.
  ///
  /// In en, this message translates to:
  /// **'HRV in the time domain (RMSSD) tracks the parasympathetic (vagal) side and was validated against atropine blockade. The spectral ratios sold as \"sympathetic/parasympathetic balance\" (LF/HF, normalised units) are not valid measures of vagal tone or of balance.'**
  String get principleNoBalanceNumberFact;

  /// No description provided for @principleNoBalanceNumberInspiration.
  ///
  /// In en, this message translates to:
  /// **'Your nervous system isn\'t a seesaw with one reading. That\'s why the app shows the rest side, the standing response and sweating separately, and never squeezes them into a score.'**
  String get principleNoBalanceNumberInspiration;

  /// No description provided for @principleOwnBaselineTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Own Normal, Not a Population Number'**
  String get principleOwnBaselineTitle;

  /// No description provided for @principleOwnBaselineFact.
  ///
  /// In en, this message translates to:
  /// **'Autonomic markers vary a lot between people, so they\'re read against the person\'s own recent history. Wrist heart rate is reliable at rest and during sleep, and much less so during cycling or strength work — which is why resting and overnight values are the ones compared.'**
  String get principleOwnBaselineFact;

  /// No description provided for @principleOwnBaselineInspiration.
  ///
  /// In en, this message translates to:
  /// **'\"Usual\" here means your usual. A number that would worry someone else may be an ordinary day for you, and the other way round.'**
  String get principleOwnBaselineInspiration;

  /// No description provided for @principleSignalsInformTitle.
  ///
  /// In en, this message translates to:
  /// **'Heart Signals Inform — They Don\'t Decide'**
  String get principleSignalsInformTitle;

  /// No description provided for @principleSignalsInformFact.
  ///
  /// In en, this message translates to:
  /// **'Almost all HRV research comes from athletes and heart patients, not from people with EDS, POTS or MCAS, and the published cut-offs predict mortality in cardiac cohorts. Ultra-short HRV windows are rarely validated.'**
  String get principleSignalsInformFact;

  /// No description provided for @principleSignalsInformInspiration.
  ///
  /// In en, this message translates to:
  /// **'So a low HRV or a higher resting pulse never shrinks your step envelope on its own. It\'s context you can weigh with how you feel — you stay the one who decides.'**
  String get principleSignalsInformInspiration;

  /// No description provided for @principleStandTestTitle.
  ///
  /// In en, this message translates to:
  /// **'Why the Stand Test Reads 1, 3 and 10 Minutes'**
  String get principleStandTestTitle;

  /// No description provided for @principleStandTestFact.
  ///
  /// In en, this message translates to:
  /// **'Consensus criteria define POTS as a heart-rate rise of 30 bpm or more within 10 minutes of standing (40 for ages 12–19) without orthostatic hypotension, and orthostatic hypotension as a fall of 20/10 mmHg or more within 3 minutes.'**
  String get principleStandTestFact;

  /// No description provided for @principleStandTestInspiration.
  ///
  /// In en, this message translates to:
  /// **'The app shows these as patterns worth mentioning to your doctor, never as a diagnosis. Your own history of tests matters just as much — and stopping early is always the right call.'**
  String get principleStandTestInspiration;

  /// No description provided for @principleSweatSignalTitle.
  ///
  /// In en, this message translates to:
  /// **'Sweating Is a Signal You Can Describe'**
  String get principleSweatSignalTitle;

  /// No description provided for @principleSweatSignalFact.
  ///
  /// In en, this message translates to:
  /// **'Sweat glands are driven by the sympathetic side only. Validated autonomic questionnaires include a secretomotor domain that asks about sweating, because what people report about their own symptoms is useful clinical information.'**
  String get principleSweatSignalFact;

  /// No description provided for @principleSweatSignalInspiration.
  ///
  /// In en, this message translates to:
  /// **'No sensor needed: noticing \"less than usual\" or \"cold and clammy\" is real data about your body, and it\'s yours to bring to your appointments.'**
  String get principleSweatSignalInspiration;

  /// No description provided for @principlePainMonitoringTitle.
  ///
  /// In en, this message translates to:
  /// **'Pain 0–2, 3–5, Above 5: the Pain-Monitoring Model'**
  String get principlePainMonitoringTitle;

  /// No description provided for @principlePainMonitoringFact.
  ///
  /// In en, this message translates to:
  /// **'Rehabilitation that lets pain reach up to 5/10 during exercise — as long as it settles by the next morning and isn\'t sharp — did as well as rest in a randomised trial, with no negative effects from staying active.'**
  String get principlePainMonitoringFact;

  /// No description provided for @principlePainMonitoringInspiration.
  ///
  /// In en, this message translates to:
  /// **'Some discomfort isn\'t damage. The plan\'s pain colours tell you when to keep going, when to hold, and when to step back — not when to give up.'**
  String get principlePainMonitoringInspiration;

  /// No description provided for @principleGradedExposureTitle.
  ///
  /// In en, this message translates to:
  /// **'Facing a Feared Movement, One Small Step at a Time'**
  String get principleGradedExposureTitle;

  /// No description provided for @principleGradedExposureFact.
  ///
  /// In en, this message translates to:
  /// **'In the fear-avoidance model, fear of pain — not pain intensity alone — leads to avoidance, disuse and more disability. Graded exposure tests the prediction step by step, and each time nothing bad happens the belief loosens.'**
  String get principleGradedExposureFact;

  /// No description provided for @principleGradedExposureInspiration.
  ///
  /// In en, this message translates to:
  /// **'That\'s why the fear ladder keeps an evidence list. Every \"I did it and nothing bad happened\" is proof your body collected for you.'**
  String get principleGradedExposureInspiration;

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

  /// No description provided for @commonOkButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOkButton;

  /// No description provided for @commonCloseButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonCloseButton;

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
  /// **'ZebraPace is a personal project, built by one zebra for other zebras, and offered freely.'**
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

  /// No description provided for @settingsTabHealthConnectTitle.
  ///
  /// In en, this message translates to:
  /// **'❤️ Health Connect'**
  String get settingsTabHealthConnectTitle;

  /// No description provided for @settingsTabHealthKitConnectedCaption.
  ///
  /// In en, this message translates to:
  /// **'Connected — steps, sleep and heart readings sync on their own, and workouts are suggested for review.'**
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

  /// No description provided for @settingsTabHealthConnectOpenSettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Open Health Connect to change access'**
  String get settingsTabHealthConnectOpenSettingsButton;

  /// No description provided for @settingsTabHealthKitConnectButton.
  ///
  /// In en, this message translates to:
  /// **'Connect Apple Health'**
  String get settingsTabHealthKitConnectButton;

  /// No description provided for @settingsTabHealthConnectConnectButton.
  ///
  /// In en, this message translates to:
  /// **'Connect Health Connect'**
  String get settingsTabHealthConnectConnectButton;

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
  /// **'Check your email — tap the link, or enter the 8-digit code below (recommended if you\'re using the app from your home screen).'**
  String get settingsTabCloudSyncLinkSent;

  /// No description provided for @settingsTabCloudSyncCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Or enter the code from that email'**
  String get settingsTabCloudSyncCodeLabel;

  /// No description provided for @settingsTabCloudSyncCodePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'8-digit code'**
  String get settingsTabCloudSyncCodePlaceholder;

  /// No description provided for @settingsTabCloudSyncVerifyCodeButton.
  ///
  /// In en, this message translates to:
  /// **'Verify code'**
  String get settingsTabCloudSyncVerifyCodeButton;

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

  /// No description provided for @settingsTabDeleteAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get settingsTabDeleteAccountButton;

  /// No description provided for @settingsTabDeleteAccountConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your account?'**
  String get settingsTabDeleteAccountConfirmTitle;

  /// No description provided for @settingsTabDeleteAccountConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes your account, your email, and everything you shared in weight challenges. Challenges you started pass to another member.\n\nYour health log stays on this device — use \"Delete all my data\" below to erase it too.'**
  String get settingsTabDeleteAccountConfirmMessage;

  /// No description provided for @settingsTabDeleteAccountConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get settingsTabDeleteAccountConfirmButton;

  /// No description provided for @settingsTabDeleteAccountDone.
  ///
  /// In en, this message translates to:
  /// **'Your account has been deleted.'**
  String get settingsTabDeleteAccountDone;

  /// No description provided for @settingsTabDeleteAccountFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t delete your account: {error}'**
  String settingsTabDeleteAccountFailed(String error);

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

  /// No description provided for @settingsTabLanguageChineseTraditional.
  ///
  /// In en, this message translates to:
  /// **'繁體中文'**
  String get settingsTabLanguageChineseTraditional;

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

  /// No description provided for @lockScreenSetupSubtitleAndroid.
  ///
  /// In en, this message translates to:
  /// **'This protects your health data on this device. You\'ll also be able to use your fingerprint or face unlock once this is set.'**
  String get lockScreenSetupSubtitleAndroid;

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

  /// No description provided for @lockScreenBiometricUnlockButtonAndroid.
  ///
  /// In en, this message translates to:
  /// **'Unlock with fingerprint or face'**
  String get lockScreenBiometricUnlockButtonAndroid;

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

  /// No description provided for @lockScreenSetupForgetWarning.
  ///
  /// In en, this message translates to:
  /// **'This password can\'t be recovered. If you forget it, the only way back in is erasing ZebraPace\'s data on this phone, so keep it somewhere safe.'**
  String get lockScreenSetupForgetWarning;

  /// No description provided for @lockScreenForgotPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get lockScreenForgotPasswordButton;

  /// No description provided for @lockScreenForgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Erase and start over?'**
  String get lockScreenForgotPasswordTitle;

  /// No description provided for @lockScreenForgotPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'The password can\'t be recovered. To let you back in, ZebraPace will erase everything you\'ve logged on this phone and sign you out of challenges, then ask for a new password. Your goals and settings are kept. This can\'t be undone.'**
  String get lockScreenForgotPasswordMessage;

  /// No description provided for @lockScreenForgotPasswordConfirm.
  ///
  /// In en, this message translates to:
  /// **'Erase my log'**
  String get lockScreenForgotPasswordConfirm;

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

  /// No description provided for @appShellTabChallenge.
  ///
  /// In en, this message translates to:
  /// **'Together'**
  String get appShellTabChallenge;

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

  /// No description provided for @healthConnectWorkoutSuggestionsConnectTitle.
  ///
  /// In en, this message translates to:
  /// **'❤️ Connect Health Connect'**
  String get healthConnectWorkoutSuggestionsConnectTitle;

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

  /// No description provided for @healthkitWorkoutSuggestionsDetailsToggle.
  ///
  /// In en, this message translates to:
  /// **'Add extra weight or how it felt'**
  String get healthkitWorkoutSuggestionsDetailsToggle;

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

  /// No description provided for @vitalsTabLowEnergyNote.
  ///
  /// In en, this message translates to:
  /// **'Low-energy day — just the essentials. The rest can wait.'**
  String get vitalsTabLowEnergyNote;

  /// No description provided for @vitalsTabShowAllButton.
  ///
  /// In en, this message translates to:
  /// **'Show all sections'**
  String get vitalsTabShowAllButton;

  /// No description provided for @vitalsTabShowEssentialsButton.
  ///
  /// In en, this message translates to:
  /// **'Show only the essentials'**
  String get vitalsTabShowEssentialsButton;

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

  /// No description provided for @vitalsMetricsRowCheckinLabel.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get vitalsMetricsRowCheckinLabel;

  /// No description provided for @vitalsMetricsRowSleepLabel.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get vitalsMetricsRowSleepLabel;

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

  /// No description provided for @insightsTabBodyMetricsTitle.
  ///
  /// In en, this message translates to:
  /// **'⚖️ Weight & Body Composition'**
  String get insightsTabBodyMetricsTitle;

  /// No description provided for @bodyMetricsChartEmptyState.
  ///
  /// In en, this message translates to:
  /// **'No weight or body-fat entries in range.'**
  String get bodyMetricsChartEmptyState;

  /// No description provided for @insightsTabHeartTitle.
  ///
  /// In en, this message translates to:
  /// **'❤️ Resting heart rate & HRV'**
  String get insightsTabHeartTitle;

  /// No description provided for @heartTrendRestingLabel.
  ///
  /// In en, this message translates to:
  /// **'Resting heart rate (bpm)'**
  String get heartTrendRestingLabel;

  /// No description provided for @heartTrendSleepingLabel.
  ///
  /// In en, this message translates to:
  /// **'Lowest sleeping heart rate (bpm)'**
  String get heartTrendSleepingLabel;

  /// No description provided for @heartTrendHrvLabel.
  ///
  /// In en, this message translates to:
  /// **'Heart rate variability (ms)'**
  String get heartTrendHrvLabel;

  /// No description provided for @heartTrendEmptyState.
  ///
  /// In en, this message translates to:
  /// **'No resting heart rate or HRV in this range yet. They come from a watch or ring through your phone\'s health app, or from what you type into the Sleep section.'**
  String get heartTrendEmptyState;

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

  /// No description provided for @healthSourceAppleHealth.
  ///
  /// In en, this message translates to:
  /// **'From Apple Health'**
  String get healthSourceAppleHealth;

  /// No description provided for @healthSourceHealthConnect.
  ///
  /// In en, this message translates to:
  /// **'From Health Connect'**
  String get healthSourceHealthConnect;

  /// No description provided for @healthSourceManual.
  ///
  /// In en, this message translates to:
  /// **'Edited by you'**
  String get healthSourceManual;

  /// No description provided for @healthEditButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get healthEditButton;

  /// No description provided for @healthUseHealthButton.
  ///
  /// In en, this message translates to:
  /// **'Use Health value'**
  String get healthUseHealthButton;

  /// No description provided for @healthCancelEditButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get healthCancelEditButton;

  /// No description provided for @stepsSectionWaitingForHealth.
  ///
  /// In en, this message translates to:
  /// **'No steps from Health yet today.'**
  String get stepsSectionWaitingForHealth;

  /// No description provided for @sleepSectionWaitingForHealth.
  ///
  /// In en, this message translates to:
  /// **'Nothing from Health for last night yet.'**
  String get sleepSectionWaitingForHealth;

  /// No description provided for @stepsSectionStepsValue.
  ///
  /// In en, this message translates to:
  /// **'{steps} steps'**
  String stepsSectionStepsValue(int steps);

  /// No description provided for @sleepSectionHeartRateRangeValue.
  ///
  /// In en, this message translates to:
  /// **'Heart rate while sleeping {min}–{max} bpm'**
  String sleepSectionHeartRateRangeValue(String min, String max);

  /// No description provided for @sleepSectionRestingValue.
  ///
  /// In en, this message translates to:
  /// **'Resting {bpm} bpm'**
  String sleepSectionRestingValue(int bpm);

  /// No description provided for @sleepSectionHrvValue.
  ///
  /// In en, this message translates to:
  /// **'HRV {ms} ms'**
  String sleepSectionHrvValue(int ms);

  /// No description provided for @sleepSectionMorningLabel.
  ///
  /// In en, this message translates to:
  /// **'Resting heart rate & HRV (optional)'**
  String get sleepSectionMorningLabel;

  /// No description provided for @sleepSectionRestingPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Resting bpm'**
  String get sleepSectionRestingPlaceholder;

  /// No description provided for @sleepSectionHrvPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'HRV ms'**
  String get sleepSectionHrvPlaceholder;

  /// No description provided for @sleepSectionStagesLabel.
  ///
  /// In en, this message translates to:
  /// **'REM & deep sleep (optional)'**
  String get sleepSectionStagesLabel;

  /// No description provided for @sleepSectionRemPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'REM min'**
  String get sleepSectionRemPlaceholder;

  /// No description provided for @sleepSectionDeepPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Deep min'**
  String get sleepSectionDeepPlaceholder;

  /// No description provided for @sleepSectionRemValue.
  ///
  /// In en, this message translates to:
  /// **'REM {minutes} min'**
  String sleepSectionRemValue(int minutes);

  /// No description provided for @sleepSectionDeepValue.
  ///
  /// In en, this message translates to:
  /// **'Deep {minutes} min'**
  String sleepSectionDeepValue(int minutes);

  /// No description provided for @sleepSectionNightmaresLabel.
  ///
  /// In en, this message translates to:
  /// **'Nightmares'**
  String get sleepSectionNightmaresLabel;

  /// No description provided for @sleepSectionNightmaresCaption.
  ///
  /// In en, this message translates to:
  /// **'Just whether there were any'**
  String get sleepSectionNightmaresCaption;

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
  /// **'👣 Steps (14-day rolling avg)'**
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

  /// No description provided for @insightsTabHrExertionTitle.
  ///
  /// In en, this message translates to:
  /// **'❤️ Exertion Intensity vs. Symptoms'**
  String get insightsTabHrExertionTitle;

  /// No description provided for @insightsTabHrExertionCaption.
  ///
  /// In en, this message translates to:
  /// **'Peak heart rate on activity/calisthenics days vs. body score N days later — how hard a day ran, not just how much of it.'**
  String get insightsTabHrExertionCaption;

  /// No description provided for @insightsTabPemLagLabel.
  ///
  /// In en, this message translates to:
  /// **'Compare with how you felt this many days later:'**
  String get insightsTabPemLagLabel;

  /// No description provided for @insightsViewOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get insightsViewOverview;

  /// No description provided for @insightsViewTrends.
  ///
  /// In en, this message translates to:
  /// **'Trends'**
  String get insightsViewTrends;

  /// No description provided for @insightsViewPatterns.
  ///
  /// In en, this message translates to:
  /// **'Patterns'**
  String get insightsViewPatterns;

  /// No description provided for @insightsViewRecords.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get insightsViewRecords;

  /// No description provided for @insightsPatternHeadlineLower.
  ///
  /// In en, this message translates to:
  /// **'After higher-exertion days, your body score {lag} later averaged lower: {higherAvg} vs. {typicalAvg}.'**
  String insightsPatternHeadlineLower(
    String lag,
    String higherAvg,
    String typicalAvg,
  );

  /// No description provided for @insightsPatternHeadlineNoDip.
  ///
  /// In en, this message translates to:
  /// **'So far, no clear dip in your body score {lag} after higher-exertion days: {higherAvg} vs. {typicalAvg}.'**
  String insightsPatternHeadlineNoDip(
    String lag,
    String higherAvg,
    String typicalAvg,
  );

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

  /// No description provided for @metsSummaryWidgetCaptionHealthConnect.
  ///
  /// In en, this message translates to:
  /// **'From confirmed Health Connect workout imports in this range.'**
  String get metsSummaryWidgetCaptionHealthConnect;

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

  /// No description provided for @insightsRangeSixMonths.
  ///
  /// In en, this message translates to:
  /// **'6 mo'**
  String get insightsRangeSixMonths;

  /// No description provided for @insightsRangeOneYear.
  ///
  /// In en, this message translates to:
  /// **'1 yr'**
  String get insightsRangeOneYear;

  /// No description provided for @insightsRangeAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get insightsRangeAll;

  /// No description provided for @challengeTabTitle.
  ///
  /// In en, this message translates to:
  /// **'Together'**
  String get challengeTabTitle;

  /// No description provided for @challengeTabSignInPrompt.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Cloud Sync to take on challenges together with your friends.'**
  String get challengeTabSignInPrompt;

  /// No description provided for @challengeTabSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get challengeTabSignInButton;

  /// No description provided for @challengeTabLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your progress. Check your connection and try again.'**
  String get challengeTabLoadError;

  /// No description provided for @challengeTabJoinTitle.
  ///
  /// In en, this message translates to:
  /// **'🤝 Together'**
  String get challengeTabJoinTitle;

  /// No description provided for @challengeTabJoinCaption.
  ///
  /// In en, this message translates to:
  /// **'Join a friend\'s challenge with their code, or start your own.'**
  String get challengeTabJoinCaption;

  /// No description provided for @challengeTabSharingNotice.
  ///
  /// In en, this message translates to:
  /// **'Shared with this group: the name you choose and, for each day of the challenge, your value (steps, sleep hours, active minutes or whether you logged; your weight in weight challenges), whether you met your goal, and whether it was a rest or flare day. Nothing else from your log leaves your phone. By joining or creating a challenge you agree to share this. Deleting your account in Settings removes it all.'**
  String get challengeTabSharingNotice;

  /// No description provided for @challengeTabModeJoin.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get challengeTabModeJoin;

  /// No description provided for @challengeTabModeCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get challengeTabModeCreate;

  /// No description provided for @challengeTabChallengeNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Challenge name'**
  String get challengeTabChallengeNamePlaceholder;

  /// No description provided for @challengeTabCodePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Invite code'**
  String get challengeTabCodePlaceholder;

  /// No description provided for @challengeTabNewCodePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Choose a code'**
  String get challengeTabNewCodePlaceholder;

  /// No description provided for @challengeTabNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get challengeTabNamePlaceholder;

  /// No description provided for @challengeTabStartWeightPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Starting weight (kg)'**
  String get challengeTabStartWeightPlaceholder;

  /// No description provided for @challengeTabJoinButton.
  ///
  /// In en, this message translates to:
  /// **'Join in'**
  String get challengeTabJoinButton;

  /// No description provided for @challengeTabCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get challengeTabCreateButton;

  /// No description provided for @challengeTabActionError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Check the code and try again.'**
  String get challengeTabActionError;

  /// No description provided for @challengeTabInviteHint.
  ///
  /// In en, this message translates to:
  /// **'Invite friends with code {code}'**
  String challengeTabInviteHint(String code);

  /// No description provided for @challengeTabCopyCodeButton.
  ///
  /// In en, this message translates to:
  /// **'Copy code'**
  String get challengeTabCopyCodeButton;

  /// No description provided for @challengeTabCodeCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied!'**
  String get challengeTabCodeCopied;

  /// No description provided for @challengeTabMyProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'My Progress'**
  String get challengeTabMyProgressTitle;

  /// No description provided for @challengeTabMyProgressCaption.
  ///
  /// In en, this message translates to:
  /// **'You\'re at {percent} so far.'**
  String challengeTabMyProgressCaption(String percent);

  /// No description provided for @challengeTabWeightAutoSyncHint.
  ///
  /// In en, this message translates to:
  /// **'Synced automatically from your weigh-ins in Vitals (last 7 days, outliers trimmed).'**
  String get challengeTabWeightAutoSyncHint;

  /// No description provided for @challengeTabWeightNoRecentEntryHint.
  ///
  /// In en, this message translates to:
  /// **'No weigh-in in the last 7 days yet — showing your last synced weight.'**
  String get challengeTabWeightNoRecentEntryHint;

  /// No description provided for @challengeTabStartWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get challengeTabStartWeightLabel;

  /// No description provided for @challengeTabGoalWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get challengeTabGoalWeightLabel;

  /// No description provided for @challengeTabLeaderboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Everyone\'s Progress'**
  String get challengeTabLeaderboardTitle;

  /// No description provided for @challengeTabProgressChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress Over Time'**
  String get challengeTabProgressChartTitle;

  /// No description provided for @challengeTabProgressChartEmptyState.
  ///
  /// In en, this message translates to:
  /// **'Once at least two of you have a couple of weigh-ins logged, your trends will show up here.'**
  String get challengeTabProgressChartEmptyState;

  /// No description provided for @challengeTabProgressChartStartLabel.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get challengeTabProgressChartStartLabel;

  /// No description provided for @challengeTabProgressChartGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get challengeTabProgressChartGoalLabel;

  /// No description provided for @challengeTabYouLabel.
  ///
  /// In en, this message translates to:
  /// **'{name} (you)'**
  String challengeTabYouLabel(String name);

  /// No description provided for @stepsSectionTodayGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Today\'s goal'**
  String get stepsSectionTodayGoalLabel;

  /// No description provided for @stepsSectionMessageReadinessHonored.
  ///
  /// In en, this message translates to:
  /// **'🌙 Logged. Your body asked for less today and you listened. Rest is part of the plan, not a missed target.'**
  String get stepsSectionMessageReadinessHonored;

  /// No description provided for @readinessSteadyHeadline.
  ///
  /// In en, this message translates to:
  /// **'💚 Your body\'s signals look steady. Usual envelope today.'**
  String get readinessSteadyHeadline;

  /// No description provided for @readinessLowerHeadline.
  ///
  /// In en, this message translates to:
  /// **'🌙 Your body is asking to hold steady today, so there\'s no growth goal.'**
  String get readinessLowerHeadline;

  /// No description provided for @readinessLowHeadline.
  ///
  /// In en, this message translates to:
  /// **'🌙 Your body is asking for a smaller day, so today\'s envelope is smaller.'**
  String get readinessLowHeadline;

  /// No description provided for @readinessAutonomicAwayHeadline.
  ///
  /// In en, this message translates to:
  /// **'Your heart signals are further from your usual today. Just information: your envelope stays the same.'**
  String get readinessAutonomicAwayHeadline;

  /// No description provided for @readinessReasonRestingHeartRate.
  ///
  /// In en, this message translates to:
  /// **'Resting heart rate is {bpm} bpm above your usual.'**
  String readinessReasonRestingHeartRate(int bpm);

  /// No description provided for @readinessReasonHrv.
  ///
  /// In en, this message translates to:
  /// **'Heart rate variability is {percent}% below your usual.'**
  String readinessReasonHrv(int percent);

  /// No description provided for @readinessReasonRecoveryWindow.
  ///
  /// In en, this message translates to:
  /// **'Soreness is lasting past the 72-hour recovery window.'**
  String get readinessReasonRecoveryWindow;

  /// No description provided for @readinessReasonPossibleCrash.
  ///
  /// In en, this message translates to:
  /// **'A recent soreness check looked like a possible crash.'**
  String get readinessReasonPossibleCrash;

  /// No description provided for @readinessRestingLine.
  ///
  /// In en, this message translates to:
  /// **'Resting heart rate {bpm} bpm'**
  String readinessRestingLine(int bpm);

  /// No description provided for @readinessSleepingLine.
  ///
  /// In en, this message translates to:
  /// **'Lowest sleeping heart rate {bpm} bpm'**
  String readinessSleepingLine(int bpm);

  /// No description provided for @readinessHrvLine.
  ///
  /// In en, this message translates to:
  /// **'HRV {ms} ms'**
  String readinessHrvLine(int ms);

  /// No description provided for @readinessUsual.
  ///
  /// In en, this message translates to:
  /// **'your usual {value}'**
  String readinessUsual(int value);

  /// No description provided for @readinessUsualPending.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{your usual shows after 1 more day} other{your usual shows after {days} more days}}'**
  String readinessUsualPending(int days);

  /// No description provided for @stopSignalsTitle.
  ///
  /// In en, this message translates to:
  /// **'🛑 When to stop'**
  String get stopSignalsTitle;

  /// No description provided for @stopSignalsReserve.
  ///
  /// In en, this message translates to:
  /// **'End each set with 1–2 clean reps still in reserve. Never train to failure.'**
  String get stopSignalsReserve;

  /// No description provided for @stopSignalsTempo.
  ///
  /// In en, this message translates to:
  /// **'Move slowly and with control, so your muscles hold the joint instead of momentum or your ligaments.'**
  String get stopSignalsTempo;

  /// No description provided for @stopSignalsRedFlagsTitle.
  ///
  /// In en, this message translates to:
  /// **'Stop right away if you notice:'**
  String get stopSignalsRedFlagsTitle;

  /// No description provided for @stopSignalsDizziness.
  ///
  /// In en, this message translates to:
  /// **'Dizziness or light-headedness'**
  String get stopSignalsDizziness;

  /// No description provided for @stopSignalsRacingHeart.
  ///
  /// In en, this message translates to:
  /// **'A sudden racing heart, especially when you stand up'**
  String get stopSignalsRacingHeart;

  /// No description provided for @stopSignalsCoordination.
  ///
  /// In en, this message translates to:
  /// **'Losing coordination, or not sensing where a joint is'**
  String get stopSignalsCoordination;

  /// No description provided for @stopSignalsJointPain.
  ///
  /// In en, this message translates to:
  /// **'Sharp joint pain'**
  String get stopSignalsJointPain;

  /// No description provided for @stopSignalsAfterward.
  ///
  /// In en, this message translates to:
  /// **'Soreness that is still there, or getting worse, after 72 hours means the last session was too much. Scale back next time.'**
  String get stopSignalsAfterward;

  /// No description provided for @settingsTabHealthReadinessCaption.
  ///
  /// In en, this message translates to:
  /// **'ZebraPace can now read resting heart rate and heart rate variability and show them next to your own usual. They\'re information only and never change your step goal.'**
  String get settingsTabHealthReadinessCaption;

  /// No description provided for @settingsTabHealthReadinessButton.
  ///
  /// In en, this message translates to:
  /// **'Allow resting heart rate & HRV'**
  String get settingsTabHealthReadinessButton;

  /// No description provided for @settingsTabHealthSleepCaption.
  ///
  /// In en, this message translates to:
  /// **'ZebraPace can now read your sleep to fill in last night\'s duration and sleeping heart rate for you.'**
  String get settingsTabHealthSleepCaption;

  /// No description provided for @settingsTabHealthSleepButton.
  ///
  /// In en, this message translates to:
  /// **'Allow sleep'**
  String get settingsTabHealthSleepButton;

  /// No description provided for @challengeKindWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get challengeKindWeight;

  /// No description provided for @challengeKindSteps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get challengeKindSteps;

  /// No description provided for @challengeKindLogging.
  ///
  /// In en, this message translates to:
  /// **'Daily logging'**
  String get challengeKindLogging;

  /// No description provided for @challengeKindSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get challengeKindSleep;

  /// No description provided for @challengeKindActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get challengeKindActivity;

  /// No description provided for @challengeTabKindLabel.
  ///
  /// In en, this message translates to:
  /// **'What will you track?'**
  String get challengeTabKindLabel;

  /// No description provided for @challengeTabDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get challengeTabDurationLabel;

  /// No description provided for @challengeTabWeeksLabel.
  ///
  /// In en, this message translates to:
  /// **'{weeks, plural, =1{1 week} other{{weeks} weeks}}'**
  String challengeTabWeeksLabel(int weeks);

  /// No description provided for @challengeTabWeekProgress.
  ///
  /// In en, this message translates to:
  /// **'Week {week} of {total}'**
  String challengeTabWeekProgress(int week, int total);

  /// No description provided for @challengeTabFinished.
  ///
  /// In en, this message translates to:
  /// **'Challenge finished 🎉'**
  String get challengeTabFinished;

  /// No description provided for @challengeTabSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Set your goal'**
  String get challengeTabSetupTitle;

  /// No description provided for @challengeTabSetupWeightCaption.
  ///
  /// In en, this message translates to:
  /// **'Your starting weight — your progress is measured from here.'**
  String get challengeTabSetupWeightCaption;

  /// No description provided for @challengeTabSetupGoalCaption.
  ///
  /// In en, this message translates to:
  /// **'Pick a daily goal that fits your body. Every day you meet it is a point — everyone competes against their own goal, not each other\'s numbers.'**
  String get challengeTabSetupGoalCaption;

  /// No description provided for @challengeTabSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get challengeTabSaveButton;

  /// No description provided for @challengeGoalStepsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Steps per day'**
  String get challengeGoalStepsPlaceholder;

  /// No description provided for @challengeGoalSleepPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Hours of sleep per night'**
  String get challengeGoalSleepPlaceholder;

  /// No description provided for @challengeGoalActivityPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Active minutes per day'**
  String get challengeGoalActivityPlaceholder;

  /// No description provided for @challengeGoalSteps.
  ///
  /// In en, this message translates to:
  /// **'{value} steps'**
  String challengeGoalSteps(String value);

  /// No description provided for @challengeGoalSleep.
  ///
  /// In en, this message translates to:
  /// **'{value} h of sleep'**
  String challengeGoalSleep(String value);

  /// No description provided for @challengeGoalActivity.
  ///
  /// In en, this message translates to:
  /// **'{value} active min'**
  String challengeGoalActivity(String value);

  /// No description provided for @challengeGoalLogging.
  ///
  /// In en, this message translates to:
  /// **'Log something every day'**
  String get challengeGoalLogging;

  /// No description provided for @challengeTabMyGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Your goal: {goal}'**
  String challengeTabMyGoalLabel(String goal);

  /// No description provided for @challengeTabChangeGoalButton.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get challengeTabChangeGoalButton;

  /// No description provided for @challengeTabThisWeekLabel.
  ///
  /// In en, this message translates to:
  /// **'{met}/7 this week'**
  String challengeTabThisWeekLabel(int met);

  /// No description provided for @challengeTabTotalDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day met} other{{count} days met}} in total'**
  String challengeTabTotalDays(int count);

  /// No description provided for @challengeTabDailySyncHint.
  ///
  /// In en, this message translates to:
  /// **'Updated automatically from what you log in ZebraPace.'**
  String get challengeTabDailySyncHint;

  /// No description provided for @challengeTabRestDayHint.
  ///
  /// In en, this message translates to:
  /// **'Rest and flare days count as met — resting is part of pacing.'**
  String get challengeTabRestDayHint;

  /// No description provided for @challengeTabLoggingHint.
  ///
  /// In en, this message translates to:
  /// **'A day counts when you do a check-in, log an activity, mark a rest/flare day, or enter your weight.'**
  String get challengeTabLoggingHint;

  /// No description provided for @challengeTabNoGoalYet.
  ///
  /// In en, this message translates to:
  /// **'No goal yet'**
  String get challengeTabNoGoalYet;

  /// No description provided for @challengeTabDayRestLegend.
  ///
  /// In en, this message translates to:
  /// **'rest day'**
  String get challengeTabDayRestLegend;

  /// No description provided for @appShellTabPlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get appShellTabPlan;

  /// No description provided for @planEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your training plan'**
  String get planEmptyTitle;

  /// No description provided for @planEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Write down the routine you and your physio or coach agreed on: phases, weekly sessions, each exercise\'s steps. Then follow it here day by day, at whatever level today allows.'**
  String get planEmptyBody;

  /// No description provided for @planCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'Create my plan'**
  String get planCreateTitle;

  /// No description provided for @planEditBasicsTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit plan details'**
  String get planEditBasicsTitle;

  /// No description provided for @planEditorDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'A plan you write here is a tool to follow your clinician\'s advice, not a replacement for it.'**
  String get planEditorDisclaimer;

  /// No description provided for @planNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get planNameLabel;

  /// No description provided for @planNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. My 12-week program'**
  String get planNameHint;

  /// No description provided for @planStartLabel.
  ///
  /// In en, this message translates to:
  /// **'Starts on'**
  String get planStartLabel;

  /// No description provided for @planWeeksLabel.
  ///
  /// In en, this message translates to:
  /// **'Length in weeks'**
  String get planWeeksLabel;

  /// No description provided for @planCeilingLabel.
  ///
  /// In en, this message translates to:
  /// **'Weekly ceiling (minutes)'**
  String get planCeilingLabel;

  /// No description provided for @planCeilingHint.
  ///
  /// In en, this message translates to:
  /// **'Optional. All logged movement counts toward it.'**
  String get planCeilingHint;

  /// No description provided for @planFloorLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily floor'**
  String get planFloorLabel;

  /// No description provided for @planFloorHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 10 calf raises at the counter, 10 quad sets'**
  String get planFloorHint;

  /// No description provided for @planEditorTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit plan'**
  String get planEditorTitle;

  /// No description provided for @planEditButton.
  ///
  /// In en, this message translates to:
  /// **'Edit plan'**
  String get planEditButton;

  /// No description provided for @planBasicsSummary.
  ///
  /// In en, this message translates to:
  /// **'{weeks} weeks'**
  String planBasicsSummary(int weeks);

  /// No description provided for @planCeilingSummary.
  ///
  /// In en, this message translates to:
  /// **'ceiling {minutes} min a week'**
  String planCeilingSummary(int minutes);

  /// No description provided for @planFloorSummary.
  ///
  /// In en, this message translates to:
  /// **'Daily floor: {note}'**
  String planFloorSummary(String note);

  /// No description provided for @planPhasesTitle.
  ///
  /// In en, this message translates to:
  /// **'Phases'**
  String get planPhasesTitle;

  /// No description provided for @planPhasesCaption.
  ///
  /// In en, this message translates to:
  /// **'Each phase raises one thing. You move on when you pass its gate, not when the calendar says so.'**
  String get planPhasesCaption;

  /// No description provided for @planAddPhase.
  ///
  /// In en, this message translates to:
  /// **'Add phase'**
  String get planAddPhase;

  /// No description provided for @planPhaseNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get planPhaseNameLabel;

  /// No description provided for @planPhaseNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Re-establish'**
  String get planPhaseNameHint;

  /// No description provided for @planPhaseGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get planPhaseGoalLabel;

  /// No description provided for @planPhaseEffortLabel.
  ///
  /// In en, this message translates to:
  /// **'Effort'**
  String get planPhaseEffortLabel;

  /// No description provided for @planPhaseCardioLabel.
  ///
  /// In en, this message translates to:
  /// **'Cardio'**
  String get planPhaseCardioLabel;

  /// No description provided for @planPhaseGateLabel.
  ///
  /// In en, this message translates to:
  /// **'Gate to move on'**
  String get planPhaseGateLabel;

  /// No description provided for @planPhaseGateHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 2 weeks with 2–3 comfortable sessions, pain settling by next morning'**
  String get planPhaseGateHint;

  /// No description provided for @planSessionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly sessions'**
  String get planSessionsTitle;

  /// No description provided for @planSessionsCaption.
  ///
  /// In en, this message translates to:
  /// **'Tap a session to add its exercises.'**
  String get planSessionsCaption;

  /// No description provided for @planAddSession.
  ///
  /// In en, this message translates to:
  /// **'Add session'**
  String get planAddSession;

  /// No description provided for @planSessionNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get planSessionNameLabel;

  /// No description provided for @planSessionNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. A: strength'**
  String get planSessionNameHint;

  /// No description provided for @planSessionDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get planSessionDayLabel;

  /// No description provided for @planAnyDay.
  ///
  /// In en, this message translates to:
  /// **'Any day'**
  String get planAnyDay;

  /// No description provided for @planSessionDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get planSessionDurationLabel;

  /// No description provided for @planSessionLowDayLabel.
  ///
  /// In en, this message translates to:
  /// **'On a low day'**
  String get planSessionLowDayLabel;

  /// No description provided for @planSessionLowDayHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Ankle isometrics only'**
  String get planSessionLowDayHint;

  /// No description provided for @planSessionCardioLabel.
  ///
  /// In en, this message translates to:
  /// **'Cardio session'**
  String get planSessionCardioLabel;

  /// No description provided for @planSessionCardioCaption.
  ///
  /// In en, this message translates to:
  /// **'Also saves it as an activity in Movement, so charts and challenges see it.'**
  String get planSessionCardioCaption;

  /// No description provided for @planCardioTag.
  ///
  /// In en, this message translates to:
  /// **'cardio'**
  String get planCardioTag;

  /// No description provided for @planMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String planMinutes(int minutes);

  /// No description provided for @planDeletePlan.
  ///
  /// In en, this message translates to:
  /// **'Delete this plan'**
  String get planDeletePlan;

  /// No description provided for @planSessionGone.
  ///
  /// In en, this message translates to:
  /// **'This was deleted.'**
  String get planSessionGone;

  /// No description provided for @planSessionDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get planSessionDetailsTitle;

  /// No description provided for @planLowDaySummary.
  ///
  /// In en, this message translates to:
  /// **'On a low day: {note}'**
  String planLowDaySummary(String note);

  /// No description provided for @planExercisesTitle.
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get planExercisesTitle;

  /// No description provided for @planExercisesCaption.
  ///
  /// In en, this message translates to:
  /// **'An exercise is a slot like \"Push\" or \"Calf\". Inside it you list its steps, easiest first.'**
  String get planExercisesCaption;

  /// No description provided for @planAddExercise.
  ///
  /// In en, this message translates to:
  /// **'Add exercise'**
  String get planAddExercise;

  /// No description provided for @planExerciseNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get planExerciseNameLabel;

  /// No description provided for @planExerciseNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Push'**
  String get planExerciseNameHint;

  /// No description provided for @planExerciseCueLabel.
  ///
  /// In en, this message translates to:
  /// **'How to do it'**
  String get planExerciseCueLabel;

  /// No description provided for @planExerciseCueHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Elbows soft, shoulders down'**
  String get planExerciseCueHint;

  /// No description provided for @planNoStepsYet.
  ///
  /// In en, this message translates to:
  /// **'No steps yet'**
  String get planNoStepsYet;

  /// No description provided for @planStepsTitle.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get planStepsTitle;

  /// No description provided for @planStepsCaption.
  ///
  /// In en, this message translates to:
  /// **'Easiest first. The filled circle is where you are now; tap a circle to change it.'**
  String get planStepsCaption;

  /// No description provided for @planAddStep.
  ///
  /// In en, this message translates to:
  /// **'Add step'**
  String get planAddStep;

  /// No description provided for @planCurrentStepHint.
  ///
  /// In en, this message translates to:
  /// **'Moving up happens on the Plan tab once three sessions felt comfortable.'**
  String get planCurrentStepHint;

  /// No description provided for @planStepNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get planStepNameLabel;

  /// No description provided for @planStepNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Wall push-up'**
  String get planStepNameHint;

  /// No description provided for @planStepDoseLabel.
  ///
  /// In en, this message translates to:
  /// **'Dose'**
  String get planStepDoseLabel;

  /// No description provided for @planStepDoseHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 1→3 × 4–6'**
  String get planStepDoseHint;

  /// No description provided for @planStepClearanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Needs clinician sign-off'**
  String get planStepClearanceLabel;

  /// No description provided for @planStepClearanceCaption.
  ///
  /// In en, this message translates to:
  /// **'Stays locked until you mark it cleared.'**
  String get planStepClearanceCaption;

  /// No description provided for @planStepClearedLabel.
  ///
  /// In en, this message translates to:
  /// **'Cleared'**
  String get planStepClearedLabel;

  /// No description provided for @planStartsLater.
  ///
  /// In en, this message translates to:
  /// **'Starts soon'**
  String get planStartsLater;

  /// No description provided for @planWeekOf.
  ///
  /// In en, this message translates to:
  /// **'Week {week} of {total}'**
  String planWeekOf(int week, int total);

  /// No description provided for @planNoSessionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Add your sessions'**
  String get planNoSessionsTitle;

  /// No description provided for @planNoSessionsBody.
  ///
  /// In en, this message translates to:
  /// **'Tap Edit plan to add your weekly sessions and their exercises.'**
  String get planNoSessionsBody;

  /// No description provided for @planTodayNoSession.
  ///
  /// In en, this message translates to:
  /// **'No session planned today'**
  String get planTodayNoSession;

  /// No description provided for @planModeFull.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get planModeFull;

  /// No description provided for @planModeLowDay.
  ///
  /// In en, this message translates to:
  /// **'Low day'**
  String get planModeLowDay;

  /// No description provided for @planModeFloor.
  ///
  /// In en, this message translates to:
  /// **'Floor only'**
  String get planModeFloor;

  /// No description provided for @planOtherSession.
  ///
  /// In en, this message translates to:
  /// **'Do a different session'**
  String get planOtherSession;

  /// No description provided for @planNoDoubleUp.
  ///
  /// In en, this message translates to:
  /// **'Missed sessions are skipped, never doubled up.'**
  String get planNoDoubleUp;

  /// No description provided for @planRestHint.
  ///
  /// In en, this message translates to:
  /// **'Resting? Tap Rest day at the top — it counts just the same.'**
  String get planRestHint;

  /// No description provided for @planRestLogged.
  ///
  /// In en, this message translates to:
  /// **'Rest day'**
  String get planRestLogged;

  /// No description provided for @planFlareLogged.
  ///
  /// In en, this message translates to:
  /// **'Flare day'**
  String get planFlareLogged;

  /// No description provided for @planFlareNote.
  ///
  /// In en, this message translates to:
  /// **'After a flare: floor or full rest for about 3 days, then your last comfortable level. Never restart from zero, never add load to catch up.'**
  String get planFlareNote;

  /// No description provided for @planMorningTitle.
  ///
  /// In en, this message translates to:
  /// **'How is it this morning?'**
  String get planMorningTitle;

  /// No description provided for @planMorningCaption.
  ///
  /// In en, this message translates to:
  /// **'After {session}, compared with your usual baseline.'**
  String planMorningCaption(String session);

  /// No description provided for @planNextMorningSettled.
  ///
  /// In en, this message translates to:
  /// **'At or below usual'**
  String get planNextMorningSettled;

  /// No description provided for @planNextMorningHigher.
  ///
  /// In en, this message translates to:
  /// **'Pain higher than usual'**
  String get planNextMorningHigher;

  /// No description provided for @planNextMorningPem.
  ///
  /// In en, this message translates to:
  /// **'PEM'**
  String get planNextMorningPem;

  /// No description provided for @planSessionTempoNote.
  ///
  /// In en, this message translates to:
  /// **'Slowly: 2 seconds down, a short pause, 1–2 seconds up. Mid-range, no locking joints. Seated and lying work first, standing last.'**
  String get planSessionTempoNote;

  /// No description provided for @planLowDayDefault.
  ///
  /// In en, this message translates to:
  /// **'A low day: fewer sets, easier steps, or just part of the session. It counts.'**
  String get planLowDayDefault;

  /// No description provided for @planPainLabel.
  ///
  /// In en, this message translates to:
  /// **'Highest pain during it (0–10)'**
  String get planPainLabel;

  /// No description provided for @planPainSharp.
  ///
  /// In en, this message translates to:
  /// **'Sharp, catching or giving way'**
  String get planPainSharp;

  /// No description provided for @planPainSafe.
  ///
  /// In en, this message translates to:
  /// **'0–2: safe. Carry on.'**
  String get planPainSafe;

  /// No description provided for @planPainAcceptable.
  ///
  /// In en, this message translates to:
  /// **'3–5: acceptable if it settles by tomorrow morning.'**
  String get planPainAcceptable;

  /// No description provided for @planPainTooMuch.
  ///
  /// In en, this message translates to:
  /// **'Too much: stop this exercise. Next time, an easier step.'**
  String get planPainTooMuch;

  /// No description provided for @planSessionWrapUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Wrap up'**
  String get planSessionWrapUpTitle;

  /// No description provided for @planCardioSavesActivity.
  ///
  /// In en, this message translates to:
  /// **'Also saved as an activity in Movement.'**
  String get planCardioSavesActivity;

  /// No description provided for @planNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get planNoteLabel;

  /// No description provided for @planSaveSession.
  ///
  /// In en, this message translates to:
  /// **'Save session'**
  String get planSaveSession;

  /// No description provided for @planWeekTitle.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get planWeekTitle;

  /// No description provided for @planWeekSessions.
  ///
  /// In en, this message translates to:
  /// **'{done} of {planned} sessions, no judgment attached.'**
  String planWeekSessions(int done, int planned);

  /// No description provided for @planCeilingUsed.
  ///
  /// In en, this message translates to:
  /// **'{used} of {ceiling} min this week'**
  String planCeilingUsed(int used, int ceiling);

  /// No description provided for @planCeilingReached.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached this week\'s ceiling. Even on a great day, the rest of the week is floor or rest.'**
  String get planCeilingReached;

  /// No description provided for @planPhaseCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Phase: {phase}'**
  String planPhaseCardTitle(String phase);

  /// No description provided for @planGateSummary.
  ///
  /// In en, this message translates to:
  /// **'Gate: {gate}'**
  String planGateSummary(String gate);

  /// No description provided for @planRepeatIsSuccess.
  ///
  /// In en, this message translates to:
  /// **'Repeating a phase is part of the plan. Eight weeks at one level is a success, not a failure.'**
  String get planRepeatIsSuccess;

  /// No description provided for @planPhaseBack.
  ///
  /// In en, this message translates to:
  /// **'Back a phase'**
  String get planPhaseBack;

  /// No description provided for @planPhaseNext.
  ///
  /// In en, this message translates to:
  /// **'Move to {phase}'**
  String planPhaseNext(String phase);

  /// No description provided for @planPhaseNextConfirm.
  ///
  /// In en, this message translates to:
  /// **'Did you pass this phase\'s gate?'**
  String get planPhaseNextConfirm;

  /// No description provided for @planNotYet.
  ///
  /// In en, this message translates to:
  /// **'Not yet'**
  String get planNotYet;

  /// No description provided for @planGatePassed.
  ///
  /// In en, this message translates to:
  /// **'Yes, passed'**
  String get planGatePassed;

  /// No description provided for @planStepUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready for the next step?'**
  String get planStepUpTitle;

  /// No description provided for @planStepUpCaption.
  ///
  /// In en, this message translates to:
  /// **'Three comfortable sessions plus 72 hours with no PEM or flare. One change a week.'**
  String get planStepUpCaption;

  /// No description provided for @planReadinessNotYet.
  ///
  /// In en, this message translates to:
  /// **'Keep going at this step.'**
  String get planReadinessNotYet;

  /// No description provided for @planReadinessReady.
  ///
  /// In en, this message translates to:
  /// **'Ready for {step} whenever you want.'**
  String planReadinessReady(String step);

  /// No description provided for @planReadinessWaitWeek.
  ///
  /// In en, this message translates to:
  /// **'Ready, but something else changed this week. Wait a few days.'**
  String get planReadinessWaitWeek;

  /// No description provided for @planReadinessWaitRecovery.
  ///
  /// In en, this message translates to:
  /// **'Ready, but give it 72 hours after PEM or a flare.'**
  String get planReadinessWaitRecovery;

  /// No description provided for @planReadinessNeedsClearance.
  ///
  /// In en, this message translates to:
  /// **'{step} waits for your clinician\'s sign-off.'**
  String planReadinessNeedsClearance(String step);

  /// No description provided for @planReadinessTop.
  ///
  /// In en, this message translates to:
  /// **'Top of this ladder. Staying here is great.'**
  String get planReadinessTop;

  /// No description provided for @planMoveUp.
  ///
  /// In en, this message translates to:
  /// **'Move up'**
  String get planMoveUp;

  /// No description provided for @planMarkCleared.
  ///
  /// In en, this message translates to:
  /// **'Mark as cleared'**
  String get planMarkCleared;

  /// No description provided for @planStepBack.
  ///
  /// In en, this message translates to:
  /// **'Step back'**
  String get planStepBack;

  /// No description provided for @planPhrasesTitle.
  ///
  /// In en, this message translates to:
  /// **'Phrases'**
  String get planPhrasesTitle;

  /// No description provided for @planPhrasesEditHint.
  ///
  /// In en, this message translates to:
  /// **'Opens your phrases'**
  String get planPhrasesEditHint;

  /// No description provided for @planPhrasesOwnTitle.
  ///
  /// In en, this message translates to:
  /// **'My phrases'**
  String get planPhrasesOwnTitle;

  /// No description provided for @planPhrasesOwnCaption.
  ///
  /// In en, this message translates to:
  /// **'Shown first, whatever the day looked like.'**
  String get planPhrasesOwnCaption;

  /// No description provided for @planPhrasesAddHint.
  ///
  /// In en, this message translates to:
  /// **'Something your future self would tell you'**
  String get planPhrasesAddHint;

  /// No description provided for @planPhrasesAdd.
  ///
  /// In en, this message translates to:
  /// **'Add phrase'**
  String get planPhrasesAdd;

  /// No description provided for @planPhrasesBuiltInTitle.
  ///
  /// In en, this message translates to:
  /// **'Built-in phrases'**
  String get planPhrasesBuiltInTitle;

  /// No description provided for @planPhrase1.
  ///
  /// In en, this message translates to:
  /// **'This is something my ideal self can do, and today I can do something to make that true.'**
  String get planPhrase1;

  /// No description provided for @planPhrase2.
  ///
  /// In en, this message translates to:
  /// **'My future me will be proud.'**
  String get planPhrase2;

  /// No description provided for @planPhrase3.
  ///
  /// In en, this message translates to:
  /// **'Rest is the dose today, and taking it is part of the plan.'**
  String get planPhrase3;

  /// No description provided for @planPhrase4.
  ///
  /// In en, this message translates to:
  /// **'The floor still counts. Showing up small is still showing up.'**
  String get planPhrase4;

  /// No description provided for @planPhrase5.
  ///
  /// In en, this message translates to:
  /// **'Today\'s body is the one I train with, and I\'m listening to it.'**
  String get planPhrase5;

  /// No description provided for @planPhrase6.
  ///
  /// In en, this message translates to:
  /// **'Repeating a week is the plan working, not falling behind.'**
  String get planPhrase6;

  /// No description provided for @planPhrase7.
  ///
  /// In en, this message translates to:
  /// **'Slow and steady is how I get to keep doing this.'**
  String get planPhrase7;

  /// No description provided for @planPhrase8.
  ///
  /// In en, this message translates to:
  /// **'Whatever today looked like, I\'m still building trust with my body.'**
  String get planPhrase8;

  /// No description provided for @planCheckinTitle.
  ///
  /// In en, this message translates to:
  /// **'Sunday check-in'**
  String get planCheckinTitle;

  /// No description provided for @planCheckinCaption.
  ///
  /// In en, this message translates to:
  /// **'Five minutes to look back at the week and set next week\'s ceiling.'**
  String get planCheckinCaption;

  /// No description provided for @planCheckinStart.
  ///
  /// In en, this message translates to:
  /// **'Start check-in'**
  String get planCheckinStart;

  /// No description provided for @planCheckinPemYes.
  ///
  /// In en, this message translates to:
  /// **'There was PEM or a flare this week.'**
  String get planCheckinPemYes;

  /// No description provided for @planCheckinPemNo.
  ///
  /// In en, this message translates to:
  /// **'No PEM or flare this week.'**
  String get planCheckinPemNo;

  /// No description provided for @planCheckinPemCauseLabel.
  ///
  /// In en, this message translates to:
  /// **'What came before it?'**
  String get planCheckinPemCauseLabel;

  /// No description provided for @planCheckinPemCauseHint.
  ///
  /// In en, this message translates to:
  /// **'Training, work, stairs, sleep, migraine…'**
  String get planCheckinPemCauseHint;

  /// No description provided for @planCheckinJointsOk.
  ///
  /// In en, this message translates to:
  /// **'Next-morning pain stayed at or below baseline.'**
  String get planCheckinJointsOk;

  /// No description provided for @planCheckinJointsHigher.
  ///
  /// In en, this message translates to:
  /// **'Some mornings were higher than baseline.'**
  String get planCheckinJointsHigher;

  /// No description provided for @planCheckinJointsUnknown.
  ///
  /// In en, this message translates to:
  /// **'No next-morning answers this week.'**
  String get planCheckinJointsUnknown;

  /// No description provided for @planCheckinWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight this week: {kg} kg'**
  String planCheckinWeight(String kg);

  /// No description provided for @planCheckinNoWeight.
  ///
  /// In en, this message translates to:
  /// **'No weigh-in this week.'**
  String get planCheckinNoWeight;

  /// No description provided for @planCheckinProtein.
  ///
  /// In en, this message translates to:
  /// **'{days} days reached your protein goal.'**
  String planCheckinProtein(int days);

  /// No description provided for @planCheckinWinLabel.
  ///
  /// In en, this message translates to:
  /// **'One win, however small'**
  String get planCheckinWinLabel;

  /// No description provided for @planCheckinWinHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Did the stairs holding the rail'**
  String get planCheckinWinHint;

  /// No description provided for @planCheckinWinSummary.
  ///
  /// In en, this message translates to:
  /// **'Win: {win}'**
  String planCheckinWinSummary(String win);

  /// No description provided for @planCheckinFearLabel.
  ///
  /// In en, this message translates to:
  /// **'Fear-list step taken'**
  String get planCheckinFearLabel;

  /// No description provided for @planCheckinFearHint.
  ///
  /// In en, this message translates to:
  /// **'Filled from your fear ladder when you logged a try'**
  String get planCheckinFearHint;

  /// No description provided for @planCheckinDecisionLabel.
  ///
  /// In en, this message translates to:
  /// **'Next week\'s ceiling'**
  String get planCheckinDecisionLabel;

  /// No description provided for @planCheckinRaise.
  ///
  /// In en, this message translates to:
  /// **'Raise about 10%'**
  String get planCheckinRaise;

  /// No description provided for @planCheckinKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep the same'**
  String get planCheckinKeep;

  /// No description provided for @planCheckinStepBack.
  ///
  /// In en, this message translates to:
  /// **'Step back'**
  String get planCheckinStepBack;

  /// No description provided for @planCheckinCeilingTo.
  ///
  /// In en, this message translates to:
  /// **'→ {minutes} min'**
  String planCheckinCeilingTo(int minutes);

  /// No description provided for @planCheckinNoRaiseAfterPem.
  ///
  /// In en, this message translates to:
  /// **'After PEM, the ceiling doesn\'t go up. Pacing comes before progression.'**
  String get planCheckinNoRaiseAfterPem;

  /// No description provided for @planGateFactsTitle.
  ///
  /// In en, this message translates to:
  /// **'What your logs say (last 14 days)'**
  String get planGateFactsTitle;

  /// No description provided for @planGateFactsSessions.
  ///
  /// In en, this message translates to:
  /// **'Comfortable sessions: {earlier}, then {latest}'**
  String planGateFactsSessions(int earlier, int latest);

  /// No description provided for @planGateFactsNoPem.
  ///
  /// In en, this message translates to:
  /// **'No PEM or flare'**
  String get planGateFactsNoPem;

  /// No description provided for @planGateFactsPain.
  ///
  /// In en, this message translates to:
  /// **'Pain settling by next morning'**
  String get planGateFactsPain;

  /// No description provided for @planTestWeeksLabel.
  ///
  /// In en, this message translates to:
  /// **'Retest in weeks'**
  String get planTestWeeksLabel;

  /// No description provided for @planTestWeeksHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 1, 6, 12'**
  String get planTestWeeksHint;

  /// No description provided for @planTestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Baseline tests'**
  String get planTestsTitle;

  /// No description provided for @planTestsCaption.
  ///
  /// In en, this message translates to:
  /// **'Progress is hard to feel week to week; these show real change.'**
  String get planTestsCaption;

  /// No description provided for @planTestsRetestWeek.
  ///
  /// In en, this message translates to:
  /// **'It\'s a retest week.'**
  String get planTestsRetestWeek;

  /// No description provided for @planTestsEditorCaption.
  ///
  /// In en, this message translates to:
  /// **'e.g. sit-to-stand reps in 30 s, wall push-ups, single-leg stance seconds.'**
  String get planTestsEditorCaption;

  /// No description provided for @planTestsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add test'**
  String get planTestsAdd;

  /// No description provided for @planTestsNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get planTestsNameLabel;

  /// No description provided for @planTestsNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Sit-to-stand in 30 s'**
  String get planTestsNameHint;

  /// No description provided for @planTestsUnitLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get planTestsUnitLabel;

  /// No description provided for @planTestsUnitHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. reps, seconds, kg'**
  String get planTestsUnitHint;

  /// No description provided for @planTestsAddResult.
  ///
  /// In en, this message translates to:
  /// **'Add result'**
  String get planTestsAddResult;

  /// No description provided for @planTestsValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get planTestsValueLabel;

  /// No description provided for @planTestsNoResult.
  ///
  /// In en, this message translates to:
  /// **'No result yet'**
  String get planTestsNoResult;

  /// No description provided for @planTestsFirst.
  ///
  /// In en, this message translates to:
  /// **'{value} on {date}'**
  String planTestsFirst(String value, String date);

  /// No description provided for @planTestsChange.
  ///
  /// In en, this message translates to:
  /// **'{first} → {latest} ({date})'**
  String planTestsChange(String first, String latest, String date);

  /// No description provided for @planTestsStopIfUnsure.
  ///
  /// In en, this message translates to:
  /// **'Stop if unsure. A test is never worth a flare.'**
  String get planTestsStopIfUnsure;

  /// No description provided for @planTestsTapToDelete.
  ///
  /// In en, this message translates to:
  /// **'Tap a result to delete it.'**
  String get planTestsTapToDelete;

  /// No description provided for @planFearTitle.
  ///
  /// In en, this message translates to:
  /// **'Fear ladder'**
  String get planFearTitle;

  /// No description provided for @planFearIntro.
  ///
  /// In en, this message translates to:
  /// **'List the movements you avoid and rate each 0–10 for fear. Each week, try one at about 3–4/10 in a small, safe form. Predict first, then note what actually happened.'**
  String get planFearIntro;

  /// No description provided for @planFearThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Try this week: {item}'**
  String planFearThisWeek(String item);

  /// No description provided for @planFearThisWeekCaption.
  ///
  /// In en, this message translates to:
  /// **'A small, safe version, e.g. two steps holding the rail.'**
  String get planFearThisWeekCaption;

  /// No description provided for @planFearLogTry.
  ///
  /// In en, this message translates to:
  /// **'Log a try'**
  String get planFearLogTry;

  /// No description provided for @planFearListTitle.
  ///
  /// In en, this message translates to:
  /// **'My list'**
  String get planFearListTitle;

  /// No description provided for @planFearEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add 8–10 movements you avoid, each rated 0–10.'**
  String get planFearEmpty;

  /// No description provided for @planFearSettledTitle.
  ///
  /// In en, this message translates to:
  /// **'Feels about 2/10 now'**
  String get planFearSettledTitle;

  /// No description provided for @planFearAdd.
  ///
  /// In en, this message translates to:
  /// **'Add movement'**
  String get planFearAdd;

  /// No description provided for @planFearItemMeta.
  ///
  /// In en, this message translates to:
  /// **'started at {initial}/10 · {tries} tries'**
  String planFearItemMeta(int initial, int tries);

  /// No description provided for @planFearMarkSettled.
  ///
  /// In en, this message translates to:
  /// **'It feels about 2/10 — move on'**
  String get planFearMarkSettled;

  /// No description provided for @planFearReopen.
  ///
  /// In en, this message translates to:
  /// **'Back on the list'**
  String get planFearReopen;

  /// No description provided for @planFearItemLabel.
  ///
  /// In en, this message translates to:
  /// **'Movement'**
  String get planFearItemLabel;

  /// No description provided for @planFearItemHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Kneeling on a cushion'**
  String get planFearItemHint;

  /// No description provided for @planFearRatingLabel.
  ///
  /// In en, this message translates to:
  /// **'Fear (0–10)'**
  String get planFearRatingLabel;

  /// No description provided for @planFearAttemptLabel.
  ///
  /// In en, this message translates to:
  /// **'What I tried'**
  String get planFearAttemptLabel;

  /// No description provided for @planFearAttemptHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Left knee on a thick cushion, 10 seconds'**
  String get planFearAttemptHint;

  /// No description provided for @planFearPredictionLabel.
  ///
  /// In en, this message translates to:
  /// **'What I predicted would happen'**
  String get planFearPredictionLabel;

  /// No description provided for @planFearPredictionHint.
  ///
  /// In en, this message translates to:
  /// **'Before you try'**
  String get planFearPredictionHint;

  /// No description provided for @planFearBeforeLabel.
  ///
  /// In en, this message translates to:
  /// **'Fear before (0–10)'**
  String get planFearBeforeLabel;

  /// No description provided for @planFearOutcomeLabel.
  ///
  /// In en, this message translates to:
  /// **'What actually happened'**
  String get planFearOutcomeLabel;

  /// No description provided for @planFearOutcomeHint.
  ///
  /// In en, this message translates to:
  /// **'After you try'**
  String get planFearOutcomeHint;

  /// No description provided for @planFearAfterLabel.
  ///
  /// In en, this message translates to:
  /// **'Fear now (0–10)'**
  String get planFearAfterLabel;

  /// No description provided for @planFearNothingBad.
  ///
  /// In en, this message translates to:
  /// **'I did it and nothing bad happened'**
  String get planFearNothingBad;

  /// No description provided for @planFearEvidenceTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Evidence} other{Evidence ({count})}}'**
  String planFearEvidenceTitle(int count);

  /// No description provided for @planFearEvidenceCaption.
  ///
  /// In en, this message translates to:
  /// **'Every time you did it and nothing bad happened. This is what changes the belief that pain means damage.'**
  String get planFearEvidenceCaption;

  /// No description provided for @planFearEvidenceShort.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 time nothing bad happened} other{{count} times nothing bad happened}}'**
  String planFearEvidenceShort(int count);

  /// No description provided for @planFearAllSettled.
  ///
  /// In en, this message translates to:
  /// **'Everything on your list feels about 2/10. Add more when you\'re ready.'**
  String get planFearAllSettled;

  /// No description provided for @planFearOpen.
  ///
  /// In en, this message translates to:
  /// **'Open fear ladder'**
  String get planFearOpen;

  /// No description provided for @planFearSpikeNote.
  ///
  /// In en, this message translates to:
  /// **'If fear or trauma symptoms spike, that is information, not failure. Step back one rung. A psychologist who knows graded exposure can help if this stalls.'**
  String get planFearSpikeNote;

  /// No description provided for @planStepLockedNote.
  ///
  /// In en, this message translates to:
  /// **'Waits for your physio\'s or clinician\'s OK. Skip it for now — the rest of the session still counts.'**
  String get planStepLockedNote;

  /// No description provided for @autonomicTitle.
  ///
  /// In en, this message translates to:
  /// **'🫀 Autonomic signals'**
  String get autonomicTitle;

  /// No description provided for @autonomicCaption.
  ///
  /// In en, this message translates to:
  /// **'Two sides of your nervous system, kept apart and compared with your own history. There\'s no single \"balance\" number: no valid measure gives one.'**
  String get autonomicCaption;

  /// No description provided for @autonomicVagalTitle.
  ///
  /// In en, this message translates to:
  /// **'Rest side (parasympathetic)'**
  String get autonomicVagalTitle;

  /// No description provided for @autonomicVagalEmpty.
  ///
  /// In en, this message translates to:
  /// **'Connect Health, or log resting heart rate and HRV in Sleep, to see this side.'**
  String get autonomicVagalEmpty;

  /// No description provided for @autonomicVagalNote.
  ///
  /// In en, this message translates to:
  /// **'Information only: these never change your step envelope.'**
  String get autonomicVagalNote;

  /// No description provided for @autonomicHrvMetricIos.
  ///
  /// In en, this message translates to:
  /// **'Apple Health records HRV as SDNN, which mixes both sides. It\'s only compared with itself.'**
  String get autonomicHrvMetricIos;

  /// No description provided for @autonomicHrvMetricAndroid.
  ///
  /// In en, this message translates to:
  /// **'Health Connect records HRV as RMSSD, which mostly reflects the rest side.'**
  String get autonomicHrvMetricAndroid;

  /// No description provided for @autonomicStandTitle.
  ///
  /// In en, this message translates to:
  /// **'Standing response (sympathetic, indirect)'**
  String get autonomicStandTitle;

  /// No description provided for @autonomicStandEmpty.
  ///
  /// In en, this message translates to:
  /// **'No stand test yet. It takes about 15 minutes.'**
  String get autonomicStandEmpty;

  /// No description provided for @autonomicStandStart.
  ///
  /// In en, this message translates to:
  /// **'Start a stand test'**
  String get autonomicStandStart;

  /// No description provided for @autonomicStandLast.
  ///
  /// In en, this message translates to:
  /// **'Last test {date}'**
  String autonomicStandLast(String date);

  /// No description provided for @autonomicHrRise.
  ///
  /// In en, this message translates to:
  /// **'Standing heart rate: {change} bpm vs resting'**
  String autonomicHrRise(String change);

  /// No description provided for @autonomicHrRiseUsual.
  ///
  /// In en, this message translates to:
  /// **'your usual rise {bpm}'**
  String autonomicHrRiseUsual(int bpm);

  /// No description provided for @autonomicHrRisePending.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{your usual rise shows after 1 more test} other{your usual rise shows after {count} more tests}}'**
  String autonomicHrRisePending(int count);

  /// No description provided for @autonomicPressureChange.
  ///
  /// In en, this message translates to:
  /// **'Blood pressure changed {sys}/{dia} mmHg in the first 3 minutes'**
  String autonomicPressureChange(String sys, String dia);

  /// No description provided for @autonomicPotsHint.
  ///
  /// In en, this message translates to:
  /// **'A heart-rate rise of 30 bpm or more (or above 120) can suggest a pattern worth mentioning to your doctor. It isn\'t a diagnosis.'**
  String get autonomicPotsHint;

  /// No description provided for @autonomicOhHint.
  ///
  /// In en, this message translates to:
  /// **'A blood-pressure drop of 20/10 mmHg or more within 3 minutes can suggest a pattern worth mentioning to your doctor. It isn\'t a diagnosis.'**
  String get autonomicOhHint;

  /// No description provided for @autonomicStoppedEarly.
  ///
  /// In en, this message translates to:
  /// **'stopped early'**
  String get autonomicStoppedEarly;

  /// No description provided for @autonomicAllTests.
  ///
  /// In en, this message translates to:
  /// **'All tests'**
  String get autonomicAllTests;

  /// No description provided for @autonomicTapToDelete.
  ///
  /// In en, this message translates to:
  /// **'Tap a test to delete it.'**
  String get autonomicTapToDelete;

  /// No description provided for @autonomicSweatTitle.
  ///
  /// In en, this message translates to:
  /// **'Sweating (sympathetic, as you describe it)'**
  String get autonomicSweatTitle;

  /// No description provided for @autonomicSweatCaption.
  ///
  /// In en, this message translates to:
  /// **'Sweat glands answer only to the sympathetic side. Anything different today?'**
  String get autonomicSweatCaption;

  /// No description provided for @autonomicSweatRecent.
  ///
  /// In en, this message translates to:
  /// **'Last 14 days: {summary}'**
  String autonomicSweatRecent(String summary);

  /// No description provided for @sweatMoreThanUsual.
  ///
  /// In en, this message translates to:
  /// **'More than usual'**
  String get sweatMoreThanUsual;

  /// No description provided for @sweatLessThanUsual.
  ///
  /// In en, this message translates to:
  /// **'Less than usual'**
  String get sweatLessThanUsual;

  /// No description provided for @sweatCouldNotSweat.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t sweat in heat or effort'**
  String get sweatCouldNotSweat;

  /// No description provided for @sweatColdClammy.
  ///
  /// In en, this message translates to:
  /// **'Cold, clammy hands or feet'**
  String get sweatColdClammy;

  /// No description provided for @sweatNightSweats.
  ///
  /// In en, this message translates to:
  /// **'Night sweats'**
  String get sweatNightSweats;

  /// No description provided for @sweatOneSideOrPatchy.
  ///
  /// In en, this message translates to:
  /// **'Only on one side or in patches'**
  String get sweatOneSideOrPatchy;

  /// No description provided for @standSymptomLightheaded.
  ///
  /// In en, this message translates to:
  /// **'Light-headed'**
  String get standSymptomLightheaded;

  /// No description provided for @standSymptomPalpitations.
  ///
  /// In en, this message translates to:
  /// **'Racing or pounding heart'**
  String get standSymptomPalpitations;

  /// No description provided for @standSymptomBlurredVision.
  ///
  /// In en, this message translates to:
  /// **'Blurred or dimming vision'**
  String get standSymptomBlurredVision;

  /// No description provided for @standSymptomNausea.
  ///
  /// In en, this message translates to:
  /// **'Nausea'**
  String get standSymptomNausea;

  /// No description provided for @standSymptomSweating.
  ///
  /// In en, this message translates to:
  /// **'Sweating'**
  String get standSymptomSweating;

  /// No description provided for @standSymptomShaky.
  ///
  /// In en, this message translates to:
  /// **'Shaky'**
  String get standSymptomShaky;

  /// No description provided for @standSymptomBreathless.
  ///
  /// In en, this message translates to:
  /// **'Short of breath'**
  String get standSymptomBreathless;

  /// No description provided for @standSymptomHeadache.
  ///
  /// In en, this message translates to:
  /// **'Headache or neck ache'**
  String get standSymptomHeadache;

  /// No description provided for @standTestTitle.
  ///
  /// In en, this message translates to:
  /// **'Stand test'**
  String get standTestTitle;

  /// No description provided for @standTestIntro.
  ///
  /// In en, this message translates to:
  /// **'This shows how your heart rate (and blood pressure, if you have a cuff) responds when you stand up. You rest 5 minutes, then stand still for up to 10 minutes, typing in your heart rate at 1, 3 and 10 minutes.'**
  String get standTestIntro;

  /// No description provided for @standTestSafetyTitle.
  ///
  /// In en, this message translates to:
  /// **'Before you start'**
  String get standTestSafetyTitle;

  /// No description provided for @standTestSafetyWall.
  ///
  /// In en, this message translates to:
  /// **'Stand with your back near a wall and a chair right behind you.'**
  String get standTestSafetyWall;

  /// No description provided for @standTestSafetyStop.
  ///
  /// In en, this message translates to:
  /// **'If you feel faint, dizzy or unwell, sit or lie down right away and tap Stop test. Stopping is always fine.'**
  String get standTestSafetyStop;

  /// No description provided for @standTestSafetyCompany.
  ///
  /// In en, this message translates to:
  /// **'If you\'ve fainted before, only do it with someone with you.'**
  String get standTestSafetyCompany;

  /// No description provided for @standTestSafetyWhen.
  ///
  /// In en, this message translates to:
  /// **'Skip it on a flare day, right after eating, or after a hot shower.'**
  String get standTestSafetyWhen;

  /// No description provided for @standTestRestPosition.
  ///
  /// In en, this message translates to:
  /// **'Rest position'**
  String get standTestRestPosition;

  /// No description provided for @standTestLying.
  ///
  /// In en, this message translates to:
  /// **'Lying down'**
  String get standTestLying;

  /// No description provided for @standTestSitting.
  ///
  /// In en, this message translates to:
  /// **'Sitting'**
  String get standTestSitting;

  /// No description provided for @standTestBeginRest.
  ///
  /// In en, this message translates to:
  /// **'Start resting (5 min)'**
  String get standTestBeginRest;

  /// No description provided for @standTestResting.
  ///
  /// In en, this message translates to:
  /// **'Rest quietly. Rest ends in {time}.'**
  String standTestResting(String time);

  /// No description provided for @standTestSkipRest.
  ///
  /// In en, this message translates to:
  /// **'I\'ve already rested 5 minutes'**
  String get standTestSkipRest;

  /// No description provided for @standTestBaselineLabel.
  ///
  /// In en, this message translates to:
  /// **'Resting'**
  String get standTestBaselineLabel;

  /// No description provided for @standTestBaselinePrompt.
  ///
  /// In en, this message translates to:
  /// **'Type your resting heart rate, then stand up.'**
  String get standTestBaselinePrompt;

  /// No description provided for @standTestStandUp.
  ///
  /// In en, this message translates to:
  /// **'I\'m standing now'**
  String get standTestStandUp;

  /// No description provided for @standTestPointLabel.
  ///
  /// In en, this message translates to:
  /// **'{min} min standing'**
  String standTestPointLabel(int min);

  /// No description provided for @standTestStanding.
  ///
  /// In en, this message translates to:
  /// **'Standing {time}'**
  String standTestStanding(String time);

  /// No description provided for @standTestNextAt.
  ///
  /// In en, this message translates to:
  /// **'{min}-minute reading in {time}'**
  String standTestNextAt(int min, String time);

  /// No description provided for @standTestAllRead.
  ///
  /// In en, this message translates to:
  /// **'All readings done. You can sit down.'**
  String get standTestAllRead;

  /// No description provided for @standTestStop.
  ///
  /// In en, this message translates to:
  /// **'Stop test'**
  String get standTestStop;

  /// No description provided for @standTestStoppedTitle.
  ///
  /// In en, this message translates to:
  /// **'Test stopped'**
  String get standTestStoppedTitle;

  /// No description provided for @standTestStoppedBody.
  ///
  /// In en, this message translates to:
  /// **'Sit or lie down and rest. What you recorded so far is saved.'**
  String get standTestStoppedBody;

  /// No description provided for @standTestFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish and save'**
  String get standTestFinish;

  /// No description provided for @standTestHr.
  ///
  /// In en, this message translates to:
  /// **'Heart rate'**
  String get standTestHr;

  /// No description provided for @standTestSys.
  ///
  /// In en, this message translates to:
  /// **'Systolic'**
  String get standTestSys;

  /// No description provided for @standTestDia.
  ///
  /// In en, this message translates to:
  /// **'Diastolic'**
  String get standTestDia;

  /// No description provided for @standTestBpOptional.
  ///
  /// In en, this message translates to:
  /// **'Blood pressure, optional'**
  String get standTestBpOptional;

  /// No description provided for @standTestHrHint.
  ///
  /// In en, this message translates to:
  /// **'From your watch\'s heart rate app or a pulse oximeter.'**
  String get standTestHrHint;

  /// No description provided for @standTestSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Anything you feel while standing'**
  String get standTestSymptoms;

  /// No description provided for @autonomicBpTitle.
  ///
  /// In en, this message translates to:
  /// **'Blood pressure (cuff)'**
  String get autonomicBpTitle;

  /// No description provided for @autonomicBpEmpty.
  ///
  /// In en, this message translates to:
  /// **'No readings yet. Type them in from your cuff whenever you measure.'**
  String get autonomicBpEmpty;

  /// No description provided for @autonomicBpAdd.
  ///
  /// In en, this message translates to:
  /// **'Add a reading'**
  String get autonomicBpAdd;

  /// No description provided for @autonomicBpUsual.
  ///
  /// In en, this message translates to:
  /// **'your usual {sys}/{dia}'**
  String autonomicBpUsual(int sys, int dia);

  /// No description provided for @autonomicBpUsualPending.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{your usual shows after 1 more reading in this position} other{your usual shows after {count} more readings in this position}}'**
  String autonomicBpUsualPending(int count);

  /// No description provided for @autonomicBpPulse.
  ///
  /// In en, this message translates to:
  /// **'pulse {bpm}'**
  String autonomicBpPulse(int bpm);

  /// No description provided for @bpPositionSitting.
  ///
  /// In en, this message translates to:
  /// **'Sitting'**
  String get bpPositionSitting;

  /// No description provided for @bpPositionLying.
  ///
  /// In en, this message translates to:
  /// **'Lying down'**
  String get bpPositionLying;

  /// No description provided for @bpPositionStanding.
  ///
  /// In en, this message translates to:
  /// **'Standing'**
  String get bpPositionStanding;

  /// No description provided for @bpSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Blood pressure reading'**
  String get bpSheetTitle;

  /// No description provided for @bpPosition.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get bpPosition;

  /// No description provided for @bpPulseOptional.
  ///
  /// In en, this message translates to:
  /// **'Pulse, optional'**
  String get bpPulseOptional;

  /// No description provided for @bpTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get bpTime;

  /// No description provided for @bpTip.
  ///
  /// In en, this message translates to:
  /// **'For a steady reading: sit for 5 minutes first, feet flat, arm supported at heart level, and don\'t talk.'**
  String get bpTip;

  /// No description provided for @bpAllReadings.
  ///
  /// In en, this message translates to:
  /// **'All readings'**
  String get bpAllReadings;

  /// No description provided for @bpTapToDelete.
  ///
  /// In en, this message translates to:
  /// **'Tap a reading to delete it.'**
  String get bpTapToDelete;

  /// No description provided for @remindersSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders & alerts'**
  String get remindersSectionTitle;

  /// No description provided for @remindersSectionCaption.
  ///
  /// In en, this message translates to:
  /// **'Gentle nudges, never on Rest or Flare days. They show on your lock screen, so they never include numbers or details.'**
  String get remindersSectionCaption;

  /// No description provided for @remindersCheckinToggle.
  ///
  /// In en, this message translates to:
  /// **'Quick check-in'**
  String get remindersCheckinToggle;

  /// No description provided for @remindersCheckinCaption.
  ///
  /// In en, this message translates to:
  /// **'Skipped if you already checked in in the two hours before.'**
  String get remindersCheckinCaption;

  /// No description provided for @remindersAddTime.
  ///
  /// In en, this message translates to:
  /// **'Add a time'**
  String get remindersAddTime;

  /// No description provided for @remindersRemoveTime.
  ///
  /// In en, this message translates to:
  /// **'Remove this time'**
  String get remindersRemoveTime;

  /// No description provided for @remindersSorenessToggle.
  ///
  /// In en, this message translates to:
  /// **'Soreness check'**
  String get remindersSorenessToggle;

  /// No description provided for @remindersSorenessCaption.
  ///
  /// In en, this message translates to:
  /// **'The first and second day after you log movement.'**
  String get remindersSorenessCaption;

  /// No description provided for @remindersWeeklyToggle.
  ///
  /// In en, this message translates to:
  /// **'Weekly check-in'**
  String get remindersWeeklyToggle;

  /// No description provided for @remindersWeeklyCaption.
  ///
  /// In en, this message translates to:
  /// **'Sundays, while a plan is active and that week isn\'t reviewed yet.'**
  String get remindersWeeklyCaption;

  /// No description provided for @remindersPacingToggle.
  ///
  /// In en, this message translates to:
  /// **'Pacing alerts'**
  String get remindersPacingToggle;

  /// No description provided for @remindersPacingCaption.
  ///
  /// In en, this message translates to:
  /// **'When today\'s steps reach your goal, and if they pass your caution line. Checked in the background from Apple Health or Health Connect, so an alert can arrive late.'**
  String get remindersPacingCaption;

  /// No description provided for @remindersPacingNeedsHealth.
  ///
  /// In en, this message translates to:
  /// **'Connect Apple Health or Health Connect in Movement first.'**
  String get remindersPacingNeedsHealth;

  /// No description provided for @remindersPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notifications are off for ZebraPace in your phone\'s settings, so nothing will show.'**
  String get remindersPermissionDenied;

  /// No description provided for @remindersTimeDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get remindersTimeDone;

  /// No description provided for @notificationChannelReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get notificationChannelReminders;

  /// No description provided for @notificationChannelPacing.
  ///
  /// In en, this message translates to:
  /// **'Pacing alerts'**
  String get notificationChannelPacing;

  /// No description provided for @notificationCheckinTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick check-in'**
  String get notificationCheckinTitle;

  /// No description provided for @notificationCheckinBody.
  ///
  /// In en, this message translates to:
  /// **'How are your energy, body and mood right now? It takes a few seconds.'**
  String get notificationCheckinBody;

  /// No description provided for @notificationSorenessTitle.
  ///
  /// In en, this message translates to:
  /// **'Soreness or crash?'**
  String get notificationSorenessTitle;

  /// No description provided for @notificationSorenessBody.
  ///
  /// In en, this message translates to:
  /// **'After recent movement, three quick questions help tell ordinary soreness apart from PEM.'**
  String get notificationSorenessBody;

  /// No description provided for @notificationWeeklyTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly check-in'**
  String get notificationWeeklyTitle;

  /// No description provided for @notificationWeeklyBody.
  ///
  /// In en, this message translates to:
  /// **'A short look back at this week, to set next week\'s plan.'**
  String get notificationWeeklyBody;

  /// No description provided for @notificationPacingGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s step goal reached'**
  String get notificationPacingGoalTitle;

  /// No description provided for @notificationPacingGoalBody.
  ///
  /// In en, this message translates to:
  /// **'That\'s today\'s gentle growth done. Anything more is optional.'**
  String get notificationPacingGoalBody;

  /// No description provided for @notificationPacingCautionTitle.
  ///
  /// In en, this message translates to:
  /// **'Past today\'s caution line'**
  String get notificationPacingCautionTitle;

  /// No description provided for @notificationPacingCautionBody.
  ///
  /// In en, this message translates to:
  /// **'Steps are above your recent baseline. Consider extra rest, hydration and electrolytes.'**
  String get notificationPacingCautionBody;

  /// No description provided for @shareZebraUpTitle.
  ///
  /// In en, this message translates to:
  /// **'ZebraUp'**
  String get shareZebraUpTitle;

  /// No description provided for @shareZebraUpToggle.
  ///
  /// In en, this message translates to:
  /// **'Share with ZebraUp'**
  String get shareZebraUpToggle;

  /// No description provided for @shareZebraUpCaption.
  ///
  /// In en, this message translates to:
  /// **'ZebraUp, on this same phone, can read your last 30 days of steps, Rest/Flare days, soreness checks that looked like a crash/PEM pattern, resting heart rate, heart rate variability and logged activity. Nothing goes online. Turning this off removes what was shared.'**
  String get shareZebraUpCaption;

  /// No description provided for @sourcesLinkLabel.
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get sourcesLinkLabel;

  /// No description provided for @sourcesScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Sources & references'**
  String get sourcesScreenTitle;

  /// No description provided for @sourcesScreenIntro.
  ///
  /// In en, this message translates to:
  /// **'ZebraPace\'s health information comes from the sources below. Tap one to open it. ZebraPace isn\'t a medical device and doesn\'t diagnose anything; talk with your care team before changing your care.'**
  String get sourcesScreenIntro;

  /// No description provided for @sourcesAppDefaultsNote.
  ///
  /// In en, this message translates to:
  /// **'The 1% step goal, the 10% caution line and the water, protein and sleep goals are ZebraPace\'s starting defaults, not clinical thresholds. You can change them in Settings.'**
  String get sourcesAppDefaultsNote;

  /// No description provided for @sourcesSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all sources'**
  String get sourcesSeeAll;

  /// No description provided for @sourcesAppSynthesis.
  ///
  /// In en, this message translates to:
  /// **'ZebraPace\'s own summary of the studies above, not a finding from them.'**
  String get sourcesAppSynthesis;

  /// No description provided for @sourceTopicPacing.
  ///
  /// In en, this message translates to:
  /// **'Pacing and the step envelope'**
  String get sourceTopicPacing;

  /// No description provided for @sourceTopicPem.
  ///
  /// In en, this message translates to:
  /// **'Post-exertional malaise (PEM) and soreness'**
  String get sourceTopicPem;

  /// No description provided for @sourceTopicStandTest.
  ///
  /// In en, this message translates to:
  /// **'Stand test, POTS and orthostatic hypotension'**
  String get sourceTopicStandTest;

  /// No description provided for @sourceTopicHeartSignals.
  ///
  /// In en, this message translates to:
  /// **'Resting heart rate and heart rate variability'**
  String get sourceTopicHeartSignals;

  /// No description provided for @sourceTopicSweating.
  ///
  /// In en, this message translates to:
  /// **'Sweating'**
  String get sourceTopicSweating;

  /// No description provided for @sourceTopicMets.
  ///
  /// In en, this message translates to:
  /// **'METs (exercise intensity)'**
  String get sourceTopicMets;

  /// No description provided for @sourceTopicExercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise, stop signals and progression with EDS'**
  String get sourceTopicExercise;

  /// No description provided for @sourceTopicFearExposure.
  ///
  /// In en, this message translates to:
  /// **'Fear of movement and gradual exposure'**
  String get sourceTopicFearExposure;

  /// No description provided for @sourceTopicSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get sourceTopicSleep;

  /// No description provided for @challengeMembersTitle.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get challengeMembersTitle;

  /// No description provided for @challengeMembersOwnerCaption.
  ///
  /// In en, this message translates to:
  /// **'You created this challenge, so you can remove members. Someone you remove can\'t rejoin with the code.'**
  String get challengeMembersOwnerCaption;

  /// No description provided for @challengeMemberCreatorBadge.
  ///
  /// In en, this message translates to:
  /// **'created it'**
  String get challengeMemberCreatorBadge;

  /// No description provided for @challengeRemoveMemberButton.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get challengeRemoveMemberButton;

  /// No description provided for @challengeRemoveMemberTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}?'**
  String challengeRemoveMemberTitle(String name);

  /// No description provided for @challengeRemoveMemberMessage.
  ///
  /// In en, this message translates to:
  /// **'Their days and progress in this challenge are deleted for everyone, and they can\'t rejoin with the code. Nothing in their own log changes.'**
  String get challengeRemoveMemberMessage;

  /// No description provided for @challengeLeaveButton.
  ///
  /// In en, this message translates to:
  /// **'Leave this challenge'**
  String get challengeLeaveButton;

  /// No description provided for @challengeLeaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave this challenge?'**
  String get challengeLeaveTitle;

  /// No description provided for @challengeLeaveMessage.
  ///
  /// In en, this message translates to:
  /// **'Your days and progress in this challenge are deleted for everyone. Your own log stays on your phone, and you can rejoin later with the code.'**
  String get challengeLeaveMessage;

  /// No description provided for @challengeLeaveOwnerHandover.
  ///
  /// In en, this message translates to:
  /// **'You created it, so it passes to another member, who can then remove members.'**
  String get challengeLeaveOwnerHandover;

  /// No description provided for @challengeLeaveLastMember.
  ///
  /// In en, this message translates to:
  /// **'You\'re the only member, so the challenge itself is deleted.'**
  String get challengeLeaveLastMember;

  /// No description provided for @challengeLeaveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get challengeLeaveConfirm;

  /// No description provided for @challengeLeaveRemoveError.
  ///
  /// In en, this message translates to:
  /// **'That didn\'t work. Check your connection and try again.'**
  String get challengeLeaveRemoveError;

  /// No description provided for @plusTitle.
  ///
  /// In en, this message translates to:
  /// **'Zebras+'**
  String get plusTitle;

  /// No description provided for @plusCaptionFree.
  ///
  /// In en, this message translates to:
  /// **'Long-term patterns, long history and reports for your physio, in ZebraPace and ZebraUp. Logging, today\'s pacing and safety alerts are always free.'**
  String get plusCaptionFree;

  /// No description provided for @plusCaptionActive.
  ///
  /// In en, this message translates to:
  /// **'Zebras+ is on for ZebraPace and ZebraUp. Thank you for supporting the zebras.'**
  String get plusCaptionActive;

  /// No description provided for @plusNeedsAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign in under Cloud sync first, so your plan follows you to ZebraUp and to a new phone.'**
  String get plusNeedsAccount;

  /// No description provided for @plusSeePlans.
  ///
  /// In en, this message translates to:
  /// **'See Zebras+'**
  String get plusSeePlans;

  /// No description provided for @plusManage.
  ///
  /// In en, this message translates to:
  /// **'Manage subscription'**
  String get plusManage;

  /// No description provided for @plusRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get plusRestore;

  /// No description provided for @plusPurchased.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Zebras+!'**
  String get plusPurchased;

  /// No description provided for @plusRestored.
  ///
  /// In en, this message translates to:
  /// **'Purchases restored.'**
  String get plusRestored;

  /// No description provided for @plusRestoreNothing.
  ///
  /// In en, this message translates to:
  /// **'No Zebras+ purchase found for this store account.'**
  String get plusRestoreNothing;

  /// No description provided for @plusPending.
  ///
  /// In en, this message translates to:
  /// **'Your payment is pending. Zebras+ turns on once the store confirms it.'**
  String get plusPending;

  /// No description provided for @plusErrorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t reach the store. Check your connection and try again.'**
  String get plusErrorNetwork;

  /// No description provided for @plusErrorNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Purchases aren\'t allowed on this device.'**
  String get plusErrorNotAllowed;

  /// No description provided for @plusErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong with the store. Please try again.'**
  String get plusErrorGeneric;

  /// No description provided for @plusLockedRangeMessage.
  ///
  /// In en, this message translates to:
  /// **'Ranges longer than 90 days are part of Zebras+. Everything is still recorded, so subscribing shows your full history right away.'**
  String get plusLockedRangeMessage;

  /// No description provided for @plusUnavailableHere.
  ///
  /// In en, this message translates to:
  /// **'Zebras+ can be bought in the ZebraPace app for iPhone or Android.'**
  String get plusUnavailableHere;

  /// No description provided for @insightsLongTermTitle.
  ///
  /// In en, this message translates to:
  /// **'🧭 Your pattern over months'**
  String get insightsLongTermTitle;

  /// No description provided for @insightsLongTermCaption.
  ///
  /// In en, this message translates to:
  /// **'How your body score dips after bigger days across your whole history, and whether that is changing.'**
  String get insightsLongTermCaption;

  /// No description provided for @insightsLongTermLocked.
  ///
  /// In en, this message translates to:
  /// **'See which delay your dips usually follow, and whether they are getting smaller month by month. Part of Zebras+.'**
  String get insightsLongTermLocked;

  /// No description provided for @insightsLongTermNotEnough.
  ///
  /// In en, this message translates to:
  /// **'This needs about two months of logged steps and body scores. So far: {days} days.'**
  String insightsLongTermNotEnough(int days);

  /// No description provided for @insightsLongTermUsual.
  ///
  /// In en, this message translates to:
  /// **'Across your history, your body score runs about {dip} points lower {lag} after bigger days. That is your usual delay.'**
  String insightsLongTermUsual(String lag, String dip);

  /// No description provided for @insightsLongTermNoClear.
  ///
  /// In en, this message translates to:
  /// **'Across your history, there is no clear delayed dip after bigger days.'**
  String get insightsLongTermNoClear;

  /// No description provided for @insightsLongTermDelayTitle.
  ///
  /// In en, this message translates to:
  /// **'Dip by delay (points)'**
  String get insightsLongTermDelayTitle;

  /// No description provided for @insightsLongTermMonthsTitle.
  ///
  /// In en, this message translates to:
  /// **'Dip {lag} later, month by month'**
  String insightsLongTermMonthsTitle(String lag);

  /// No description provided for @insightsLongTermTrendSmaller.
  ///
  /// In en, this message translates to:
  /// **'Your dips have gotten smaller than in your first months.'**
  String get insightsLongTermTrendSmaller;

  /// No description provided for @insightsLongTermTrendBigger.
  ///
  /// In en, this message translates to:
  /// **'Your dips have gotten bigger than in your first months. If that matches how you have been feeling, it may be a good time to ease your load or talk it over with your care team.'**
  String get insightsLongTermTrendBigger;

  /// No description provided for @insightsLongTermTrendSimilar.
  ///
  /// In en, this message translates to:
  /// **'Your dips are about the same size as in your first months.'**
  String get insightsLongTermTrendSimilar;

  /// No description provided for @insightsLongTermFootnote.
  ///
  /// In en, this message translates to:
  /// **'A pattern in your own logs, not a diagnosis. Today\'s pacing warnings never depend on this view and are always free.'**
  String get insightsLongTermFootnote;

  /// No description provided for @plusLockedPatternMessage.
  ///
  /// In en, this message translates to:
  /// **'Your pattern over months is part of Zebras+. Today\'s warnings and the day-by-day checks stay free.'**
  String get plusLockedPatternMessage;

  /// No description provided for @creditsEntry.
  ///
  /// In en, this message translates to:
  /// **'AI credits & sponsoring'**
  String get creditsEntry;

  /// No description provided for @creditsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Credits & sponsoring'**
  String get creditsScreenTitle;

  /// No description provided for @creditsTitle.
  ///
  /// In en, this message translates to:
  /// **'AI credits'**
  String get creditsTitle;

  /// No description provided for @creditsCaption.
  ///
  /// In en, this message translates to:
  /// **'Credits pay for the weekly summary written by AI in the cloud. One summary uses one credit.'**
  String get creditsCaption;

  /// No description provided for @creditsBalance.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{You have 1 credit} other{You have {count} credits}}'**
  String creditsBalance(int count);

  /// No description provided for @creditsBalanceError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your balance. Check your connection.'**
  String get creditsBalanceError;

  /// No description provided for @creditsBuy.
  ///
  /// In en, this message translates to:
  /// **'Buy {count} credits · {price}'**
  String creditsBuy(int count, String price);

  /// No description provided for @creditsArriving.
  ///
  /// In en, this message translates to:
  /// **'Thank you! Your credits will show up in a moment.'**
  String get creditsArriving;

  /// No description provided for @creditsPurchased.
  ///
  /// In en, this message translates to:
  /// **'Credits added.'**
  String get creditsPurchased;

  /// No description provided for @sponsorTitle.
  ///
  /// In en, this message translates to:
  /// **'Sponsor a plan'**
  String get sponsorTitle;

  /// No description provided for @sponsorCaption.
  ///
  /// In en, this message translates to:
  /// **'Give a year of Zebras+ to someone who can\'t pay for it. Your gift goes to a shared fund for scholarships.'**
  String get sponsorCaption;

  /// No description provided for @sponsorBuy.
  ///
  /// In en, this message translates to:
  /// **'Sponsor a year · {price}'**
  String sponsorBuy(String price);

  /// No description provided for @sponsorThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you! Your gift is in the fund.'**
  String get sponsorThanks;

  /// No description provided for @consumablesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Not available in this store yet.'**
  String get consumablesUnavailable;

  /// No description provided for @insightsCompareTitle.
  ///
  /// In en, this message translates to:
  /// **'⚖️ Compare periods'**
  String get insightsCompareTitle;

  /// No description provided for @insightsCompareCaption.
  ///
  /// In en, this message translates to:
  /// **'Your averages side by side. Numbers, not grades: more steps isn\'t automatically better, and rest days count.'**
  String get insightsCompareCaption;

  /// No description provided for @insightsCompareLocked.
  ///
  /// In en, this message translates to:
  /// **'Compare your last months with the ones before, or with the same time last year. Part of Zebras+.'**
  String get insightsCompareLocked;

  /// No description provided for @plusLockedCompareMessage.
  ///
  /// In en, this message translates to:
  /// **'Comparing periods is part of Zebras+. Every day is still recorded and shown in Trends.'**
  String get plusLockedCompareMessage;

  /// No description provided for @insightsCompareMonths.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 month} other{{count} months}}'**
  String insightsCompareMonths(int count);

  /// No description provided for @insightsCompareVsPrevious.
  ///
  /// In en, this message translates to:
  /// **'vs. before'**
  String get insightsCompareVsPrevious;

  /// No description provided for @insightsCompareVsLastYear.
  ///
  /// In en, this message translates to:
  /// **'vs. last year'**
  String get insightsCompareVsLastYear;

  /// No description provided for @insightsCompareEarlier.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get insightsCompareEarlier;

  /// No description provided for @insightsCompareRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get insightsCompareRecent;

  /// No description provided for @insightsCompareChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get insightsCompareChange;

  /// No description provided for @insightsCompareDaysLogged.
  ///
  /// In en, this message translates to:
  /// **'Days logged'**
  String get insightsCompareDaysLogged;

  /// No description provided for @insightsCompareSteps.
  ///
  /// In en, this message translates to:
  /// **'Steps (avg)'**
  String get insightsCompareSteps;

  /// No description provided for @insightsCompareBody.
  ///
  /// In en, this message translates to:
  /// **'Body score (1–5)'**
  String get insightsCompareBody;

  /// No description provided for @insightsCompareMental.
  ///
  /// In en, this message translates to:
  /// **'Mental state (1–5)'**
  String get insightsCompareMental;

  /// No description provided for @insightsCompareSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep (h)'**
  String get insightsCompareSleep;

  /// No description provided for @insightsCompareRestingHr.
  ///
  /// In en, this message translates to:
  /// **'Resting HR (bpm)'**
  String get insightsCompareRestingHr;

  /// No description provided for @insightsCompareHrv.
  ///
  /// In en, this message translates to:
  /// **'HRV (ms)'**
  String get insightsCompareHrv;

  /// No description provided for @insightsCompareRestDays.
  ///
  /// In en, this message translates to:
  /// **'Rest days'**
  String get insightsCompareRestDays;

  /// No description provided for @insightsCompareFlareDays.
  ///
  /// In en, this message translates to:
  /// **'Flare days'**
  String get insightsCompareFlareDays;

  /// No description provided for @insightsCompareNoEarlierData.
  ///
  /// In en, this message translates to:
  /// **'No logs in the earlier period yet.'**
  String get insightsCompareNoEarlierData;

  /// No description provided for @physioReportButton.
  ///
  /// In en, this message translates to:
  /// **'Physio report'**
  String get physioReportButton;

  /// No description provided for @plusLockedPhysioMessage.
  ///
  /// In en, this message translates to:
  /// **'The physio report is part of Zebras+: a two-page summary for physiotherapy or rehab appointments. The PDF summary above stays free for any period.'**
  String get plusLockedPhysioMessage;

  /// No description provided for @physioQuestionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Questions for my physio'**
  String get physioQuestionsTitle;

  /// No description provided for @physioQuestionsHint.
  ///
  /// In en, this message translates to:
  /// **'Optional. Printed at the end of the report.'**
  String get physioQuestionsHint;

  /// No description provided for @physioQuestionsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Can I add a second short walk on good days?'**
  String get physioQuestionsPlaceholder;

  /// No description provided for @physioCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create report'**
  String get physioCreateButton;

  /// No description provided for @physioReportHeading.
  ///
  /// In en, this message translates to:
  /// **'Activity report for physiotherapy'**
  String get physioReportHeading;

  /// No description provided for @physioReportFor.
  ///
  /// In en, this message translates to:
  /// **'For: {name}'**
  String physioReportFor(String name);

  /// No description provided for @physioSummaryHeading.
  ///
  /// In en, this message translates to:
  /// **'In 30 seconds'**
  String get physioSummaryHeading;

  /// No description provided for @physioSummaryLogged.
  ///
  /// In en, this message translates to:
  /// **'Days logged: {logged} of {total}'**
  String physioSummaryLogged(int logged, int total);

  /// No description provided for @physioSummarySteps.
  ///
  /// In en, this message translates to:
  /// **'Average steps on active days: {steps}'**
  String physioSummarySteps(String steps);

  /// No description provided for @physioSummaryBody.
  ///
  /// In en, this message translates to:
  /// **'Average body score: {score} of 5'**
  String physioSummaryBody(String score);

  /// No description provided for @physioSummaryVsPrevious.
  ///
  /// In en, this message translates to:
  /// **'{change} vs. the previous {days} days'**
  String physioSummaryVsPrevious(String change, int days);

  /// No description provided for @physioSummaryRestFlare.
  ///
  /// In en, this message translates to:
  /// **'Rest days: {rest} · Flare days: {flare}'**
  String physioSummaryRestFlare(int rest, int flare);

  /// No description provided for @physioSummaryCrashChecks.
  ///
  /// In en, this message translates to:
  /// **'Soreness checks that looked like a possible crash: {count}'**
  String physioSummaryCrashChecks(int count);

  /// No description provided for @physioSummaryUsualDelay.
  ///
  /// In en, this message translates to:
  /// **'Usual delay before a dip after bigger days (whole history): {lag}'**
  String physioSummaryUsualDelay(String lag);

  /// No description provided for @physioSymptomsHeading.
  ///
  /// In en, this message translates to:
  /// **'Symptoms after sessions'**
  String get physioSymptomsHeading;

  /// No description provided for @physioSorenessTally.
  ///
  /// In en, this message translates to:
  /// **'Soreness checks: {doms} looked like ordinary muscle soreness, {crash} like a possible crash, {unclear} unclear.'**
  String physioSorenessTally(int doms, int crash, int unclear);

  /// No description provided for @physioNoSorenessChecks.
  ///
  /// In en, this message translates to:
  /// **'No soreness checks in this period.'**
  String get physioNoSorenessChecks;

  /// No description provided for @physioColDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get physioColDate;

  /// No description provided for @physioColOnset.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get physioColOnset;

  /// No description provided for @physioColSpread.
  ///
  /// In en, this message translates to:
  /// **'Spread'**
  String get physioColSpread;

  /// No description provided for @physioColTrend.
  ///
  /// In en, this message translates to:
  /// **'Trend'**
  String get physioColTrend;

  /// No description provided for @physioColVerdict.
  ///
  /// In en, this message translates to:
  /// **'Read as'**
  String get physioColVerdict;

  /// No description provided for @physioFollowUpIntro.
  ///
  /// In en, this message translates to:
  /// **'Body score (1 severe – 5 loose & stable) on session days and the two days after:'**
  String get physioFollowUpIntro;

  /// No description provided for @physioColSession.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get physioColSession;

  /// No description provided for @physioColSameDay.
  ///
  /// In en, this message translates to:
  /// **'Same day'**
  String get physioColSameDay;

  /// No description provided for @physioColDay1.
  ///
  /// In en, this message translates to:
  /// **'+1 day'**
  String get physioColDay1;

  /// No description provided for @physioColDay2.
  ///
  /// In en, this message translates to:
  /// **'+2 days'**
  String get physioColDay2;

  /// No description provided for @physioNoSessions.
  ///
  /// In en, this message translates to:
  /// **'No sessions logged in this period.'**
  String get physioNoSessions;
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
