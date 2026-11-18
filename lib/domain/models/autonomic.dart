/// The Autonomic signals card: two lanes kept apart on purpose. No
/// sympathetic/parasympathetic "balance" or ratio is ever computed — the
/// spectral indices that claim to show one (LF/HF, normalised units) aren't
/// valid measures of either side.
library;

/// The points of the stand test, in order.
enum StandPoint {
  baseline,
  min1,
  min3,
  min10;

  /// Seconds after standing up when this point is read (baseline: before).
  int get atSecond => switch (this) {
        baseline => 0,
        min1 => 60,
        min3 => 180,
        min10 => 600,
      };
}

/// Felt while standing. Stored by name.
enum StandSymptom {
  lightheaded,
  palpitations,
  blurredVision,
  nausea,
  sweating,
  shaky,
  breathless,
  headache;

  static List<StandSymptom> fromNames(Iterable<String> names) => [
        for (final n in names)
          ...StandSymptom.values.where((s) => s.name == n),
      ];
}

/// Sweating as the person describes it for a day. Stored by name.
enum SweatKind {
  moreThanUsual,
  lessThanUsual,
  couldNotSweat,
  coldClammy,
  nightSweats,
  oneSideOrPatchy;

  static List<SweatKind> fromNames(Iterable<String> names) => [
        for (final n in names)
          ...SweatKind.values.where((s) => s.name == n),
      ];
}

/// Plausible ranges for typed-in numbers. Anything outside is treated as
/// a typo and ignored, so one slip can't distort the comparisons.
abstract final class VitalRange {
  static int? hr(int? v) => _within(v, 25, 250);
  static int? sys(int? v) => _within(v, 50, 260);
  static int? dia(int? v) => _within(v, 25, 160);

  static int? _within(int? v, int lo, int hi) => v != null && v >= lo && v <= hi ? v : null;
}

class StandReading {
  const StandReading({this.hr, this.sys, this.dia});

  final int? hr;
  final int? sys;
  final int? dia;

  bool get isEmpty => hr == null && sys == null && dia == null;
}

class StandTest {
  const StandTest({
    required this.id,
    required this.date,
    required this.startedAt,
    this.baselinePosition = 'lying',
    this.readings = const {},
    this.symptoms = const [],
    this.stoppedEarly = false,
    this.note,
  });

  final String id;
  final String date;
  final String startedAt;

  /// 'lying' or 'sitting'.
  final String baselinePosition;
  final Map<StandPoint, StandReading> readings;
  final List<StandSymptom> symptoms;
  final bool stoppedEarly;
  final String? note;

  StandReading at(StandPoint p) => readings[p] ?? const StandReading();
}

class SweatLog {
  const SweatLog({required this.id, required this.date, this.kinds = const [], this.note});

  final String id;
  final String date;
  final List<SweatKind> kinds;
  final String? note;
}

/// One cuff reading typed in by the person.
class BloodPressureReading {
  const BloodPressureReading({
    required this.id,
    required this.date,
    required this.takenAt,
    required this.systolic,
    required this.diastolic,
    this.pulse,
    this.position = 'sitting',
    this.note,
  });

  final String id;
  final String date;
  final String takenAt;
  final int systolic;
  final int diastolic;
  final int? pulse;

  /// 'sitting', 'lying' or 'standing'.
  final String position;
  final String? note;
}
