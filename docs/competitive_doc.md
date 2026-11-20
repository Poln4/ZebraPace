# Competitive Analysis: 16 mHealth Apps + 1 Official Registry

**Version 3.2 · 21 November 2026.** Adds Hypermobile (app #17), refreshes
prices checked on 21 November 2026, and corrects ZebraUp's own
position to match the November 2026 business model (optional
account and sync, Zebras+ plan). See the update log.

Consolidated from five source analyses (an original 12-app matrix,
a 9-app deep review with critical caveats, a 3-app supplement on
Clarity DTX / MedM / Welltory, a dedicated analysis of The Zebra
Project — the EDS Society's official registry app, and a review
covering Fatigue Fighter / Kalpa / MCAS Insight alongside deeper
verification of Cara Care, MedM, Welltory, Guava, ClarityDTX, and
TZP). All source material is Paulina's own; this document
structures it for reference and adds explicit mapping to ZebraUp
design decisions.

The Zebra Project (TZP) is qualitatively different from the other
15 apps analyzed: it is a longitudinal research registry, not a
daily tracker. It's included as app #16 because the EDS Society's
authoritative position makes it central to understanding ZebraUp's
positioning — as a complement, not a competitor.

---

## Purpose

Justify ZebraUp's architectural decisions by anchoring them in real
patterns and anti-patterns observed in existing apps:

- Where ZebraUp is doing something novel (competitive differentiator)
- Where ZebraUp is adopting a proven pattern (adoption)
- Where ZebraUp is deliberately avoiding a known-bad pattern (anti-pattern)

Target audience: Paulina + potential collaborators, testers, or
future funders who need to understand what ZebraUp brings to the
space.

---

## Methodology: the 4-dimension framework

Each app was reviewed across four dimensions:

1. **Modelo de evento** — schema-open vs closed; typed events;
   severity; detail layers; vault management
2. **Acción post-evento** — medication tracking; non-medication
   actions; effectiveness capture; clinical export; rescue vs basal
3. **Baseline fluctuation vs acute event** — energy envelope; pacing;
   flare/crash mode; check-in structure
4. **Modelo de negocio** — freemium/subscription/DTx/B2B; pricing;
   data monetization; provider tier

---

## Executive summary

**Key gap identified across all 16 daily-tracker apps**: no app
natively implements post-symptom prompting linked to action taken
with structured effectiveness capture and timing. ClarityDTX claims
to (in marketing) but with major credibility issues (see
anti-patterns). This is ZebraUp's primary architectural opportunity,
addressed by Sprint F.

**Hypermobile: EDS Joint Tracker** (app #17, added November 2026) is
the first daily tracker found that is both EDS-specific and fully
on-device (no accounts, no servers). It removes "local-first" and
"no serious EDS daily tracker exists" as ZebraUp differentiators.
It does not describe an action→effectiveness follow-up, and its PDF
reports and full history are paid.

**EDS Society + Guava (October 2026)**: the Society is discontinuing
the tracker inside its official app and sends users to Guava Health,
with an in-app transfer of tracked data. The research registry (DICE,
on REDCap) continues separately. Guava is now the Society-endorsed
daily tracker, which makes it ZebraUp's most important competitor —
see the update note under app #16.

**The Zebra Project (TZP)** — the 16th entry — occupies a different
category entirely: it is the EDS Society's official longitudinal
research registry, not a daily tracker. TZP captures structured
clinical baseline and periodic reassessment for research; it
explicitly does not do daily granular tracking. **ZebraUp complements
TZP rather than competes with it** — a patient could use TZP for
research contribution + baseline clinical documentation and ZebraUp
for daily "what works for me?" pattern discovery.

**Two philosophical camps in event modeling** (among the 12 daily
trackers):
- **Schema-open radical** (Bearable, Folia, Chronic Insights, Guava) — user creates categories
- **Schema-closed condition-specific** (Cara Care, Flo, Visible, MCAS apps) — curated lists per condition

For multimorbidity populations (EDS + POTS + MCAS), Guava and Folia
are the closest structural referents to ZebraUp; Visible is the
obligatory reference for energy envelope / baseline modeling; TZP
is the authoritative reference for standardized clinical scales
integration (PHQ-9, GAD-7, FIQR, Rand-36).

**Business model archetypes**:
- Freemium B2C with subscription (Bearable, Chronic Insights, Welltory, Visible)
- Free-to-user + B2B/DTx revenue (Folia, ClarityDTX, Cara Care as DiGA)
- Hybrid (Guava, Wave, MedM) — freemium consumer + enterprise SaaS
- **Nonprofit official registry** (TZP) — free, research-funded, indirect data monetization via research grants

---

## The apps

### 1. Bearable

**Modelo de evento**: Schema-open radical — probably the most
customizable app in the set. User creates emotions, symptoms,
symptom groups, health measurements, factors, habits, goals,
experiments, foods, and medications using own terms and even emojis.
Multiple typed events (Mood/Emotions, Symptoms, Sleep, Energy,
Medications, Nutrition, Bowel Movements, Custom Ratings, Health
Measurements), with "Factors" as a separate correlational stream.
Severity per symptom (severity + frequency); explicitly rejected
VAS 0-10 for daily symptoms to reduce brain-fog fatigue in
multi-comorbid patients.

**Acción post-evento**: Medication tracked as a parallel independent
event, not relational. No post-symptom prompt. Effectiveness is
inferred statistically (retrospective "Effect on Symptom" report,
premium "same day effect"). No native distinction between rescue
and basal medication — users force it via manually-named custom
groups. Non-medication actions captured via "Factors" (rest,
cold/heat, meditation) as binary or scaled variables.

**Baseline vs acute**: No formal distinction. All logging via the
same daily check-in. No energy envelope / pacing / battery concept.
No flare mode — interface identical during crises, criticized by
users with severe fatigue.

**Modelo de negocio**: Freemium B2C. Generous free tier (unlimited
symptom/factor/medication tracking, weekly reports). Premium
US$34.99/year (frequently discounted to ~US$19/year) unlocks
advanced correlations, extended history, wearable cross-integration,
full clinical export. Account required; data stored in an encrypted cloud; explicitly does not
sell aggregate research data. Reviewed by Cedars-Sinai clinicians.
No provider tier; "Bearable Heroes" scholarship program instead.

---

### 2. Visible

**Modelo de evento**: Schema-closed / condition-specific for ME/CFS
+ Long COVID. Structured around guided morning/evening check-ins,
not a free vault. Tracks HRV (phone camera or armband), sleep
quality (1-5), symptoms, crashes, cycle, free-text notes. Central
metric is the algorithm-derived "Stability Score" (1-5), not
subjective symptom severity per event. No detail layers for symptom
location or quality — deliberate to protect user energy.

**Acción post-evento**: Medication tracked but not causally linked
to symptoms. Non-medication action framework IS the intervention:
rest and pacing themselves. No "did it work?" prompt; effectiveness
seen indirectly via stability score impact and next-day crashes.
No rescue/basal distinction.

**Baseline vs acute**: Category-defining. Explicit baseline
(Morning Stability triangulating HRV + RHR + sleep quality against
90-day moving baseline) vs acute (dedicated crash tracking). The
sector reference for **energy envelope** via the "PacePoints"
system — a battery budget consumed by activities. No simplified
flare mode UI because the base app already requires <60 seconds of
interaction assuming chronic energy deficit.

**Modelo de negocio**: Freemium + hardware. Free tier: check-ins,
Trends, HRV via camera. Membership US$19.99/month or US$179.88/year
unlocks all-day PacePoints (requires Visible Band 2.0 armband, MSRP
US$99.99, promo ~US$79.70). Research partnerships (Imperial
College London, anonymized ME/CFS + Long COVID data with opt-in).
No provider dashboard. HSA/FSA eligible in US.

---

### 3. Guava Health

**Modelo de evento**: Schema-open with deep structure — closest
architecturally to ZebraUp. Multiple typed events (Symptoms,
Medication, Body Measurements, Daily Habits, EHR records). Symptoms
severity + frequency + duration. Best detail layers of the set:
**interactive 2D body heat map** for symptom location/radiation/
frequency. Vault is expansive and AI-assisted — automated CCDA/HL7
extraction from medical portals (Epic, MyChart, Cerner across
50,000+ providers), plus voice NLP via Guava Assistant to catalog
unstructured text into standardized metrics.

**Acción post-evento**: Medication as architectural pillar —
schedules, inventory (refill alerts), pin-symptoms-in-reminders for
PRN meds. Vault combines user entries with prescription database
integration. Non-medication actions captured broadly via biosensor
integration (Apple Health, Dexcom, Oura). Effectiveness via
correlational AI, not immediate prompt. Clinical export ("Visit
Prep Summary") is a core feature and free.

**Baseline vs acute**: No pacing framework. Continuous wearable
data provides passive baseline. No explicit flare mode but supports
offline logging. AI correlates atypical days with baseline data.

**Modelo de negocio**: Unusually generous freemium. Free:
unlimited symptom/med/cycle/food/activity tracking, EHR sync,
wearable sync, correlations, clinical export in 20+ languages.
Premium US$8/month or US$78/year unlocks Emergency Card, auto
insights, unlimited family profiles, lab result auto-detection,
Guava Assistant AI, Photo AI. **Provider Dashboard** for functional
medicine/concierge doctors at US$60/month per patient. HIPAA
compliant; does not sell data; no ads. VA-approved app.

**Note on family profiles as premium**: Guava's paywall on
"unlimited family profiles" is an anti-pattern for pediatric and
multi-observer chronic illness populations where caregiver
reporting is diagnostically essential. See
`docs/design_decisions/multi_observer_profiles.md` for ZebraUp's
counter-position.

---

### 4. Cara Care

**Modelo de evento**: Schema-closed condition-specific (GI/IBS/
Rome IV). Four typed events: Nutrition, Symptoms, Stools,
Medication. Rejects VAS 0-10 for stools; uses **Bristol Stool Scale
(Types 1-7)** plus textual categories. Detail layers hyper-specific:
abdominal pain includes laterality, quality (throbbing, dull),
bloating descriptors. Vault built on preconfigured nutritional
database (FODMAP filtering), limiting free creation to preserve
data integrity for dietary analysis.

**Acción post-evento**: Medication log is peripheral to the
nutritional core. No post-symptom prompt. Non-medication focus on
lifestyle (sleep, stress, exercise). Effectiveness not real-time;
algorithms retrospectively identify "best/worst days" by FODMAP
load vs motility (users report the algorithm occasionally returns
the same foods on best and worst days). Clinical export as PDF for
gastroenterologists. No rescue/basal distinction.

**Baseline vs acute**: Not modeled via energy pacing but via a
12-week clinical program (elimination, reintroduction,
personalization phases). Daily intensive check-in required — flare
days demand the same rigor because algorithm precision requires it.

**Modelo de negocio**: Pivoted to **DTx / DiGA** in Germany after
Bayer acquisition. DiGA certified — physician-prescribed, 100%
reimbursed by German statutory insurance. Free at the user level in
DE. Direct-to-consumer subscription in other markets (~US$89.99).
Premium includes dietitian chat + gut-brain psychological support.
GDPR/medical-grade data protection prohibits marketing sale.
Published outcome: **72.5% of completers showed clinically relevant
IBS-SSS reduction ≥50 points after 12 weeks** (RWE study).

---

### 5. MCAS Tracker (Clarity Digital Therapeutics)

**Critical caveat first**: There is no verifiable app branded
"MCAS 360". "Mast Cell 360" (mastcell360.com) is a functional
medicine **clinic** run by Beth O'Hara (MC360® method), not an app.
The closest apps in the space are "MCAS Tracker" (Clarity Digital
Therapeutics) and "MCAS Insight" (Nicholas Relstab). Both are
low-download, recent (2025), template-style products.

**Modelo de evento**: Schema-closed with pre-populated MCAS vault
sparing the patient from configuring dozens of atypical categories.
Typed events: Reactions, Environmental Triggers, Medication,
Low-Histamine Diet. Severity uses a specialized "1-10 adjacent to
anaphylaxis" scale prioritizing systemic shock. Detail layers
critical: one dietary event requires histamine level, food
freshness, preparation method. Vault allows custom triggers (VOCs,
thermal stress, hormonal cycle).

**Acción post-evento**: Architecturally one of the most sophisticated
in the set — formally distinguishes mast cell maintenance treatment
(H1/H2 blockers, DAO, stabilizers) from acute rescue (EpiPen). "MCAS
Tracker" is one of the few to explicitly claim "monitor
effectiveness" of medication (community tips document minutes-to-
relief pattern), though the UI-level implementation with structured
timing fields cannot be verified publicly. Post-reaction crash
duration is captured. Clinical exports combine H1/H2 response
curves, tryptase levels, and dietary triggers.

**Baseline vs acute**: Distinguishes histamine bucket baseline from
acute degranulation. **"Rapid capture" flare mode** — 30-second
emergency logging with voice-to-text when anaphylaxis prevents
touch interaction. This is a genuine crash mode.

**Modelo de negocio**: MCAS Tracker: freemium/subscription with
chaotic IAP (yearly US$39.99 AND US$19.99, "Premium Yearly" US$29.99,
"easy pass" US$7.99, "flex pass" US$4.95 and US$18.99, etc.) —
signature of A/B tested subscription mill. Part of a portfolio of
30+ template apps by same developer. MCAS Insight: US$0.99 flat, 1
rating, boilerplate copy. **Neither has significant user
validation.** Conclusion: **the MCAS niche has no serious
consolidated competitor and is an open space ZebraUp could capture**.

---

### 6. Flo

**Modelo de evento**: Schema-closed curated. 16 trackers with 80+
predefined symptoms/events. Cannot create custom entities. Recently
introduced detail layers for PMDD, endometriosis, PCOS diagnostics.
Severity mostly presence/absence.

**Acción post-evento**: Superficial vs chronic-illness needs. No
post-symptom effectiveness prompt. Tracks predefined non-medication
actions (water, sleep). Algorithm prioritizes future prediction
based on cycle phases. Clinical report rudimentary.

**Baseline vs acute**: "Baseline" is hormonal cycle phase.
Predictive not reactive.

**Modelo de negocio**: **Aggressive freemium with a critical
privacy history.**
- **FTC final order 22 June 2021** ("FTC Finalizes Order with Flo
  Health, a Fertility-Tracking App that Shared Sensitive Health Data
  with Facebook, Google, and Others") — required affirmative consent
  before data sharing after Flo shared intimate data despite privacy
  promises.
- **Frasco v. Flo Health class action settled 31 July 2025 for
  US$56M total** (US$48M from Google, US$8M from Flo).

Current Flo declares no data sale + ISO certifications post-
settlement; reputation permanently damaged. Especially sensitive
for zebra population. Massive scale: 460M+ downloads declared,
~70M MAU (Nov 2024); Business of Apps (2026) estimates ~77M active
and ~5M paid subscribers. Premium ~US$40-45/year. **This is the
anti-model.**

---

### 7. Folia Health

**Modelo de evento**: Schema-open highly dynamic, built by/for the
rare-disease community (Lupus, CF, arthritis). Rejects mandatory
rigidity: each symptom's scale is user-defined (0-5, yes/no, count,
free text tags). Adaptive personalizable detail layers. Multi-day
tracking (log a range of days at once — useful for brain fog).
Vault gives patient total control to model own metrics if platform
lacks terms for orphan diagnosis. Supports 100+ conditions.

**Acción post-evento**: **Architecturally distinguishes at the
database level between scheduled (preventive) and PRN (as-needed /
rescue) medications.** Non-medication captured with direct linkage
to reaction patterns. When logging a flare, flow prompts user to
simultaneously capture suspected trigger and applied treatment.
Clinical export is a key pillar — designed for reports readable in
"10 seconds" presenting scheduled adherence + PRN interventions in
the same graphical frame ("Appointment Guide" developed with
clinicians).

**Baseline vs acute**: Clear architectural separation. Baseline
via Weekly Snapshot revealing insidious patterns (fatigue,
cognitive dysfunction). **Curated flare mode configurations
adapted to specific pathologies** (Lupus, PNH). Additional
**"Caregiver mode"** for family members to record when severity
incapacitates primary patient.

**Modelo de negocio**: **The most distinctive model — completely
free without premium tiers, without paywalls, without hidden
usage limits.** No advertising. Sustains via Real World Evidence
(RWE) B2B — partnerships with pharma (Novartis) for orphan drug
development observational studies; has informed FDA discussions
and guidelines. **Series A of US$10.5M closed 1 October 2025**,
led by S3 Ventures with Crosslink Capital and Create Health
Ventures. Explicit opt-in for anonymous studies. Via **"Data
Dividends" program**, company pays users economic dividends (US$4/
month = up to US$48/year, in gift cards, for tracking at least
weekly). Radical transparency: user sees which studies use their
data and can withdraw. Data dividends currently active for eczema
and PNH; expanding to lupus and sickle cell in 2026.

---

### 8. Chronic Insights

**Modelo de evento**: Schema-open with highest analytical
sophistication. Developed by patient (spoonie with axial
spondyloarthritis). Typed events: Symptoms, Factors, Medication,
Weather, Body Measurements, Clinical Tests, Questionnaires (BASDAI,
BASFI, FIQR). Detail layers are the biggest technical differentiator:
**"paint in 3D"** on interactive 3D anatomical model to delineate
exact topography, radiation, severity of multiple concurrent pains
in different colors. Severity offers **two selectable modalities
per symptom**: discrete (bar charts) for episodic like migraines,
continuous (line charts) for uninterrupted baseline pain — **the
cleanest architectural distinction in the set for episodic vs
continuous symptoms**.

**Acción post-evento**: Exhaustive medication tracking (mg,
fractions like ½, ¼). Non-medication factors broad (dietary,
climate). Effectiveness via graphical analytical overlay, not
prompt. Discrete symptoms as bar charts vs continuous lines makes
correlations visible. Clinical export criticized by users for not
including all data types/notes — the export failure is a real
weakness.

**Baseline vs acute**: **Resolved architecturally at the
visualization type chosen in the vault.** Severe episodic attack →
discrete capture (bar chart). Underlying systemic malaise →
continuous fluctuation (line chart). Simplified crash-mode
captured via a **companion smartwatch app (Wear OS, Apple Watch)**
allowing critical logging from the wrist.

**Modelo de negocio**: Independent freemium, ethically clean. Free
tier very generous (unlimited symptoms, vitals, medications,
factors, charts, PDF export, cloud backup via user's own Dropbox/
Google Drive/OneDrive, no ads). Premium ~US$24.99/year for 3D pain
map, weather integration, smartwatch companion. *Price check 21
Nov 2026 (US App Store): annual US$30.99, monthly US$4.99.* Developer donates
**10% of subscription revenue to chronic illness charities selected
by user within the app**. **Says it collects zero health data,
does not sell data, no trackers.** *Note (21 Nov 2026): its App
Store privacy label lists "Data Not Linked to You", which means
some data is collected but not tied to identity — not strictly
zero.* Highly responsive to community
suggestions.

---

### 9. Wave Health

**Modelo de evento**: Moderate schema-open. Originated in oncology
toxicity tracking (chemoWave, TTI Inc), extended to autoimmune. User
selects symptoms/conditions or adds own. Severity via **"Condition
General" scale (0-100)** plus individual symptom impact scores
(0-10). Simple 5-level intensity scale (users request 1-10 in
reviews). Bristol Stool Scale for bowel. No body map / 3D. User
adds symptoms/conditions but sometimes app's condition list is
incomplete (e.g., MS, microscopic colitis missing) blocking setup.

**Acción post-evento**: Medication tracking robust — timers,
adherence (taken vs missed). Non-medication broad (hydration,
mindfulness). Effectiveness via "My Insights" (AI correlation). No
immediate prompt. Clinical export ("My Reports") is a premium PDF
consolidator aligning medication adherence with symptom graphs +
biometrics. Does not distinguish rescue/basal at interface level.

**Baseline vs acute**: Focus on routine scheduled logging.
"Condition Shift" daily metric. No pacing framework. No dedicated
flare mode; crises registered as high peaks in conventional logs.

**Modelo de negocio**: Hybrid B2C freemium + B2B. Consumer app free
in base features. **"My Reports" AI-powered PDFs behind Wave Pro**
US$10.99/month or US$54.99/semester after 30-day trial. Institutional
"Wave Health Care Portal" B2B for clinics/hospitals at
~US$70/month per patient integrating ePROs. #1 ePRO app for cancer
per Cedars-Sinai review. **Alert**: third-party analysis
(JustUseApp) flagged low legitimacy based on reviews; user reports
of data loss and crashes.

---

### 10. ClarityDTX (Disautonomia/POTS/EDS/Fibro Suite)

**Structural context**: ClarityDTX operates a portfolio of
**condition-specific apps** — mental health (ADHD, anxiety, bipolar,
BPD, depression, OCD, PTSD, insomnia, EDs), autoimmune (lupus, MS,
eczema, EDS, MCAS, Hashimoto, arthritis), chronic pain/fatigue
(ME/CFS, fibromyalgia, migraine, Lyme), women's health
(endometriosis, IVF, PCOS, PMDD), metabolic/neurological (POTS,
autism, generic "chronic illness tracker"). Positioning identical to
ZebraUp's: "instead of building one app for everyone, we design
purpose-specific tools for each condition." **Conceptually the
closest competitor to ZebraUp of the 12 analyzed.**

**Modelo de evento**: Schema-closed dirigido, pre-populated per
condition. Severity uses evidence-based clinical scales (VAS 0-10
for pain, PHQ-9 for psychological comorbidities, FACIT for fatigue).
Diagnostic-grade detail layers: POTS app requires cardiovascular
parameters at 1/3/5/10-minute standing intervals; EDS documents
subluxations per articular region.

**Acción post-evento**: **Proactively supports post-event prompts to
delineate real response curves** — requires patient to rate symptom
severity before medication, then triggers a questionnaire 30-60 min
after intake to track onset, peak, duration. Non-medication measures
specialist-required (mg salt intake + fluids for POTS, structured PT
for EDS). Clearly differentiates basal therapies from acute rescue.
Clinical export superimposes treatment adherence, rescue timing,
symptom frequency — optimized for specialist protocol. **This is
the only app in the set explicitly claiming the effectiveness-with-
timing pattern that ZebraUp targets.**

**Baseline vs acute**: Fundamental to architecture. Energy-limiting
pacing tools via Spoon Theory for fibromyalgia + ME/CFS variants.
Baseline via barometric pressure + orthostatic biometrics. Acute
events have dedicated rapid-crisis modules (EDS dislocations, POTS
orthostatic attacks). Algorithm alerts rheumatologists to **"48-
hour PEM lag"** in fibromyalgia, connecting elevated baseline load
from 2 days ago to current crash.

**Modelo de negocio**: DTx institutional network — inverts consumer
model. Each consumer app "Free to download" without paywalls on
reports or subscription walls. Revenue via B2B — clinical
consortiums, hospitals, associations for continuous care monitoring
programs ingesting ePROs into medical workflows. Offline logging
without forced account creation. Encryption AES-256; explicit
non-monetization to third parties.

**BUT — major credibility issues** (documented in supplement analysis):
- App has chaotic paywall SKUs (yearly US$39.99 AND US$19.99,
  "Premium Yearly" US$29.99, "easy pass" US$7.99, "flex pass"
  US$4.95 and US$18.99, etc.) — signature of A/B tested subscription
  mill.
- **Website claims "5.0/5 from 464 reviews"; US App Store shows 4.4
  with only 5 ratings**. Discrepancy documented.
- **Privacy policy vs App Store label conflict**: website states
  "we never sell or share your personal information", but App Store
  label declares data linked to identity — including Health and
  "Sensitive Info" — with purposes including "Developer's
  Advertising or Marketing" and analytics with User ID + Device ID.
- Portfolio replicated across 30+ conditions without verifiable
  clinical depth per condition.
- *Check 21 Nov 2026*: the generic "Chronic Illness Tracker" still
  sells passes from US$4.95 to US$34.99; the MCAS Tracker listing
  still says data is linked to identity, with offline logging and
  cloud backup. Pattern unchanged.

**Reading for ZebraUp**: the idea is market-validated, but the
credibility bar a patient-developer can set (local-first, no data
marketing, radical transparency) is a defensible differentiator
precisely because Clarity fails it.

---

### 11. MedM Health

**Modelo de evento**: Not a symptom tracker — a health diary whose
competitive advantage is hardware connectivity. Auto-collects 30+
measurement types from hundreds of Bluetooth monitors. Schema-
closed strictly quantitative. Types: BP, glucose, ECG, SpO2,
spirometry, weight + body composition, temperature, HR, HRV, sleep,
activity, water intake, stress level, medication intake, and "Note"
(only free-text schema-open channel). Severity does not apply —
everything is physical magnitude with units. Users complain of
rigid catalog: premium user reports no food diary with macros/
nutrients, only total calories field, blocking use as sole app.

**Acción post-evento**: "Medication Intake" as independent event
type with reminders. No symptom→medication linkage because no
symptom events exist. No post-event prompt. Non-medication actions
limited to measurable (exercise, sleep, water). Effectiveness does
not exist. Clinical export as PDF/XLSX premium, CSV free. No
rescue/basal distinction.

**Baseline vs acute**: No conceptual distinction — everything is
time-series of vitals. No acute event, no energy envelope, no
flare mode. MedM occupies the pure "instrumented objective
baseline" extreme of the spectrum, without subjective layer.

**Modelo de negocio**: **Honest legible freemium** (strong contrast
with Clarity). Free: unlimited device collection, manual entry, no-
registration/offline mode, backup for registered users, medication
+ measurement reminders, configurable dashboard, history/trends/
charts, CSV export, 2-week Premium trial. Premium: family
records + pets, ecosystem sync (Apple, Google, Samsung, Fitbit,
Garmin), remote monitoring via app or portal, threshold
notifications, printable PDF/XLSX reports. Prices (US App Store):
Lifetime US$99.99; one-time 1mo US$5.99, 3mo US$15.99, 6mo US$25.99;
promo month US$1.99. **The real business is B2B**: MedM is a
white-label RPM (remote patient monitoring) platform capturing 16
physiological data types from 800+ sensor models, with patient
apps, middleware hub, cloud repository, clinical dashboard, EHR/
EMR integration APIs. Consumer B2C subsidizes/feeds the B2B
infrastructure. Data never sold; AES encrypted; MedM Health
classified as Patient Data Management System under EU medical
device directive.

---

### 12. Welltory

**Modelo de evento**: Inverts the paradigm — instead of patient
reporting how they feel, measures autonomic nervous system (HRV via
phone camera PPG or Apple Watch) and computes how the body is.
Positioning: "see what's draining your energy and stop it before it
drains your day". 17M users. Actively courting POTS/dysautonomia
audience. Hybrid: typed physiological measurements + open tags for
subjective context. No formal symptom vault; **free tags** fulfill
that function without structure — leading to uncontrollable tag
accumulation (users complain in App Store). Severity computed by
algorithm (Health, Battery, Stress scores) not reported — opacity
cost.

**Acción post-evento**: Medication practically absent as first-
class citizen. No medication vault, no post-symptom prompt, no
rescue/basal taxonomy. Closest analog: tag a measurement with drug
name. **For ZebraUp's Dimension 2, Welltory confirms the market gap
from the opposite extreme.**

**But — the "Experiments" pattern is the most valuable concept for
ZebraUp**: measure HRV → do breathing exercise → tag it → measure
again → Welltory analyzes the connection. **Effectiveness capture
post-action measured physiologically instead of self-reported —
objective pre/post with implicit timing.** Also offers acute
recommendations (panic attacks).

**Baseline vs acute**: Core identity, objective parallel to Visible.
Battery reflects energy left before sleep (activities that raise HR
drain, rest recharges). Explicit personal baseline compared against
own data not generic norms — exactly the principle underpinning
ZebraUp's baseline modeling. Daily check-in structural (Morning +
Evening reports over 30 days). No simplified flare mode UI. But
anticipatory value real: lupus user describes it as **"weather
report for your body"**; hEDS + fibromyalgia user credits daily
battery forecast for forcing her into pacing.

