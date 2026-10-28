import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/defaults.dart';
import '../core/utils/date_utils.dart';
import '../data/db/app_database.dart' hide DailyLog;
import '../data/healthkit/health_kit_service.dart';
import '../data/repositories/activity_repository.dart';
import '../data/repositories/calisthenics_repository.dart';
import '../data/repositories/checkin_repository.dart';
import '../data/repositories/daily_log_repository.dart';
import '../data/repositories/injury_repository.dart';
import '../data/repositories/liquid_log_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../data/repositories/soreness_check_repository.dart';
import '../data/repositories/therapy_repository.dart';
import '../data/repositories/weather_cache_repository.dart';
import '../domain/models/daily_log.dart';
import '../domain/models/detected_workout.dart';
import '../domain/services/body_metrics_service.dart';
import '../domain/services/calisthenics_service.dart';
import '../domain/services/doctor_report_service.dart';
import '../domain/services/export_import_service.dart';
import '../domain/services/hr_exertion_service.dart';
import '../domain/services/hydration_service.dart';
import '../domain/services/mets_estimation_service.dart';
import '../domain/services/mets_summary_service.dart';
import '../domain/services/month_chapter_service.dart';
import '../domain/services/pacing_service.dart';
import '../domain/services/pem_service.dart';
import '../domain/services/health_sync_service.dart';
import '../domain/services/readiness_service.dart';
import '../domain/services/sleep_energy_service.dart';
import '../domain/services/soreness_check_service.dart';
import '../domain/services/stripe_service.dart';
import '../domain/services/weather_service.dart';
import '../domain/services/weight_challenge_progress_service.dart';
import '../domain/services/challenge_day_service.dart';

// --- Database (single instance for the app's lifetime) ---

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

// --- Repositories ---

final dailyLogRepositoryProvider = Provider<DailyLogRepository>(
  (ref) => DailyLogRepository(ref.watch(appDatabaseProvider)),
);
final activityRepositoryProvider = Provider<ActivityRepository>(
  (ref) => ActivityRepository(ref.watch(appDatabaseProvider)),
);
final calisthenicsRepositoryProvider = Provider<CalisthenicsRepository>(
  (ref) => CalisthenicsRepository(ref.watch(appDatabaseProvider)),
);
final therapyRepositoryProvider = Provider<TherapyRepository>(
  (ref) => TherapyRepository(ref.watch(appDatabaseProvider)),
);
final liquidLogRepositoryProvider = Provider<LiquidLogRepository>(
  (ref) => LiquidLogRepository(ref.watch(appDatabaseProvider)),
);
final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(appDatabaseProvider)),
);
final checkinRepositoryProvider = Provider<CheckinRepository>(
  (ref) => CheckinRepository(ref.watch(appDatabaseProvider)),
);
final injuryRepositoryProvider = Provider<InjuryRepository>(
  (ref) => InjuryRepository(ref.watch(appDatabaseProvider)),
);
final sorenessCheckRepositoryProvider = Provider<SorenessCheckRepository>(
  (ref) => SorenessCheckRepository(ref.watch(appDatabaseProvider)),
);
final weatherCacheRepositoryProvider = Provider<WeatherCacheRepository>(
  (ref) => WeatherCacheRepository(ref.watch(appDatabaseProvider)),
);

// --- Services ---

final pacingServiceProvider = Provider<PacingService>(
  (ref) => PacingService(ref.watch(dailyLogRepositoryProvider)),
);
final calisthenicsServiceProvider = Provider<CalisthenicsService>(
  (ref) => CalisthenicsService(ref.watch(calisthenicsRepositoryProvider)),
);
final stripeServiceProvider = Provider<StripeService>(
  (ref) => StripeService(
    ref.watch(dailyLogRepositoryProvider),
    ref.watch(settingsRepositoryProvider),
  ),
);
final bodyMetricsServiceProvider = Provider<BodyMetricsService>(
  (ref) => BodyMetricsService(ref.watch(dailyLogRepositoryProvider)),
);
final hydrationServiceProvider = Provider<HydrationService>(
  (ref) => HydrationService(
    ref.watch(liquidLogRepositoryProvider),
    ref.watch(dailyLogRepositoryProvider),
  ),
);
final readinessServiceProvider = Provider<ReadinessService>((ref) => ReadinessService());
final healthSyncServiceProvider = Provider<HealthSyncService>((ref) => HealthSyncService());

