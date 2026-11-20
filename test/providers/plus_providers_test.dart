import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/data/plus/plus_entitlement_store.dart';
import 'package:zebrapace_app/domain/services/plus_access.dart';
import 'package:zebrapace_app/providers/plus_providers.dart';

/// In-memory stand-in so tests never touch the Keychain plugin.
class FakePlusEntitlementStore extends PlusEntitlementStore {
  FakePlusEntitlementStore([this.saved]);

  PlusEntitlement? saved;

  @override
  Future<PlusEntitlement> read() async => saved ?? PlusEntitlement.none;

  @override
  Future<void> write(PlusEntitlement entitlement) async => saved = entitlement;

  @override
  Future<void> clear() async => saved = null;
}

void main() {
  ProviderContainer containerWith(FakePlusEntitlementStore store) {
    final c = ProviderContainer(
      overrides: [plusEntitlementStoreProvider.overrideWithValue(store)],
    );
    addTearDown(c.dispose);
    return c;
  }

  final activePlan = PlusEntitlement(
    active: true,
    verifiedAt: DateTime.now().toUtc(),
    expiresAt: DateTime.now().toUtc().add(const Duration(days: 365)),
  );

  test('defaults to free with an empty cache', () async {
    final c = containerWith(FakePlusEntitlementStore());
    c.read(plusEntitlementProvider);
    await Future<void>.delayed(Duration.zero);
    expect(c.read(isPlusProvider), isFalse);
    expect(c.read(plusHistoryStartKeyProvider), isNotNull);
  });

  test('restores an active plan from the cache (offline start)', () async {
    final c = containerWith(FakePlusEntitlementStore(activePlan));
    c.read(plusEntitlementProvider);
    await Future<void>.delayed(Duration.zero);
    expect(c.read(isPlusProvider), isTrue);
    expect(c.read(plusHistoryStartKeyProvider), isNull);
  });

  test('apply persists; clear forgets', () async {
    final store = FakePlusEntitlementStore();
    final c = containerWith(store);
    await c.read(plusEntitlementProvider.notifier).apply(activePlan);
    expect(c.read(isPlusProvider), isTrue);
    expect(store.saved, activePlan);

    await c.read(plusEntitlementProvider.notifier).clear();
    expect(c.read(isPlusProvider), isFalse);
    expect(store.saved, isNull);
  });

  test('debug override wins in debug builds', () {
    final c = containerWith(FakePlusEntitlementStore());
    c.read(plusDebugOverrideProvider.notifier).state = true;
    expect(c.read(isPlusProvider), isTrue);
  });
}