**Modelo de negocio**: Freemium with a **serious dark pattern for
chronic patients**:
- 3-day (72h) Premium trial after first measurement
- Free tier after trial: 1 HRV measurement/day with only 5 basic
  metrics instead of 21, simplified reports, experiments disabled,
  and — **critically — history limited to 30 days: anything older is
  deleted unless exported first**
- For a chronic patient documenting longitudinally, **free-tier
  history deletion is the most hostile anti-pattern of the 12 apps
  analyzed**
- Premium: unlimited, 21 HRV metrics, all history, AI coach.
  US$8.99/month cited; annual/lifetime in constant promotion (141+
  discount codes tracked in one year, up to 75% off)
- Data + ads: no ads, sole revenue from subscriptions, no sale/
  sharing, HIPAA/GDPR, export + account deletion on demand
- **Formal research tier**: partnerships with 30+ universities
  including UCL, Johns Hopkins, Harvard Medical School; special
  pricing for study participants
- Trustpilot complaints: auto-charge of annual plan when trying
  monthly, hidden cancellation, inconsistent scores minutes apart

**Verified 21 November 2026** (Welltory help center and App Store
listing; app not installed):
- Free-tier deletion confirmed in three help-center articles: "data
  older than 30 days is deleted. Export it in advance to avoid losing
  old data." Deleted, not hidden.
