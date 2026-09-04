import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/data/auth/biometric_service.dart';
import 'package:zebrapace_app/domain/services/password_service.dart';
import 'package:zebrapace_app/providers/auth_providers.dart';

import '../helpers/fake_secure_auth_storage.dart';

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

AuthNotifier _makeNotifier(FakeSecureAuthStorage storage) =>
    AuthNotifier(storage, _FakeBiometricService(), PasswordService());

void main() {
  test('a fresh install with no password needs setup', () async {
    final storage = FakeSecureAuthStorage();
    final state = await _ready(_makeNotifier(storage));
    expect(state.status, AuthStatus.needsSetup);
  });

  test('a password with no recorded unlock time starts locked', () async {
    final storage = FakeSecureAuthStorage();
    await storage.setPassword('salt', 'hash');
    final state = await _ready(_makeNotifier(storage));
    expect(state.status, AuthStatus.locked);
  });

  test('within the grace window since the last unlock skips the lock screen', () async {
    final storage = FakeSecureAuthStorage();
    await storage.setPassword('salt', 'hash');
    await storage.setLastUnlockedAt(DateTime.now().subtract(const Duration(minutes: 2)));
    final state = await _ready(_makeNotifier(storage));
    expect(state.status, AuthStatus.unlocked);
  });

  test('outside the grace window re-locks even with a password on file', () async {
    final storage = FakeSecureAuthStorage();
    await storage.setPassword('salt', 'hash');
    await storage.setLastUnlockedAt(DateTime.now().subtract(const Duration(minutes: 10)));
    final state = await _ready(_makeNotifier(storage));
    expect(state.status, AuthStatus.locked);
  });

  test('within an extended grace override skips the lock screen even if stale', () async {
    final storage = FakeSecureAuthStorage();
    await storage.setPassword('salt', 'hash');
    await storage.setLastUnlockedAt(DateTime.now().subtract(const Duration(hours: 2)));
    await storage.setGraceOverrideUntil(DateTime.now().add(const Duration(minutes: 10)));
    final state = await _ready(_makeNotifier(storage));
    expect(state.status, AuthStatus.unlocked);
  });

  test('an expired grace override does not skip the lock screen', () async {
    final storage = FakeSecureAuthStorage();
    await storage.setPassword('salt', 'hash');
    await storage.setLastUnlockedAt(DateTime.now().subtract(const Duration(hours: 2)));
    await storage.setGraceOverrideUntil(DateTime.now().subtract(const Duration(minutes: 1)));
    final state = await _ready(_makeNotifier(storage));
    expect(state.status, AuthStatus.locked);
  });

  test('recordBackgrounding only stamps the grace-window clock while unlocked', () async {
    final storage = FakeSecureAuthStorage();
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

  test('extendGraceWindow sets a future override', () async {
    final storage = FakeSecureAuthStorage();
    final notifier = _makeNotifier(storage);
    await _ready(notifier);

    await notifier.extendGraceWindow();
    final override = await storage.getGraceOverrideUntil();
    expect(override, isNotNull);
    expect(override!.isAfter(DateTime.now()), isTrue);
  });

  test('manual lock() resets the grace window, so a fresh instance stays locked', () async {
    final storage = FakeSecureAuthStorage();
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
