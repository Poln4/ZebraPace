import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../../core/config/revenuecat_config.dart';
import '../../domain/services/plus_access.dart';

/// Thin wrapper over the RevenueCat SDK, so the rest of the app only ever
/// sees [PlusEntitlement] (business_plan.md §4.2: no screen talks to the
/// store directly). Paywall and Customer Center are RevenueCat's native UI.
class RevenueCatService {
  RevenueCatService({String? apiKey})
      : _apiKey = apiKey ?? RevenueCatConfig.keyFor(defaultTargetPlatform);

  final String? _apiKey;
  bool _configured = false;

  /// False on web/desktop or a release build without a store key yet.
  bool get available => _apiKey != null;

  bool get isConfigured => _configured;

  /// Configures once. [appUserId] is the Supabase user id when signed in —
  /// the same id in ZebraUp is what makes one purchase unlock both apps.
  Future<void> configure({
    required String? appUserId,
    required void Function(PlusEntitlement) onEntitlement,
  }) async {
    final key = _apiKey;
    if (key == null || _configured) return;
    if (kDebugMode) await Purchases.setLogLevel(LogLevel.debug);
    final config = PurchasesConfiguration(key)..appUserID = appUserId;
    await Purchases.configure(config);
    _configured = true;
    // Fires right away with the cached info, then on every change
    // (purchase, renewal, expiry, restore, refund, logIn/logOut).
    Purchases.addCustomerInfoUpdateListener(
      (info) => onEntitlement(entitlementFromCustomerInfo(info)),
    );
  }

  /// Keeps RevenueCat's user in step with the Supabase account.
  Future<void> syncUser(String? supabaseUserId) async {
    if (!_configured) return;
    if (supabaseUserId != null) {
      if (await Purchases.appUserID != supabaseUserId) {
        await Purchases.logIn(supabaseUserId);
      }
    } else if (!await Purchases.isAnonymous) {
      await Purchases.logOut();
    }
  }

  /// Fresh state from RevenueCat (falls back to its own cache offline).
  Future<PlusEntitlement> refresh() async {
    if (!_configured) return PlusEntitlement.none;
    return entitlementFromCustomerInfo(await Purchases.getCustomerInfo());
  }

  Future<PlusEntitlement> restore() async {
    return entitlementFromCustomerInfo(await Purchases.restorePurchases());
  }

  /// Shows the paywall configured for the current offering in the
  /// dashboard. Purchase results also arrive via the update listener.
  Future<PaywallResult> presentPaywall() =>
      RevenueCatUI.presentPaywall(displayCloseButton: true);

  /// Cancel, change plan, refunds, restore — RevenueCat's native screen.
  Future<void> presentCustomerCenter() => RevenueCatUI.presentCustomerCenter();

  /// The AI-credits and sponsor packages, from the `credits` offering.
  /// Either may be missing (not set up in the dashboard or the store yet).
  Future<ConsumablePackages> consumablePackages() async {
    if (!_configured) return const ConsumablePackages();
    final offering =
        (await Purchases.getOfferings()).all[PlusConstants.consumablesOfferingId];
    return ConsumablePackages.from(offering?.availablePackages ?? const []);
  }

  /// Buys one consumable. The server credits it when RevenueCat's webhook
  /// arrives — the phone never adds credits itself.
  Future<void> purchase(Package package) =>
      Purchases.purchase(PurchaseParams.package(package));
}

class ConsumablePackages {
  const ConsumablePackages({this.credits, this.sponsor});

  ConsumablePackages.from(List<Package> packages)
      : credits = _find(packages, PlusConstants.creditsPackageId),
        sponsor = _find(packages, PlusConstants.sponsorPackageId);

  final Package? credits;
  final Package? sponsor;

  static Package? _find(List<Package> packages, String id) {
    for (final p in packages) {
      if (p.identifier == id) return p;
    }
    return null;
  }
}

PlusEntitlement entitlementFromCustomerInfo(CustomerInfo info) {
  final e = info.entitlements.all[PlusConstants.entitlementId];
  return entitlementFrom(
    isActive: e?.isActive ?? false,
    expirationDate: e?.expirationDate,
    now: DateTime.now(),
  );
}

/// Pure mapping, kept separate so it's testable without the SDK.
///
/// RevenueCat flips `isActive` off the moment the expiry date passes, even
/// offline before it could see a renewal. So a dated entitlement counts as
/// granted and [PlusEntitlement.isActiveAt] applies the offline grace to
/// its expiry. An inactive one with no date (revoked lifetime) is off.
PlusEntitlement entitlementFrom({
  required bool isActive,
  required String? expirationDate,
  required DateTime now,
}) {
  final expiry = expirationDate == null
      ? null
      // Unparseable date: treat as expiring now (grace only), never forever.
      : (DateTime.tryParse(expirationDate) ?? now).toUtc();
  return PlusEntitlement(
    active: isActive || expiry != null,
    verifiedAt: now.toUtc(),
    expiresAt: expiry,
  );
}

/// User-facing failure category for a RevenueCat error.
enum PurchaseFailure { cancelled, network, pending, notAllowed, other }

PurchaseFailure purchaseFailureFrom(Object error) {
  if (error is! PlatformException) return PurchaseFailure.other;
  return switch (PurchasesErrorHelper.getErrorCode(error)) {
    PurchasesErrorCode.purchaseCancelledError => PurchaseFailure.cancelled,
    PurchasesErrorCode.networkError ||
    PurchasesErrorCode.offlineConnectionError =>
      PurchaseFailure.network,
    PurchasesErrorCode.paymentPendingError => PurchaseFailure.pending,
    PurchasesErrorCode.purchaseNotAllowedError ||
    PurchasesErrorCode.insufficientPermissionsError =>
      PurchaseFailure.notAllowed,
    _ => PurchaseFailure.other,
  };
}
