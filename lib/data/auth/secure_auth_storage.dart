import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Keychain-backed storage for the salted password hash — replaces
/// app.py's `.streamlit/secrets.toml` shared-password file.
class SecureAuthStorage {
  SecureAuthStorage([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _saltKey = 'zebrapace_password_salt';
  static const _hashKey = 'zebrapace_password_hash';
  static const _lastUnlockedAtKey = 'zebrapace_last_unlocked_at';
  static const _graceOverrideUntilKey = 'zebrapace_grace_override_until';

  Future<bool> hasPassword() async {
    final salt = await _storage.read(key: _saltKey);
    return salt != null;
  }

  Future<void> setPassword(String salt, String hash) async {
    await _storage.write(key: _saltKey, value: salt);
    await _storage.write(key: _hashKey, value: hash);
  }

  Future<({String salt, String hash})?> getPassword() async {
    final salt = await _storage.read(key: _saltKey);
    final hash = await _storage.read(key: _hashKey);
    if (salt == null || hash == null) return null;
    return (salt: salt, hash: hash);
  }

  Future<void> clear() async {
    await _storage.delete(key: _saltKey);
    await _storage.delete(key: _hashKey);
    await _storage.delete(key: _lastUnlockedAtKey);
    await _storage.delete(key: _graceOverrideUntilKey);
  }

  /// Marks "still within the grace window" — see AuthNotifier's re-lock
  /// policy. Stamped on every successful unlock and whenever the app is
  /// backgrounded while unlocked, so a brief trip away (e.g. tapping a
  /// Supabase magic-link email) doesn't force Face ID/password again, while
  /// genuinely walking away does.
  Future<void> setLastUnlockedAt(DateTime time) async {
    await _storage.write(key: _lastUnlockedAtKey, value: time.toIso8601String());
  }

  Future<DateTime?> getLastUnlockedAt() async {
    final raw = await _storage.read(key: _lastUnlockedAtKey);
    return raw == null ? null : DateTime.tryParse(raw);
  }

  /// A longer, one-shot grace window on top of the normal one — set right
  /// before deliberately sending the user to an external flow (the Cloud
  /// Sync magic-link email), so that round trip doesn't force a re-lock
  /// even if it takes longer than the standard grace window.
  Future<void> setGraceOverrideUntil(DateTime time) async {
    await _storage.write(key: _graceOverrideUntilKey, value: time.toIso8601String());
  }

  Future<DateTime?> getGraceOverrideUntil() async {
    final raw = await _storage.read(key: _graceOverrideUntilKey);
    return raw == null ? null : DateTime.tryParse(raw);
  }
}
