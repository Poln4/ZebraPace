import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/defaults.dart';
import 'app_providers.dart';

/// Whether the invite code has ever been verified — same watch-the-settings
/// pattern as welcomeAcknowledgedProvider. Checked first in _AuthGate,
/// ahead of the welcome/disclaimer screen: this gates whether the app is
/// usable at all, not just whether the disclaimer's been read.
///
/// NOTE this is a soft speed bump, not real access control — the code is
/// compared client-side, so anyone reading the compiled JS/app bundle can
/// find it. It stops casual sharing, not a determined bypass.
///
/// Web only: the store builds are already gated by Play's and TestFlight's
/// tester lists, so on Android and iOS this is always true.
final inviteCodeVerifiedProvider = StreamProvider<bool>((ref) {
  if (!ref.watch(inviteGateEnabledProvider)) return Stream.value(true);
  return ref
      .watch(settingsRepositoryProvider)
      .watchAll()
      .map((m) => m[SettingsKeys.inviteCodeVerified] == 'true');
});

/// Whether this build asks for the invite code at all: only on the web.
/// A provider so tests can turn it on outside a browser.
final inviteGateEnabledProvider = Provider<bool>((ref) => kIsWeb);

const inviteCode = 'BienBien';

bool checkInviteCode(String input) => input.trim().toLowerCase() == inviteCode.toLowerCase();
