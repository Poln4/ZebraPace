import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_providers.dart' hide AuthState;

/// Cloud account identity (Supabase Auth) — separate from `auth_providers.dart`,
/// which gates the local device lock (Face ID/password). Signing in here
/// only establishes who owns synced data later; it doesn't touch the lock
/// screen and doesn't move any health data yet.
enum CloudAuthAction { idle, sending, linkSent, error }

class CloudAuthState {
  const CloudAuthState({this.action = CloudAuthAction.idle, this.error});

  final CloudAuthAction action;
  final String? error;

  CloudAuthState copyWith({CloudAuthAction? action, String? error}) {
    return CloudAuthState(action: action ?? this.action, error: error);
  }
}

final supabaseClientProvider = Provider<SupabaseClient>((ref) => Supabase.instance.client);

/// Reacts to sign-in (magic link clicked), sign-out, and token refresh.
final cloudAuthStateChangeProvider = StreamProvider<AuthState>((ref) {
  return ref.watch(supabaseClientProvider).auth.onAuthStateChange;
});

/// The signed-in user, if any — derived from current session plus live
/// auth-state changes so it updates the moment a magic link is clicked.
final cloudUserProvider = Provider<User?>((ref) {
  ref.watch(cloudAuthStateChangeProvider);
  return ref.watch(supabaseClientProvider).auth.currentUser;
});

/// Set true the moment a magic link actually completes sign-in (the
/// AuthChangeEvent.signedIn case, as opposed to an already-existing
/// session just being restored) — app.dart's _AuthGate sets this,
/// AppShell consumes it once to auto-navigate to Settings' Cloud Sync
/// section, so returning from the email lands you somewhere that
/// confirms it worked instead of the Vitals tab.
final pendingCloudSyncNavigationProvider = StateProvider<bool>((ref) => false);

class CloudAuthController extends StateNotifier<CloudAuthState> {
  CloudAuthController(this._client, this._ref) : super(const CloudAuthState());

  final SupabaseClient _client;
  final Ref _ref;

  Future<void> sendMagicLink(String email) async {
    state = state.copyWith(action: CloudAuthAction.sending, error: null);
    try {
      // Extends the local lock's grace window before sending the user off
      // to their email — without this, a round trip longer than the
      // normal grace window strands them on the lock screen with no idea
      // they'd already signed in successfully.
      await _ref.read(authProvider.notifier).extendGraceWindow();
      await _client.auth.signInWithOtp(
        email: email,
        emailRedirectTo: kIsWeb ? null : 'zebrapace://login-callback',
      );
      state = state.copyWith(action: CloudAuthAction.linkSent, error: null);
    } catch (e) {
      state = state.copyWith(action: CloudAuthAction.error, error: e.toString());
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
    state = const CloudAuthState();
  }

  void reset() => state = const CloudAuthState();
}

final cloudAuthControllerProvider =
    StateNotifierProvider<CloudAuthController, CloudAuthState>((ref) {
  return CloudAuthController(ref.watch(supabaseClientProvider), ref);
});
