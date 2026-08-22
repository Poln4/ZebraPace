import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/defaults.dart';
import '../../../core/theme/zebra_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_providers.dart';
import '../../../providers/invite_code_providers.dart';

/// Gates the whole app ahead of even the welcome/disclaimer screen — see
/// invite_code_providers.dart for what this is and isn't (a soft speed
/// bump, not real access control).
class InviteCodeScreen extends ConsumerStatefulWidget {
  const InviteCodeScreen({super.key});

  @override
  ConsumerState<InviteCodeScreen> createState() => _InviteCodeScreenState();
}

class _InviteCodeScreenState extends ConsumerState<InviteCodeScreen> {
  final _controller = TextEditingController();
  String? _error;

  static final _websiteUrl = Uri.parse('https://paulinavl.netlify.app');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🦓', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 12),
                Text(
                  l10n.inviteCodeScreenTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: ZebraColors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.inviteCodeScreenBody,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, height: 1.5, color: ZebraColors.black),
                ),
                const SizedBox(height: 20),
                CupertinoTextField(
                  controller: _controller,
                  placeholder: l10n.inviteCodeScreenPlaceholder,
                  textAlign: TextAlign.center,
                  autocorrect: false,
                  onSubmitted: (_) => _submit(),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Text(_error!,
                      style: const TextStyle(color: CupertinoColors.destructiveRed, fontSize: 12)),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    onPressed: _submit,
                    child: Text(l10n.inviteCodeScreenSubmitButton),
                  ),
                ),
                const SizedBox(height: 8),
                CupertinoButton(
                  onPressed: () => launchUrl(_websiteUrl, mode: LaunchMode.externalApplication),
                  child: Text(l10n.inviteCodeScreenGetCodeButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (checkInviteCode(_controller.text)) {
      ref.read(settingsRepositoryProvider).set(SettingsKeys.inviteCodeVerified, 'true');
    } else {
      final l10n = AppLocalizations.of(context);
      setState(() => _error = l10n.inviteCodeScreenError);
    }
  }
}
