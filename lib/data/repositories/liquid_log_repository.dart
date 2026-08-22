import 'package:drift/drift.dart';

import '../../core/constants/enums.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/id_gen.dart';
import '../../domain/models/liquid_log.dart';
import '../db/app_database.dart' as db;

class LiquidLogRepository {
  LiquidLogRepository(this._db);

  final db.AppDatabase _db;

  LiquidLog _toDomain(db.LiquidLog row) {
    return LiquidLog(
      id: row.id,
      date: row.date,
      drinkType: DrinkType.fromDb(row.drinkType) ?? DrinkType.water,
      customDrinkLabel: row.customDrinkLabel,
      amountMlRaw: row.amountMlRaw,
      hydrationMlCredit: row.hydrationMlCredit,
    );
  }

  Stream<List<LiquidLog>> watchForDate(String date) {
    final query = _db.select(_db.liquidLogs)..where((t) => t.date.equals(date));
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  Future<void> insert({
    required String date,
    required DrinkType drinkType,
    required int amountMlRaw,
    String? customDrinkLabel,
  }) async {
    final credit = LiquidLog.creditFor(drinkType, amountMlRaw);
    await _db.into(_db.liquidLogs).insert(
          db.LiquidLogsCompanion.insert(
            id: newId(),
            date: date,
            drinkType: drinkType.db,
            customDrinkLabel: Value(customDrinkLabel),
            amountMlRaw: amountMlRaw,
            hydrationMlCredit: credit,
            updatedAt: nowIso(),
          ),
        );
  }

  Future<void> deleteForDate(String date) async {
    await (_db.delete(_db.liquidLogs)..where((t) => t.date.equals(date))).go();
  }

  /// Sums today's raw/credit hydration directly from liquid_logs — the
  /// DailyLogs.waterMlRaw/waterMlCredit columns are a derived cache of this,
  /// recomputed on every write rather than incrementally mutated (see
  /// HydrationService and the plan's data-layer notes on the original's
  /// water_ml misnomer).
  Future<({int raw, double credit})> sumForDate(String date) async {
    final rawSum = _db.liquidLogs.amountMlRaw.sum();
    final creditSum = _db.liquidLogs.hydrationMlCredit.sum();
    final query = _db.selectOnly(_db.liquidLogs)
      ..addColumns([rawSum, creditSum])
      ..where(_db.liquidLogs.date.equals(date));
    final row = await query.getSingle();
    return (
      raw: row.read(rawSum) ?? 0,
      credit: row.read(creditSum) ?? 0.0,
    );
  }
}
