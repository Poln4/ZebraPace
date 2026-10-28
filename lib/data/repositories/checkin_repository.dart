import 'package:drift/drift.dart';

import '../../core/constants/enums.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/id_gen.dart';
import '../../domain/models/checkin.dart';
import '../db/app_database.dart' as db;

class CheckinRepository {
  CheckinRepository(this._db);

  final db.AppDatabase _db;

  Checkin _toDomain(db.Checkin row) {
    return Checkin(
      id: row.id,
      date: row.date,
      loggedAt: row.loggedAt,
      mentalState: MentalState.fromDb(row.mentalState) ?? MentalState.okay,
      bodyFeeling: BodyFeeling.fromDb(row.bodyFeeling) ?? BodyFeeling.manageable,
      note: row.note,
    );
  }

  Stream<List<Checkin>> watchForDate(String date) {
    final query = _db.select(_db.checkins)
      ..where((t) => t.date.equals(date))
      ..orderBy([(t) => OrderingTerm.asc(t.loggedAt)]);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  /// Dates in [startDate, endDate] with at least one check-in — the only
  /// thing the daily-logging challenge needs to know about check-ins.
  Future<Set<String>> getDatesWithCheckins(String startDate, String endDate) async {
    final query = _db.selectOnly(_db.checkins, distinct: true)
      ..addColumns([_db.checkins.date])
      ..where(_db.checkins.date.isBiggerOrEqualValue(startDate) &
          _db.checkins.date.isSmallerOrEqualValue(endDate));
    final rows = await query.get();
    return {for (final row in rows) row.read(_db.checkins.date)!};
  }

  Future<void> insert({
    required String date,
    required MentalState mentalState,
    required BodyFeeling bodyFeeling,
    String note = '',
  }) async {
    await _db.into(_db.checkins).insert(
          db.CheckinsCompanion.insert(
            id: newId(),
            date: date,
            loggedAt: timeKey(DateTime.now()),
            mentalState: mentalState.db,
            bodyFeeling: bodyFeeling.db,
            note: Value(note),
            updatedAt: nowIso(),
          ),
        );
  }
}
