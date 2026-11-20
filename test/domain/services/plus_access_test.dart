import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/domain/services/plus_access.dart';

void main() {
  final verified = DateTime.utc(2026, 11, 1);

  group('PlusEntitlement.isActiveAt', () {
    test('inactive is never active', () {
      final e = PlusEntitlement(active: false, verifiedAt: verified);
      expect(e.isActiveAt(verified), isFalse);
    });

    test('no expiry stays active', () {
      final e = PlusEntitlement(active: true, verifiedAt: verified);
      expect(e.isActiveAt(DateTime.utc(2030)), isTrue);
    });

    test('keeps working through the offline grace past expiry, then stops', () {
      final expiry = DateTime.utc(2026, 12, 1);
      final e = PlusEntitlement(active: true, verifiedAt: verified, expiresAt: expiry);
      expect(e.isActiveAt(expiry.subtract(const Duration(days: 1))), isTrue);
      expect(e.isActiveAt(expiry.add(const Duration(days: 6, hours: 23))), isTrue);
      expect(e.isActiveAt(expiry.add(PlusConstants.offlineGrace)), isFalse);
    });
  });

  group('PlusEntitlement JSON', () {
    test('round-trips', () {
      final e = PlusEntitlement(
        active: true,
        verifiedAt: verified,
        expiresAt: DateTime.utc(2027, 11, 1),
      );
      expect(PlusEntitlement.fromJson(e.toJson()), e);
      final noExpiry = PlusEntitlement(active: true, verifiedAt: verified);
      expect(PlusEntitlement.fromJson(noExpiry.toJson()), noExpiry);
    });

    test('malformed data fails closed', () {
      expect(PlusEntitlement.fromJson({}), PlusEntitlement.none);
      expect(
        PlusEntitlement.fromJson({'active': 'yes', 'verifiedAt': verified.toIso8601String()}),
        PlusEntitlement.none,
      );
      expect(
        PlusEntitlement.fromJson({
          'active': true,
          'verifiedAt': verified.toIso8601String(),
          'expiresAt': 'not a date',
        }),
        PlusEntitlement.none,
      );
    });
  });

  group('rangeNeedsPlus', () {
    test('up to 13 weeks is free, so the existing 90-day range stays free', () {
      expect(PlusConstants.freeHistoryDays, 91);
      expect(rangeNeedsPlus(90), isFalse);
      expect(rangeNeedsPlus(91), isFalse);
      expect(rangeNeedsPlus(92), isTrue);
      expect(rangeNeedsPlus(365), isTrue);
    });
  });
}
