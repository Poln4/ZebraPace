import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/date_utils.dart';
import '../data/repositories/weight_challenge_repository.dart';
import '../domain/models/weight_challenge.dart';
import '../domain/models/weight_challenge_entry.dart';
import '../domain/models/weight_challenge_weigh_in.dart';
import 'app_providers.dart';
import 'cloud_sync_providers.dart';

final weightChallengeRepositoryProvider = Provider<WeightChallengeRepository>(
  (ref) => WeightChallengeRepository(ref.watch(supabaseClientProvider)),
);

/// The signed-in user's own challenges. A one-shot fetch (see
/// WeightChallengeRepository.fetchMyChallenges), not a stream — ChallengeTab
/// invalidates this right after a successful create/join so a brand-new
/// membership shows up immediately without needing a realtime subscription
/// for something that otherwise almost never changes.
final myWeightChallengesProvider = FutureProvider.autoDispose<List<WeightChallenge>>((ref) async {
  final user = ref.watch(cloudUserProvider);
  if (user == null) return const [];
  return ref.watch(weightChallengeRepositoryProvider).fetchMyChallenges(user.id);
});

/// Which of the user's challenges is currently shown in ChallengeTab.
/// Deliberately not persisted — resets to null (→ ChallengeTab's own
/// "default to the first one" fallback) each app launch, since remembering
/// this across restarts isn't worth a settings-table round trip for a
/// rarely-changed choice.
final currentChallengeIdProvider = StateProvider<String?>((ref) => null);

final weightChallengeEntriesProvider =
    StreamProvider.autoDispose.family<List<WeightChallengeEntry>, String>(
  (ref, challengeId) => ref.watch(weightChallengeRepositoryProvider).watchEntries(challengeId),
);

final weightChallengeHistoryProvider =
    StreamProvider.autoDispose.family<List<WeightChallengeWeighIn>, String>(
  (ref, challengeId) => ref.watch(weightChallengeRepositoryProvider).watchHistory(challengeId),
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
/// though myWeightChallengesProvider only ever lists challenges they're
/// already a member of.
final myWeightChallengeEntryProvider =
    Provider.autoDispose.family<WeightChallengeEntry?, String>((ref, challengeId) {
  final user = ref.watch(cloudUserProvider);
  if (user == null) return null;
  final entries = ref.watch(weightChallengeEntriesProvider(challengeId)).valueOrNull;
  if (entries == null) return null;
  for (final entry in entries) {
    if (entry.userId == user.id) return entry;
  }
  return null;
});
