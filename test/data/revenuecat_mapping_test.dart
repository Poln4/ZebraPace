import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/data/plus/revenuecat_service.dart';
import 'package:zebrapace_app/domain/services/plus_access.dart';

void main() {
  final now = DateTime.utc(2026, 11, 21, 12);

  test('no entitlement is free', () {
    final e = entitlementFrom(isActive: false, expirationDate: null, now: now);
    expect(e.isActiveAt(now), isFalse);
  });

  test('active subscription carries its expiry', () {
    final e = entitlementFrom(isActive: true, expirationDate: '2027-11-21T12:00:00Z', now: now);
    expect(e.expiresAt, DateTime.utc(2027, 11, 21, 12));
    expect(e.isActiveAt(now), isTrue);
  });

  test('lifetime/promo without expiry stays on', () {
    final e = entitlementFrom(isActive: true, expirationDate: null, now: now);
    expect(e.isActiveAt(DateTime.utc(2035)), isTrue);
  });

  test('RevenueCat says inactive right after expiry offline: grace still applies', () {
    final e = entitlementFrom(isActive: false, expirationDate: '2026-11-20T12:00:00Z', now: now);
    expect(e.isActiveAt(now), isTrue);
    expect(e.isActiveAt(DateTime.utc(2026, 11, 20, 12).add(PlusConstants.offlineGrace)), isFalse);
  });

  test('revoked lifetime (inactive, no date) is off', () {
    final e = entitlementFrom(isActive: false, expirationDate: null, now: now);
    expect(e.isActiveAt(now), isFalse);
  });

  test('unparseable expiry gets only the grace, never forever', () {
    final e = entitlementFrom(isActive: true, expirationDate: 'garbage', now: now);
    expect(e.isActiveAt(now.add(const Duration(days: 8))), isFalse);
  });

  test('non-store errors map to other', () {
    expect(purchaseFailureFrom(Exception('x')), PurchaseFailure.other);
  });
}
