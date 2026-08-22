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
final inviteCodeVerifiedProvider = StreamProvider<bool>((ref) {
  return ref
      .watch(settingsRepositoryProvider)
      .watchAll()
      .map((m) => m[SettingsKeys.inviteCodeVerified] == 'true');
});

const inviteCode = 'BienBien';

bool checkInviteCode(String input) => input.trim().toLowerCase() == inviteCode.toLowerCase();
