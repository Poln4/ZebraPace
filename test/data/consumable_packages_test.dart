import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:zebrapace_app/data/plus/revenuecat_service.dart';
import 'package:zebrapace_app/domain/services/plus_access.dart';

Package _package(String id, String productId) => Package(
      id,
      PackageType.custom,
      StoreProduct(productId, '', '', 0.99, r'$0.99', 'USD'),
      const PresentedOfferingContext(PlusConstants.consumablesOfferingId, null, null),
    );

void main() {
  test('finds the credits and sponsor packages by id', () {
    final p = ConsumablePackages.from([
      _package('something_else', 'x'),
      _package(PlusConstants.sponsorPackageId, 'zebrapace.sponsor.year'),
      _package(PlusConstants.creditsPackageId, 'zebrapace.credits.pack'),
    ]);
    expect(p.credits?.storeProduct.identifier, 'zebrapace.credits.pack');
    expect(p.sponsor?.storeProduct.identifier, 'zebrapace.sponsor.year');
  });

  test('missing packages stay null (offering not set up yet)', () {
    final p = ConsumablePackages.from([_package('something_else', 'x')]);
    expect(p.credits, isNull);
    expect(p.sponsor, isNull);
  });
}
