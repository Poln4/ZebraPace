import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/date_utils.dart';
import '../data/repositories/challenge_repository.dart';
import '../domain/models/challenge.dart';
import '../domain/models/challenge_day.dart';
import '../domain/models/challenge_entry.dart';
import '../domain/models/weight_challenge_weigh_in.dart';
import 'app_providers.dart';
import 'cloud_sync_providers.dart';

final challengeRepositoryProvider = Provider<ChallengeRepository>(
  (ref) => ChallengeRepository(ref.watch(supabaseClientProvider)),
);

/// The signed-in user's own challenges. A one-shot fetch (see
/// ChallengeRepository.fetchMyChallenges), not a stream — ChallengeTab
/// invalidates this right after a successful create/join so a brand-new
/// membership shows up immediately without needing a realtime subscription
/// for something that otherwise almost never changes.
final myChallengesProvider = FutureProvider.autoDispose<List<Challenge>>((ref) async {
  final user = ref.watch(cloudUserProvider);
  if (user == null) return const [];
  return ref.watch(challengeRepositoryProvider).fetchMyChallenges(user.id);
});

/// Which of the user's challenges is currently shown in ChallengeTab.
/// Deliberately not persisted — resets to null (→ ChallengeTab's own
/// "default to the first one" fallback) each app launch, since remembering
/// this across restarts isn't worth a settings-table round trip for a
/// rarely-changed choice.
final currentChallengeIdProvider = StateProvider<String?>((ref) => null);

final challengeEntriesProvider =
    StreamProvider.autoDispose.family<List<ChallengeEntry>, String>(
  (ref, challengeId) => ref.watch(challengeRepositoryProvider).watchEntries(challengeId),
);

final weightChallengeHistoryProvider =
    StreamProvider.autoDispose.family<List<WeightChallengeWeighIn>, String>(
  (ref, challengeId) => ref.watch(challengeRepositoryProvider).watchHistory(challengeId),
);

/// The trimmed 7-day average from the user's own local Vitals history (see
/// WeightChallengeProgressService) — null when there's no weigh-in in that
/// window yet. MyProgressCard both displays this and auto-syncs it to the
/// shared table, so the Together tab never needs its own separate manual
/// weight entry.
final computedChallengeWeightProvider = FutureProvider.autoDispose<double?>((ref) {
  return ref.watch(weightChallengeProgressServiceProvider).computeCurrentWeightKg(todayKey());
});

/// The signed-in user's own row in one challenge, if they've joined it —
/// null both while loading and (in principle) if they somehow haven't,
/// though myChallengesProvider only ever lists challenges they're
/// already a member of.
final myChallengeEntryProvider =
    Provider.autoDispose.family<ChallengeEntry?, String>((ref, challengeId) {
  final user = ref.watch(cloudUserProvider);
  if (user == null) return null;
  final entries = ref.watch(challengeEntriesProvider(challengeId)).valueOrNull;
  if (entries == null) return null;
  for (final entry in entries) {
    if (entry.userId == user.id) return entry;
  }
  return null;
});

/// Every member's per-day results in one daily-goal challenge.
final challengeDaysProvider = StreamProvider.autoDispose.family<List<ChallengeDay>, String>(
  (ref, challengeId) => ref.watch(challengeRepositoryProvider).watchDays(challengeId),
);

/// Emits whenever today's local log or today's activities change — the
/// daily-challenge card listens to this to re-sync, so a step count
/// arriving from HealthKit or a new check-in reaches friends without the
/// Together tab having to be reopened. Earlier days are re-synced too, but
/// only on that trigger or when the card is first shown.
final todayChallengeInputsProvider = StreamProvider.autoDispose<Object>((ref) {
  final today = todayKey();
  final controller = StreamController<Object>();
  final logSub = ref.watch(dailyLogRepositoryProvider).watchDailyLog(today).listen(controller.add);
  final activitySub =
      ref.watch(activityRepositoryProvider).watchForDate(today).listen(controller.add);
  ref.onDispose(() {
    logSub.cancel();
    activitySub.cancel();
    controller.close();
  });
  return controller.stream;
});