final sorenessCheckServiceProvider = Provider<SorenessCheckService>(
  (ref) => SorenessCheckService(),
);
final pemServiceProvider = Provider<PemService>(
  (ref) => PemService(ref.watch(dailyLogRepositoryProvider)),
);
final hrExertionServiceProvider = Provider<HrExertionService>(
  (ref) => HrExertionService(
    ref.watch(activityRepositoryProvider),
    ref.watch(calisthenicsRepositoryProvider),
    ref.watch(dailyLogRepositoryProvider),
  ),
);
final sleepEnergyServiceProvider = Provider<SleepEnergyService>((ref) => SleepEnergyService());
final weatherServiceProvider = Provider<WeatherService>(
  (ref) => WeatherService(
    ref.watch(weatherCacheRepositoryProvider),
    ref.watch(dailyLogRepositoryProvider),
  ),
);
final monthChapterServiceProvider = Provider<MonthChapterService>(
  (ref) => MonthChapterService(),
);
final doctorReportServiceProvider = Provider<DoctorReportService>(
  (ref) => DoctorReportService(),
);
final exportImportServiceProvider = Provider<ExportImportService>(
  (ref) => ExportImportService(ref.watch(appDatabaseProvider)),
);
final metsEstimationServiceProvider = Provider<MetsEstimationService>(
  (ref) => MetsEstimationService(),
);
final metsSummaryServiceProvider = Provider<MetsSummaryService>(
  (ref) => MetsSummaryService(),
);
final challengeDayServiceProvider = Provider<ChallengeDayService>(
  (ref) => ChallengeDayService(
    ref.watch(dailyLogRepositoryProvider),
    ref.watch(activityRepositoryProvider),
    ref.watch(checkinRepositoryProvider),
  ),
);
final weightChallengeProgressServiceProvider = Provider<WeightChallengeProgressService>(
  (ref) => WeightChallengeProgressService(ref.watch(dailyLogRepositoryProvider)),
);

// --- HealthKit (Phase 3) ---

final healthKitServiceProvider = Provider<HealthKitService>((ref) => HealthKitService());

const _healthKitRequested = 'requested';

/// Whether to treat HealthKit as connected — re-checked on-demand (not a
/// stream, since the OS gives us no push notification for permission
/// changes made outside the app). iOS answers "unknown" for read access,
/// so in that case this falls back to whether the user already went
/// through the permission sheet via [connectHealthKit]. If they denied
/// some types there, reads for those types simply come back empty.
final healthKitEnabledProvider = FutureProvider.autoDispose<bool>((ref) async {
  final granted = await ref.watch(healthKitServiceProvider).hasPermissions();
  if (granted != null) return granted;
  final status =
      await ref.watch(settingsRepositoryProvider).getString(SettingsKeys.healthKitAuthStatus, '');
  return status == _healthKitRequested;
});

/// Shows the HealthKit permission sheet and remembers that it was shown,
/// since iOS won't tell us the answer later (see healthKitEnabledProvider).
/// On Android, without Health Connect installed there's no sheet to show,
/// so this sends the user to the Play Store instead.
Future<void> connectHealthKit(WidgetRef ref) async {
  final service = ref.read(healthKitServiceProvider);
  if (!await service.isAvailable()) {
    await service.installHealthConnect();
    return;
  }
  final shown = await service.requestAuthorization();
  if (shown) {
    final settings = ref.read(settingsRepositoryProvider);
    await settings.set(SettingsKeys.healthKitAuthStatus, _healthKitRequested);
    await settings.set(SettingsKeys.healthReadinessRequested, _healthKitRequested);
    await settings.set(SettingsKeys.healthSleepRequested, _healthKitRequested);
  }
  ref.invalidate(healthKitEnabledProvider);
  ref.invalidate(readinessProvider);
}

