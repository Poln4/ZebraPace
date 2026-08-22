import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/utils/date_utils.dart';
import '../../core/utils/stats.dart';
import '../../data/repositories/daily_log_repository.dart';
import '../../data/repositories/weather_cache_repository.dart';

class GeocodeResult {
  const GeocodeResult({required this.displayName, required this.lat, required this.lon});

  final String displayName;
  final double lat;
  final double lon;
}

class WeatherCorrelation {
  const WeatherCorrelation({
    required this.days,
    required this.correlation,
  });

  final List<WeatherDay> days;
  final double? correlation; // null if n < minSampleSize

  bool get hasEnoughData => correlation != null;
}

/// Ported from app.py's geocode_location/fetch_weather_range — same
/// Open-Meteo endpoints and parameters (see the plan's verified request
/// shapes). Same-day (unlagged) correlation with body_score, distinct from
/// PemService's lagged correlation.
class WeatherService {
  WeatherService(this._weatherCacheRepository, this._dailyLogRepository, {http.Client? client})
      : _client = client ?? http.Client();

  final WeatherCacheRepository _weatherCacheRepository;
  final DailyLogRepository _dailyLogRepository;
  final http.Client _client;

  static const minSampleSize = 4;

  Future<GeocodeResult?> geocode(String query) async {
    final uri = Uri.https('geocoding-api.open-meteo.com', '/v1/search', {
      'name': query,
      'count': '1',
      'language': 'en',
      'format': 'json',
    });
    try {
      final response = await _client.get(uri).timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) return null;
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final results = body['results'] as List?;
      if (results == null || results.isEmpty) return null;
      final top = results.first as Map<String, dynamic>;
      final display = '${top['name']}, ${top['admin1'] ?? ''} ${top['country'] ?? ''}'.trim();
      return GeocodeResult(
        displayName: display,
        lat: (top['latitude'] as num).toDouble(),
        lon: (top['longitude'] as num).toDouble(),
      );
    } catch (_) {
      return null;
    }
  }

  /// Read-through cache: only fetches dates missing from WeatherCache for
  /// this (lat, lon) in the requested range. Never hard-fails on network
  /// issues — falls back to whatever's already cached, same resilience
  /// pattern as the original.
  Future<List<WeatherDay>> fetchRange(
    double lat,
    double lon,
    String startDate,
    String endDate,
  ) async {
    final allDates = dateKeysBetween(startDate, endDate);
    final cached = await _weatherCacheRepository.getCachedDates(lat, lon, startDate, endDate);
    final missing = allDates.where((d) => !cached.contains(d)).toList()..sort();

    if (missing.isNotEmpty) {
      try {
        final uri = Uri.https('archive-api.open-meteo.com', '/v1/archive', {
          'latitude': lat.toString(),
          'longitude': lon.toString(),
          'start_date': missing.first,
          'end_date': missing.last,
          'hourly': 'temperature_2m,relative_humidity_2m,surface_pressure',
          'timezone': 'auto',
        });
        final response = await _client.get(uri).timeout(const Duration(seconds: 20));
        if (response.statusCode == 200) {
          final body = jsonDecode(response.body) as Map<String, dynamic>;
          final hourly = body['hourly'] as Map<String, dynamic>?;
          if (hourly != null) {
            await _aggregateAndCache(lat, lon, hourly);
          }
        }
      } catch (_) {
        // Degrade gracefully — return whatever's already cached below.
      }
    }

    return _weatherCacheRepository.getRange(lat, lon, startDate, endDate);
  }

  Future<void> _aggregateAndCache(double lat, double lon, Map<String, dynamic> hourly) async {
    final times = (hourly['time'] as List).cast<String>();
    final temps = (hourly['temperature_2m'] as List?)?.cast<num?>();
    final humidity = (hourly['relative_humidity_2m'] as List?)?.cast<num?>();
    final pressure = (hourly['surface_pressure'] as List?)?.cast<num?>();

    final byDate = <String, _DailyAccumulator>{};
    for (var i = 0; i < times.length; i++) {
      final date = times[i].substring(0, 10);
      final acc = byDate.putIfAbsent(date, _DailyAccumulator.new);
      if (temps != null && temps[i] != null) acc.addTemp(temps[i]!.toDouble());
      if (humidity != null && humidity[i] != null) acc.addHumidity(humidity[i]!.toDouble());
      if (pressure != null && pressure[i] != null) acc.addPressure(pressure[i]!.toDouble());
    }

    for (final entry in byDate.entries) {
      await _weatherCacheRepository.upsertDay(
        lat,
        lon,
        WeatherDay(
          date: entry.key,
          tempC: entry.value.avgTemp,
          humidityPct: entry.value.avgHumidity,
          pressureHpa: entry.value.avgPressure,
        ),
      );
    }
  }

  Future<WeatherCorrelation> correlateWithBodyScore(
    double lat,
    double lon,
    String startDate,
    String endDate,
  ) async {
    final days = await fetchRange(lat, lon, startDate, endDate);
    final logs = await _dailyLogRepository.getRange(startDate, endDate);
    final scoreByDate = {
      for (final l in logs)
        if (l.bodyFeeling != null) l.date: l.bodyFeeling!.score,
    };

    final pressures = <double>[];
    final scores = <double>[];
    for (final day in days) {
      final score = scoreByDate[day.date];
      if (day.pressureHpa == null || score == null) continue;
      pressures.add(day.pressureHpa!);
      scores.add(score.toDouble());
    }

    if (pressures.length < minSampleSize) {
      return WeatherCorrelation(days: days, correlation: null);
    }
    return WeatherCorrelation(days: days, correlation: pearsonCorrelation(pressures, scores));
  }
}

class _DailyAccumulator {
  double _tempSum = 0;
  int _tempCount = 0;
  double _humiditySum = 0;
  int _humidityCount = 0;
  double _pressureSum = 0;
  int _pressureCount = 0;

  void addTemp(double v) {
    _tempSum += v;
    _tempCount++;
  }

  void addHumidity(double v) {
    _humiditySum += v;
    _humidityCount++;
  }

  void addPressure(double v) {
    _pressureSum += v;
    _pressureCount++;
  }

  double? get avgTemp => _tempCount == 0 ? null : _tempSum / _tempCount;
  double? get avgHumidity => _humidityCount == 0 ? null : _humiditySum / _humidityCount;
  double? get avgPressure => _pressureCount == 0 ? null : _pressureSum / _pressureCount;
}
