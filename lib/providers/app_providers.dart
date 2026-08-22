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
import '../domain/services/hydration_service.dart';
import '../domain/services/mets_estimation_service.dart';
import '../domain/services/mets_summary_service.dart';
import '../domain/services/month_chapter_service.dart';
import '../domain/services/pacing_service.dart';
import '../domain/services/pem_service.dart';
import '../domain/services/sleep_energy_service.dart';
import '../domain/services/soreness_check_service.dart';
import '../domain/services/stripe_service.dart';
import '../domain/services/weather_service.dart';

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
final sorenessCheckServiceProvider = Provider<SorenessCheckService>(
  (ref) => SorenessCheckService(),
);
final pemServiceProvider = Provider<PemService>(
  (ref) => PemService(ref.watch(dailyLogRepositoryProvider)),
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

// --- HealthKit (Phase 3) ---

final healthKitServiceProvider = Provider<HealthKitService>((ref) => HealthKitService());

/// Whether HealthKit permissions are currently granted — re-checked
/// on-demand (not a stream, since the OS gives us no push notification for
/// permission changes made outside the app).
final healthKitEnabledProvider = FutureProvider.autoDispose<bool>((ref) {
  return ref.watch(healthKitServiceProvider).hasPermissions();
});

final healthKitStepsProvider = FutureProvider.autoDispose.family<int?, String>((ref, date) async {
  final enabled = await ref.watch(healthKitEnabledProvider.future);
  if (!enabled) return null;
  return ref.watch(healthKitServiceProvider).getStepsForDate(dateFromKey(date));
});

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
