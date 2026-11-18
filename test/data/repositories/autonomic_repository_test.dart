import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/data/db/app_database.dart' show AppDatabase;
import 'package:zebrapace_app/data/repositories/autonomic_repository.dart';
import 'package:zebrapace_app/domain/models/autonomic.dart';

void main() {
  late AppDatabase db;
  late AutonomicRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = AutonomicRepository(db);
  });
  tearDown(() => db.close());

  test('stand test round-trips readings, symptoms and early stop', () async {
    await repo.saveStandTest(const StandTest(
      id: 't1',
      date: '2026-11-18',
      startedAt: '2026-11-18T09:00:00',
      baselinePosition: 'sitting',
      readings: {
        StandPoint.baseline: StandReading(hr: 68, sys: 118, dia: 76),
        StandPoint.min1: StandReading(hr: 92),
      },
      symptoms: [StandSymptom.lightheaded, StandSymptom.palpitations],
      stoppedEarly: true,
    ));
    final t = (await repo.watchStandTests().first).single;
    expect(t.baselinePosition, 'sitting');
    expect(t.at(StandPoint.baseline).sys, 118);
    expect(t.at(StandPoint.min1).hr, 92);
    expect(t.at(StandPoint.min3).isEmpty, isTrue);
    expect(t.symptoms, [StandSymptom.lightheaded, StandSymptom.palpitations]);
    expect(t.stoppedEarly, isTrue);

    await repo.deleteStandTest('t1');
    expect(await repo.watchStandTests().first, isEmpty);
  });

  test('sweat is one row per day; clearing it removes the day', () async {
    await repo.setSweat('2026-11-18', [SweatKind.coldClammy]);
    await repo.setSweat('2026-11-18', [SweatKind.coldClammy, SweatKind.nightSweats]);
    var logs = await repo.watchSweatRange('2026-11-01', '2026-11-30').first;
    expect(logs.single.kinds, [SweatKind.coldClammy, SweatKind.nightSweats]);

    await repo.setSweat('2026-11-18', const []);
    logs = await repo.watchSweatRange('2026-11-01', '2026-11-30').first;
    expect(logs, isEmpty);
  });

  test('blood pressure readings are kept oldest first', () async {
    await repo.saveBloodPressure(const BloodPressureReading(
        id: 'b', date: '2026-11-18', takenAt: '2026-11-18T20:00:00', systolic: 112, diastolic: 74));
    await repo.saveBloodPressure(const BloodPressureReading(
        id: 'a',
        date: '2026-11-18',
        takenAt: '2026-11-18T08:00:00',
        systolic: 118,
        diastolic: 78,
        pulse: 66,
        position: 'lying'));
    final all = await repo.watchBloodPressure().first;
    expect(all.map((r) => r.id), ['a', 'b']);
    expect(all.first.pulse, 66);
    expect(all.first.position, 'lying');
  });
}
