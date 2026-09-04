/// Full progression ladder + per-level goals, sourced from
/// hybridcalisthenics.com (Al Kavadlo's Hybrid Calisthenics method) on
/// 2026-09-04. Goal numbers are language-independent data — only level
/// [CalisthenicsLevel.name] is localized, via [AppLocalizations].
library;

import '../../l10n/app_localizations.dart';
import 'enums.dart';

enum GoalUnit { reps, secondsHold }

class CalisthenicsLevel {
  const CalisthenicsLevel({
    required this.name,
    required this.targetSets,
    required this.targetValue,
    this.unit = GoalUnit.reps,
    this.bothSides = false,
  });

  final String name;
  final int targetSets;

  /// Target reps, or target hold-seconds when [unit] is [GoalUnit.secondsHold].
  final int targetValue;
  final GoalUnit unit;

  /// True when the site's goal is per side (e.g. "2 Sets of 12 (Both Sides)")
  /// rather than a combined total.
  final bool bothSides;
}

extension CalisthenicsExerciseLevels on CalisthenicsExercise {
  List<CalisthenicsLevel> levels(AppLocalizations l10n) => switch (this) {
        CalisthenicsExercise.pushups => [
            CalisthenicsLevel(name: l10n.calisthenicsPushupsWall, targetSets: 3, targetValue: 50),
            CalisthenicsLevel(
                name: l10n.calisthenicsPushupsIncline, targetSets: 3, targetValue: 40),
            CalisthenicsLevel(
                name: l10n.calisthenicsPushupsAdvancedIncline, targetSets: 3, targetValue: 35),
            CalisthenicsLevel(name: l10n.calisthenicsPushupsKnee, targetSets: 3, targetValue: 30),
            CalisthenicsLevel(name: l10n.calisthenicsPushupsFull, targetSets: 3, targetValue: 25),
            CalisthenicsLevel(
                name: l10n.calisthenicsPushupsNarrow, targetSets: 3, targetValue: 20),
            CalisthenicsLevel(
                name: l10n.calisthenicsPushupsSideStaggered,
                targetSets: 2,
                targetValue: 20,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsPushupsArcher,
                targetSets: 2,
                targetValue: 12,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsPushupsSlidingOneArm,
                targetSets: 2,
                targetValue: 12,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsPushupsOneArm,
                targetSets: 2,
                targetValue: 9,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsPushupsAdvancedOneArm,
                targetSets: 2,
                targetValue: 9,
                bothSides: true),
          ],
        CalisthenicsExercise.squats => [
            CalisthenicsLevel(
                name: l10n.calisthenicsSquatsJackknife, targetSets: 3, targetValue: 35),
            CalisthenicsLevel(
                name: l10n.calisthenicsSquatsAssisted, targetSets: 3, targetValue: 30),
            CalisthenicsLevel(name: l10n.calisthenicsSquatsHalf, targetSets: 2, targetValue: 50),
            CalisthenicsLevel(name: l10n.calisthenicsSquatsFull, targetSets: 2, targetValue: 30),
            CalisthenicsLevel(
                name: l10n.calisthenicsSquatsNarrow, targetSets: 2, targetValue: 30),
            CalisthenicsLevel(
                name: l10n.calisthenicsSquatsSideStaggered,
                targetSets: 2,
                targetValue: 20,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsSquatsFrontStaggered,
                targetSets: 2,
                targetValue: 15,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsSquatsAssistedOneLeg,
                targetSets: 2,
                targetValue: 12,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsSquatsOneLegChair,
                targetSets: 2,
                targetValue: 12,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsSquatsOneLeg,
                targetSets: 2,
                targetValue: 12,
                bothSides: true),
          ],
        CalisthenicsExercise.pullups => [
            CalisthenicsLevel(name: l10n.calisthenicsPullupsWall, targetSets: 3, targetValue: 50),
            CalisthenicsLevel(
                name: l10n.calisthenicsPullupsHorizontal, targetSets: 3, targetValue: 30),
            CalisthenicsLevel(
                name: l10n.calisthenicsPullupsAdvancedHorizontal,
                targetSets: 3,
                targetValue: 25),
            CalisthenicsLevel(
                name: l10n.calisthenicsPullupsJackknife, targetSets: 3, targetValue: 20),
            CalisthenicsLevel(name: l10n.calisthenicsPullupsFull, targetSets: 3, targetValue: 12),
            CalisthenicsLevel(name: l10n.calisthenicsPullupsNarrow, targetSets: 3, targetValue: 9),
            CalisthenicsLevel(
                name: l10n.calisthenicsPullupsOneHand,
                targetSets: 2,
                targetValue: 9,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsPullupsAdvancedOneHand,
                targetSets: 2,
                targetValue: 9,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsPullupsArcher,
                targetSets: 2,
                targetValue: 9,
                bothSides: true),
            CalisthenicsLevel(name: l10n.calisthenicsPullupsOneArm, targetSets: 2, targetValue: 6),
          ],
        CalisthenicsExercise.legRaises => [
            CalisthenicsLevel(name: l10n.calisthenicsLegRaisesKnee, targetSets: 2, targetValue: 30),
            CalisthenicsLevel(
                name: l10n.calisthenicsLegRaisesAdvancedKnee, targetSets: 2, targetValue: 30),
            CalisthenicsLevel(
                name: l10n.calisthenicsLegRaisesAlternating, targetSets: 2, targetValue: 25),
            CalisthenicsLevel(name: l10n.calisthenicsLegRaisesFull, targetSets: 2, targetValue: 25),
            CalisthenicsLevel(
                name: l10n.calisthenicsLegRaisesTuckPlow, targetSets: 2, targetValue: 20),
            CalisthenicsLevel(name: l10n.calisthenicsLegRaisesPlow, targetSets: 2, targetValue: 20),
            CalisthenicsLevel(
                name: l10n.calisthenicsLegRaisesHangingKnee, targetSets: 2, targetValue: 15),
            CalisthenicsLevel(
                name: l10n.calisthenicsLegRaisesAdvancedHangingKnee,
                targetSets: 2,
                targetValue: 15),
            CalisthenicsLevel(
                name: l10n.calisthenicsLegRaisesHanging, targetSets: 2, targetValue: 25),
            CalisthenicsLevel(
                name: l10n.calisthenicsLegRaisesToeToBar, targetSets: 2, targetValue: 25),
          ],
        CalisthenicsExercise.bridges => [
            CalisthenicsLevel(name: l10n.calisthenicsBridgesGlute, targetSets: 3, targetValue: 50),
            CalisthenicsLevel(
                name: l10n.calisthenicsBridgesStraight, targetSets: 3, targetValue: 30),
            CalisthenicsLevel(name: l10n.calisthenicsBridgesWall, targetSets: 3, targetValue: 30),
            CalisthenicsLevel(
                name: l10n.calisthenicsBridgesIncline, targetSets: 2, targetValue: 25),
            CalisthenicsLevel(name: l10n.calisthenicsBridgesHead, targetSets: 2, targetValue: 25),
            CalisthenicsLevel(name: l10n.calisthenicsBridgesFull, targetSets: 2, targetValue: 15),
            CalisthenicsLevel(name: l10n.calisthenicsBridgesWheel, targetSets: 2, targetValue: 15),
            CalisthenicsLevel(
                name: l10n.calisthenicsBridgesTap,
                targetSets: 2,
                targetValue: 30,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsBridgesWallWalking, targetSets: 2, targetValue: 10),
            CalisthenicsLevel(
                name: l10n.calisthenicsBridgesStandToStand, targetSets: 2, targetValue: 5),
          ],
        CalisthenicsExercise.twists => [
            CalisthenicsLevel(
                name: l10n.calisthenicsTwistsStraightLeg,
                targetSets: 3,
                targetValue: 60,
                unit: GoalUnit.secondsHold,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsTwistsBentLeg,
                targetSets: 3,
                targetValue: 60,
                unit: GoalUnit.secondsHold,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsTwistsFull,
                targetSets: 3,
                targetValue: 60,
                unit: GoalUnit.secondsHold,
                bothSides: true),
          ],
      };
}
