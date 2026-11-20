import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/errors/error_reporter.dart';
import '../data/plus/plus_entitlement_store.dart';
import '../data/plus/revenuecat_service.dart';
import '../domain/services/plus_access.dart';
import 'cloud_sync_providers.dart';

/// The single checkpoint for Zebras+ (business_plan.md §4.2): screens read
/// [isPlusProvider] and nothing else. No screen talks to the store or
/// RevenueCat directly.
///
/// Must never be imported, directly or transitively, by safety code —
/// see test/core/plus_safety_boundary_test.dart.

final plusEntitlementStoreProvider =
    Provider<PlusEntitlementStore>((ref) => PlusEntitlementStore());

/// Holds the last confirmed entitlement. Starts from the on-device cache;
/// the RevenueCat listener ([plusSyncProvider]) calls [apply] whenever the
/// store reports a change, including after cloud sign-out.
class PlusEntitlementNotifier extends StateNotifier<PlusEntitlement> {
  PlusEntitlementNotifier(this._store) : super(PlusEntitlement.none) {
    _load();
  }

  final PlusEntitlementStore _store;
  bool _touched = false;

  Future<void> _load() async {
    final cached = await _store.read();
    // A store update that lands before the cache read finishes wins.
    if (!_touched && mounted) state = cached;
  }

  Future<void> apply(PlusEntitlement entitlement) async {
    _touched = true;
    state = entitlement;
    await _store.write(entitlement);
  }

  Future<void> clear() async {
    _touched = true;
    state = PlusEntitlement.none;
    await _store.clear();
  }
}

final plusEntitlementProvider =
    StateNotifierProvider<PlusEntitlementNotifier, PlusEntitlement>(
  (ref) => PlusEntitlementNotifier(ref.watch(plusEntitlementStoreProvider)),
);

final revenueCatServiceProvider = Provider<RevenueCatService>((ref) => RevenueCatService());

/// Watched from app.dart's root: configures RevenueCat once and keeps its
/// user in step with the Supabase account (logIn on sign-in, logOut on
/// sign-out — the listener then reports the anonymous user's empty
/// entitlements, so the plan leaves with the account). Failures are
/// reported and swallowed: purchases being down must never break the app.
final plusSyncProvider = FutureProvider<void>((ref) async {
  final service = ref.watch(revenueCatServiceProvider);
  if (!service.available) return;
  final userId = ref.watch(cloudUserProvider.select((u) => u?.id));
  final notifier = ref.read(plusEntitlementProvider.notifier);
  try {
    if (!service.isConfigured) {
      await service.configure(appUserId: userId, onEntitlement: notifier.apply);
    } else {
      await service.syncUser(userId);
    }
  } catch (e, st) {
    ErrorReporter.report(e, st, where: 'plusSync');
  }
});

/// Debug builds only: force paid views on/off while building them, before
/// purchases exist. Ignored in release and profile builds.
final plusDebugOverrideProvider = StateProvider<bool?>((ref) => null);

final isPlusProvider = Provider<bool>((ref) {
  if (kDebugMode) {
    final override = ref.watch(plusDebugOverrideProvider);
    if (override != null) return override;
  }
  return ref.watch(plusEntitlementProvider).isActiveAt(DateTime.now());
});

/// Earliest date key a depth-limited view may show (null = everything).
final plusHistoryStartKeyProvider = Provider<String?>((ref) {
  return plusHistoryStartKey(today: DateTime.now(), isPlus: ref.watch(isPlusProvider));
});
