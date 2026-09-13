import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/data/repositories/calisthenics_repository.dart';

void main() {
  late AppDatabase db;
  late CalisthenicsRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = CalisthenicsRepository(db);
  });

  tearDown(() => db.close());

  test('update changes sets/reps/comfort/HR range but leaves exercise/progression fixed', () async {
    await repo.insert(
      date: '2026-01-01',
      exercise: CalisthenicsExercise.pushups,
      progression: 'Wall',
      sets: 3,
      reps: 10,
      comfortScore: 3,
    );
    final before = (await repo.getRange('2026-01-01', '2026-01-01')).single;

    await repo.update(
      id: before.id,
      sets: 4,
      reps: 12,
      comfortScore: 4.5,
      contractionMode: ContractionMode.concentric,
      heartRateMinBpm: 95,
      heartRateMaxBpm: 130,
    );

    final after = (await repo.getRange('2026-01-01', '2026-01-01')).single;
    expect(after.sets, 4);
    expect(after.reps, 12);
    expect(after.comfortScore, 4.5);
    expect(after.contractionMode, ContractionMode.concentric);
    expect(after.heartRateMinBpm, 95);
    expect(after.heartRateMaxBpm, 130);
    expect(after.exercise, CalisthenicsExercise.pushups);
    expect(after.progression, 'Wall');
  });

  test('delete removes only the targeted row', () async {
    await repo.insert(
      date: '2026-01-01',
      exercise: CalisthenicsExercise.pushups,
      progression: 'Wall',
      sets: 3,
      reps: 10,
      comfortScore: 3,
    );
    await repo.insert(
      date: '2026-01-01',
      exercise: CalisthenicsExercise.squats,
      progression: 'Bodyweight',
      sets: 3,
      reps: 10,
      comfortScore: 3,
    );
    final rows = await repo.getRange('2026-01-01', '2026-01-01');
    final toDelete = rows.firstWhere((s) => s.exercise == CalisthenicsExercise.pushups);

    await repo.delete(toDelete.id);

    final remaining = await repo.getRange('2026-01-01', '2026-01-01');
    expect(remaining.length, 1);
    expect(remaining.single.exercise, CalisthenicsExercise.squats);
  });
}
