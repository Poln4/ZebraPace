import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/weight_challenge_repository.dart';
import '../domain/models/weight_challenge_entry.dart';
import 'cloud_sync_providers.dart';

final weightChallengeRepositoryProvider = Provider<WeightChallengeRepository>(
  (ref) => WeightChallengeRepository(ref.watch(supabaseClientProvider)),
);

final weightChallengeEntriesProvider = StreamProvider.autoDispose<List<WeightChallengeEntry>>(
  (ref) => ref.watch(weightChallengeRepositoryProvider).watchAll(),
);

/// The signed-in user's own row, if they've joined — null both while
/// loading and when they simply haven't joined yet (ChallengeTab tells
/// those apart via the outer AsyncValue instead of folding them together).
final myWeightChallengeEntryProvider = Provider.autoDispose<WeightChallengeEntry?>((ref) {
  final user = ref.watch(cloudUserProvider);
  if (user == null) return null;
  final entries = ref.watch(weightChallengeEntriesProvider).valueOrNull;
  if (entries == null) return null;
  for (final entry in entries) {
    if (entry.userId == user.id) return entry;
  }
  return null;
});
