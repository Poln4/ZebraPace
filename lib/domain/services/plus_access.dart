import '../../core/utils/date_utils.dart';

/// Zebras+ access rules — the pure half of `isPlusProvider` (see
/// docs/business_plan.md §4.2). Nothing here talks to a store, so it is
/// trivially testable and the provider stays a thin wrapper.
///
/// Safety code (pacing_service, pem_service, the load ceiling and the
/// pacing alerts) must never import this file or plus_providers.dart —
/// test/core/plus_safety_boundary_test.dart enforces it. "No se vende el
/// freno."
class PlusConstants {
  PlusConstants._();

  /// RevenueCat entitlement id, shared with ZebraUp (business_plan.md
  /// calls it `zebras_plus`; the dashboard id is `zebras`).
  static const entitlementId = 'zebras';

  /// How long a cached active plan keeps working past its expiry date
  /// while the phone can't confirm a renewal (offline, store hiccup).
  static const offlineGrace = Duration(days: 7);

  /// N in §4.4: weeks of history and pattern depth that are free — the
  /// recent baseline pacing needs. Deeper views beyond this are Zebras+.
  /// Still "por decidir" in the plan; 6 is the proposal.
  static const freeHistoryWeeks = 6;
}

/// Last known Zebras+ state, as confirmed by the store/RevenueCat.
class PlusEntitlement {
  const PlusEntitlement({
    required this.active,
    required this.verifiedAt,
    this.expiresAt,
  });

  static final none = PlusEntitlement(
    active: false,
    verifiedAt: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
  );

  final bool active;

  /// When the current period ends. Null means it doesn't expire
  /// (lifetime or open-ended promotional grant).
  final DateTime? expiresAt;

  /// When the store last confirmed this state.
  final DateTime verifiedAt;

  /// True while the plan counts as active, including [PlusConstants.offlineGrace]
  /// past [expiresAt] — so being offline over a renewal date never locks
  /// anyone out. A fresh online check overwrites the cache either way.
  bool isActiveAt(DateTime now) {
    if (!active) return false;
    final expiry = expiresAt;
    if (expiry == null) return true;
    return now.isBefore(expiry.add(PlusConstants.offlineGrace));
  }

  Map<String, Object?> toJson() => {
        'active': active,
        'expiresAt': expiresAt?.toUtc().toIso8601String(),
        'verifiedAt': verifiedAt.toUtc().toIso8601String(),
      };

  /// Returns [none] for anything malformed — a corrupt cache must fail
  /// closed for paid views (safety features don't depend on this at all).
  static PlusEntitlement fromJson(Map<String, Object?> json) {
    final active = json['active'];
    final verified = DateTime.tryParse(json['verifiedAt'] as String? ?? '');
    final rawExpiry = json['expiresAt'];
    final expiry = rawExpiry is String ? DateTime.tryParse(rawExpiry) : null;
    if (active is! bool || verified == null) return none;
    if (rawExpiry != null && expiry == null) return none;
    return PlusEntitlement(active: active, verifiedAt: verified, expiresAt: expiry);
  }

  @override
  bool operator ==(Object other) =>
      other is PlusEntitlement &&
      other.active == active &&
      other.expiresAt == expiresAt &&
      other.verifiedAt == verifiedAt;

  @override
  int get hashCode => Object.hash(active, expiresAt, verifiedAt);
}

/// Earliest day a depth-limited view (long-term patterns, long load
/// history, projections) may show. Null = no limit. "Se cobra por la
/// vista, no por el dato": everything is always recorded, so subscribing
/// reveals the full history instantly. Returned as a date key
/// (yyyy-MM-dd), the format the repositories query by.
String? plusHistoryStartKey({required DateTime today, required bool isPlus}) {
  if (isPlus) return null;
  final day = dateFromKey(dateKey(today));
  return dateKey(DateTime(day.year, day.month, day.day - PlusConstants.freeHistoryWeeks * 7));
}
