import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/weight_challenge_entry.dart';
import '../../domain/models/weight_challenge_weigh_in.dart';

/// First cloud-only-data repository in the app (every other repository
/// wraps the local drift database) — the weight challenge is inherently
/// shared, so there's nothing to keep locally beyond what the user already
/// logs in Vitals. Requires the caller to already be signed in
/// (cloud_sync_providers.dart); RLS on the Supabase side rejects writes for
/// anyone else's row regardless.
class WeightChallengeRepository {
  WeightChallengeRepository(this._client);

  final SupabaseClient _client;

  static const _table = 'weight_challenge_entries';
  static const _historyTable = 'weight_challenge_weigh_ins';

  /// Realtime stream of every participant's row, sorted by percent lost
  /// (highest first) so the leaderboard order stays consistent everywhere
  /// it's read.
  Stream<List<WeightChallengeEntry>> watchAll() {
    return _client.from(_table).stream(primaryKey: ['user_id']).map((rows) {
      final entries = rows.map(WeightChallengeEntry.fromMap).toList();
      entries.sort((a, b) => b.percentLost.compareTo(a.percentLost));
      return entries;
    });
  }

  /// Every logged weigh-in, across every participant — the progress-over-
  /// time chart groups these by user itself (see
  /// ChallengeProgressSeriesBuilder) rather than this repository doing it,
  /// since "one stream per user" would mean N realtime subscriptions for N
  /// participants instead of one.
  Stream<List<WeightChallengeWeighIn>> watchHistory() {
    return _client.from(_historyTable).stream(primaryKey: ['id']).map(
          (rows) => rows.map(WeightChallengeWeighIn.fromMap).toList(),
        );
  }

  Future<void> joinChallenge({
    required String userId,
    required String displayName,
    required double startWeightKg,
  }) async {
    await _client.from(_table).upsert({
      'user_id': userId,
      'display_name': displayName,
      'start_weight_kg': startWeightKg,
      'current_weight_kg': startWeightKg,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });
    await _logWeighIn(userId: userId, weightKg: startWeightKg);
  }

  Future<void> updateCurrentWeight({
    required String userId,
    required double currentWeightKg,
  }) async {
    await _client.from(_table).update({
      'current_weight_kg': currentWeightKg,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('user_id', userId);
    await _logWeighIn(userId: userId, weightKg: currentWeightKg);
  }

  Future<void> _logWeighIn({required String userId, required double weightKg}) async {
    await _client.from(_historyTable).insert({
      'user_id': userId,
      'weight_kg': weightKg,
      'logged_at': DateTime.now().toUtc().toIso8601String(),
    });
  }
}
