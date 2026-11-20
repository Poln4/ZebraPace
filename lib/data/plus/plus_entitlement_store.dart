import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/services/plus_access.dart';

/// On-device cache of the last confirmed Zebras+ state, so paid views work
/// offline (business_plan.md §4.2). Lives in the Keychain/Keystore rather
/// than the settings table on purpose: settings are part of the JSON
/// export, and importing a file must never be able to grant a plan.
class PlusEntitlementStore {
  PlusEntitlementStore([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _key = 'zebrapace_plus_entitlement';

  Future<PlusEntitlement> read() async {
    try {
      final raw = await _storage.read(key: _key);
      if (raw == null) return PlusEntitlement.none;
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, Object?>) return PlusEntitlement.none;
      return PlusEntitlement.fromJson(decoded);
    } catch (_) {
      return PlusEntitlement.none;
    }
  }

  Future<void> write(PlusEntitlement entitlement) =>
      _storage.write(key: _key, value: jsonEncode(entitlement.toJson()));

  Future<void> clear() => _storage.delete(key: _key);
}
