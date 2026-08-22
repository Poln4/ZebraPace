import 'package:drift/drift.dart';

import '../../core/constants/enums.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/id_gen.dart';
import '../../domain/models/injury.dart';
import '../db/app_database.dart' as db;

class InjuryRepository {
  InjuryRepository(this._db);

  final db.AppDatabase _db;

  Injury _toDomain(db.Injury row) {
    return Injury(
      id: row.id,
      dateStarted: row.dateStarted,
      zone: InjuryZone.fromDb(row.zone),
      kind: InjuryKind.fromDb(row.kind),
      type: InjuryType.fromDb(row.type),
      note: row.note,
      resolvedAt: row.resolvedAt,
      stillPainful: row.stillPainful,
      comparedToUsual: ComparedToUsual.fromDb(row.comparedToUsual),
    );
  }

  /// Active injuries banner — visible app-wide until resolved.
  Stream<List<Injury>> watchActive() {
    final query = _db.select(_db.injuries)
      ..where((t) => t.resolvedAt.isNull())
      ..orderBy([(t) => OrderingTerm.desc(t.dateStarted)]);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  Future<List<Injury>> getAll() async {
    final query = _db.select(_db.injuries)
      ..orderBy([(t) => OrderingTerm.desc(t.dateStarted)]);
    return (await query.get()).map(_toDomain).toList();
  }

  /// Relevant to a PDF/insights date range: started on/before the range end,
  /// and either still active or resolved on/after the range start.
  Future<List<Injury>> getRelevantToRange(String startDate, String endDate) async {
    final all = await getAll();
    return all
        .where((i) =>
            i.dateStarted.compareTo(endDate) <= 0 &&
            (i.resolvedAt == null || i.resolvedAt!.compareTo(startDate) >= 0))
        .toList();
  }

  Future<void> insert({
    required String dateStarted,
    required InjuryZone zone,
    required InjuryKind kind,
    required InjuryType type,
    String note = '',
  }) async {
    await _db.into(_db.injuries).insert(
          db.InjuriesCompanion.insert(
            id: newId(),
            dateStarted: dateStarted,
            zone: zone.db,
            kind: kind.db,
            type: type.db,
            note: Value(note),
            stillPainful: const Value(true),
            updatedAt: nowIso(),
          ),
        );
  }

  Future<void> updateStatus(
    String id, {
    required bool stillPainful,
    ComparedToUsual? comparedToUsual,
    bool resolve = false,
  }) async {
    await (_db.update(_db.injuries)..where((t) => t.id.equals(id))).write(
      db.InjuriesCompanion(
        stillPainful: Value(stillPainful),
        comparedToUsual: Value(comparedToUsual?.db),
        resolvedAt: resolve ? Value(todayKey()) : const Value.absent(),
        updatedAt: Value(nowIso()),
      ),
    );
  }
}
