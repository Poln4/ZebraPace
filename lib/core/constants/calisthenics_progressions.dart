/// Full progression ladder + per-level goals, sourced from
/// hybridcalisthenics.com (Al Kavadlo's Hybrid Calisthenics method) on
/// 2026-09-04. Goal numbers are language-independent data — only level
/// [CalisthenicsLevel.name] is localized, via [AppLocalizations].
library;

import '../../l10n/app_localizations.dart';
import 'enums.dart';

class CalisthenicsLevel {
  const CalisthenicsLevel({
    required this.name,
    required this.targetSets,
    required this.targetValue,
    this.unit = SetUnit.reps,
    this.bothSides = false,
  });

  final String name;
  final int targetSets;

  /// Target reps, or target hold-seconds when [unit] is [SetUnit.seconds].
  final int targetValue;
  final SetUnit unit;

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
                unit: SetUnit.seconds,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsTwistsBentLeg,
                targetSets: 3,
                targetValue: 60,
                unit: SetUnit.seconds,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsTwistsFull,
                targetSets: 3,
                targetValue: 60,
                unit: SetUnit.seconds,
                bothSides: true),
          ],
        // Not a Hybrid Calisthenics ladder — common standalone holds so
        // isometric work outside the six ladders has somewhere to go. Goals
        // are gentle starting targets, not sourced from the method.
        CalisthenicsExercise.holds => [
            CalisthenicsLevel(
                name: l10n.calisthenicsHoldsPlank,
                targetSets: 3,
                targetValue: 60,
                unit: SetUnit.seconds),
            CalisthenicsLevel(
                name: l10n.calisthenicsHoldsSidePlank,
                targetSets: 3,
                targetValue: 30,
                unit: SetUnit.seconds,
                bothSides: true),
            CalisthenicsLevel(
                name: l10n.calisthenicsHoldsWallSit,
                targetSets: 3,
                targetValue: 60,
                unit: SetUnit.seconds),
            CalisthenicsLevel(
                name: l10n.calisthenicsHoldsGluteBridge,
                targetSets: 3,
                targetValue: 30,
                unit: SetUnit.seconds),
            CalisthenicsLevel(
                name: l10n.calisthenicsHoldsHollowBody,
                targetSets: 3,
                targetValue: 30,
                unit: SetUnit.seconds),
            CalisthenicsLevel(
                name: l10n.calisthenicsHoldsDeadHang,
                targetSets: 3,
                targetValue: 30,
                unit: SetUnit.seconds),
          ],
      };
}

/// True when at least [targetSets] of the logged sets each reached
/// [targetValue] — "3 sets of 30" means three sets of 30 or more, not one
/// big set. Sets beyond the target count don't have to qualify.
bool meetsGoal(List<int> setValues, {required int targetSets, required int targetValue}) =>
    setValues.where((v) => v >= targetValue).length >= targetSets;

/// 0.0-1.0 progress toward the goal: the best [targetSets] sets, each
/// capped at [targetValue], as a share of the full goal.
double goalProgress(List<int> setValues, {required int targetSets, required int targetValue}) {
  if (targetSets <= 0 || targetValue <= 0) return 0;
  final best = ([...setValues]..sort((a, b) => b.compareTo(a))).take(targetSets);
  final done = best.fold<int>(0, (sum, v) => sum + (v > targetValue ? targetValue : v));
  return done / (targetSets * targetValue);
}
