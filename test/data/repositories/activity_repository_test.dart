import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/data/repositories/activity_repository.dart';
import 'package:zebrapace_app/domain/models/activity.dart';

void main() {
  late AppDatabase db;
  late ActivityRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = ActivityRepository(db);
  });

  tearDown(() => db.close());

  test('update changes the editable fields, including a retroactive HR range', () async {
    await repo.insert(date: '2026-01-01', activityName: 'Walk', durationMin: 20);
    final before = (await repo.getRange('2026-01-01', '2026-01-01')).single;

    await repo.update(
      id: before.id,
      activityName: 'Walk (updated)',
      durationMin: 30,
      extraWeightKg: 2,
      mentalState: MentalState.good,
      bodyFeeling: BodyFeeling.good,
      heartRateMinBpm: 90,
      heartRateMaxBpm: 140,
    );

    final after = (await repo.getRange('2026-01-01', '2026-01-01')).single;
    expect(after.activityName, 'Walk (updated)');
    expect(after.durationMin, 30);
    expect(after.extraWeightKg, 2);
    expect(after.heartRateMinBpm, 90);
    expect(after.heartRateMaxBpm, 140);
  });

  test('update leaves HealthKit-only fields (source, metsAvg) untouched', () async {
    await repo.insert(
      date: '2026-01-01',
      activityName: 'Run',
      durationMin: 20,
      source: ActivitySource.healthkit,
      healthkitUuid: 'uuid-1',
      metsAvg: 8.5,
      activeEnergyKcal: 150,
    );
    final before = (await repo.getRange('2026-01-01', '2026-01-01')).single;

    await repo.update(id: before.id, activityName: 'Run', durationMin: 25);

    final after = (await repo.getRange('2026-01-01', '2026-01-01')).single;
    expect(after.source, ActivitySource.healthkit);
    expect(after.healthkitUuid, 'uuid-1');
    expect(after.metsAvg, 8.5);
    expect(after.activeEnergyKcal, 150);
  });

  test('delete removes only the targeted row', () async {
    await repo.insert(date: '2026-01-01', activityName: 'Walk', durationMin: 20);
    await repo.insert(date: '2026-01-01', activityName: 'Swim', durationMin: 30);
    final rows = await repo.getRange('2026-01-01', '2026-01-01');
    final toDelete = rows.firstWhere((a) => a.activityName == 'Walk');

    await repo.delete(toDelete.id);

    final remaining = await repo.getRange('2026-01-01', '2026-01-01');
    expect(remaining.length, 1);
    expect(remaining.single.activityName, 'Swim');
  });
}