- Free tier: one HRV measurement a day, 5 metrics instead of 21.
- Apple Health, Health Connect and Samsung Health keep syncing on the
  free tier after the trial.
- Spanish added in version 4.61.0 ("Spanish, a new language Welltory
  speaks now"). Help center in English, Russian and Spanish; the full
  in-app language list was not verified.
- No yearly price on Welltory's own pages (welltory.com/pricing
  returned 404).
- **Reading for ZebraPace**: Welltory is the closest pacing referent
  that works with a phone camera or watch, and now speaks Spanish. The
  contrast that holds: ZebraPace keeps full history free and never
  deletes it for not paying.

---

### 13. Fatigue Fighter (NALS Foundation)

**Structural context**: App by the **NALS Foundation**, aimed
specifically at **adolescents dealing with chronic anxiety,
depression, and POTS (Postural Orthostatic Tachycardia Syndrome)**.
Positions primarily as a **CBT-based therapeutic intervention**
rather than a symptom tracker. Related to the WOEBOT category of
CBT chatbot apps but focused on the adolescent chronic-illness
overlap population. Different category of tool than the other 14
daily trackers analyzed.

**Modelo de evento**: Schema-closed, therapeutically-oriented
rather than event-oriented. Instead of typed symptom events,
structures interactions as guided CBT exercises. Captures mood /
anxiety states through validated instruments during structured
check-ins. No detailed symptom vault — focus is on cognitive
restructuring around symptom experience rather than pattern
detection. Includes puzzles, structured breathing exercises,
meditation modules.

