import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/date_utils.dart';
import '../data/repositories/autonomic_repository.dart';
import '../domain/models/autonomic.dart';
import 'app_providers.dart';

final autonomicRepositoryProvider = Provider<AutonomicRepository>(
  (ref) => AutonomicRepository(ref.watch(appDatabaseProvider)),
);

/// All stand tests, oldest first.
final standTestsProvider = StreamProvider<List<StandTest>>(
  (ref) => ref.watch(autonomicRepositoryProvider).watchStandTests(),
);

/// Sweating logs for the 14 days ending on the given date.
final sweatLogsProvider = StreamProvider.family<List<SweatLog>, String>((ref, date) {
  final from = dateKey(dateFromKey(date).subtract(const Duration(days: 13)));
  return ref.watch(autonomicRepositoryProvider).watchSweatRange(from, date);
});

/// Cuff blood-pressure readings, oldest first.
final bloodPressureProvider = StreamProvider<List<BloodPressureReading>>(
  (ref) => ref.watch(autonomicRepositoryProvider).watchBloodPressure(),
);
