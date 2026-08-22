import 'package:drift/drift.dart';

/// Read-through cache of Open-Meteo daily aggregates, keyed by (date, lat, lon).
/// Regenerable from the API — not user data, so no sync columns.
class WeatherCache extends Table {
  TextColumn get date => text()();
  RealColumn get lat => real()();
  RealColumn get lon => real()();
  RealColumn get tempC => real().nullable()();
  RealColumn get humidityPct => real().nullable()();
  RealColumn get pressureHpa => real().nullable()();

  @override
  Set<Column> get primaryKey => {date, lat, lon};
}