**Acción post-evento**: **Non-medication actions are the
intervention itself** — breathing exercises, meditation, CBT
puzzles designed to reframe thoughts about fatigue, anxiety, POTS
symptoms. No medication tracking layer beyond potential mood/
anxiety medication logging. Effectiveness captured indirectly
through pre/post exercise state ratings (similar to WOEBOT's
mood delta tracking). Explicitly designed to reduce symptom
burden through psychological intervention rather than to log
symptoms for pattern discovery. No rescue vs basal distinction.

**Baseline vs acute**: Baseline captured through recurring mood /
anxiety check-ins. Not modeled as pacing or energy envelope —
modeled as psychological state and coping capacity. Crisis
intervention through immediate access to grounding / breathing
exercises. Approach is closer to Woebot's model than to Bearable
or Visible.

**Modelo de negocio**: **Nonprofit-funded** (NALS Foundation).
Presumably free at the user level. Backed by adolescent-focused
clinical development pathway. Data governance oriented to clinical
research ethics of vulnerable populations.

**Reading for ZebraUp**: **Different category of tool entirely —
therapeutic intervention rather than tracker.** Not competitive
with ZebraUp; potentially complementary for the adolescent zebra
population. Two design insights:
- **Adolescent population needs different modalities**. ZebraUp's
  current design is adult-oriented; an adolescent version (relevant
  for the godchild use case discussed in
  `multi_observer_profiles.md`) might benefit from CBT-adjacent
  elements or a lighter interaction model.
- **Validates the therapeutic-vs-tracking distinction**. Fatigue
  Fighter chose therapeutic. ZebraUp chose tracking. Both are
  legitimate — pretending ZebraUp does both would be scope creep
  and lose the sharp positioning.

---

### 14. Kalpa (Kalpa Care)

**Structural context**: App by **Kalpa Care**, aimed at
**autoimmune conditions** (lupus, rheumatoid arthritis, multiple
sclerosis, Hashimoto, etc.). Community-driven approach combining
symptom tracking, personalized insights, and support networks.
Positions between symptom tracker and community platform — hybrid
category that neither Bearable nor Bezzy fully occupy.

**Modelo de evento**: Schema-open with **autoimmune-condition-
specific vault suggestions**. Users track symptoms, medications,
flares, mood. Community features allow implicit comparison with
others through curated content, support groups, and shared
tracking patterns. Detail layers include autoimmune-relevant
fields (joint swelling, fatigue severity, cognitive symptoms)
but not to the depth of Cara Care (GI) or MCAS Tracker (mast
cell) for their respective specialties.

