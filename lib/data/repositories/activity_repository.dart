import 'package:drift/drift.dart';

import '../../core/constants/enums.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/id_gen.dart';
import '../../domain/models/activity.dart';
import '../db/app_database.dart' as db;

class ActivityRepository {
  ActivityRepository(this._db);

  final db.AppDatabase _db;

  Activity _toDomain(db.Activity row) {
    return Activity(
      id: row.id,
      date: row.date,
      activityName: row.activityName,
      durationMin: row.durationMin,
      extraWeightKg: row.extraWeightKg,
      mentalState: MentalState.fromDb(row.mentalState),
      bodyFeeling: BodyFeeling.fromDb(row.bodyFeeling),
      source: row.source == 'healthkit' ? ActivitySource.healthkit : ActivitySource.manual,
      healthkitUuid: row.healthkitUuid,
      metsAvg: row.metsAvg,
      activeEnergyKcal: row.activeEnergyKcal,
    );
  }

  Stream<List<Activity>> watchForDate(String date) {
    final query = _db.select(_db.activities)..where((t) => t.date.equals(date));
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  Stream<List<Activity>> watchRecent({int limit = 10}) {
    final query = _db.select(_db.activities)
      ..orderBy([(t) => OrderingTerm.desc(t.date)])
      ..limit(limit);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  Future<List<Activity>> getRange(String startDate, String endDate) async {
    final query = _db.select(_db.activities)
      ..where((t) => t.date.isBiggerOrEqualValue(startDate) & t.date.isSmallerOrEqualValue(endDate));
    final rows = await query.get();
    return rows.map(_toDomain).toList();
  }

  Future<void> insert({
    required String date,
    required String activityName,
    required int durationMin,
    double extraWeightKg = 0,
    MentalState? mentalState,
    BodyFeeling? bodyFeeling,
    ActivitySource source = ActivitySource.manual,
    String? healthkitUuid,
    double? metsAvg,
    double? activeEnergyKcal,
  }) async {
    await _db.into(_db.activities).insert(
          db.ActivitiesCompanion.insert(
            id: newId(),
            date: date,
            activityName: activityName,
            durationMin: durationMin,
            extraWeightKg: Value(extraWeightKg),
            mentalState: Value(mentalState?.db),
            bodyFeeling: Value(bodyFeeling?.db),
            source: Value(source == ActivitySource.healthkit ? 'healthkit' : 'manual'),
            healthkitUuid: Value(healthkitUuid),
            metsAvg: Value(metsAvg),
            activeEnergyKcal: Value(activeEnergyKcal),
            updatedAt: nowIso(),
          ),
        );
  }

  Future<bool> isHealthkitWorkoutImported(String healthkitUuid) async {
    final row = await (_db.select(_db.activities)
          ..where((t) => t.healthkitUuid.equals(healthkitUuid)))
        .getSingleOrNull();
    return row != null;
  }
}
