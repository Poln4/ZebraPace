import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/weight_challenge.dart';
import '../../domain/models/weight_challenge_entry.dart';
import '../../domain/models/weight_challenge_weigh_in.dart';

/// First cloud-only-data repository in the app (every other repository
/// wraps the local drift database) — challenges are inherently shared, so
/// there's nothing to keep locally beyond what the user already logs in
/// Vitals. Requires the caller to already be signed in
/// (cloud_sync_providers.dart).
///
/// Challenges are named, code-gated groups (`weight_challenges`); entries
/// and weigh-ins carry a `challenge_id` and RLS only lets a member read
/// rows from a challenge they've actually joined — so a new group of
/// friends never sees another group's weights, and joining always goes
/// through the `join_weight_challenge` RPC (never a direct table read),
/// since letting the client SELECT `weight_challenges` directly would let
/// anyone enumerate other groups' names/codes.
class WeightChallengeRepository {
  WeightChallengeRepository(this._client);

  final SupabaseClient _client;

  static const _table = 'weight_challenge_entries';
  static const _historyTable = 'weight_challenge_weigh_ins';

  /// The challenges the signed-in user belongs to, newest first — a
  /// one-shot fetch rather than a realtime stream, since membership only
  /// changes through `createChallenge`/`joinChallenge` below, which
  /// callers already know to re-fetch after.
  Future<List<WeightChallenge>> fetchMyChallenges(String userId) async {
    final rows = await _client
        .from(_table)
        .select('weight_challenges(*)')
        .eq('user_id', userId);
    final challenges = [
      for (final row in rows as List)
        if ((row as Map<String, dynamic>)['weight_challenges'] != null)
          WeightChallenge.fromMap(row['weight_challenges'] as Map<String, dynamic>),
    ];
    challenges.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return challenges;
  }

  /// Realtime stream of one challenge's participants, sorted by percent
  /// lost (highest first) so the leaderboard order stays consistent
  /// everywhere it's read.
  Stream<List<WeightChallengeEntry>> watchEntries(String challengeId) {
    return _client
        .from(_table)
        .stream(primaryKey: ['challenge_id', 'user_id'])
        .eq('challenge_id', challengeId)
        .map((rows) {
      final entries = rows.map(WeightChallengeEntry.fromMap).toList();
      entries.sort((a, b) => b.percentLost.compareTo(a.percentLost));
      return entries;
    });
  }

  /// Every logged weigh-in for one challenge — the progress-over-time
  /// chart groups these by user itself (see ChallengeProgressSeriesBuilder)
  /// rather than this repository doing it.
  Stream<List<WeightChallengeWeighIn>> watchHistory(String challengeId) {
    return _client
        .from(_historyTable)
        .stream(primaryKey: ['id'])
        .eq('challenge_id', challengeId)
        .map((rows) => rows.map(WeightChallengeWeighIn.fromMap).toList());
  }

  /// Creates a brand-new code-gated challenge and immediately joins its
  /// creator to it — a challenge with zero members isn't a useful state,
  /// so this always chains into [joinChallenge] under the hood.
  Future<WeightChallenge> createChallenge({
    required String name,
    required String code,
    required double targetPercent,
    required String displayName,
    required double startWeightKg,
  }) async {
    final row = await _client.rpc<Map<String, dynamic>>('create_weight_challenge', params: {
      'p_name': name,
      'p_code': code,
      'p_target_percent': targetPercent,
    });
    final challenge = WeightChallenge.fromMap(row);
    await joinChallenge(code: challenge.code, displayName: displayName, startWeightKg: startWeightKg);
    return challenge;
  }

  /// Joins an existing challenge by its invite code — the lookup runs
  /// server-side inside a SECURITY DEFINER function precisely so the
  /// client never needs (and RLS never grants) permission to browse
  /// `weight_challenges` before joining one.
  Future<WeightChallengeEntry> joinChallenge({
    required String code,
    required String displayName,
    required double startWeightKg,
  }) async {
    final row = await _client.rpc<Map<String, dynamic>>('join_weight_challenge', params: {
      'p_code': code,
      'p_display_name': displayName,
      'p_start_weight_kg': startWeightKg,
    });
    return WeightChallengeEntry.fromMap(row);
  }

  Future<void> updateCurrentWeight({
    required String challengeId,
    required String userId,
    required double currentWeightKg,
  }) async {
    await _client
        .from(_table)
        .update({
          'current_weight_kg': currentWeightKg,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('challenge_id', challengeId)
        .eq('user_id', userId);
    await _logWeighIn(challengeId: challengeId, userId: userId, weightKg: currentWeightKg);
  }

  /// Logs today's weigh-in to history without touching the snapshot row —
  /// used when the computed weight hasn't meaningfully changed, so the
  /// progress chart still gets a point for today (a flat stretch across
  /// many identical days is real information, not "nothing to record"),
  /// without bumping the entry's updated_at for no reason.
  Future<void> logWeighIn({
    required String challengeId,
    required String userId,
    required double weightKg,
  }) {
    return _logWeighIn(challengeId: challengeId, userId: userId, weightKg: weightKg);
  }

  Future<void> _logWeighIn({
    required String challengeId,
    required String userId,
    required double weightKg,
  }) async {
    await _client.from(_historyTable).insert({
      'challenge_id': challengeId,
      'user_id': userId,
      'weight_kg': weightKg,
      'logged_at': DateTime.now().toUtc().toIso8601String(),
    });
  }
}
