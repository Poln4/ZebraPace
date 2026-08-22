import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/defaults.dart';
import 'app_providers.dart';

/// Discrete steps rather than a free slider — predictable, and matches how
/// iOS's own Dynamic Type picker works. This multiplies on top of whatever
/// text-scale the OS/browser is already applying (MediaQuery.textScaler),
/// it doesn't replace it — someone who already bumped their OS text size up
/// can still make ZebraPace's text larger still.
const List<double> textScaleSteps = [0.85, 1.0, 1.15, 1.3, 1.5];

final textScaleFactorProvider = StreamProvider<double>((ref) {
  return ref.watch(settingsRepositoryProvider).watchAll().map((m) {
    final raw = m[SettingsKeys.textScaleFactor];
    return double.tryParse(raw ?? '') ?? DefaultSettings.textScaleFactor;
  });
});
