import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthChangeEvent;

import 'core/constants/defaults.dart';
import 'core/theme/zebra_theme.dart';
import 'l10n/app_localizations.dart';
import 'presentation/screens/invite/invite_code_screen.dart';
import 'presentation/screens/lock/lock_screen.dart';
import 'presentation/screens/shell/app_shell.dart';
import 'presentation/screens/welcome/welcome_screen.dart';
import 'providers/app_providers.dart';
import 'providers/auth_providers.dart';
import 'providers/cloud_sync_providers.dart';
import 'providers/invite_code_providers.dart';
import 'providers/locale_providers.dart';
import 'providers/text_scale_providers.dart';
import 'providers/welcome_providers.dart';

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

/// Gate order: invite code (invite_code_providers.dart) first — whether the
/// app is usable at all — then the welcome/disclaimer screen (once ever),
/// then the Face ID/password gate. That last one re-locks after being
/// backgrounded for AuthConstants.reLockGraceMinutes — see
/// AuthNotifier/SecureAuthStorage. This widget is the WidgetsBindingObserver
/// that stamps "last seen unlocked" whenever the app actually backgrounds
/// (not just on cold start), so the grace window measures real time away.
class _AuthGate extends ConsumerStatefulWidget {
  const _AuthGate();

  @override
  ConsumerState<_AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<_AuthGate> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.hidden) {
      ref.read(authProvider.notifier).recordBackgrounding();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watched from the very root, ahead of every gate below, so a magic
    // link completing sign-in is caught regardless of which screen is
    // currently showing (invite/welcome/lock/app) — AppShell consumes this
    // once to auto-navigate to Settings' Cloud Sync section.
    ref.listen(cloudAuthStateChangeProvider, (previous, next) {
      if (next.valueOrNull?.event == AuthChangeEvent.signedIn) {
        ref.read(pendingCloudSyncNavigationProvider.notifier).state = true;
      }
    });

    final inviteVerified = ref.watch(inviteCodeVerifiedProvider);
    return inviteVerified.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (verified) {
        if (!verified) return const InviteCodeScreen();

        final welcomeSeen = ref.watch(welcomeAcknowledgedProvider);
        return welcomeSeen.when(
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const SizedBox.shrink(),
          data: (seen) {
            if (!seen) {
              return WelcomeScreen(
                onContinue: () => ref
                    .read(settingsRepositoryProvider)
                    .set(SettingsKeys.welcomeAcknowledged, 'true'),
              );
            }
            final status = ref.watch(authProvider.select((s) => s.status));
            return status == AuthStatus.unlocked ? const AppShell() : const LockScreen();
          },
        );
      },
    );
  }
}
