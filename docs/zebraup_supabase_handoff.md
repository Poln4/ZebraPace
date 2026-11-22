# ZebraUp joins Supabase (identity only)

Handoff for a ZebraUp session · 2026-11-21 · source of truth for the shared setup: ZebraPace's `lib/providers/cloud_sync_providers.dart` and `supabase/migrations/006_delete_my_account.sql`.

## Why

One **Zebras account** shared by ZebraPace and ZebraUp. RevenueCat identifies buyers by the Supabase user id, so once both apps sign in to the same Supabase project, one Zebras+ purchase (entitlement `zebras`) unlocks both. Juntos needs the same account later.

## Scope (keep it this small)

- **Identity only.** No health data leaves the device. Hive stays the only store; export/import/wipe don't change. ZebraUp stays local-first.
- **Optional.** Everything works without an account. Sign-in sits in Ajustes, not in onboarding or the beta gate.
- **Same project as ZebraPace.** Don't create a new Supabase project. A second project would give the same person two different ids, and the shared plan would break.
- No new tables or migrations for this step.

---

## Part A: Supabase dashboard (Paulina, once)

1. **Auth → URL Configuration → Redirect URLs:** add ZebraUp's production Netlify URL (and the deploy-preview pattern if you test previews). Leave the Site URL as it is.
2. **Auth → Email Templates → Magic Link:** confirm the template shows `{{ .Token }}` (ZebraPace already depends on it). The template is shared by both apps, so make the wording say "Zebras" rather than one app's name.
3. **Auth → SMTP:** Supabase's built-in email has a very low hourly limit, and two apps now share it. Set up custom SMTP (for example Resend) before inviting testers.

## Part B: ZebraUp code (hand this to Claude in the ZebraUp repo)

1. **Dependency:** `flutter pub add supabase_flutter` (ZebraPace uses `^2.17.2`).

2. **Config:** create `lib/config/supabase_config.dart`. These values are public client config; RLS protects the data, so committing them is fine:
   ```dart
   class SupabaseConfig {
     static const url = 'https://jclbxpnixzlmzpkqzvcb.supabase.co';
     static const anonKey = 'sb_publishable_PSWSpE1cRyhR53rcXk4sqw_HSWI8Pa6';
   }
   ```
   Never put the database password, service-role key or any secret key in the app.

3. **Init:** in `main.dart`, after `Hive.initFlutter()` and before `runApp`:
   ```dart
   await Supabase.initialize(url: SupabaseConfig.url, publishableKey: SupabaseConfig.anonKey);
   ```
   supabase_flutter keeps the session itself (in localStorage on web). Don't copy the session or the email into Hive.

4. **Sign-in UI: a "Cuenta Zebras" section in `AccountDataScreen`** (Ajustes → Mis datos). It can be its own `StatefulWidget` built on `Supabase.instance.client.auth.onAuthStateChange`, because it doesn't need `main_screen.dart`'s plumbing.
   - **Signed out:** email field → "Enviar código" calls
     `auth.signInWithOtp(email: email)`, then an 8-digit code field → `auth.verifyOTP(email: email, token: code, type: OtpType.email)`.
   - **Code first, link second.** On iPhone, an emailed link always opens Safari, and an installed home-screen PWA keeps its storage separate from Safari's, so a session made by the link never reaches the installed app. Typing the code avoids that. The link can stay in the email for desktop users.
   - **Signed in:** show the email, "Cerrar sesión" (`auth.signOut()`), and "Eliminar cuenta" (step 5).
   - Show loading and error states (wrong or expired code, no connection), and explain plainly what the account is for: one Zebras+ plan for both apps; your health data stays on this device.

5. **Delete account:** call the existing `rpc('delete_my_account')`, then `auth.signOut(scope: SignOutScope.local)`. Confirm first, and say clearly that **this deletes the shared Zebras account, including in ZebraPace** (its challenge memberships too). Data on this device is untouched. No migration is needed: the function only acts on `auth.uid()`.

6. **"Borrar todo" (wipe all):** decide with Paulina whether it also signs out. Suggested: yes, sign out locally but don't delete the account.

7. **Strings:** add them to `app_es.arb` (the template), `app_en.arb`, `app_zh.arb` and `app_zh_TW.arb`, then run `flutter gen-l10n`.

8. **Docs:** update ZebraUp's `CLAUDE.md` (stack: Supabase Auth, identity only) and the privacy policy. ZebraUp now stores an email address in Supabase, shared with ZebraPace.

### How to check it worked

- `flutter analyze` and `flutter build web` are clean.
- In the installed PWA on an iPhone, sign in with the code, close and reopen the app, and confirm you're still signed in.
- Sign in to ZebraPace with the same email. Supabase → Authentication → Users must show **one** user, not two.
- Delete the account from ZebraUp; ZebraPace's session should stop working on its next refresh.

---

## Part C: later, not in this step

**The web versions are temporary.** Both apps drop their web version once the native apps are stable (estimated 3–6 months from 2026-11-21). So:

- **No RevenueCat Web Billing in ZebraUp.** ZebraUp sells Zebras+ only once it's native, through App Store/Play in the same RevenueCat project, with its own `appl_…` / `goog_…` keys. Configure with `appUserID` = the Supabase user id and require sign-in before buying, same as ZebraPace.
- **Accounts made now carry over** to native ZebraUp. Sign-in by code keeps working natively; a deep link can be added then.
- **Before the web closes:** give testers notice and a clear export → import path (Hive data in the browser can't move to the native app by itself), and remind them to create an account if they want the free year.
