import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/data/repositories/therapy_repository.dart';

void main() {
  late AppDatabase db;
  late TherapyRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = TherapyRepository(db);
  });

  tearDown(() => db.close());

  test('update changes the editable fields', () async {
    await repo.insert(date: '2026-01-01', therapyName: 'Massage', durationMin: 15);
    final before = (await repo.getRange('2026-01-01', '2026-01-01')).single;

    await repo.update(
      id: before.id,
      therapyName: 'Massage (updated)',
      durationMin: 30,
      mentalState: MentalState.good,
      bodyFeeling: BodyFeeling.good,
    );

    final after = (await repo.getRange('2026-01-01', '2026-01-01')).single;
    expect(after.therapyName, 'Massage (updated)');
    expect(after.durationMin, 30);
    expect(after.mentalState, MentalState.good);
    expect(after.bodyFeeling, BodyFeeling.good);
  });

  test('delete removes only the targeted row', () async {
    await repo.insert(date: '2026-01-01', therapyName: 'Massage', durationMin: 15);
    await repo.insert(date: '2026-01-01', therapyName: 'Heat pad', durationMin: 20);
    final rows = await repo.getRange('2026-01-01', '2026-01-01');
    final toDelete = rows.firstWhere((t) => t.therapyName == 'Massage');

    await repo.delete(toDelete.id);

    final remaining = await repo.getRange('2026-01-01', '2026-01-01');
    expect(remaining.length, 1);
    expect(remaining.single.therapyName, 'Heat pad');
  });
}
