import 'package:drift/native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/app.dart';
import 'package:zebrapace_app/data/auth/biometric_service.dart';
import 'package:zebrapace_app/data/auth/secure_auth_storage.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/providers/app_providers.dart';
import 'package:zebrapace_app/providers/auth_providers.dart';

/// In-memory stand-in so the widget test never touches the real Keychain
/// (flutter_secure_storage) or biometric (local_auth) platform channels,
/// which have no implementation registered in a plain `flutter test` run.
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
}

class _FakeBiometricService extends BiometricService {
  @override
  Future<bool> isAvailable() async => false; // exercise the password-only path
}

List<Override> _testOverrides() => [
      appDatabaseProvider.overrideWithValue(AppDatabase(NativeDatabase.memory())),
      secureAuthStorageProvider.overrideWithValue(_FakeSecureAuthStorage()),
      biometricServiceProvider.overrideWithValue(_FakeBiometricService()),
    ];

Future<void> _settleAndTearDown(WidgetTester tester) async {
  // Tear the tree down inside the test body (rather than letting the test
  // framework do it after return) so drift's internal stream-query-close
  // Timer(Duration.zero, ...) gets a chance to fire before the framework's
  // post-test "no pending timers" invariant check runs.
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(Duration.zero);
}

/// The invite code screen gates everything else on a fresh install, ahead
/// of even the welcome/disclaimer screen (see app.dart's _AuthGate) — tests
/// that care about what's behind it enter the code first.
Future<void> _enterInviteCode(WidgetTester tester) async {
  expect(find.text('This app is invite-only 🦓'), findsOneWidget);
  await tester.enterText(find.byType(CupertinoTextField).first, 'BienBien');
  await tester.tap(find.text('Unlock'));
  await tester.pumpAndSettle();
}

/// The welcome/disclaimer screen gates everything else after that, once
/// ever — tests that care about what's behind it tap through the one-time
/// "Continue" button.
Future<void> _acknowledgeWelcome(WidgetTester tester) async {
  expect(find.text('Welcome to ZebraPace 🦓'), findsOneWidget);
  final continueButton = find.text('I understand — Continue');
  await tester.ensureVisible(continueButton);
  await tester.pumpAndSettle();
  await tester.tap(continueButton);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('a fresh install shows the invite code screen first', (tester) async {
    await tester.pumpWidget(ProviderScope(overrides: _testOverrides(), child: const ZebraPaceApp()));
    await tester.pumpAndSettle();

    expect(find.text('This app is invite-only 🦓'), findsOneWidget);
    await _settleAndTearDown(tester);
  });

  testWidgets('entering the invite code lands on the welcome/disclaimer screen', (tester) async {
    await tester.pumpWidget(ProviderScope(overrides: _testOverrides(), child: const ZebraPaceApp()));
    await tester.pumpAndSettle();
    await _enterInviteCode(tester);

    expect(find.text('Welcome to ZebraPace 🦓'), findsOneWidget);
    await _settleAndTearDown(tester);
  });

  testWidgets('acknowledging the welcome screen lands on the password setup screen',
      (tester) async {
    await tester.pumpWidget(ProviderScope(overrides: _testOverrides(), child: const ZebraPaceApp()));
    await tester.pumpAndSettle();
    await _enterInviteCode(tester);
    await _acknowledgeWelcome(tester);

    expect(find.text('Set up a password'), findsOneWidget);
    await _settleAndTearDown(tester);
  });

  testWidgets('setting up a password unlocks straight into the Daily Vitals tab', (tester) async {
    await tester.pumpWidget(ProviderScope(overrides: _testOverrides(), child: const ZebraPaceApp()));
    await tester.pumpAndSettle();
    await _enterInviteCode(tester);
    await _acknowledgeWelcome(tester);

    await tester.enterText(find.byKey(const ValueKey('setup_password')), 'test1234');
    await tester.enterText(find.byKey(const ValueKey('setup_confirm')), 'test1234');
    await tester.tap(find.text('Set password'));
    await tester.pumpAndSettle();

    expect(find.text('ZebraPace'), findsOneWidget);
    expect(find.text('Daily Vitals & Fuel'), findsWidgets);
    await _settleAndTearDown(tester);
  });
}