/// False for installs that connected Health before resting HR/HRV were
/// read, so Settings can offer to ask for just those.
final healthReadinessRequestedProvider = FutureProvider.autoDispose<bool>((ref) async {
  final status = await ref
      .watch(settingsRepositoryProvider)
      .getString(SettingsKeys.healthReadinessRequested, '');
  return status == _healthKitRequested;
});

/// False for installs that connected Health before sleep was read.
final healthSleepRequestedProvider = FutureProvider.autoDispose<bool>((ref) async {
  final status = await ref
      .watch(settingsRepositoryProvider)
      .getString(SettingsKeys.healthSleepRequested, '');
  return status == _healthKitRequested;
});

final sorenessChecksForDateProvider = StreamProvider.autoDispose.family((ref, String date) {
  return ref.watch(sorenessCheckRepositoryProvider).watchForDate(date);
});

/// Readiness for [date] from resting HR + HRV and recent soreness checks.
/// Each day uses the logged value (typed in, or pre-filled and saved) and
/// otherwise Apple Health / Health Connect's. Without any resting HR for
/// [date], the logged overnight minimum heart rate stands in for it, as its
/// own series: the two run at different levels, so they're never mixed in
/// one baseline.
final readinessProvider =
    FutureProvider.autoDispose.family<ReadinessResult, String>((ref, date) async {
  ref.watch(sorenessChecksForDateProvider(date));
  ref.watch(dailyLogProvider);

  final day = dateFromKey(date);
  final start = day.subtract(const Duration(days: ReadinessService.baselineDays));

  var health = <String, AutonomicReading>{};
  if (!kIsWeb && await ref.watch(healthKitEnabledProvider.future)) {
    health = await ref
        .watch(healthKitServiceProvider)
        .getAutonomicReadings(start, day.add(const Duration(days: 1)));
  }
  final logs = await ref.watch(dailyLogRepositoryProvider).getRange(dateKey(start), date);
  final logged = {for (final l in logs) l.date: l};
  var readings = {
    for (final d in {...health.keys, ...logged.keys})
      d: AutonomicReading(
        restingHeartRate:
            logged[d]?.restingHeartRate?.toDouble() ?? health[d]?.restingHeartRate,
        hrvMs: logged[d]?.hrvMs ?? health[d]?.hrvMs,
      ),
  };
  final fromSleep = readings[date]?.restingHeartRate == null;
  if (fromSleep) {
    final overnightMin = {
      for (final l in logs)
        if (l.sleepHeartRateMin case final bpm?) l.date: bpm.toDouble(),
    };
    readings = {
      for (final d in {...readings.keys, ...overnightMin.keys})
        d: AutonomicReading(restingHeartRate: overnightMin[d], hrvMs: readings[d]?.hrvMs),
    };
  }

  final sorenessChecks = await ref
      .watch(sorenessCheckRepositoryProvider)
      .getRange(dateKey(day.subtract(const Duration(days: 4))), date);

  final result = ref.watch(readinessServiceProvider).evaluate(
        date: date,
        readings: readings,
        sorenessChecks: sorenessChecks,
      );
  return fromSleep && result.restingHeartRateToday != null
      ? result.withRestingHeartRateFromSleep()
      : result;
});