**Acción post-evento**: Medication tracking with schedules and
effectiveness reassessment (**periodic, not event-linked** —
consistent with the medication gap identified across the whole
set). Non-medication actions captured broadly (diet, exercise,
stress management). Clinical export possible but not central to
the value proposition. **Community support treated as itself an
intervention type** — users can log "reached out to community"
as a coping action, which is a design decision worth noting. No
formal rescue vs basal distinction.

**Baseline vs acute**: Daily check-in based. Flare tracking as
elevated intensity but without formal flare mode UI simplification.
**Community engagement as baseline maintenance mechanism** — a
different model than Visible's energy envelope or Welltory's HRV
baseline. Emotional / social baseline modeling is novel here.

**Modelo de negocio**: Freemium likely (specific pricing not
verified in accessible sources). Community engagement drives
retention. Autoimmune community is well-organized (established
patient advocacy groups per condition) and social sharing is a
central value proposition.

**Reading for ZebraUp**: **Community features are a legitimate
differentiator ZebraUp does NOT need to build.** Kalpa serves that
need for autoimmune-adjacent conditions; Bezzy, HealthUnlocked, and
condition-specific Discord/Reddit communities serve zebra
populations. ZebraUp can point users toward existing communities
without hosting one. Two additional insights:
- Adjacent conditions (lupus, RA, MS) share enough architectural
  DNA with EDS that a well-designed tracker can serve multiple
  autoimmune-adjacent conditions with modest per-condition
  configuration
