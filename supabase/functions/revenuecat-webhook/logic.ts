// Pure logic for the RevenueCat webhook — no Deno or network APIs, so it
// can be tested on its own (see logic_test.ts).

export const ENTITLEMENT_ID = "zebras";

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

type WebhookEvent = {
  app_user_id?: unknown;
  original_app_user_id?: unknown;
  aliases?: unknown;
  transferred_from?: unknown;
  transferred_to?: unknown;
};

/// Every Supabase user id an event touches. A TRANSFER moves a purchase
/// between ids, so both sides must be re-synced. RevenueCat's anonymous
/// ids ($RCAnonymousID:…) aren't accounts and are skipped.
export function userIdsFromEvent(event: WebhookEvent): string[] {
  const candidates: unknown[] = [
    event.app_user_id,
    event.original_app_user_id,
    ...(Array.isArray(event.aliases) ? event.aliases : []),
    ...(Array.isArray(event.transferred_from) ? event.transferred_from : []),
    ...(Array.isArray(event.transferred_to) ? event.transferred_to : []),
  ];
  const ids = new Set<string>();
  for (const c of candidates) {
    if (typeof c === "string" && UUID.test(c)) ids.add(c.toLowerCase());
  }
  return [...ids];
}

type SubscriberEntitlement = {
  expires_date?: string | null;
  grace_period_expires_date?: string | null;
  product_identifier?: string | null;
};

export type EntitlementRow = {
  user_id: string;
  entitlement_id: string;
  granted: boolean;
  expires_at: string | null;
  product_id: string | null;
  updated_at: string;
};

/// Row for one person from RevenueCat's GET /v1/subscribers/{id} response.
/// A missing entitlement (never bought, or a revoked lifetime) is stored
/// as granted=false so cached copies on phones turn off too. A billing
/// grace period extends the expiry, as RevenueCat's SDKs do.
export function rowFromSubscriber(
  userId: string,
  subscriberResponse: unknown,
  now: Date,
): EntitlementRow {
  const entitlements = (subscriberResponse as {
    subscriber?: { entitlements?: Record<string, SubscriberEntitlement> };
  })?.subscriber?.entitlements;
  const e = entitlements?.[ENTITLEMENT_ID];
  const base = {
    user_id: userId,
    entitlement_id: ENTITLEMENT_ID,
    updated_at: now.toISOString(),
  };
  if (!e) return { ...base, granted: false, expires_at: null, product_id: null };

  const expiry = latest(e.expires_date, e.grace_period_expires_date);
  return {
    ...base,
    granted: true,
    expires_at: expiry,
    product_id: e.product_identifier ?? null,
  };
}

/// Later of two ISO dates; null (never expires) only if the main expiry is null.
function latest(main?: string | null, grace?: string | null): string | null {
  if (main == null) return null;
  const m = Date.parse(main);
  const g = grace == null ? NaN : Date.parse(grace);
  // Unparseable main date: expire now rather than never.
  if (Number.isNaN(m)) return new Date(0).toISOString();
  return new Date(Number.isNaN(g) ? m : Math.max(m, g)).toISOString();
}

/// Constant-time string comparison for the shared webhook secret.
export function safeEqual(a: string, b: string): boolean {
  const enc = new TextEncoder();
  const x = enc.encode(a);
  const y = enc.encode(b);
  let diff = x.length ^ y.length;
  for (let i = 0; i < Math.max(x.length, y.length); i++) {
    diff |= (x[i] ?? 0) ^ (y[i] ?? 0);
  }
  return diff === 0;
}
