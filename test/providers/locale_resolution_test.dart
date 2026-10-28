import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/l10n/app_localizations.dart';
import 'package:zebrapace_app/providers/locale_providers.dart';

/// What CupertinoApp does with the OS's preferred languages.
String _settingsTitle(Locale preferred) => lookupAppLocalizations(
        basicLocaleListResolution([preferred], AppLocalizations.supportedLocales))
    .settingsTabTitle;

void main() {
  test('every Chinese-speaking region gets Traditional Chinese', () {
    for (final locale in const [
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'HK'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
      Locale('zh', 'TW'),
      Locale('zh', 'SG'),
      Locale('zh'),
    ]) {
      expect(_settingsTitle(locale), '設定', reason: '$locale');
    }
  });

  test('the old zh_TW setting is the Chinese option', () {
    expect(normalizedLanguageCode('zh_TW'), 'zh');
    expect(normalizedLanguageCode('es'), 'es');
  });
}