- **Social baseline modeling** ("did reaching out to the community
  help today?") is an interesting design direction. Not planned
  for ZebraUp but worth noting as a legitimate paradigm.

---

### 15. MCAS Insight (Nicholas Relstab)

**Structural context**: **Individual developer product** (Nicholas
Relstab, listed developer on App Store). Purpose: symptom, food,
trigger tracking specifically for the MCAS community. Basic
capabilities. One of the two named MCAS-specific apps (alongside
MCAS Tracker from ClarityDTX). Analyzed briefly in the MCAS
Tracker section (app #5) as a competitive template product;
elevated to its own entry here given the MCAS niche importance
and the fact that neither MCAS Insight nor MCAS Tracker has
meaningful market share.

**Modelo de evento**: Schema-closed MCAS-specific vault. Symptom
types focused on histamine reactions (flushing, urticaria, GI,
respiratory, cardiovascular). Trigger tracking central: foods
(with histamine content awareness), environmental exposures
(perfume, cleaning products), medications (contrast, opiates,
NSAIDs). Severity capture via basic 1-10 scale (not calibrated
for anaphylaxis progression like MCAS Tracker's specialized
scale). **Not diagnostic-grade** like the ClarityDTX condition-
specific approach.

**Acción post-evento**: Basic medication tracking. No formal
rescue vs stabilizer distinction (unlike MCAS Tracker which does
attempt this). Effectiveness capture minimal or absent —
community tips document minutes-to-relief patterns but not
verified as structured UI fields. No clinical export beyond raw
data.

**Baseline vs acute**: Not modeled explicitly. Users log reactions
as they occur. No pacing or energy envelope. No formal flare mode
or rapid-capture UI for anaphylactic events.

**Modelo de negocio**: **US$0.99 flat purchase**, per App Store.
1 rating documented at analysis time. Boilerplate copy suggesting
individual-developer template product. **Not actively sustained
development** — closer to hobby project than commercial product.

**Reading for ZebraUp**: **Confirms the MCAS niche opportunity
remains fully open.** Neither MCAS Insight nor MCAS Tracker has
meaningful validation. A well-built MCAS module (Sprint E) in
ZebraUp would be architecturally and clinically superior to both.
Both existing MCAS apps together validate the demand for MCAS-
specific tracking (worth building for the population) but fail on
execution quality (worth doing right). The combined installed
base of these two apps is negligible compared to the estimated
MCAS-diagnosed and MCAS-suspected population — massive underserved
market.

---

### 16. The Zebra Project (TZP) — Official EDS Society Registry

**Structural context**: Launched around 2023 by The Ehlers-Danlos
Society. Officially positioned as a "digital longitudinal registry"
— NOT a symptom tracker in the daily-management sense. Two
audiences: patients (contributing data) and researchers (querying
anonymized data via research portal). Uniquely authoritative among
the 13 apps analyzed by virtue of being the official app of the EDS
advocacy organization. Represents the "official channel" that any
serious ZebraUp positioning must engage with, not ignore.

**Modelo de evento**: Schema-closed condition-specific for
EDS/HSD + comorbidities. Three-phase registration flow:

1. **Initial Registration & Consent** — the most comprehensive
   demographic capture of the set (gender expression, race/
   ethnicity, sex assigned at birth). Consent explicit and
   granular for research participation.
2. **Personal Health History** — comorbidities across body systems
   (rheumatological, dermatological, endocrine, gastrointestinal,
   neurological, cardiovascular, psychiatric).
3. **Personal Story** — free-text narrative about diagnostic
   journey and disability impact on daily activities.

Diagnostic criteria integrated at data-model level:
- **2017 Villefranche criteria** for hEDS
- **Beighton score** capture
- Genetic testing details when available

Symptoms captured broadly but not designed for daily granular
logging — the unit of capture is periodic health-state snapshots,
not individual event episodes.

Severity via **standardized clinical scales rather than
app-invented ones**:
- **FIQR** (Fibromyalgia Impact Questionnaire Revised) for fatigue
  and functional impact
- **Rand-36** (SF-36 adaptation) for quality of life
- **PHQ-9** for depression
- **GAD-7** for anxiety
- PTSD-related items

**Acción post-evento**: Medication tracking structured per body
system, distinguishing prescription vs OTC. Effectiveness capture
exists as **periodic reassessment**, not as an event-linked
prompt — the user reassesses their overall medication regimen at
follow-up intervals, not "did this dose work for this symptom
right now." Non-medication interventions (PT, dietary changes)
captured at protocol adherence level. Clinical export orientation
is for research contribution, not for patient's clinical visit —
anonymized data flows to the research portal, which studies
subscribe to. No rescue vs basal distinction at UI level.

**Baseline vs acute**: **Does not model this distinction. TZP is
a registry, not a tracker.** Data collection cadence is periodic
(initial registration + subsequent updates on user's own schedule),
not continuous. No energy envelope, no flare mode, no pacing
feature, no daily check-in. This is the fundamental structural
difference from every other app in the set — TZP's utility is
longitudinal for research purposes, not real-time for daily
management.

**Modelo de negocio**: Nonprofit official registry. Free at the
user level. Funded by:
- **The Ehlers-Danlos Society** (501c3 nonprofit) via donations
  and grants
- **Research partnerships** — pharmaceutical companies, academic
  institutions, and NIH-funded studies pay for anonymized research
  access to the registry (subject to patient consent)

Data monetization is indirect — patients opt into specific studies
explicitly, and the EDS Society receives research funding that
sustains the platform. Zero advertising, zero data sales to
third parties per EDS Society governance. Model architecturally
similar to Folia's data dividends but without individual dividend
payments (patients contribute to the community's research goals
rather than earning personally).

**Update — October 2026: tracker handed to Guava.** Per the
Society's page "Transfer Your Tracker Data to Guava Health" (last
updated 8 October 2026), the Society is discontinuing the tracker
feature of The Ehlers-Danlos Society App and partnering with Guava
Health. Users connect Guava from the app, review each entry (Ready /
Needs review / Not supported / Excluded) and confirm before anything
is sent. Transferable types: symptoms, medication doses, mood,
energy, weight, hydration, vitals, sleep, activity, food and drink,
bowel movements, menstrual-cycle events. Some details have no Guava
equivalent. Users can export PDF or JSON; the transfer doesn't delete
on-device data; transferred data falls under Guava's privacy policy.
No reason or end date is given.

The registry is separate and continues: the DICE EDS & HSD Global
Registry runs on the Society's own REDCap instance for research
surveys. The page does not say how much of this entry's "TZP"
description maps to the old app tracker vs the DICE registry —
re-check before quoting it.

**What it changes for ZebraUp**:
- The Society no longer runs a daily tracker; it recommends Guava.
  Guava gains the EDS community's official endorsement on top of
  already targeting POTS/EDS/MCAS.
- Guava is cloud-based and US-centric (patient-portal sync with US
  EHRs, HIPAA framing, US-priced Premium). It advertises 20+
  languages, so the gap is not interface translation alone: it is
  Latin American context (no US portals, local pricing, es-419
  clinical copy, on-device by default).
- The "complement" framing still holds, but the counterpart is now
  DICE (research surveys), not a Society tracker.
- Possible future: a JSON import from the Society app's export, for
  users who don't want a US cloud service (format not checked).

**Position vs ZebraUp — complement, not competitor**: TZP captures
the registry layer (initial baseline + periodic updates for
research). ZebraUp captures the daily/event layer that TZP
explicitly doesn't. A patient could reasonably use both — TZP for
research contribution + clinical baseline, ZebraUp for daily "what
works?" pattern discovery. Future export from ZebraUp to TZP
format would be a legitimate value-add feature (Phase 4+
consideration).

**Reading for ZebraUp positioning**:
- ZebraUp's differentiator is NOT "an app for EDS" — TZP already
  fills that authoritative slot with the EDS Society's stamp
- ZebraUp's differentiator IS "the daily action-effectiveness
  loop that TZP explicitly doesn't do"
- **Adopting TZP's standardized scale integration (PHQ-9, GAD-7,
  FIQR, Rand-36)** as optional features would give ZebraUp
  clinical rigor without competing with TZP's registry role — and
  would make future TZP export interoperable
- Ideal narrative: "ZebraUp for daily. TZP for the annual
  registry snapshot. Export from one to the other."

---

### 17. Hypermobile: EDS Joint Tracker (added November 2026)

**Structural context**: iOS/iPadOS app by an individual developer
(William Barry Agnew), listed for EDS and Hypermobility Spectrum
Disorder with optional POTS and MCAS modules. English only. Not in
any earlier version of this analysis. Source: App Store listing
(id6783487872), checked 21 November 2026; app not installed.

**Modelo de evento**: Schema-closed, EDS-specific. Daily "Today"
check-in plus a Joint Log for joint events (subluxation /
dislocation). Records how each joint event was reduced (self,
manual assist, ER). Beighton score tracking. POTS module: resting
and standing heart rate entered by hand, with automatic delta
against the +30 bpm threshold. MCAS module: reactions with
triggers, symptoms, severity.

**Acción post-evento**: Logs medications and braces in the daily
check-in, and reduction method per joint event. The listing does
not describe asking whether a medication or action helped. No
rescue vs basal distinction described.

**Baseline vs acute**: Daily check-in as baseline; joint events as
acute entries. No pacing, energy envelope or wearable connection;
no Apple Health integration mentioned.

**Modelo de negocio**: Freemium. Free: Today check-in, full Joint
Log, 30-day Insights. Premium US$5.99/month or US$39.99/year (7-day
trial on monthly): Beighton tracking, POTS and MCAS modules, full
Insights history, PDF report export.

**Privacy**: "No accounts, no servers, no analytics, no third-party
trackers"; uninstalling deletes the data; App Privacy section says
no data collected.

**Reading for ZebraUp**:
- **Local-first is no longer unique among EDS apps.** Hypermobile
  matches it — and goes further (no optional sync at all).
- **Still differentiating**: free doctor report (Hypermobile's PDF
  is Premium), full history free (Hypermobile's insights beyond 30
  days are Premium), the action→effectiveness follow-up, Android
  and web, Spanish and Traditional Chinese.
- **Anti-patterns to keep avoiding**: clinical export and long
  history behind a paywall — the same lines ZebraUp's business
  model draws as free.
- **Worth borrowing**: structured "how was it reduced" field per
  joint event; automatic orthostatic delta against a threshold.

---

## Cross-cutting observations

### Convergence in event modeling

Dominant pattern among generalist chronic-illness apps: **typed
events + user-customizable vault**. Bearable, Guava, Folia, Chronic
Insights, and Wave converge here — recognizing that no fixed list
covers chronic illness heterogeneity, they delegate ontology to the
patient. Condition-specific apps (Cara Care, Flo, MCAS niche apps)
do the opposite: curated closed lists gain logging speed and data
quality but lose flexibility.

For ZebraUp (multimorbidity population), schema-open is nearly
mandatory — but with **"starter templates" per condition** to avoid
setup paralysis suffered by new Bearable users ("too many options,
>10 min to log").

Severity has NO industry standard. Chronic Insights and Folia get
it right by allowing scale to vary per symptom (0-5, yes/no,
count, custom) — more phenomenologically honest than forcing 0-10
on everything. Bearable + Visible explicitly rejected VAS 0-10 for
daily symptoms to reduce brain-fog fatigue.

### The medication gap

**All 12 apps track medication, but nearly all model it as an
independent log statistically correlated later — not as an action
linked to the symptom that motivated it. None implements natively
the prompt "you just logged a symptom — did you take/do anything
for it?" that is central to ZebraUp's Sprint F.**

Post-action effectiveness ("did it help? much/some/none" with
timing) is essentially absent in all 12: all substitute direct
outcome with retrospective correlation (Bearable "same day
effect", Guava/Folia/Wave insights, Chronic Insights custom charts).

**Only "MCAS Tracker" and ClarityDTX claim effectiveness-with-
timing** — but with major caveats:
- MCAS Tracker's timing is documented via community tips, not
  verified as structured UI fields
- ClarityDTX declares the pattern but has documented credibility
  issues (paywall SKU chaos, privacy discrepancy, unverifiable review
  counts)

**Rescue vs basal medication distinction** — critical for migraine
(triptan vs preventive), MCAS (EpiPen/antihistamine PRN vs
stabilizer), POTS — is best resolved by:
- **Folia**: distinguishes "regimen (scheduled)" vs "PRN (as-needed)"
  at database level
- **Guava**: partial — allows PRN logging vs schedule
- **ClarityDTX**: claims formal distinction (unverified)

None labels it as formal rescue/preventive taxonomy with outcome
attached. **This is ZebraUp's largest and clearest competitive gap.**

### Baseline vs acute spectrum

With all 12 daily trackers mapped, the spectrum is:

| Position | Apps |
|---|---|
| Baseline purely instrumental, no symptoms | MedM |
| Baseline physiological computed with energy envelope | Welltory |
| Baseline self-reported + HR with formal pacing | Visible |
| Daily subjective check-in + events | Bearable, Guava, Wave |
| Flare log + self-reported baseline journal | ClarityDTX, Folia |
| Acute at data-model level (episodic vs continuous) | Chronic Insights |

**TZP is off this spectrum entirely** — a longitudinal registry
captures periodic snapshots, not daily fluctuation. Placing TZP on
this axis would be a category error.

**Vacant position in the daily-tracker space**: acute typed event
with detail layers + subjective baseline load + post-event action
with effectiveness + integrated clinical export. This is ZebraUp's
positioning.

Welltory + Visible convergence on battery metaphor validates the
concept but their coverage is HRV-driven. ZebraUp's differentiation
should not compete on pacing infrastructure but on the clinical-
documentation layer they lack. And ZebraUp does NOT compete with
TZP on the research-registry layer — different problem.

### Business model archetypes

Five clear patterns:

| Model | Apps | Trade-off |
|---|---|---|
| Freemium with free clinical export | Guava (US$8/mo), Bearable (US$34.99/yr) | User-friendly, revenue from AI/insights premium |
| Free + research/dividends monetization | Folia (US$0, pays US$4/mo dividends) | Radical transparency required; needs pharma partnerships and compliance |
| Hardware + subscription | Visible (US$19.99/mo + armband) | Depends on HRV as value proposition |
| DiGA / institutional B2B | Cara Care, ClarityDTX (partial) | Requires regulatory certification (DE-specific for DiGA) |
| Aggressive freemium at scale | Flo (US$40/yr, growing paywalls) | Ethical + reputation risks |
| **Nonprofit official registry** | **TZP** | **Free; sustained by advocacy org donations + research grants; positions app as the "authoritative" channel; requires nonprofit governance** |

For ZebraUp population (income often impacted by illness), models 1
and 2 are most congruent. Folia's data dividends with radical
transparency is especially powerful for building trust in a
skeptical zebra community — but demands serious research
infrastructure and compliance. The TZP nonprofit model is
architecturally unavailable to ZebraUp (no advocacy org sponsorship)
but its existence changes the competitive framing: **ZebraUp does
not need to be an "EDS app" because TZP already is one authoritatively
for the registry use case.**

---

## Anti-patterns explicitly avoided

### Welltory: free-tier historical data deletion

The most damaging anti-pattern for chronic illness populations. A
user tracking a decade-long illness loses everything if they lapse
from paid to free tier. **ZebraUp's local-first architecture
structurally eliminates this** — data lives on the user's device,
not on a subscription-gated cloud.

### Flo: privacy policy vs practice

Documented FTC final order (22 June 2021) and US$56M class action
settlement (31 July 2025) after sharing intimate health data with
Facebook/Google despite privacy promises. **ZebraUp's response**:
data lives on the device by default; account and sync are optional
and opt-in; no ad or analytics SDKs; cloud AI only through paid APIs
with explicit consent before any data is sent (see
`zebraup-modelo-de-negocio.md`, section 7).

### ClarityDTX: paywall opacity + privacy discrepancy

Documented app privacy label vs website claim discrepancy. Chaotic
paywall SKUs (10+ subscription variants A/B tested). Unverifiable
review claims (website: 5.0/464; App Store: 4.4/5). **ZebraUp's
approach — direct transparency about what's free, what's not (via
open code and clear documentation), no advertising integration —
directly counters this.**

### Bearable: setup paralysis

Full schema-open with no guided onboarding overwhelms new users
with brain fog (">10 min to log"). ZebraUp response: **starter
templates per condition** while preserving full customization.

### Chronic Insights: broken clinical export

Users report PDF export doesn't include all data types/notes —
fatal when the entire purpose is sharing with the physician.
**ZebraUp response: clinical export as core free feature, tested
for 100% field coverage before release.**

### Wave: data loss + crashes

Third-party analysis flagged low legitimacy; user reports of losing
entire history and crashes. **ZebraUp response: reliability of
export and data persistence are non-negotiable requirements, not
premium features.**

### Guava: family profiles behind paywall

Guava reserves "unlimited family profiles" for the US$8/month tier.
For pediatric zebra populations, this converts a diagnostic
necessity (multi-observer reporting) into a revenue lever. A
godmother, therapist, or grandparent adding observations to a
child's profile is not a "family plan bonus" — it's the clinical
mechanism by which patterns get detected. **ZebraUp response:
multi-observer profile sharing explicit free (deferred to future
sprint due to sync architecture; see
`docs/design_decisions/multi_observer_profiles.md`).**

---

## Patterns adopted or considered

### Chronic Insights: episodic vs continuous at data-model level

The bar-chart-vs-line-chart distinction per symptom is the cleanest
implementation in the set for representing acute vs baseline
phenomena. **ZebraUp equivalent**: F.E3 tag rendering distinguishes
"was rated" vs "still evolving"; future refinement should apply the
same principle to symptom rendering (episodic-visible vs
continuous-baseline).

### Folia: rescue vs basal + data dividends

Folia's PRN vs scheduled medication distinction at DB level is the
gold standard. **Adopted for**: future Sprint F.F+ MedicationType
picker (basal_scheduled / prn_rescue / both / undefined) — see
`PHASE_5_ROADMAP.md`.

Folia's data dividends model is aspirational for ZebraUp if/when
research infrastructure is built — noted but explicitly out of
scope for local-first architecture.

### Welltory: Experiments (pre/post measurement)

The concept applies to ZebraUp's Sprint F effectiveness capture, but
adapted: instead of objective HRV pre/post, ZebraUp uses subjective
severity pre/post (which is what F.E's inferred rating does — delta
between severity-before and severity-after). Timing captured via
follow-up window.

**Explicit note**: Welltory itself is disqualified as ongoing
inspiration due to free-tier deletion. We adopted the *concept*, not
the *product*.

### Guava: heat map + free clinical export

Body heat map for symptom location is the best detail layer in the
set. **Deferred**: future Sprint E MCAS could adopt for skin
symptoms (urticaria, flushing). Not yet implemented.

Guava's free clinical export sets the standard ZebraUp meets.

### Visible: pacing as clinical concept

Validation of Potato Day pacing feature comes from Visible's
mainstream success + Ruiz-Maya 2021 clinical evidence (see
`docs/eds_research_notes.md`). **Adopted**: pacing framing as
protection, not indulgence.

### ClarityDTX: post-event effectiveness prompt with timing

Conceptually validates ZebraUp's Sprint F architecture. But
executional credibility is low — **ZebraUp's opportunity is
executing the same idea with the trust bar that a patient-developer
can defensibly set.**

### MCAS Tracker: 30-second rapid capture / voice-to-text flare mode

Genuinely simplified UI for anaphylaxis. **Considered for**: future
Sprint G Flare Mode — voice-to-text option for when hands are
symptomatic (subluxation, tremor) or user is disoriented.

### Folia: Caregiver mode

Recording when incapacitation prevents primary patient interaction.
**Considered for**: future accessibility sprint after core features
stabilize.

### TZP: Standardized clinical scales

TZP integrates PHQ-9 (depression), GAD-7 (anxiety), FIQR (fatigue
+ function), and Rand-36 (quality of life) as its severity capture
layer instead of app-invented 0-10 scales. This is clinically
authoritative and makes data comparable across studies.

**Considered for**: optional premium features in ZebraUp that let
users periodically capture these standardized scales. Value:
- Legitimizes ZebraUp data for clinical visits (physicians
  recognize these scales)
- Enables future TZP export (interoperability)
- Doesn't compete with TZP's registry role — augments it

**Not adopted as default** because for daily tracking these scales
would be too heavy. Right pattern is periodic (weekly? monthly?)
prompts to complete a scale — cadence to be decided.

### TZP: Diagnostic criteria at data model

TZP encodes 2017 Villefranche criteria for hEDS and Beighton score
at the data-model level, not just as prose. **Considered for**:
Profile.diagnoses expansion when Sprint E and beyond touch condition-
specific features. Making Beighton score a structured field (not
free text) enables ZebraUp to reason about hypermobility gradient
in future correlation features.

---

## ZebraUp's competitive differentiator

Structured post-event action capture with effectiveness measurement,
executed with a credibility profile no template-app portfolio can
match — **and explicitly positioned as complement to TZP, not
competitor**.

### The mechanism (Sprint F architecture)

1. Log symptom / bowel / hem / fever event
2. Either proactive (bowel/hem/fever) or retro (symptom) capture of
   what user did
3. Effectiveness rating tied to the specific action + event pair,
   inferred from severity delta with checkbox override for
   "partial relief then returned"
4. Natural-language surfacing in symptom log (F.E3 tags)
5. Aggregation for Botiquín scorecard and weekly narrative
   (Sprint T0)

### Ultimate value

Patients answer their own "what works for me?" question with
structured longitudinal data, without any backend dependency, with
transparent architecture, without data monetization.

### Positioning triangulation

- **TZP (official registry)**: authoritative periodic snapshots for research contribution
- **Bearable / Guava / Folia (schema-open trackers)**: daily broad-spectrum tracking
- **Visible (energy envelope)**: HRV-driven pacing for ME/CFS specifically
- **Cara Care / MCAS Tracker (condition-specific closed)**: deep GI or MCAS tracking with clinical scale integration
- **Hypermobile (EDS, on-device)**: EDS joint log + Beighton, local-only, English, iOS, paid PDF
- **ZebraUp**: daily action-effectiveness loop for the multimorbidity zebra population (EDS + POTS + MCAS overlap) with retro capture pattern and Sprint F post-event effectiveness

None of the existing apps occupy the specific position ZebraUp
does. TZP is the closest in EDS Society legitimacy but structurally
different (registry vs tracker). Bearable/Guava/Folia are closest
in daily tracker mechanics but lack the post-event effectiveness
loop.

### Secondary differentiators

- **LatAm-first localization**: vademecum from MedlinePlus +
  Orphadata + SNOMED CT Spanish (Snowstorm), not CIMA. Copy in
  LatAm tuteo neutro strictly. Testers Chilean; Taiwan translation
  in progress.
- **Local-first by default**: works with no account; data lives on
  the device. Account, sync and backup are optional and free
  (November 2026 business model). *No longer unique on its own* —
  Hypermobile is also on-device — so it now differentiates in
  combination with free export, free full history and Spanish.
- **Rare-disease awareness**: chip designs and red-flag detection
  reflect current EDS/HSD research (see `eds_research_notes.md`).
  Most tracker apps use standard population reference values, which
  are wrong for zebra patients.
- **MCAS niche opportunity**: no serious consolidated competitor
  exists (MCAS Tracker and MCAS Insight are template products with
  minimal validation). A well-built MCAS module in ZebraUp — with
  flare tracking, environmental/dietary triggers, rescue logging
  (EpiPen/antihistamine) vs stabilizer distinction — could be a
  strong acquisition differentiator given MCAS's overlap with
  EDS + POTS (the "zebra trifecta").

---

## Honest gaps in this analysis

- **ClarityDTX**: exact free/premium cut, whether custom symptoms
  can be created outside the preset list, and whether rescue/basal
  is a data-model distinction or just marketing copy — none
  verifiable without installing and auditing each condition-specific
  app.
- **MedM**: exact annual recurring plan price not verifiable in
  accessible sources (only one-time and lifetime).
- **Welltory**: list price is unstable due to permanent promotional
  discounting.
- **Wave**: exact Wave+ price not clearly published.
- **Cara Care direct-to-consumer**: US price pivoted to reimbursement
  via German DiGA model; direct US price not clearly documented.
- **MCAS360**: does not exist as an app. Mast Cell 360 is a
  functional medicine clinic. Analysis of the MCAS space based on
  the low-quality template apps that do exist.
- **App Store review counts**: ClarityDTX website claim of "5.0/464
  reviews" vs App Store showing 4.4/5 documented as discrepancy;
  actual usage validation cannot be confirmed.
- **Feature verification depth**: some capabilities (e.g., whether
  Guava has a post-symptom prompt, exact ClarityDTX effectiveness
  timing UI) could not be confirmed at UI level without direct app
  use, and are marked as inference where applicable.
- **TZP verification depth**: analysis based on the EDS Society's
  published documentation and screenshots. Actual UI behavior of
  the medication effectiveness reassessment, exact scale
  administration cadence, and researcher data access controls not
  independently audited.

- **Hypermobile**: based on the App Store listing only (21 Nov
  2026); not installed. Whether it ever asks if an action helped,
  and how the POTS/MCAS modules behave, are unverified.
- **Prices**: only Chronic Insights, Clarity and Hypermobile were
  re-checked on 21 Nov 2026. Other prices are from the July 2026
  research.

For a definitive audit of any of the above: install the app and
audit the paywall + core flow directly. Estimated 15 min per app
for a structured protocol.

---

## Recommendations (ZebraUp roadmap alignment)

### Stage 1 (MVP) — Win the post-event action gap

Build the flow the 12 apps don't have. **Status: ✓ shipped in
Sprint F.A through F.F** (see `sprint_f_part_c.md`).

### Stage 2 — Dual event model (acute vs baseline)

Adopt Chronic Insights' data-model distinction: each symptom
configurable as episodic (discrete event, bar chart) or continuous/
baseline (daily check-in, line chart). Add flare/crash mode with
simplified UI. **Deferred to future sprint** (see
`PHASE_5_ROADMAP.md` Open Design Conversations).

### Stage 3 — Detail layers + bulletproof clinical export

Prioritize body heat map for MCAS + EDS. Treat clinical export as
core free feature, ultra-reliable. **Partially shipped**: PDF export
queued as Phase 4; detail layers for headache/fatigue/abdominal
done as C.4/D.1/D.2.

### Stage 4 — Business model

Launch free with tracking + clinical export free (Guava model).
Reserve for premium: insights/correlations, AI assistant, wearable
integration. **Family/caregiver management explicitly free** —
clinical value of multi-observer reporting requires it. Charging
for additional profiles or observers converts a population-serving
feature into a revenue lever and rejects the diagnostic pattern
that pediatric zebra populations depend on. See
`docs/design_decisions/multi_observer_profiles.md`.

~~Target price for premium tier: US$6-9/mo or ~US$35-78/yr
(Bearable-Guava range).~~ **Decided (November 2026, see
`zebraup-modelo-de-negocio.md`)**: one Zebras+ plan for ZebraUp and
ZebraPace — 4.990 CLP or US$19.99 a year (monthly 490 CLP /
US$2.99), AI credit packs, "apadrinar" support. Below the
Bearable-Guava range and Hypermobile's US$39.99. Scholarship is
one tap, no forms. Free forever: logging, account, sync, export,
deletion, standard doctor summary, full-history charts, caregiver
profile.

Evaluate mid-term data dividends with opt-in + radical
transparency (Folia) only if HIPAA-serious compliance is built. Never
Flo-style data sharing without consent.

### Niche opportunity: MCAS

Analysis of both MCAS-specific apps (MCAS Tracker at #5,
MCAS Insight at #15) confirms no serious consolidated MCAS
competitor exists. Both are individual-developer template
products with minimal user validation:

- **MCAS Tracker** (ClarityDTX portfolio): chaotic paywall SKUs,
  privacy discrepancies, part of 30+ app template portfolio
- **MCAS Insight** (Nicholas Relstab): US$0.99 flat, 1 rating,
  hobby-project scale

A well-built MCAS module (Sprint E) with flare tracking +
environmental / dietary triggers + rescue vs stabilizer distinction
+ credible transparency would be a strong acquisition
differentiator. **Queued as Sprint E** — see
`PHASE_5_ROADMAP.md`.

### Classification update: Road to 2026

The Society's Road to 2026 updates the 2017 International
Classification. Monogenic EDS types publish 2 December 2026;
hEDS and HSD publish March 2027 (open access). **Action**: ZebraUp's
hEDS 2017 criteria panel and any Beighton/criteria fields must be
reviewed when the March 2027 hEDS criteria appear; label the current
panel as "2017 criteria" until then.

### Interoperability: TZP export

Since TZP is the authoritative EDS Society registry, an export
feature from ZebraUp to TZP's data format would be a substantial
value-add — patients can use ZebraUp for daily tracking and
periodically export a summary to their TZP registry entry, sharing
with the research community without duplicate data entry. **Queued
as a Phase 4+ track** — depends on TZP's data schema being
documented publicly and on ZebraUp's PDF/structured export being
built. See `PHASE_5_ROADMAP.md`.

---

## Update log

- **Post-Sprint T0 consolidation**: full doc built from three source
  analyses (12-app matrix, 9-app deep review, 3-app supplement).
  Preserved original findings + honest caveats + added explicit
  ZebraUp mapping section.
- **Post-T0 docs pass, multi-observer profile design captured**:
  updated business model recommendation to explicitly exclude
  family/caregiver management from premium; added Guava paywall as
  anti-pattern; cross-referenced new multi_observer_profiles.md.
- **Sprint E.A followup — TZP integration**: added The Zebra Project
  (EDS Society official registry) as app #13. Restructured executive
  summary to distinguish daily-tracker landscape from registry
  landscape. Added "nonprofit official registry" business model
  archetype. Added TZP-adopted patterns (standardized clinical
  scales PHQ-9/GAD-7/FIQR/Rand-36; diagnostic criteria at data
  model). Refined ZebraUp positioning as explicit complement (not
  competitor) to TZP. Added TZP export as interoperability
  recommendation (Phase 4+).
- **Sprint E.A followup pt. 2 — three missing apps integrated**:
  added Fatigue Fighter (NALS Foundation, adolescent CBT+POTS),
  Kalpa (Kalpa Care, autoimmune community + tracker), and
  MCAS Insight (Nicholas Relstab, individual-developer MCAS
  tracker) as apps #13, #14, #15. TZP renumbered to #16. Total
  now 15 mHealth apps + 1 official registry. Reinforced MCAS
  niche opportunity now backed by evidence that both existing
  MCAS-specific apps are template/hobby-scale products.
- **v3 — 21 November 2026**: added Hypermobile: EDS Joint Tracker as
  app #17 (EDS-specific, on-device, freemium with paid PDF). Title
  now 16 mHealth apps + 1 official registry. Updated Chronic
  Insights price and privacy-label note; added a Clarity re-check.
  Corrected ZebraUp's position to the November 2026 business model
  (optional account and sync; decided Zebras+ pricing; caregiver
  profile free). Reworded "local-first" from unique differentiator
  to one part of a combination. Removed a stray duplicate
  "Cross-cutting observations" heading before app #13.
- **v3.1 — 21 November 2026**: EDS Society discontinued its app
  tracker and partners with Guava Health (page updated 8 Oct 2026);
  DICE registry continues on REDCap. Added update note to #16,
  executive summary line, Guava reframed as Society-endorsed tracker,
  and Road to 2026 classification action (hEDS criteria March 2027).
- **v3.2 — 21 November 2026**: verified Welltory's free tier against
  its help center (30-day history deletion confirmed, 1 HRV
  measurement a day with 5 metrics, health-platform sync stays free)
  and noted Spanish support since version 4.61.0. Added a reading for
  ZebraPace. Source of the public comparison at
  zebras.paulinavl.com/compare/. Bearable's storage corrected from
  "encrypted on-device" to "account required; encrypted cloud", to
  match the public comparison.
