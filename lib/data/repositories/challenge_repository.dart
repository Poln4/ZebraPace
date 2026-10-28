import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/utils/date_utils.dart';
import '../../domain/models/challenge.dart';
import '../../domain/models/challenge_day.dart';
import '../../domain/models/challenge_entry.dart';
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
/// friends never sees another group's weights or days, and joining always
/// goes through the `join_challenge` RPC (never a direct table read),
/// since letting the client SELECT `weight_challenges` directly would let
/// anyone enumerate other groups' names/codes.
class ChallengeRepository {
  ChallengeRepository(this._client);

  final SupabaseClient _client;

  static const _table = 'weight_challenge_entries';
  static const _historyTable = 'weight_challenge_weigh_ins';
  static const _daysTable = 'challenge_days';

  /// The challenges the signed-in user belongs to, newest first — a
  /// one-shot fetch rather than a realtime stream, since membership only
  /// changes through `createChallenge`/`joinChallenge` below, which
  /// callers already know to re-fetch after.
  Future<List<Challenge>> fetchMyChallenges(String userId) async {
    final rows = await _client
        .from(_table)
        .select('weight_challenges(*)')
        .eq('user_id', userId);
    final challenges = [
      for (final row in rows as List)
        if ((row as Map<String, dynamic>)['weight_challenges'] != null)
          Challenge.fromMap(row['weight_challenges'] as Map<String, dynamic>),
    ];
    challenges.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return challenges;
  }

  /// Realtime stream of one challenge's participants, sorted by percent
  /// lost (highest first) so the leaderboard order stays consistent
  /// everywhere it's read.
  Stream<List<ChallengeEntry>> watchEntries(String challengeId) {
    return _client
        .from(_table)
        .stream(primaryKey: ['challenge_id', 'user_id'])
        .eq('challenge_id', challengeId)
        .map((rows) {
      final entries = rows.map(ChallengeEntry.fromMap).toList();
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
  /// so this always chains into [joinChallenge] under the hood. The
  /// creator then sets their goal/starting weight the same way a joiner
  /// does (ChallengeSetupCard), so there's only one setup path.
  Future<Challenge> createChallenge({
    required String name,
    required String code,
    required ChallengeKind kind,
    required DateTime startsOn,
    required int weeks,
    required double targetPercent,
    required String displayName,
  }) async {
    final row = await _client.rpc<Map<String, dynamic>>('create_challenge', params: {
      'p_name': name,
      'p_code': code,
      'p_kind': kind.db,
      'p_starts_on': dateKey(startsOn),
      'p_weeks': weeks,
      'p_target_percent': targetPercent,
    });
    final challenge = Challenge.fromMap(row);
    await joinChallenge(code: challenge.code, displayName: displayName);
    return challenge;
  }

  /// Joins an existing challenge by its invite code — the lookup runs
  /// server-side inside a SECURITY DEFINER function precisely so the
  /// client never needs (and RLS never grants) permission to browse
  /// `weight_challenges` before joining one. Takes no kind-specific data:
  /// the joiner doesn't know the challenge's kind until they're in.
  Future<ChallengeEntry> joinChallenge({
    required String code,
    required String displayName,
  }) async {
    final row = await _client.rpc<Map<String, dynamic>>('join_challenge', params: {
      'p_code': code,
      'p_display_name': displayName,
    });
    return ChallengeEntry.fromMap(row);
  }

  /// Weight challenges only: the member's single manually-confirmed
  /// starting weight, which also seeds the progress chart's first point.
  Future<void> setStartWeight({
    required String challengeId,
    required String userId,
    required double startWeightKg,
  }) async {
    await _client
        .from(_table)
        .update({
          'start_weight_kg': startWeightKg,
          'current_weight_kg': startWeightKg,
          'updated_at': nowIso(),
        })
        .eq('challenge_id', challengeId)
        .eq('user_id', userId);
    await _logWeighIn(challengeId: challengeId, userId: userId, weightKg: startWeightKg);
  }

  /// Every other kind: the member's own daily target (steps, hours,
  /// minutes; 1 for logging).
  Future<void> setDailyGoal({
    required String challengeId,
    required String userId,
    required double dailyGoal,
  }) async {
    await _client
        .from(_table)
        .update({'daily_goal': dailyGoal, 'updated_at': nowIso()})
        .eq('challenge_id', challengeId)
        .eq('user_id', userId);
  }

  /// Every member's per-day results for one daily-goal challenge.
  Stream<List<ChallengeDay>> watchDays(String challengeId) {
    return _client
        .from(_daysTable)
        .stream(primaryKey: ['challenge_id', 'user_id', 'day'])
        .eq('challenge_id', challengeId)
        .map((rows) => rows.map(ChallengeDay.fromMap).toList());
  }

  /// Writes the whole computed range in one request. Re-sending days that
  /// didn't change is deliberate — a log edited after the fact (a late
  /// check-in, a corrected step count) fixes the shared result without any
  /// change tracking.
  Future<void> upsertDays(List<ChallengeDay> days) async {
    if (days.isEmpty) return;
    await _client
        .from(_daysTable)
        .upsert([for (final day in days) day.toMap()], onConflict: 'challenge_id,user_id,day');
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
