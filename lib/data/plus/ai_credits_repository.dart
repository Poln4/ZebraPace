import 'package:supabase_flutter/supabase_flutter.dart';

/// Reads the signed-in person's AI-credit balance from Supabase
/// (migration 011). Read-only on purpose: only the server adds credits
/// (revenuecat-webhook) or spends them, so a phone can't grant itself any.
class AiCreditsRepository {
  AiCreditsRepository(this._client);

  final SupabaseClient _client;

  /// Current balance; 0 when nothing was ever bought. RLS limits the
  /// query to the caller's own row.
  Future<int> balance() async {
    final row = await _client
        .from('ai_credit_balances')
        .select('balance')
        .maybeSingle();
    return (row?['balance'] as num?)?.toInt() ?? 0;
  }
}
