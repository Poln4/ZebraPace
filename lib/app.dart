import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/defaults.dart';
import 'core/theme/zebra_theme.dart';
import 'l10n/app_localizations.dart';
import 'presentation/screens/lock/lock_screen.dart';
import 'presentation/screens/shell/app_shell.dart';
import 'providers/auth_providers.dart';
import 'providers/locale_providers.dart';
import 'providers/text_scale_providers.dart';

class ZebraPaceApp extends ConsumerWidget {
  const ZebraPaceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final textScaleFactor =
        ref.watch(textScaleFactorProvider).valueOrNull ?? DefaultSettings.textScaleFactor;
    return CupertinoApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: ZebraTheme.cupertino,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        // Multiplies on top of whatever text scale the OS/browser already
        // applies (MediaQuery.textScaler) rather than replacing it — see
        // text_scale_providers.dart.
        final mediaQuery = MediaQuery.of(context);
        final baseScale = mediaQuery.textScaler.scale(1.0);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.linear(baseScale * textScaleFactor),
          ),
          child: child!,
        );
      },
      home: const _AuthGate(),
    );
  }
}

/// Re-lock policy: lock on every cold start (plan §7's recommended default
/// for a health-data app) — AuthNotifier never persists an "unlocked" state,
/// so this always starts behind the lock screen.
class _AuthGate extends ConsumerWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(authProvider.select((s) => s.status));
    return status == AuthStatus.unlocked ? const AppShell() : const LockScreen();
  }
}
