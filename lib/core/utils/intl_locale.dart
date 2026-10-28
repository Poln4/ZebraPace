import 'package:flutter/widgets.dart';

/// The locale name to hand to intl's DateFormat/NumberFormat. The app's
/// Chinese is Traditional, but intl's plain 'zh' data is Simplified (周一
/// instead of 週一), so Chinese uses its Taiwan data.
String intlLocaleOf(BuildContext context) {
  final locale = Localizations.localeOf(context);
  if (locale.languageCode == 'zh') return 'zh_TW';
  return locale.toString();
}
