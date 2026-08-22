import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/defaults.dart';
import 'app_providers.dart';

/// Language codes the language picker offers — 'system' follows the OS
/// locale, falling back to English if the OS locale isn't supported.
const List<String> supportedAppLanguageCodes = ['system', 'en', 'es', 'zh_TW'];

final languageCodeProvider = StreamProvider<String>((ref) {
  return ref.watch(settingsRepositoryProvider).watchAll().map(
        (m) => m[SettingsKeys.languageCode] ?? DefaultSettings.languageCode,
      );
});

/// `null` tells [CupertinoApp]/[MaterialApp] to resolve the locale from the
/// OS via `supportedLocales`, matching the 'system' setting.
final localeProvider = Provider<Locale?>((ref) {
  final code = ref.watch(languageCodeProvider).valueOrNull ?? DefaultSettings.languageCode;
  return switch (code) {
    'en' => const Locale('en'),
    'es' => const Locale('es'),
    'zh_TW' => const Locale('zh', 'TW'),
    _ => null,
  };
});
