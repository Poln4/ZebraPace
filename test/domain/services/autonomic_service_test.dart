import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/domain/models/autonomic.dart';
import 'package:zebrapace_app/domain/services/autonomic_service.dart';

StandTest test_(
  String id, {
  int? base,
  int? m1,
  int? m3,
  int? m10,
  int? bSys,
  int? bDia,
  int? s1,
  int? d1,
  int? s3,
  int? d3,
}) => StandTest(
  id: id,
  date: '2026-11-18',
  startedAt: '2026-11-18T09:0$id:00',
  readings: {
    StandPoint.baseline: StandReading(hr: base, sys: bSys, dia: bDia),
    StandPoint.min1: StandReading(hr: m1, sys: s1, dia: d1),
    StandPoint.min3: StandReading(hr: m3, sys: s3, dia: d3),
    StandPoint.min10: StandReading(hr: m10),
  },
);

BloodPressureReading bp(
  String id,
  String at,
  int sys,
  int dia, {
  String position = 'sitting',
}) => BloodPressureReading(
  id: id,
  date: at.substring(0, 10),
  takenAt: at,
  systolic: sys,
  diastolic: dia,
  position: position,
);

void main() {
  group('stand test', () {
    test('rise is the highest standing HR minus baseline', () {
      final s = AutonomicService.summarize(
        test_('1', base: 70, m1: 88, m3: 95, m10: 91),
      );
      expect(s.hrRise, 25);
      expect(s.maxStandingHr, 95);
      expect(s.heartRatePattern, isFalse);
    });

    test('a rise of 30 bpm shows the heart-rate pattern hint', () {
      expect(
        AutonomicService.summarize(test_('1', base: 70, m1: 100))
            .heartRatePattern,
        isTrue,
      );
    });

    test('any standing HR above 120 shows it even with a smaller rise', () {
      expect(
        AutonomicService.summarize(test_('1', base: 100, m3: 121))
            .heartRatePattern,
        isTrue,
      );
    });

    test('pressure drop of 20 systolic or 10 diastolic within 3 min', () {
      final s = AutonomicService.summarize(
        test_(
          '1',
          base: 70,
          m1: 80,
          bSys: 120,
          bDia: 80,
          s1: 102,
          d1: 76,
          s3: 99,
          d3: 78,
        ),
      );
      expect(s.sysChange, -21);
      expect(s.diaChange, -4);
      expect(s.pressureDropPattern, isTrue);
    });

    test('no baseline means no rise and no hint', () {
      final s = AutonomicService.summarize(test_('1', m1: 130));
      expect(s.hrRise, isNull);
      expect(s.heartRatePattern, isTrue, reason: 'above 120 stands on its own');
    });

    test('usual rise appears after 3 earlier tests, as their median', () {
      final earlier = [
        test_('1', base: 70, m1: 80),
        test_('2', base: 70, m1: 90),
      ];
      final latest = test_('4', base: 70, m1: 85);
      expect(
        AutonomicService.summarize(latest, earlier: earlier).usualHrRise,
        isNull,
      );
      final more = [...earlier, test_('3', base: 70, m1: 82)];
      expect(AutonomicService.summarize(latest, earlier: more).usualHrRise, 12);
    });

    test('next point follows the timer', () {
      expect(AutonomicService.nextPoint(0), StandPoint.min1);
      expect(AutonomicService.nextPoint(60), StandPoint.min3);
      expect(AutonomicService.nextPoint(599), StandPoint.min10);
      expect(AutonomicService.nextPoint(600), isNull);
    });
  });

  group('blood pressure', () {
    test('usual is the median of earlier readings in the same position', () {
      final all = [
        bp('a', '2026-11-01T08:00:00', 110, 70),
        bp('b', '2026-11-02T08:00:00', 120, 80),
        bp('c', '2026-11-03T08:00:00', 130, 90),
        bp('s', '2026-11-03T09:00:00', 100, 60, position: 'standing'),
        bp('d', '2026-11-04T08:00:00', 140, 95),
      ];
      expect(AutonomicService.usualPressure(all, all.last), (120.0, 80.0));
    });

    test('readings older than 30 days or fewer than 3 give no usual', () {
      final all = [
        bp('a', '2026-09-01T08:00:00', 110, 70),
        bp('b', '2026-11-02T08:00:00', 120, 80),
        bp('c', '2026-11-03T08:00:00', 130, 90),
        bp('d', '2026-11-04T08:00:00', 140, 95),
      ];
      expect(AutonomicService.usualPressure(all, all.last), isNull);
    });
  });

  test('sweat counts, most common first', () {
    final logs = [
      const SweatLog(
        id: '1',
        date: '2026-11-17',
        kinds: [SweatKind.coldClammy],
      ),
      const SweatLog(
        id: '2',
        date: '2026-11-18',
        kinds: [SweatKind.coldClammy, SweatKind.nightSweats],
      ),
    ];
    expect(AutonomicService.sweatCounts(logs).first, (SweatKind.coldClammy, 2));
  });

  test('typos outside plausible ranges are ignored', () {
    expect(VitalRange.hr(6611676), isNull);
    expect(VitalRange.hr(66), 66);
    expect(VitalRange.sys(12), isNull);
    expect(VitalRange.dia(74), 74);
  });

  test('a stored typo in the baseline gives no rise', () {
    final s = AutonomicService.summarize(test_('1', base: 6611676, m1: 98));
    expect(s.hrRise, isNull);
  });
}
