import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/data/repositories/activity_repository.dart';
import 'package:zebrapace_app/data/repositories/daily_log_repository.dart';
import 'package:zebrapace_app/data/repositories/injury_repository.dart';
import 'package:zebrapace_app/domain/services/export_import_service.dart';

void main() {
  late AppDatabase db;
  late ExportImportService service;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    service = ExportImportService(db);
  });

  tearDown(() => db.close());

  test('export -> wipe -> import (merge) round-trips daily_logs and activities', () async {
    final dailyLogRepo = DailyLogRepository(db);
    final activityRepo = ActivityRepository(db);

    final log = await dailyLogRepo.getOrCreateDailyLog('2026-01-01');
    await dailyLogRepo.upsertDailyLog(log.copyWith(steps: 4200, proteinG: 80));
    await activityRepo.insert(date: '2026-01-01', activityName: 'Gentle walk', durationMin: 15);

    final exported = await service.exportAllDataJson();

    await service.deleteAllDataExceptSettings();
    expect(await dailyLogRepo.getAll(), isEmpty);

    await service.importAllDataJson(exported, replace: false);

    final restored = await dailyLogRepo.getAll();
    expect(restored, hasLength(1));
    expect(restored.first.steps, 4200);
    expect(restored.first.proteinG, 80);

    final activities = await activityRepo.watchForDate('2026-01-01').first;
    expect(activities, hasLength(1));
    expect(activities.first.activityName, 'Gentle walk');
  });

  test('re-importing the same export twice does not duplicate rows (idempotent merge)', () async {
    final dailyLogRepo = DailyLogRepository(db);
    final log = await dailyLogRepo.getOrCreateDailyLog('2026-01-01');
    await dailyLogRepo.upsertDailyLog(log.copyWith(steps: 1000));

    final exported = await service.exportAllDataJson();
    await service.importAllDataJson(exported, replace: false);
    await service.importAllDataJson(exported, replace: false);

    expect(await dailyLogRepo.getAll(), hasLength(1));
  });

  test('replace mode wipes existing data in a table before importing', () async {
    final dailyLogRepo = DailyLogRepository(db);
    final log = await dailyLogRepo.getOrCreateDailyLog('2026-01-01');
    await dailyLogRepo.upsertDailyLog(log.copyWith(steps: 1000));
    final exported = await service.exportAllDataJson();

    // Add a second, unrelated day that should be wiped by a replace import.
    final other = await dailyLogRepo.getOrCreateDailyLog('2026-02-01');
    await dailyLogRepo.upsertDailyLog(other.copyWith(steps: 9999));

    await service.importAllDataJson(exported, replace: true);

    final all = await dailyLogRepo.getAll();
    expect(all.map((l) => l.date), ['2026-01-01']);
  });

  test('deleteAllDataExceptSettings preserves settings but clears everything else', () async {
    final dailyLogRepo = DailyLogRepository(db);
    final injuryRepo = InjuryRepository(db);
    await dailyLogRepo.getOrCreateDailyLog('2026-01-01');
    await injuryRepo.insert(
      dateStarted: '2026-01-01',
      zone: InjuryZone.wrist,
      kind: InjuryKind.joint,
      type: InjuryType.subluxation,
    );

    await service.deleteAllDataExceptSettings();

    expect(await dailyLogRepo.getAll(), isEmpty);
    expect(await injuryRepo.getAll(), isEmpty);
  });

  test('CSV export includes a header row and one row per daily log', () async {
    final dailyLogRepo = DailyLogRepository(db);
    final log = await dailyLogRepo.getOrCreateDailyLog('2026-01-01');
    await dailyLogRepo.upsertDailyLog(log.copyWith(steps: 4200));

    final csv = await service.exportDailyLogsCsv();
    final lines = csv.trim().split('\n');
    expect(lines.first, contains('date'));
    expect(lines.length, 2); // header + 1 row
    expect(lines[1], contains('4200'));
  });
}
