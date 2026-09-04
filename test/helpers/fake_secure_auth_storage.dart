import 'package:zebrapace_app/data/auth/secure_auth_storage.dart';

/// In-memory stand-in so tests never touch the real Keychain plugin, which
/// has no implementation registered in a plain `flutter test` run. Shared
/// between widget_test.dart and auth_notifier_test.dart — override every
/// method SecureAuthStorage exposes, or a missed one falls through to the
/// real plugin and throws MissingPluginException.
class FakeSecureAuthStorage extends SecureAuthStorage {
  final _data = <String, String>{};

  @override
  Future<bool> hasPassword() async => _data.containsKey('salt');

  @override
  Future<void> setPassword(String salt, String hash) async {
    _data['salt'] = salt;
    _data['hash'] = hash;
  }

  @override
  Future<({String salt, String hash})?> getPassword() async {
    if (!_data.containsKey('salt')) return null;
    return (salt: _data['salt']!, hash: _data['hash']!);
  }

  @override
  Future<void> clear() async => _data.clear();

  @override
  Future<void> setLastUnlockedAt(DateTime time) async {
    _data['lastUnlockedAt'] = time.toIso8601String();
  }

  @override
  Future<DateTime?> getLastUnlockedAt() async {
    final raw = _data['lastUnlockedAt'];
    return raw == null ? null : DateTime.tryParse(raw);
  }

  @override
  Future<void> setGraceOverrideUntil(DateTime time) async {
    _data['graceOverrideUntil'] = time.toIso8601String();
  }

  @override
  Future<DateTime?> getGraceOverrideUntil() async {
    final raw = _data['graceOverrideUntil'];
    return raw == null ? null : DateTime.tryParse(raw);
  }
}
