import 'dart:convert';

import 'package:drift/drift.dart';

import '../../core/utils/date_utils.dart';
import '../../core/utils/id_gen.dart';
import '../../domain/models/autonomic.dart';
import '../db/app_database.dart' as db;

/// Stand tests and self-reported sweating for the Autonomic signals card.
class AutonomicRepository {
  AutonomicRepository(this._db);

  final db.AppDatabase _db;

  // --- Stand tests ---

  StandTest _test(db.StandTest r) => StandTest(
        id: r.id,
        date: r.date,
        startedAt: r.startedAt,
        baselinePosition: r.baselinePosition,
        readings: {
          StandPoint.baseline:
              StandReading(hr: r.baselineHr, sys: r.baselineSys, dia: r.baselineDia),
          StandPoint.min1: StandReading(hr: r.hr1, sys: r.sys1, dia: r.dia1),
          StandPoint.min3: StandReading(hr: r.hr3, sys: r.sys3, dia: r.dia3),
          StandPoint.min10: StandReading(hr: r.hr10, sys: r.sys10, dia: r.dia10),
        },
        symptoms: StandSymptom.fromNames(_names(r.symptoms)),
        stoppedEarly: r.stoppedEarly,
        note: r.note,
      );

  /// Oldest first, so the latest is `.last`.
  Stream<List<StandTest>> watchStandTests() {
    final q = _db.select(_db.standTests)..orderBy([(t) => OrderingTerm.asc(t.startedAt)]);
    return q.watch().map((rows) => rows.map(_test).toList());
  }

  Future<void> saveStandTest(StandTest t) async {
    final b = t.at(StandPoint.baseline);
    final m1 = t.at(StandPoint.min1);
    final m3 = t.at(StandPoint.min3);
    final m10 = t.at(StandPoint.min10);
    await _db.into(_db.standTests).insertOnConflictUpdate(db.StandTestsCompanion.insert(
          id: t.id,
          date: t.date,
          startedAt: t.startedAt,
          baselinePosition: Value(t.baselinePosition),
          baselineHr: Value(b.hr),
          baselineSys: Value(b.sys),
          baselineDia: Value(b.dia),
          hr1: Value(m1.hr),
          sys1: Value(m1.sys),
          dia1: Value(m1.dia),
          hr3: Value(m3.hr),
          sys3: Value(m3.sys),
          dia3: Value(m3.dia),
          hr10: Value(m10.hr),
          sys10: Value(m10.sys),
          dia10: Value(m10.dia),
          symptoms: Value(jsonEncode([for (final s in t.symptoms) s.name])),
          stoppedEarly: Value(t.stoppedEarly),
          note: Value(t.note),
          updatedAt: nowIso(),
        ));
  }

  Future<void> deleteStandTest(String id) async {
    await (_db.delete(_db.standTests)..where((t) => t.id.equals(id))).go();
  }

  // --- Sweating ---

  SweatLog _sweat(db.SweatLog r) => SweatLog(
        id: r.id,
        date: r.date,
        kinds: SweatKind.fromNames(_names(r.kinds)),
        note: r.note,
      );

  /// Days from [from] to [to] inclusive, oldest first.
  Stream<List<SweatLog>> watchSweatRange(String from, String to) {
    final q = _db.select(_db.sweatLogs)
      ..where((t) => t.date.isBetweenValues(from, to))
      ..orderBy([(t) => OrderingTerm.asc(t.date)]);
    return q.watch().map((rows) => rows.map(_sweat).toList());
  }

  /// One row per day; an empty selection with no note removes the day.
  Future<void> setSweat(String date, List<SweatKind> kinds, {String? note}) async {
    if (kinds.isEmpty && (note == null || note.isEmpty)) {
      await (_db.delete(_db.sweatLogs)..where((t) => t.date.equals(date))).go();
      return;
    }
    final existing =
        await (_db.select(_db.sweatLogs)..where((t) => t.date.equals(date))).getSingleOrNull();
    await _db.into(_db.sweatLogs).insertOnConflictUpdate(db.SweatLogsCompanion.insert(
          id: existing?.id ?? newId(),
          date: date,
          kinds: Value(jsonEncode([for (final k in kinds) k.name])),
          note: Value(note),
          updatedAt: nowIso(),
        ));
  }

  // --- Blood pressure (cuff) ---

  BloodPressureReading _bp(db.BloodPressureReading r) => BloodPressureReading(
        id: r.id,
        date: r.date,
        takenAt: r.takenAt,
        systolic: r.systolic,
        diastolic: r.diastolic,
        pulse: r.pulse,
        position: r.position,
        note: r.note,
      );

  /// Oldest first.
  Stream<List<BloodPressureReading>> watchBloodPressure() {
    final q = _db.select(_db.bloodPressureReadings)
      ..orderBy([(t) => OrderingTerm.asc(t.takenAt)]);
    return q.watch().map((rows) => rows.map(_bp).toList());
  }

  Future<void> saveBloodPressure(BloodPressureReading r) async {
    await _db.into(_db.bloodPressureReadings).insertOnConflictUpdate(
          db.BloodPressureReadingsCompanion.insert(
            id: r.id,
            date: r.date,
            takenAt: r.takenAt,
            systolic: r.systolic,
            diastolic: r.diastolic,
            pulse: Value(r.pulse),
            position: Value(r.position),
            note: Value(r.note),
            updatedAt: nowIso(),
          ),
        );
  }

  Future<void> deleteBloodPressure(String id) async {
    await (_db.delete(_db.bloodPressureReadings)..where((t) => t.id.equals(id))).go();
  }

  static List<String> _names(String json) {
    try {
      return (jsonDecode(json) as List).cast<String>();
    } catch (_) {
      return const [];
    }
  }
}
