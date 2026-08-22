/// Public client config for the Supabase project — the anon/publishable
/// key is meant to be embedded in client apps (RLS is what actually
/// protects data, not secrecy of this key), so it's safe to commit.
/// The project's raw Postgres connection string (DB password) must never
/// appear here or anywhere else in the app — it's a server-only credential.
class SupabaseConfig {
  static const url = 'https://jclbxpnixzlmzpkqzvcb.supabase.co';
  static const anonKey = 'sb_publishable_PSWSpE1cRyhR53rcXk4sqw_HSWI8Pa6';
}
