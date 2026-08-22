# 🦓 ZebraPace: The 1% Journey #

ZebraPace is a compassionate, pacing-focused health and fitness tracker designed specifically for individuals managing Ehlers-Danlos Syndromes (EDS), Post-Exercise Malaise (PEM), Dysautonomia and comorbidities.

Traditional fitness apps rely on linear progression, streaks, and pushing limits—which can actively harm patients with chronic, cyclical conditions. ZebraPace flips the script. It operates on the philosophy of Atomic Habits (the 1% rule) and actively celebrates rest, maintenance, and listening to your body.

## ⚕️ Before anything else ##

ZebraPace is **not a medical device** and does not diagnose or treat anything. It is **not a substitute** for your doctor, physical therapist, kinesiologist, or other care providers — please keep making those decisions with them, not instead of them. The app shows this same disclaimer on first launch, and it's always reachable again from Settings → About.

## ✨ Core Features & Philosophy ##

The "Spoon" Battery Graphic: A visual representation of your daily energy capacity (based on "Spoon Theory"), derived from last night's sleep duration and quality — an immediate, visual reminder to pace yourself on low-energy days. It's informational only: it never changes your step goal or caution line, which stay deliberately steady regardless of any single day's signal.

Sleep & Recovery Tracking: Recognizing that sleep is the primary driver of recovery for dysautonomia and connective tissue repair, the app tracks sleep duration, quality, and heart rate range as their own dedicated log, separate from — but visible alongside — your daily pacing.

The 1% Rule & PEM Protection: The app calculates your 7-day rolling average for steps/activity. It sets a gentle 1% growth goal. If you exceed your average by more than 10%, the app triggers a "Dysautonomia/PEM Precaution" alert, reminding you to hydrate, take electrolytes, and plan for a rest day.

The "3 Comfortable Sessions" Rule: Using Hampton's Hybrid Calisthenics methodology, the app tracks exercise comfort rather than just reps. You are only encouraged to move up a progression tier if you have completed the previous tier comfortably for 3 consecutive sessions.

Rest is Success: Resting is framed biologically as the time when fibroblasts repair micro-tears in connective tissue. Taking a rest day does not break a streak; it counts as a successful health intervention.

Real-World Load Tracking: Allows you to log custom activities with "Added External Weight" (e.g., carrying a heavy bag or a child) to account for the true mechanical load on your joints.

Open Liquid & Hydration Tracking: Easily track all forms of hydration, including tea, coffee, protein shakes, and electrolytes, independent of your other body metrics.

Isolated Body Metrics: Weight, height, and body fat percentage are tracked in a completely separate, dedicated section to prevent blending physical measurements with mental/pain symptom logging.

Injuries & structural events, intraday check-ins, Apple Health-sourced METs, a doctor-visit PDF report, and Face ID/Touch ID app lock round out the current feature set.

## 🚀 Running the app ##

ZebraPace is now a native **Flutter** app, targeting iOS and web, backed by a local **drift/SQLite** database — your health data stays on your device by default. (An optional, opt-in Supabase-based cloud sync for multi-device use is in progress; nothing is sent off-device unless you explicitly sign in to it under Settings → Cloud Sync.)

Prerequisites: Flutter SDK (see `pubspec.yaml` for the pinned Dart SDK constraint). For iOS you'll also need Xcode and CocoaPods; the web build has no extra native requirements.

```bash
flutter pub get
flutter run              # pick a connected device/simulator, or:
flutter run -d chrome    # run in the browser
```

`app.py` is the original Streamlit/Python prototype this was rewritten from, kept for history but no longer maintained.

## 📂 Project Structure ##

`lib/` — the Flutter app: `data/` for the drift schema and repositories, `domain/` for the pure business-logic services, `presentation/` for screens and widgets, `providers/` for Riverpod state.

`app.py` — the retired Streamlit prototype this was rewritten from.

## ☕ Support ##

ZebraPace is a personal project, built by one zebra for other zebras, and offered freely. If it's useful to you and you'd like to help keep it going, you can support it on [Ko-fi](https://ko-fi.com/paulinavl) — completely optional, no pressure.

---

Built For Zebras from a cebra.

This app is a personal case study and companion tool. It was built from the dual perspective of a patient and a developer, acknowledging that for chronic illness, doing a little is always better than pushing too hard.
