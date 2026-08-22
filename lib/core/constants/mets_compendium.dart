import 'package:health/health.dart';

/// Static METs-by-workout-type fallback table, used only when neither
/// HealthKit metadata (not currently reachable — see the plan's Phase 3
/// spike notes) nor an energy/duration/bodyweight estimate is available.
/// Values are representative single-intensity picks (not exhaustive
/// intensity tiers) from the Compendium of Physical Activities
/// (Ainsworth et al., 2011 update, and its 2024 Adult Compendium update) —
/// a reasonable "typical" MET for each HealthKit workout type, not a
/// precise measurement.
const Map<HealthWorkoutActivityType, double> metsCompendium = {
  HealthWorkoutActivityType.WALKING: 3.5,
  HealthWorkoutActivityType.HIKING: 6.0,
  HealthWorkoutActivityType.RUNNING: 9.8,
  HealthWorkoutActivityType.BIKING: 7.5,
  HealthWorkoutActivityType.HAND_CYCLING: 5.0,
  HealthWorkoutActivityType.SWIMMING: 6.0,
  HealthWorkoutActivityType.ELLIPTICAL: 5.0,
  HealthWorkoutActivityType.ROWING: 7.0,
  HealthWorkoutActivityType.STAIR_CLIMBING: 8.8,
  HealthWorkoutActivityType.STAIRS: 8.8,
  HealthWorkoutActivityType.YOGA: 2.5,
  HealthWorkoutActivityType.PILATES: 3.0,
  HealthWorkoutActivityType.FLEXIBILITY: 2.3,
  HealthWorkoutActivityType.MIND_AND_BODY: 2.5,
  HealthWorkoutActivityType.BARRE: 3.0,
  HealthWorkoutActivityType.CORE_TRAINING: 3.8,
  HealthWorkoutActivityType.FUNCTIONAL_STRENGTH_TRAINING: 3.5,
  HealthWorkoutActivityType.HIGH_INTENSITY_INTERVAL_TRAINING: 8.0,
  HealthWorkoutActivityType.CROSS_TRAINING: 6.0,
  HealthWorkoutActivityType.MIXED_CARDIO: 6.0,
  HealthWorkoutActivityType.CARDIO_DANCE: 5.5,
  HealthWorkoutActivityType.SOCIAL_DANCE: 4.5,
  HealthWorkoutActivityType.BOXING: 7.8,
  HealthWorkoutActivityType.KICKBOXING: 7.5,
  HealthWorkoutActivityType.MARTIAL_ARTS: 7.5,
  HealthWorkoutActivityType.CLIMBING: 7.5,
  HealthWorkoutActivityType.JUMP_ROPE: 10.0,
  HealthWorkoutActivityType.GOLF: 4.3,
  HealthWorkoutActivityType.TENNIS: 6.5,
  HealthWorkoutActivityType.TABLE_TENNIS: 4.0,
  HealthWorkoutActivityType.BADMINTON: 5.5,
  HealthWorkoutActivityType.SQUASH: 7.3,
  HealthWorkoutActivityType.RACQUETBALL: 7.0,
  HealthWorkoutActivityType.PICKLEBALL: 4.5,
  HealthWorkoutActivityType.BASKETBALL: 6.5,
  HealthWorkoutActivityType.SOCCER: 7.0,
  HealthWorkoutActivityType.VOLLEYBALL: 4.0,
  HealthWorkoutActivityType.BASEBALL: 5.0,
  HealthWorkoutActivityType.SOFTBALL: 5.0,
  HealthWorkoutActivityType.AMERICAN_FOOTBALL: 8.0,
  HealthWorkoutActivityType.RUGBY: 8.3,
  HealthWorkoutActivityType.HOCKEY: 8.0,
  HealthWorkoutActivityType.HANDBALL: 8.0,
  HealthWorkoutActivityType.CRICKET: 5.0,
  HealthWorkoutActivityType.GYMNASTICS: 3.8,
  HealthWorkoutActivityType.BOWLING: 3.0,
  HealthWorkoutActivityType.FISHING: 3.5,
  HealthWorkoutActivityType.SAILING: 3.0,
  HealthWorkoutActivityType.SKATING: 7.0,
  HealthWorkoutActivityType.DOWNHILL_SKIING: 6.0,
  HealthWorkoutActivityType.CROSS_COUNTRY_SKIING: 8.0,
  HealthWorkoutActivityType.SNOWBOARDING: 5.3,
  HealthWorkoutActivityType.CURLING: 4.0,
  HealthWorkoutActivityType.FENCING: 6.0,
  HealthWorkoutActivityType.ARCHERY: 3.5,
  HealthWorkoutActivityType.PLAY: 4.0,
  HealthWorkoutActivityType.COOLDOWN: 2.0,
  HealthWorkoutActivityType.PREPARATION_AND_RECOVERY: 2.0,
};

double? metsForWorkoutType(HealthWorkoutActivityType type) => metsCompendium[type];
