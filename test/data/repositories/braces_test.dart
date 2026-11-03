import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/data/repositories/daily_log_repository.dart';
import 'package:zebrapace_app/data/repositories/settings_repository.dart';
import 'package:zebrapace_app/domain/models/brace_use.dart';
import 'package:zebrapace_app/providers/brace_providers.dart';

void main() {
  late AppDatabase db;
  late DailyLogRepository logs;
  late SettingsRepository settings;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    logs = DailyLogRepository(db);
    settings = SettingsRepository(db);
  });

  tearDown(() => db.close());

  test('days logged before sides and counts still read as the same braces', () async {
    final log = await logs.getOrCreateDailyLog('2026-01-01');
    await db.customStatement(
        "UPDATE daily_logs SET braces_used = '[\"ankle\",\"ringSplints\",\"gone\"]' WHERE id = ?",
        [log.id]);

    final braces = (await logs.getOrCreateDailyLog('2026-01-01')).bracesUsed;
    expect(braces, [BraceUse.builtIn(BraceType.ankle), BraceUse.builtIn(BraceType.ringSplints)]);
    expect(braces.first.side, isNull);
    expect(braces.last.count, 1);
  });

  test('sides, counts and custom braces survive a save', () async {
    final achillesSplint = await addCustomBrace(settings, 'Achilles night splint');
    final log = await logs.getOrCreateDailyLog('2026-01-02');
    final worn = [
      BraceUse.builtIn(BraceType.ankle, side: BraceSide.both),
      BraceUse.builtIn(BraceType.ringSplints, count: 4),
      BraceUse.custom(achillesSplint, count: 2),
      BraceUse.builtIn(BraceType.siBelt),
    ];
    await logs.upsertDailyLog(log.copyWith(bracesUsed: worn));

    expect((await logs.getOrCreateDailyLog('2026-01-02')).bracesUsed, worn);
  });

  test('a removed custom brace leaves the picker but stays on logged days', () async {
    final splint = await addCustomBrace(settings, 'Night splint');
    final log = await logs.getOrCreateDailyLog('2026-01-03');
    await logs.upsertDailyLog(log.copyWith(bracesUsed: [BraceUse.custom(splint)]));

    await removeCustomBrace(settings, splint.id);

    expect(decodeCustomBraces(await settings.getString('custom_braces', '')), isEmpty);
    final kept = (await logs.getOrCreateDailyLog('2026-01-03')).bracesUsed.single;
    expect(kept.customName, 'Night splint');
  });

  test('adding a name that already exists reuses it', () async {
    final first = await addCustomBrace(settings, 'Night splint');
    final again = await addCustomBrace(settings, '  night SPLINT ');
    expect(again.id, first.id);
    expect(decodeCustomBraces(await settings.getString('custom_braces', '')), hasLength(1));
  });
}
