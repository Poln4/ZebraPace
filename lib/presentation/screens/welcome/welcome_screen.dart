import 'package:flutter/cupertino.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/kofi_support_button.dart';

/// The app's invitation/disclaimer screen — what ZebraPace is for, that
/// it's not a substitute for medical care, and that it's a personal
/// project. Two modes, driven by whether [onContinue] is supplied:
///
/// - First-run (onContinue non-null): full-bleed, no nav bar, primary
///   "Continue" button. Gated by `welcomeAcknowledgedProvider` in app.dart,
///   shown once ever, before the existing lock screen.
/// - Revisit (onContinue null): pushed as a normal route from Settings'
///   About section, with a close button instead of Continue.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, this.onContinue});

  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isRevisit = onContinue == null;

    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      navigationBar: isRevisit
          ? CupertinoNavigationBar(
              backgroundColor: ZebraColors.paper,
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.commonCloseButton),
              ),
            )
          : null,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/icon/app_icon.png', width: 120, height: 120),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.welcomeScreenTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: ZebraColors.black,
                ),
              ),
              const SizedBox(height: 20),
              _Paragraph(l10n.welcomeScreenPurposeParagraph),
              const SizedBox(height: 14),
              _DisclaimerBox(text: l10n.welcomeScreenDisclaimerParagraph),
              const SizedBox(height: 14),
              _Paragraph(l10n.welcomeScreenPersonalParagraph),
              const SizedBox(height: 12),
              const KofiSupportButton(),
              if (!isRevisit) ...[
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    onPressed: onContinue,
                    child: Text(l10n.welcomeScreenContinueButton),
                  ),
                ),
              ],
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _Paragraph extends StatelessWidget {
  const _Paragraph(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14.5, height: 1.5, color: ZebraColors.black),
    );
  }
}

class _DisclaimerBox extends StatelessWidget {
  const _DisclaimerBox({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ZebraColors.paper,
        border: Border.all(color: ZebraColors.cardBorder),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13.5,
          height: 1.5,
          color: ZebraColors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
