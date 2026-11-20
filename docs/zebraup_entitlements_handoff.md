# ZebraUp reads Zebras+ from Supabase

Handoff for a ZebraUp session · 2026-11-21 · follows `zebraup_supabase_handoff.md` (ZebraUp already signs in to the shared Supabase project).

## Why

Zebras+ is sold in ZebraPace through RevenueCat. A webhook copies each person's status into the Supabase table `entitlements`, so ZebraUp can honor the plan **without selling anything and without the RevenueCat SDK**. That fits ZebraUp's web version, which closes once native ZebraUp is stable (3–6 months). Native ZebraUp will switch to the RevenueCat SDK then.

This step only adds **the checkpoint**. No ZebraUp feature is paywalled yet.

## What already exists (don't recreate)

- Table `public.entitlements` (ZebraPace `supabase/migrations/010_entitlements.sql`):
  `user_id uuid`, `entitlement_id text` (`'zebras'`), `granted bool`, `expires_at timestamptz` (null = never expires), `product_id text`, `updated_at timestamptz`.
- Row-level security: a signed-in person can **select only their own row**. Nobody can write through the API, including the app.
- No row means no plan.

## Build

1. **One checkpoint.** Create `lib/services/plus_service.dart` exposing a `ValueNotifier<bool> isPlus` (or similar, matching ZebraUp's setState style). Every screen asks it and nothing else; no screen queries `entitlements` directly.

2. **Fetch:**
   ```dart
   final row = await Supabase.instance.client
       .from('entitlements')
       .select('granted, expires_at')
       .eq('entitlement_id', 'zebras')
       .maybeSingle();
   ```
   Refresh on startup when signed in, when sign-in completes, and when the app becomes visible again. On sign-out, clear the cache and set `isPlus = false`.

3. **The rule (identical to ZebraPace's `PlusEntitlement.isActiveAt`):**
   ```
   isPlus = granted && (expires_at == null || now < expires_at + 7 days)
   ```
   The 7 days cover being offline over a renewal. If the row is missing or can't be read, the answer is **false**.

4. **Offline cache in its own Hive box** (for example `plusBox`): store `granted`, `expires_at` and `fetched_at`. **Not `zebraBox`**, because `ProfileIoService` exports and imports from it, and an imported file must never switch Plus on. Never include `plusBox` in export or import. When offline, decide from the cache using the same rule.

5. **The safety boundary ("no se vende el freno").** Today's safety logic must never depend on the plan: `mcas_red_flag_service.dart`, `abdominal_red_flags.dart`, `fatigue_red_flags.dart`, `headache_red_flags.dart` and `flare_detection_service.dart`. Add a test that walks their imports (relative and `package:`), including indirect ones, and fails if any of them reaches `plus_service.dart`. ZebraPace's `test/core/plus_safety_boundary_test.dart` is a ready model; copy it and change the file lists. Also include a check that the walker really follows imports, so the test can't pass vacuously.

6. **UI (minimal):** in Ajustes → Cuenta Zebras, under the signed-in email, one line: "Zebras+ activo" when on. Don't sell or link to purchasing from ZebraUp yet. Ask Paulina whether to mention that Zebras+ comes from ZebraPace.

7. **Strings:** es (template), en, zh and zh_TW; run `flutter gen-l10n`.

## Notes

- On the web, the cache lives in the browser, so a determined person could edit it to unlock views locally. That's acceptable for display-only features. Anything that costs money (cloud AI credits) is checked server-side in an Edge Function, never on the client.
- Business plan §4.2 also applies here: charge for the view, not the data. Everything stays recorded; if the plan lapses nothing is deleted, the deeper views just hide, and export stays complete.

## How to check it worked

- `flutter analyze` and `flutter build web` are clean, and the boundary test passes. It should also fail when you temporarily import `plus_service.dart` from a red-flag service; remove the import afterwards.
- Once the webhook is live: buy in ZebraPace (Test Store or sandbox), sign in to ZebraUp with the same email, and see "Zebras+ activo".
- Sign out: it turns off immediately.
