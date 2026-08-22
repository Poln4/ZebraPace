import 'package:drift/drift.dart';

import '../db/app_database.dart' as db;

class WeatherDay {
  const WeatherDay({
    required this.date,
    this.tempC,
    this.humidityPct,
    this.pressureHpa,
  });

  final String date;
  final double? tempC;
  final double? humidityPct;
  final double? pressureHpa;
}

class WeatherCacheRepository {
  WeatherCacheRepository(this._db);

  final db.AppDatabase _db;

  WeatherDay _toDomain(db.WeatherCacheData row) => WeatherDay(
        date: row.date,
        tempC: row.tempC,
        humidityPct: row.humidityPct,
        pressureHpa: row.pressureHpa,
      );

  Future<Set<String>> getCachedDates(double lat, double lon, String start, String end) async {
    final query = _db.select(_db.weatherCache)
      ..where((t) =>
          t.lat.equals(lat) &
          t.lon.equals(lon) &
          t.date.isBiggerOrEqualValue(start) &
          t.date.isSmallerOrEqualValue(end));
    final rows = await query.get();
    return rows.map((r) => r.date).toSet();
  }

  Future<void> upsertDay(double lat, double lon, WeatherDay day) async {
    await _db.into(_db.weatherCache).insertOnConflictUpdate(
          db.WeatherCacheCompanion.insert(
            date: day.date,
            lat: lat,
            lon: lon,
            tempC: Value(day.tempC),
            humidityPct: Value(day.humidityPct),
            pressureHpa: Value(day.pressureHpa),
          ),
        );
  }

  Future<List<WeatherDay>> getRange(double lat, double lon, String start, String end) async {
    final query = _db.select(_db.weatherCache)
      ..where((t) =>
          t.lat.equals(lat) &
          t.lon.equals(lon) &
          t.date.isBiggerOrEqualValue(start) &
          t.date.isSmallerOrEqualValue(end))
      ..orderBy([(t) => OrderingTerm.asc(t.date)]);
    final rows = await query.get();
    return rows.map(_toDomain).toList();
  }
}
