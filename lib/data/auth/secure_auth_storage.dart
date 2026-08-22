import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Keychain-backed storage for the salted password hash — replaces
/// app.py's `.streamlit/secrets.toml` shared-password file.
class SecureAuthStorage {
  SecureAuthStorage([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _saltKey = 'zebrapace_password_salt';
  static const _hashKey = 'zebrapace_password_hash';

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
  }
}
