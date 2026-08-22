import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/defaults.dart';
import 'app_providers.dart';

/// Whether the welcome/disclaimer screen has ever been acknowledged — same
/// watch-the-settings-table pattern as textScaleFactorProvider. Read once
/// at app start by _AuthGate to decide whether to gate on WelcomeScreen
/// before the existing lock screen.
final welcomeAcknowledgedProvider = StreamProvider<bool>((ref) {
  return ref
      .watch(settingsRepositoryProvider)
      .watchAll()
      .map((m) => m[SettingsKeys.welcomeAcknowledged] == 'true');
});
