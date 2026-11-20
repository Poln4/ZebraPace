import 'package:flutter/foundation.dart';

/// Public RevenueCat SDK keys — like Supabase's publishable key, these are
/// meant to ship inside the app, so they're safe to commit. The secret API
/// key and webhook token are server-only and never belong here.
///
/// One RevenueCat project serves both ZebraPace and ZebraUp: the `zebras`
/// entitlement and the offerings are shared; each app/store has its own
/// key below.
class RevenueCatConfig {
  RevenueCatConfig._();

  /// Test Store key — works only in development builds, never in release.
  static const testStoreKey = 'test_jshJfjrCtJNrLcqnlFehuDIozCZ';

  /// Add once ZebraPace's iOS/Android apps exist in the RevenueCat project.
  static const appleKey = '';
  static const googleKey = '';

  /// Key for this build, or null when purchases aren't available here
  /// (web, desktop, or a release build without a real store key yet). The
  /// app works fully without it — only Zebras+ views stay locked.
  static String? keyFor(TargetPlatform platform, {bool isWeb = kIsWeb}) {
    if (isWeb) return null;
    final storeKey = switch (platform) {
      TargetPlatform.iOS => appleKey,
      TargetPlatform.android => googleKey,
      _ => null,
    };
    if (storeKey == null) return null;
    if (kReleaseMode) return storeKey.isEmpty ? null : storeKey;
    // Debug/profile: prefer the Test Store until real store products are
    // set up; flip with --dart-define=RC_USE_STORE=true.
    const useStore = bool.fromEnvironment('RC_USE_STORE');
    return useStore && storeKey.isNotEmpty ? storeKey : testStoreKey;
  }
}
