import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/core/utils/date_utils.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/data/repositories/calisthenics_repository.dart';
import 'package:zebrapace_app/domain/services/calisthenics_service.dart';

void main() {
  late AppDatabase db;
  late CalisthenicsRepository repo;
  late CalisthenicsService service;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = CalisthenicsRepository(db);
    service = CalisthenicsService(repo);
  });

  tearDown(() => db.close());

  Future<void> logSession(String date, double comfort) async {
    await repo.insert(
      date: date,
      exercise: CalisthenicsExercise.pushups,
      progression: 'Wall Pushups (~35% BW)',
      sets: 3,
      reps: 10,
      comfortScore: comfort,
    );
  }

  Future<void> logSessionWithVolume(String date, {required int sets, required int reps}) async {
    await repo.insert(
      date: date,
      exercise: CalisthenicsExercise.pushups,
      progression: 'Wall Pushups (~35% BW)',
      sets: sets,
      reps: reps,
      comfortScore: 3.0,
    );
  }

  test('fires only with exactly 3 sessions averaging at/above threshold', () async {
    await logSession(dateKey(DateTime(2026, 1, 1)), 4.0);
    await logSession(dateKey(DateTime(2026, 1, 2)), 4.0);

    expect(
      await service.checkComfortMilestone('pushups', dateKey(DateTime(2026, 1, 3)),
          comfortThreshold: 3.8),
      isFalse,
      reason: 'only 2 sessions logged so far, must not fire',
    );

    await logSession(dateKey(DateTime(2026, 1, 3)), 4.0);

    expect(
      await service.checkComfortMilestone('pushups', dateKey(DateTime(2026, 1, 3)),
          comfortThreshold: 3.8),
      isTrue,
      reason: 'exactly 3 sessions averaging 4.0 >= 3.8 threshold',
    );
  });

  test('does not fire when the 3-session average is below threshold', () async {
    await logSession(dateKey(DateTime(2026, 1, 1)), 2.0);
    await logSession(dateKey(DateTime(2026, 1, 2)), 3.0);
    await logSession(dateKey(DateTime(2026, 1, 3)), 3.0);

    expect(
      await service.checkComfortMilestone('pushups', dateKey(DateTime(2026, 1, 3)),
          comfortThreshold: 3.8),
      isFalse,
    );
  });

  test('only counts the exact exercise name, not other exercises', () async {
    await repo.insert(
      date: dateKey(DateTime(2026, 1, 1)),
      exercise: CalisthenicsExercise.squats,
      progression: 'Jackknife Squats',
      sets: 3,
      reps: 10,
      comfortScore: 5.0,
    );
    await logSession(dateKey(DateTime(2026, 1, 2)), 4.0);
    await logSession(dateKey(DateTime(2026, 1, 3)), 4.0);

    // Only 2 pushup sessions exist even though 3 calisthenics rows total exist.
    expect(
      await service.checkComfortMilestone('pushups', dateKey(DateTime(2026, 1, 3)),
          comfortThreshold: 3.8),
      isFalse,
    );
  });

  test('goal milestone fires only with exactly 3 sessions each meeting sets and reps', () async {
    await logSessionWithVolume(dateKey(DateTime(2026, 1, 1)), sets: 3, reps: 50);
    await logSessionWithVolume(dateKey(DateTime(2026, 1, 2)), sets: 3, reps: 50);

    expect(
      await service.checkGoalMilestone('pushups', dateKey(DateTime(2026, 1, 2)),
          targetSets: 3, targetValue: 50),
      isFalse,
      reason: 'only 2 sessions logged so far, must not fire',
    );

    await logSessionWithVolume(dateKey(DateTime(2026, 1, 3)), sets: 3, reps: 50);

    expect(
      await service.checkGoalMilestone('pushups', dateKey(DateTime(2026, 1, 3)),
          targetSets: 3, targetValue: 50),
      isTrue,
      reason: 'exactly 3 sessions all meeting the 3x50 goal',
    );
  });

  test('goal milestone does not fire when any of the last 3 sessions falls short', () async {
    await logSessionWithVolume(dateKey(DateTime(2026, 1, 1)), sets: 3, reps: 50);
    await logSessionWithVolume(dateKey(DateTime(2026, 1, 2)), sets: 3, reps: 40);
    await logSessionWithVolume(dateKey(DateTime(2026, 1, 3)), sets: 3, reps: 50);

    expect(
      await service.checkGoalMilestone('pushups', dateKey(DateTime(2026, 1, 3)),
          targetSets: 3, targetValue: 50),
      isFalse,
      reason: 'the middle session only hit 40 reps, short of the 50 goal',
    );
  });
}
