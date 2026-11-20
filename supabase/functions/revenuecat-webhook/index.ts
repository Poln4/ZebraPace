// RevenueCat → Supabase `entitlements` mirror (migration 010).
//
// RevenueCat calls this on every purchase, renewal, cancellation, expiry,
// refund and transfer. Rather than interpreting each event type, it
// re-reads the subscriber from RevenueCat's REST API and overwrites the
// row — RevenueCat's own recommendation, and it heals missed or
// out-of-order events.
//
// Deploy with JWT verification OFF (RevenueCat has no Supabase token);
// the shared secret in the Authorization header protects it instead.
//
// Secrets (Dashboard → Edge Functions → Secrets):
//   REVENUECAT_WEBHOOK_AUTH  the exact Authorization header value set in
//                            RevenueCat → Integrations → Webhooks
//   REVENUECAT_SECRET_KEY    RevenueCat secret API key (sk_…), read-only
//                            is enough
// SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY are provided automatically.

import { createClient } from "jsr:@supabase/supabase-js@2";
import { rowFromSubscriber, safeEqual, userIdsFromEvent } from "./logic.ts";

const webhookAuth = Deno.env.get("REVENUECAT_WEBHOOK_AUTH") ?? "";
const revenueCatKey = Deno.env.get("REVENUECAT_SECRET_KEY") ?? "";
const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);

const json = (status: number, body: unknown) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json" },
  });

Deno.serve(async (req) => {
  if (req.method !== "POST") return json(405, { error: "method not allowed" });
  if (!webhookAuth || !revenueCatKey) {
    console.error("revenuecat-webhook: secrets not set");
    return json(500, { error: "not configured" });
  }
  if (!safeEqual(req.headers.get("Authorization") ?? "", webhookAuth)) {
    return json(401, { error: "unauthorized" });
  }

  let event: Record<string, unknown>;
  try {
    event = (await req.json())?.event;
    if (!event || typeof event !== "object") throw new Error("no event");
  } catch {
    return json(400, { error: "bad payload" });
  }

  const userIds = userIdsFromEvent(event);
  const synced: string[] = [];
  const skipped: string[] = [];

  for (const userId of userIds) {
    const res = await fetch(
      `https://api.revenuecat.com/v1/subscribers/${encodeURIComponent(userId)}`,
      { headers: { Authorization: `Bearer ${revenueCatKey}` } },
    );
    if (!res.ok) {
      // Non-2xx makes RevenueCat retry the webhook later.
      console.error(`revenuecat-webhook: RevenueCat API ${res.status} for ${userId}`);
      return json(502, { error: "revenuecat api failed" });
    }
    const row = rowFromSubscriber(userId, await res.json(), new Date());
    const { error } = await supabase.from("entitlements").upsert(row);
    if (error) {
      // 23503: no such auth user (deleted account, or an id that never
      // was a Supabase account). Nothing to mirror; don't make RevenueCat
      // retry forever.
      if (error.code === "23503") {
        skipped.push(userId);
        continue;
      }
      console.error(`revenuecat-webhook: upsert failed for ${userId}`, error);
      return json(500, { error: "db write failed" });
    }
    synced.push(userId);
  }

  return json(200, { type: event.type ?? null, synced, skipped });
});
