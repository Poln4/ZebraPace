import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_utils.dart';
import '../../../../domain/services/pem_service.dart';
import '../../../../domain/services/weather_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import 'insights_range.dart';

final dailyLogsInRangeProvider = FutureProvider.autoDispose((ref) {
  final range = ref.watch(insightsDateRangeProvider);
  return ref.watch(dailyLogRepositoryProvider).getRange(range.start, range.end);
});

final activitiesInRangeProvider = FutureProvider.autoDispose((ref) {
  final range = ref.watch(insightsDateRangeProvider);
  return ref.watch(activityRepositoryProvider).getRange(range.start, range.end);
});

final metsSummaryInRangeProvider = Provider.autoDispose((ref) {
  final activities = ref.watch(activitiesInRangeProvider).valueOrNull ?? const [];
  return ref.watch(metsSummaryServiceProvider).summarize(activities);
});

final therapiesInRangeProvider = FutureProvider.autoDispose((ref) {
  final range = ref.watch(insightsDateRangeProvider);
  return ref.watch(therapyRepositoryProvider).getRange(range.start, range.end);
});

final calisthenicsInRangeProvider = FutureProvider.autoDispose((ref) {
  final range = ref.watch(insightsDateRangeProvider);
  return ref.watch(calisthenicsRepositoryProvider).getRange(range.start, range.end);
});

final sorenessChecksInRangeProvider = FutureProvider.autoDispose((ref) {
  final range = ref.watch(insightsDateRangeProvider);
  return ref.watch(sorenessCheckRepositoryProvider).getRange(range.start, range.end);
});

final pemLagDaysProvider = StateProvider<int>((ref) => 1);

final pemResultProvider = FutureProvider.autoDispose<PemResult>((ref) {
  final range = ref.watch(insightsDateRangeProvider);
  final lag = ref.watch(pemLagDaysProvider);
  return ref.watch(pemServiceProvider).analyze(range.start, range.end, lagDays: lag);
});

final weatherCorrelationProvider = FutureProvider.autoDispose<WeatherCorrelation?>((ref) async {
  final settings = await ref.watch(settingsSnapshotProvider.future);
  if (!settings.hasLocation) return null;
  final range = ref.watch(insightsDateRangeProvider);
  return ref.watch(weatherServiceProvider).correlateWithBodyScore(
        settings.locationLat!,
        settings.locationLon!,
        range.start,
        range.end,
      );
});

DateRange _calendarMonthOf(String date) {
  final d = dateFromKey(date);
  final start = DateTime(d.year, d.month, 1);
  final end = DateTime(d.year, d.month + 1, 0);
  return DateRange(dateKey(start), dateKey(end));
}

final monthChapterProvider =
    FutureProvider.autoDispose.family((ref, AppLocalizations l10n) async {
  final selected = ref.watch(selectedDateProvider);
  final monthRange = _calendarMonthOf(selected);
  final logs = await ref.watch(dailyLogRepositoryProvider).getRange(monthRange.start, monthRange.end);
  final activities =
      await ref.watch(activityRepositoryProvider).getRange(monthRange.start, monthRange.end);
  final calisthenics =
      await ref.watch(calisthenicsRepositoryProvider).getRange(monthRange.start, monthRange.end);
  final therapies =
      await ref.watch(therapyRepositoryProvider).getRange(monthRange.start, monthRange.end);
  return ref.watch(monthChapterServiceProvider).build(
        l10n: l10n,
        monthLogs: logs,
        activityCount: activities.length,
        calisthenicsCount: calisthenics.length,
        therapyCount: therapies.length,
      );
});
