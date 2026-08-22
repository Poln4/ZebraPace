import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/zebra_theme.dart';
import '../../l10n/app_localizations.dart';

/// Opens the author's Ko-fi page in the browser. Entirely optional support
/// link, not a paywall — same launch-external-URL pattern already used for
/// the HealthKit "Open iOS Settings" deep link in settings_tab.dart.
class KofiSupportButton extends StatelessWidget {
  const KofiSupportButton({super.key});

  static final _kofiUrl = Uri.parse('https://ko-fi.com/paulinavl');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        color: ZebraColors.sand,
        onPressed: () => launchUrl(_kofiUrl, mode: LaunchMode.externalApplication),
        child: Text(l10n.kofiSupportButton, style: const TextStyle(color: ZebraColors.onColor)),
      ),
    );
  }
}
