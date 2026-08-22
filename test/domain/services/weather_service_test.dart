import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/core/utils/date_utils.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/data/repositories/daily_log_repository.dart';
import 'package:zebrapace_app/data/repositories/weather_cache_repository.dart';
import 'package:zebrapace_app/domain/services/weather_service.dart';

void main() {
  late AppDatabase db;
  late DailyLogRepository dailyLogRepo;
  late WeatherCacheRepository weatherRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    dailyLogRepo = DailyLogRepository(db);
    weatherRepo = WeatherCacheRepository(db);
  });

  tearDown(() => db.close());

  test('geocode parses the first result from the Open-Meteo geocoding response', () async {
    final client = MockClient((request) async {
      expect(request.url.host, 'geocoding-api.open-meteo.com');
      expect(request.url.queryParameters['name'], 'Berlin');
      return http.Response(
        jsonEncode({
          'results': [
            {'name': 'Berlin', 'admin1': 'Berlin', 'country': 'Germany', 'latitude': 52.52, 'longitude': 13.405},
          ],
        }),
        200,
      );
    });
    final service = WeatherService(weatherRepo, dailyLogRepo, client: client);

    final result = await service.geocode('Berlin');
    expect(result, isNotNull);
    expect(result!.displayName, 'Berlin, Berlin Germany');
    expect(result.lat, 52.52);
    expect(result.lon, 13.405);
  });

  test('geocode returns null when the API finds nothing, never throws', () async {
    final client = MockClient((request) async => http.Response(jsonEncode({'results': []}), 200));
    final service = WeatherService(weatherRepo, dailyLogRepo, client: client);

    expect(await service.geocode('Nowhereville'), isNull);
  });

  test('hourly archive response is aggregated to daily means and cached', () async {
    final client = MockClient((request) async {
      return http.Response(
        jsonEncode({
          'hourly': {
            'time': ['2026-01-01T00:00', '2026-01-01T12:00', '2026-01-02T00:00'],
            'temperature_2m': [10.0, 20.0, 5.0],
            'relative_humidity_2m': [40.0, 60.0, 50.0],
            'surface_pressure': [1000.0, 1010.0, 1005.0],
          },
        }),
        200,
      );
    });
    final service = WeatherService(weatherRepo, dailyLogRepo, client: client);

    final days = await service.fetchRange(52.52, 13.405, '2026-01-01', '2026-01-02');
    final day1 = days.firstWhere((d) => d.date == '2026-01-01');
    expect(day1.tempC, closeTo(15.0, 0.001)); // mean of 10 and 20
    expect(day1.pressureHpa, closeTo(1005.0, 0.001));

    final day2 = days.firstWhere((d) => d.date == '2026-01-02');
    expect(day2.tempC, 5.0);
  });

  test('network failure degrades gracefully to whatever is already cached, never throws', () async {
    await weatherRepo.upsertDay(
      52.52,
      13.405,
      const WeatherDay(date: '2026-01-01', pressureHpa: 1000),
    );
    final client = MockClient((request) async => throw Exception('offline'));
    final service = WeatherService(weatherRepo, dailyLogRepo, client: client);

    final days = await service.fetchRange(52.52, 13.405, '2026-01-01', '2026-01-01');
    expect(days.single.pressureHpa, 1000);
  });

  test('correlation requires at least 4 same-day pressure/body-score pairs', () async {
    final client = MockClient((request) async => http.Response(jsonEncode({'hourly': {}}), 200));
    final service = WeatherService(weatherRepo, dailyLogRepo, client: client);

    for (var i = 0; i < 3; i++) {
      final date = dateKey(DateTime(2026, 1, 1 + i));
      await weatherRepo.upsertDay(52.52, 13.405, WeatherDay(date: date, pressureHpa: 1000.0 + i));
      final log = await dailyLogRepo.getOrCreateDailyLog(date);
      await dailyLogRepo.upsertDailyLog(log.copyWith(bodyFeeling: BodyFeeling.good));
    }

    final result = await service.correlateWithBodyScore(
      52.52,
      13.405,
      dateKey(DateTime(2026, 1, 1)),
      dateKey(DateTime(2026, 1, 3)),
    );
    expect(result.hasEnoughData, isFalse);
  });
}
