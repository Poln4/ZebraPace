import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth/biometric_service.dart';
import '../data/auth/secure_auth_storage.dart';
import '../domain/services/password_service.dart';
import '../l10n/app_localizations.dart';

enum AuthStatus { loading, needsSetup, locked, unlocked }

class AuthState {
  const AuthState({required this.status, this.error, this.biometricsAvailable = false});

  final AuthStatus status;
  final String? error;
  final bool biometricsAvailable;

  AuthState copyWith({AuthStatus? status, String? error, bool? biometricsAvailable}) {
    return AuthState(
      status: status ?? this.status,
      error: error,
      biometricsAvailable: biometricsAvailable ?? this.biometricsAvailable,
    );
  }
}

final secureAuthStorageProvider = Provider<SecureAuthStorage>((ref) => SecureAuthStorage());
final biometricServiceProvider = Provider<BiometricService>((ref) => BiometricService());
final passwordServiceProvider = Provider<PasswordService>((ref) => PasswordService());

/// Gates app.dart's root widget — re-lock policy is "lock on every cold
/// start" (the plan's recommended default for a health-data app), so this
/// notifier always starts at `locked`/`needsSetup`, never persisting an
/// "unlocked" state across app launches.
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._storage, this._biometrics, this._passwords)
      : super(const AuthState(status: AuthStatus.loading)) {
    _init();
  }

  final SecureAuthStorage _storage;
  final BiometricService _biometrics;
  final PasswordService _passwords;

  Future<void> _init() async {
    try {
      final biometricsAvailable = await _biometrics.isAvailable();
      final hasPassword = await _storage.hasPassword();

      if (!hasPassword) {
        state = AuthState(status: AuthStatus.needsSetup, biometricsAvailable: biometricsAvailable);
        return;
      }

      state = AuthState(status: AuthStatus.locked, biometricsAvailable: biometricsAvailable);
      if (biometricsAvailable) {
        // Auto-trigger on mount for minimal friction — "Use Password Instead"
        // stays visible immediately in the UI regardless, not gated on this
        // failing first (see plan §7's "both always-reachable paths" note).
        unawaited(tryBiometricUnlock());
      }
    } catch (_) {
      // Secure storage / biometrics being unreachable (e.g. a Keychain
      // access hiccup) must never strand the user on a stuck loading
      // screen — fall through to password setup as the safe default.
      state = const AuthState(status: AuthStatus.needsSetup);
    }
  }

  Future<void> setupPassword(String password) async {
    final salt = _passwords.generateSalt();
    final hash = _passwords.hash(password, salt);
    await _storage.setPassword(salt, hash);
    state = state.copyWith(status: AuthStatus.unlocked, error: null);
  }

  Future<bool> tryBiometricUnlock() async {
    final success = await _biometrics.authenticate();
    if (success) {
      state = state.copyWith(status: AuthStatus.unlocked, error: null);
    }
    return success;
  }

  Future<bool> tryPasswordUnlock(String password, AppLocalizations l10n) async {
    final stored = await _storage.getPassword();
    if (stored == null) {
      state = state.copyWith(error: l10n.authProviderNoPasswordSetUp);
      return false;
    }
    final ok = _passwords.verify(password, stored.salt, stored.hash);
    if (ok) {
      state = state.copyWith(status: AuthStatus.unlocked, error: null);
    } else {
      state = state.copyWith(error: l10n.authProviderIncorrectPassword);
    }
    return ok;
  }

  /// Manual re-lock (e.g. a "Lock now" action in Settings) — cold-start
  /// re-lock happens automatically since state is never persisted, but a
  /// manual trigger is a cheap, useful addition.
  void lock() {
    state = state.copyWith(status: AuthStatus.locked, error: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.watch(secureAuthStorageProvider),
    ref.watch(biometricServiceProvider),
    ref.watch(passwordServiceProvider),
  );
});
