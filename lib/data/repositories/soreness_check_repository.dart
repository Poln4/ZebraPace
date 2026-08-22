import 'package:drift/drift.dart';

import '../../core/constants/enums.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/id_gen.dart';
import '../../domain/models/soreness_check.dart';
import '../db/app_database.dart' as db;

class SorenessCheckRepository {
  SorenessCheckRepository(this._db);

  final db.AppDatabase _db;

  SorenessCheck _toDomain(db.SorenessCheck row) {
    return SorenessCheck(
      id: row.id,
      date: row.date,
      onset: SorenessOnset.values.byName(row.onset),
      spread: SorenessSpread.values.byName(row.spread),
      trend: SorenessTrend.values.byName(row.trend),
      verdict: row.verdict,
      verdictLabel: row.verdictLabel,
    );
  }

  Stream<List<SorenessCheck>> watchForDate(String date) {
    final query = _db.select(_db.sorenessChecks)..where((t) => t.date.equals(date));
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  Future<List<SorenessCheck>> getRange(String startDate, String endDate) async {
    final query = _db.select(_db.sorenessChecks)
      ..where((t) => t.date.isBiggerOrEqualValue(startDate) & t.date.isSmallerOrEqualValue(endDate));
    return (await query.get()).map(_toDomain).toList();
  }

  Future<void> insert({
    required String date,
    required SorenessOnset onset,
    required SorenessSpread spread,
    required SorenessTrend trend,
    required String verdict,
    required String verdictLabel,
  }) async {
    await _db.into(_db.sorenessChecks).insert(
          db.SorenessChecksCompanion.insert(
            id: newId(),
            date: date,
            onset: onset.db,
            spread: spread.db,
            trend: trend.db,
            verdict: verdict,
            verdictLabel: verdictLabel,
            updatedAt: nowIso(),
          ),
        );
  }
}
