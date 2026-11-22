// Run: node --test supabase/functions/revenuecat-webhook/logic_test.ts
// (or `deno test` — node:test works in both).
import { test } from "node:test";
import assert from "node:assert/strict";
import {
  consumableActionFromEvent,
  CREDIT_PRODUCTS,
  rowFromSubscriber,
  safeEqual,
  userIdsFromEvent,
} from "./logic.ts";

const A = "11111111-2222-3333-4444-555555555555";
const B = "AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE";
const now = new Date("2026-11-21T12:00:00Z");

test("collects Supabase ids, lowercased and de-duplicated; skips anonymous ids", () => {
  const ids = userIdsFromEvent({
    app_user_id: A,
    original_app_user_id: "$RCAnonymousID:abc123",
    aliases: [A, "$RCAnonymousID:abc123", B],
  });
  assert.deepEqual(ids.sort(), [A, B.toLowerCase()].sort());
});

test("TRANSFER re-syncs both sides", () => {
  const ids = userIdsFromEvent({ transferred_from: [A], transferred_to: [B] });
  assert.equal(ids.length, 2);
});

test("junk payload yields no ids", () => {
  assert.deepEqual(userIdsFromEvent({ app_user_id: 42, aliases: "nope" }), []);
});

test("active subscription → granted with expiry and product", () => {
  const row = rowFromSubscriber(A, {
    subscriber: {
      entitlements: {
        zebras: { expires_date: "2027-11-21T12:00:00Z", product_identifier: "yearly" },
      },
    },
  }, now);
  assert.equal(row.granted, true);
  assert.equal(row.expires_at, "2027-11-21T12:00:00.000Z");
  assert.equal(row.product_id, "yearly");
  assert.equal(row.entitlement_id, "zebras");
});

test("billing grace period extends the expiry", () => {
  const row = rowFromSubscriber(A, {
    subscriber: {
      entitlements: {
        zebras: {
          expires_date: "2026-11-20T00:00:00Z",
          grace_period_expires_date: "2026-12-04T00:00:00Z",
        },
      },
    },
  }, now);
  assert.equal(row.expires_at, "2026-12-04T00:00:00.000Z");
});

test("lifetime/promo without expiry → granted, null expiry", () => {
  const row = rowFromSubscriber(A, {
    subscriber: { entitlements: { zebras: { expires_date: null } } },
  }, now);
  assert.equal(row.granted, true);
  assert.equal(row.expires_at, null);
});

test("no entitlement (never bought / revoked) → not granted", () => {
  const row = rowFromSubscriber(A, { subscriber: { entitlements: {} } }, now);
  assert.equal(row.granted, false);
  assert.equal(row.expires_at, null);
  assert.equal(rowFromSubscriber(A, null, now).granted, false);
});

test("unparseable expiry expires rather than lasting forever", () => {
  const row = rowFromSubscriber(A, {
    subscriber: { entitlements: { zebras: { expires_date: "garbage" } } },
  }, now);
  assert.equal(row.expires_at, "1970-01-01T00:00:00.000Z");
});

test("safeEqual", () => {
  assert.equal(safeEqual("Bearer abc", "Bearer abc"), true);
  assert.equal(safeEqual("Bearer abc", "Bearer abd"), false);
  assert.equal(safeEqual("Bearer abc", "Bearer abcd"), false);
  assert.equal(safeEqual("", "x"), false);
});

// --- consumables -----------------------------------------------------------

const purchase = {
  type: "NON_RENEWING_PURCHASE",
  app_user_id: A,
  product_id: "zebrapace.credits.pack",
  transaction_id: "2000000123",
  environment: "SANDBOX",
  purchased_at_ms: Date.parse("2026-11-21T12:00:00Z"),
};

test("credit pack purchase → record with credits", () => {
  assert.deepEqual(consumableActionFromEvent(purchase), {
    action: "record",
    transactionId: "2000000123",
    userId: A,
    kind: "credits",
    productId: "zebrapace.credits.pack",
    credits: CREDIT_PRODUCTS["zebrapace.credits.pack"],
    environment: "SANDBOX",
    purchasedAt: "2026-11-21T12:00:00.000Z",
  });
});

test("sponsor purchase → record with no credits", () => {
  const a = consumableActionFromEvent({ ...purchase, product_id: "zebrapace.sponsor.year" });
  assert.equal(a?.action, "record");
  if (a?.action !== "record") return;
  assert.equal(a.kind, "sponsor");
  assert.equal(a.credits, 0);
});

test("buyer falls back to an alias when app_user_id is anonymous", () => {
  const a = consumableActionFromEvent({
    ...purchase,
    app_user_id: "$RCAnonymousID:x",
    original_app_user_id: "$RCAnonymousID:x",
    aliases: [B],
  });
  assert.equal(a?.action === "record" && a.userId, B.toLowerCase());
});

test("anonymous-only purchase is still recorded, without a user", () => {
  const a = consumableActionFromEvent({ ...purchase, app_user_id: "$RCAnonymousID:x" });
  assert.equal(a?.action === "record" && a.userId, null);
});

test("refund (CANCELLATION / CUSTOMER_SUPPORT) → refund", () => {
  assert.deepEqual(
    consumableActionFromEvent({ ...purchase, type: "CANCELLATION", cancel_reason: "CUSTOMER_SUPPORT" }),
    { action: "refund", transactionId: "2000000123" },
  );
  assert.equal(
    consumableActionFromEvent({ ...purchase, type: "CANCELLATION", cancel_reason: "UNSUBSCRIBE" }),
    null,
  );
});

test("subscriptions, unknown products and missing transaction ids are ignored", () => {
  assert.equal(consumableActionFromEvent({ ...purchase, type: "INITIAL_PURCHASE", product_id: "zebrapace.plus.annual" }), null);
  assert.equal(consumableActionFromEvent({ ...purchase, product_id: "something.else" }), null);
  assert.equal(consumableActionFromEvent({ ...purchase, transaction_id: undefined }), null);
  assert.equal(consumableActionFromEvent({ ...purchase, type: "RENEWAL" }), null);
});

test("Test Store's generic consumable grants credits outside production only", () => {
  const sandbox = consumableActionFromEvent({ ...purchase, product_id: "consumable" });
  assert.equal(sandbox?.action === "record" && sandbox.credits, 10);
  assert.equal(
    consumableActionFromEvent({ ...purchase, product_id: "consumable", environment: "PRODUCTION" }),
    null,
  );
});
