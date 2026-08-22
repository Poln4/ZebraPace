import 'package:drift/drift.dart';

import '../../core/constants/enums.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/id_gen.dart';
import '../../domain/models/therapy.dart';
import '../db/app_database.dart' as db;

class TherapyRepository {
  TherapyRepository(this._db);

  final db.AppDatabase _db;

  Therapy _toDomain(db.Therapy row) {
    return Therapy(
      id: row.id,
      date: row.date,
      therapyName: row.therapyName,
      durationMin: row.durationMin,
      mentalState: MentalState.fromDb(row.mentalState),
      bodyFeeling: BodyFeeling.fromDb(row.bodyFeeling),
    );
  }

  Stream<List<Therapy>> watchForDate(String date) {
    final query = _db.select(_db.therapies)..where((t) => t.date.equals(date));
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  Stream<List<Therapy>> watchRecent({int limit = 10}) {
    final query = _db.select(_db.therapies)
      ..orderBy([(t) => OrderingTerm.desc(t.date)])
      ..limit(limit);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  Future<List<Therapy>> getRange(String startDate, String endDate) async {
    final query = _db.select(_db.therapies)
      ..where((t) => t.date.isBiggerOrEqualValue(startDate) & t.date.isSmallerOrEqualValue(endDate));
    final rows = await query.get();
    return rows.map(_toDomain).toList();
  }

  Future<void> insert({
    required String date,
    required String therapyName,
    required int durationMin,
    MentalState? mentalState,
    BodyFeeling? bodyFeeling,
  }) async {
    await _db.into(_db.therapies).insert(
          db.TherapiesCompanion.insert(
            id: newId(),
            date: date,
            therapyName: therapyName,
            durationMin: durationMin,
            mentalState: Value(mentalState?.db),
            bodyFeeling: Value(bodyFeeling?.db),
            updatedAt: nowIso(),
          ),
        );
  }
}
