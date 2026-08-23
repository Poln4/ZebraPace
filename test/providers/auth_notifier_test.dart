import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/data/auth/biometric_service.dart';
import 'package:zebrapace_app/data/auth/secure_auth_storage.dart';
import 'package:zebrapace_app/domain/services/password_service.dart';
import 'package:zebrapace_app/providers/auth_providers.dart';

/// In-memory stand-in — same shape as widget_test.dart's fake — so this
/// never touches the real Keychain plugin, which has no implementation
/// registered in a plain `flutter test` run.
class _FakeSecureAuthStorage extends SecureAuthStorage {
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
}

class _FakeBiometricService extends BiometricService {
  @override
  Future<bool> isAvailable() async => false; // exercise the password-only path
}

/// _init() runs a few async hops (isAvailable(), storage reads) before
/// settling — wait for state to actually leave `loading` rather than
/// guessing at a fixed delay.
Future<AuthState> _ready(AuthNotifier notifier) async {
  if (notifier.state.status != AuthStatus.loading) return notifier.state;
  return notifier.stream.firstWhere((s) => s.status != AuthStatus.loading);
}

AuthNotifier _makeNotifier(_FakeSecureAuthStorage storage) =>
    AuthNotifier(storage, _FakeBiometricService(), PasswordService());

void main() {
  test('a fresh install with no password needs setup', () async {
    final storage = _FakeSecureAuthStorage();
    final state = await _ready(_makeNotifier(storage));
    expect(state.status, AuthStatus.needsSetup);
  });

  test('a password with no recorded unlock time starts locked', () async {
    final storage = _FakeSecureAuthStorage();
    await storage.setPassword('salt', 'hash');
    final state = await _ready(_makeNotifier(storage));
    expect(state.status, AuthStatus.locked);
  });

  test('within the grace window since the last unlock skips the lock screen', () async {
    final storage = _FakeSecureAuthStorage();
    await storage.setPassword('salt', 'hash');
    await storage.setLastUnlockedAt(DateTime.now().subtract(const Duration(minutes: 2)));
    final state = await _ready(_makeNotifier(storage));
    expect(state.status, AuthStatus.unlocked);
  });

  test('outside the grace window re-locks even with a password on file', () async {
    final storage = _FakeSecureAuthStorage();
    await storage.setPassword('salt', 'hash');
    await storage.setLastUnlockedAt(DateTime.now().subtract(const Duration(minutes: 10)));
    final state = await _ready(_makeNotifier(storage));
    expect(state.status, AuthStatus.locked);
  });

  test('recordBackgrounding only stamps the grace-window clock while unlocked', () async {
    final storage = _FakeSecureAuthStorage();
    final notifier = _makeNotifier(storage);
    await _ready(notifier);
    expect(notifier.state.status, AuthStatus.needsSetup);

    await notifier.recordBackgrounding();
    expect(await storage.getLastUnlockedAt(), isNull);

    await notifier.setupPassword('test1234');
    expect(notifier.state.status, AuthStatus.unlocked);

    await notifier.recordBackgrounding();
    expect(await storage.getLastUnlockedAt(), isNotNull);
  });

  test('manual lock() resets the grace window, so a fresh instance stays locked', () async {
    final storage = _FakeSecureAuthStorage();
    final notifier = _makeNotifier(storage);
    await _ready(notifier);
    await notifier.setupPassword('test1234');
    expect(notifier.state.status, AuthStatus.unlocked);

    await notifier.lock();
    expect(notifier.state.status, AuthStatus.locked);

    final fresh = await _ready(_makeNotifier(storage));
    expect(fresh.status, AuthStatus.locked);
  });
}