/// Writes today's and yesterday's steps, sleep and resting HR/HRV from
/// Apple Health / Health Connect into the log (yesterday too, since its
/// steps and the night ending this morning keep arriving after midnight).
/// Watched by AppShell, so it runs on open; resuming the app and connecting
/// Health both invalidate healthKitEnabledProvider, which re-runs it.
/// Groups the person edited are left alone (see HealthSyncService).
final healthSyncProvider = FutureProvider.autoDispose<void>((ref) async {
  if (kIsWeb) return;
  if (!await ref.watch(healthKitEnabledProvider.future)) return;
  final health = ref.read(healthKitServiceProvider);
  final repo = ref.read(dailyLogRepositoryProvider);
  final sync = ref.read(healthSyncServiceProvider);
  final today = DateTime.now();
  for (final day in [today, today.subtract(const Duration(days: 1))]) {
    final date = dateKey(day);
    final steps = await health.getStepsForDate(day);
    final sleep = await health.getSleepForDate(day);
    final start = DateTime(day.year, day.month, day.day);
    final heart = (await health.getAutonomicReadings(start, start.add(const Duration(days: 1))))[date];
    if ((steps ?? 0) <= 0 && sleep == null && heart == null) continue;
    final log = await repo.getOrCreateDailyLog(date);
    final next = sync.apply(log, steps: steps, sleep: sleep, heart: heart);
    if (next != null) await repo.upsertDailyLog(next);
  }
});

/// Hands a group back to Health after an edit: clears its "manual" mark
/// and syncs again.
Future<void> useHealthValue(
  WidgetRef ref,
  String date, {
  bool steps = false,
  bool sleep = false,
  bool heart = false,
}) async {
  final repo = ref.read(dailyLogRepositoryProvider);
  final log = await repo.getOrCreateDailyLog(date);
  await repo.upsertDailyLog(log.copyWith(
    stepsSource: steps ? null : log.stepsSource,
    sleepSource: sleep ? null : log.sleepSource,
    heartSource: heart ? null : log.heartSource,
  ));
  ref.invalidate(healthSyncProvider);
}

final detectedWorkoutsProvider =
    FutureProvider.autoDispose.family<List<DetectedWorkout>, String>((ref, date) async {
  final enabled = await ref.watch(healthKitEnabledProvider.future);
  if (!enabled) return const [];
  final workouts = await ref.watch(healthKitServiceProvider).getWorkoutsForDate(dateFromKey(date));
  final activityRepo = ref.watch(activityRepositoryProvider);
  final notImported = <DetectedWorkout>[];
  for (final w in workouts) {
    if (!await activityRepo.isHealthkitWorkoutImported(w.healthkitUuid)) {
      notImported.add(w);
    }
  }
  return notImported;
});

// --- Cross-cutting reactive state ---

/// The date the whole app is currently viewing/editing. Defaults to today;
/// changed via the date picker row in the shell.
final selectedDateProvider = StateProvider<String>((ref) => todayKey());

final settingsSnapshotProvider = StreamProvider<SettingsSnapshot>((ref) {
  return ref.watch(settingsRepositoryProvider).watchAll().map(SettingsSnapshot.fromMap);
});

/// The personalized greeting name (AppShell header) — empty string when
/// never set, same watch-the-settings-table pattern as textScaleFactorProvider.
final userNameProvider = StreamProvider<String>((ref) {
  return ref
      .watch(settingsRepositoryProvider)
      .watchAll()
      .map((m) => m[SettingsKeys.userName] ?? '');
});

final dailyLogProvider = StreamProvider.autoDispose<DailyLog>((ref) {
  final date = ref.watch(selectedDateProvider);
  return ref.watch(dailyLogRepositoryProvider).watchDailyLog(date);
});

/// Active (unresolved) injuries — watched app-wide for the persistent banner.
final activeInjuriesProvider = StreamProvider((ref) {
  return ref.watch(injuryRepositoryProvider).watchActive();
});

final stripeStatusProvider = FutureProvider.autoDispose((ref) {
  // Re-checked whenever the selected day's log changes (a save may have
  // just crossed a new stripe threshold).
  ref.watch(dailyLogProvider);
  return ref.watch(stripeServiceProvider).checkStatus();
});
