import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/auth_providers.dart';

/// Gates app.dart's root widget — not a normal route the user could
/// back-navigate past. Handles both first-run password setup and every
/// subsequent unlock. "Use Password Instead" is always visible immediately,
/// not hidden behind a failed biometric attempt (plan §7's "both
/// always-reachable paths" requirement).
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _showPasswordField = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: switch (authState.status) {
              AuthStatus.loading => const CupertinoActivityIndicator(),
              AuthStatus.needsSetup => _SetupView(
                  passwordController: _passwordController,
                  confirmController: _confirmController,
                  error: authState.error,
                ),
              AuthStatus.locked => _UnlockView(
                  showPasswordField: _showPasswordField,
                  passwordController: _passwordController,
                  biometricsAvailable: authState.biometricsAvailable,
                  error: authState.error,
                  onShowPasswordField: () => setState(() => _showPasswordField = true),
                ),
              AuthStatus.unlocked => const SizedBox.shrink(),
            },
          ),
        ),
      ),
    );
  }
}

class _SetupView extends ConsumerWidget {
  const _SetupView({
    required this.passwordController,
    required this.confirmController,
    required this.error,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmController;
  final String? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('🦓', style: TextStyle(fontSize: 48)),
        const SizedBox(height: 12),
        Text(l10n.lockScreenSetupTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: ZebraColors.black)),
        const SizedBox(height: 6),
        Text(
          l10n.lockScreenSetupSubtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13, color: CupertinoColors.systemGrey),
        ),
        const SizedBox(height: 20),
        CupertinoTextField(
          key: const ValueKey('setup_password'),
          controller: passwordController,
          placeholder: l10n.lockScreenPasswordPlaceholder,
          obscureText: true,
        ),
        const SizedBox(height: 10),
        CupertinoTextField(
          key: const ValueKey('setup_confirm'),
          controller: confirmController,
          placeholder: l10n.lockScreenConfirmPasswordPlaceholder,
          obscureText: true,
        ),
        if (error != null) ...[
          const SizedBox(height: 8),
          Text(error!, style: const TextStyle(color: CupertinoColors.destructiveRed, fontSize: 12)),
        ],
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton.filled(
            onPressed: () => _submit(context, ref, l10n),
            child: Text(l10n.lockScreenSetPasswordButton),
          ),
        ),
      ],
    );
  }

  void _submit(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final password = passwordController.text;
    if (password.length < 4) {
      _showError(context, l10n.lockScreenPasswordTooShort, l10n);
      return;
    }
    if (password != confirmController.text) {
      _showError(context, l10n.lockScreenPasswordsDontMatch, l10n);
      return;
    }
    ref.read(authProvider.notifier).setupPassword(password);
  }

  void _showError(BuildContext context, String message, AppLocalizations l10n) {
    // Setup errors are local validation, not auth-state errors — surfaced
    // via a lightweight dialog rather than routing through AuthNotifier.
    showCupertinoDialog(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text(l10n.lockScreenOk),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
        ],
      ),
    );
  }
}

class _UnlockView extends ConsumerWidget {
  const _UnlockView({
    required this.showPasswordField,
    required this.passwordController,
    required this.biometricsAvailable,
    required this.error,
    required this.onShowPasswordField,
  });

  final bool showPasswordField;
  final TextEditingController passwordController;
  final bool biometricsAvailable;
  final String? error;
  final VoidCallback onShowPasswordField;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('🦓', style: TextStyle(fontSize: 48)),
        const SizedBox(height: 12),
        Text(l10n.lockScreenLockedTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: ZebraColors.black)),
        const SizedBox(height: 20),
        if (biometricsAvailable)
          SizedBox(
            width: double.infinity,
            child: CupertinoButton.filled(
              onPressed: () => ref.read(authProvider.notifier).tryBiometricUnlock(),
              child: Text(l10n.lockScreenBiometricUnlockButton),
            ),
          ),
        const SizedBox(height: 10),
        if (!showPasswordField)
          CupertinoButton(
            onPressed: onShowPasswordField,
            child: Text(l10n.lockScreenUsePasswordButton),
          )
        else ...[
          CupertinoTextField(
            controller: passwordController,
            placeholder: l10n.lockScreenPasswordPlaceholder,
            obscureText: true,
            onSubmitted: (_) => _submit(ref, l10n),
          ),
          if (error != null) ...[
            const SizedBox(height: 8),
            Text(error!, style: const TextStyle(color: CupertinoColors.destructiveRed, fontSize: 12)),
          ],
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton.filled(
              onPressed: () => _submit(ref, l10n),
              child: Text(l10n.lockScreenUnlockButton),
            ),
          ),
        ],
      ],
    );
  }

  void _submit(WidgetRef ref, AppLocalizations l10n) {
    ref.read(authProvider.notifier).tryPasswordUnlock(passwordController.text, l10n);
  }
}
