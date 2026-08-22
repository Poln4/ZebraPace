import streamlit as st
import sqlite3
import pandas as pd
import datetime
import random
import json
import requests
from contextlib import contextmanager
import plotly.express as px
import plotly.graph_objects as go
from plotly.subplots import make_subplots
from fpdf import FPDF

# =========================================================
# STANDARDIZED SCALES
# =========================================================
MENTAL_OPTIONS = ["Exhausted/Brain Fog", "Low", "Okay", "Good", "Energized"]
BODY_OPTIONS = ["Severe Pain/Stiff", "Achy", "Manageable", "Good", "Loose & Stable"]
MENTAL_SCALE = {v: i + 1 for i, v in enumerate(MENTAL_OPTIONS)}   # 1-5
BODY_SCALE = {v: i + 1 for i, v in enumerate(BODY_OPTIONS)}       # 1-5

MENTAL_EMOJI = dict(zip(MENTAL_OPTIONS, ["😫", "😔", "😐", "🙂", "⚡"]))
BODY_EMOJI = dict(zip(BODY_OPTIONS, ["😫", "😣", "😐", "🙂", "🟢"]))

# Net hydration credit per ml of each drink, relative to plain water (1.0).
# Caffeine/alcohol have a mild diuretic effect; electrolyte/milk-based drinks retain slightly better.
# Estimate for personal pacing use only — not medical guidance.
DRINK_HYDRATION_FACTOR = {
    "Water": 1.0, "Tea": 1.0, "Coffee": 0.9, "Juice": 1.0, "Milk": 1.2,
    "Sports Drink": 1.2, "Energy Drink": 1.0, "Soda": 1.0, "Electrolytes": 1.2,
    "Protein Shake": 1.0, "Broth/Soup": 1.0, "Beer": 0.9, "Wine": 0.8, "Liquor": 0.5,
}
PROTEIN_UNIT_GRAMS = {"g": 1.0, "scoop (~30g)": 30.0, "tbsp (~7g)": 7.0}

# Contraction-mode tags for calisthenics logging (Phase 1 — eccentric-loading awareness).
# "Eccentric" = the lengthening/lowering phase (e.g. controlled descent from a pushup).
# Kept simple and descriptive on purpose — this is a training-mode label, not a prescription.
CONTRACTION_MODES = [
    "Concentric (lifting/pushing up)",
    "Eccentric (lowering, controlled)",
    "Isometric (held position)",
    "Mixed / not sure",
]

# =========================================================
# CONFIGURATION / THEME
# =========================================================
st.set_page_config(page_title="ZebraPace", page_icon="🦓", layout="wide")

# Palette anchored to ZebraUp's actual brand (see index.html): a muted sage-teal, not
# bright cyan. Black & white stripes stay for the zebra motif itself (the thing that's
# earned); everything else leans warm — cream paper, moss/sand in reserve for charts.
BLACK = "#2B2420"        # warm near-black — still reads as "black" in the stripe motif
WHITE = "#FFFFFF"        # kept true white so the stripe motif stays high-contrast
PAPER = "#FFFCF6"        # warm off-white for cards/forms
BRAND_TEAL = "#4A9B8E"   # signature accent — matches ZebraUp's brand color
TEAL = "#6E8B5E"         # secondary accent / chart series — warm moss, distinct from the brand teal
SAND = "#E8C39E"         # tertiary accent / chart series
SUCCESS = "#2F8F5B"      # matches ZebraUp's "criterion met" green
BG = "#F6EFE3"           # warm cream page background
CARD_BORDER = "#E6D9C3"  # warm tan border

PRIMARY = BRAND_TEAL
ACCENT = SAND

st.markdown(f"""
<style>
    @import url('https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600&family=Nunito:wght@400;600;700;800&display=swap');
    .stApp, body, [class*="css"] {{
        background-color: {BG};
        font-family: 'Nunito', sans-serif;
    }}
    h1 {{
        font-family: 'Fraunces', serif;
        color: {BLACK};
        border-bottom: 4px solid {BRAND_TEAL};
        padding-bottom: 8px;
        background: none;
    }}
    h2, h3 {{
        font-family: 'Nunito', sans-serif;
        font-weight: 800;
        color: {BLACK};
        border-left: 5px solid {BRAND_TEAL};
        padding: 8px 16px;
        background: linear-gradient(90deg, rgba(74,155,142,0.10), transparent 70%);
        border-radius: 4px;
        position: relative;
    }}
    .stripe-track {{
        display: flex;
        gap: 3px;
        margin: 6px 0 4px 0;
    }}
    .stripe-segment {{
        flex: 1;
        height: 20px;
        border-radius: 3px;
        background: {WHITE};
        border: 1px solid {CARD_BORDER};
    }}
    .stripe-segment.earned {{
        background: {BLACK};
        border-color: {BLACK};
    }}
    .flare-badge {{
        display: inline-block;
        background: {PAPER};
        color: {BLACK};
        border: 2px dashed {TEAL};
        padding: 6px 16px;
        border-radius: 20px;
        font-weight: 600;
        font-size: 0.9em;
    }}
    div[data-testid="stMetric"] {{
        background-color: {PAPER};
        border: 1px solid {CARD_BORDER};
        border-radius: 12px;
        padding: 16px 16px 12px 16px;
        box-shadow: 0 1px 3px rgba(43,36,32,0.06);
        position: relative;
        overflow: hidden;
    }}
    div[data-testid="stMetric"]::before {{
        content: '';
        display: block;
        position: absolute;
        top: 0; left: 0; right: 0;
        height: 6px;
        background: {BRAND_TEAL};
    }}
    div[data-testid="stForm"] {{
        background-color: {PAPER};
        border: 1px solid {CARD_BORDER};
        border-top: 4px solid {BRAND_TEAL};
        border-radius: 14px;
        padding: 18px;
    }}
    .stButton>button {{
        border-radius: 10px;
        border: 2px solid {BRAND_TEAL};
        color: {BLACK};
        background-color: {PAPER};
        font-weight: 700;
        font-family: 'Nunito', sans-serif;
    }}
    .stButton>button:hover {{
        border-color: {BLACK};
        background-color: {BRAND_TEAL};
        color: {WHITE};
    }}
    .stTabs [aria-selected="true"] {{
        color: {BRAND_TEAL} !important;
        border-bottom-color: {BRAND_TEAL} !important;
    }}
    div[data-testid="stForm"] button[kind="formSubmit"] {{
        background-color: {BRAND_TEAL};
        border: 2px solid {BLACK};
        color: {BLACK};
    }}
</style>
""", unsafe_allow_html=True)

# =========================================================
# 1. SIMPLE PASSWORD GATE
# =========================================================
APP_PASSWORD = st.secrets.get("APP_PASSWORD", "runrunCarlacorrecorre")

def check_password():
    if st.session_state.get("password_correct", False):
        return True
    st.title("🔒 ZebraPace Login")
    user_input = st.text_input("Enter Password", type="password")
    if st.button("Log In"):
        if user_input == APP_PASSWORD:
            st.session_state["password_correct"] = True
            st.rerun()
        else:
            st.error("😕 Incorrect password")
    return False

if not check_password():
    st.stop()

# =========================================================
# 2. DATABASE SETUP
# =========================================================
DB_FILE = 'zebra_data.db'

DEFAULT_SETTINGS = {
    "growth_goal_pct": "1.01",      # 1% growth target over 7-day average
    "caution_pct": "1.10",          # gentle-caution threshold above average
    "comfort_threshold": "3.8",     # avg comfort score to unlock next progression
    "water_goal_ml": "2000",
    "protein_goal_g": "100",
    "location_name": "",
    "location_lat": "",
    "location_lon": "",
}

def get_db_connection():
    return sqlite3.connect(DB_FILE)

@contextmanager
def get_db():
    """Yields a connection guaranteed to close, even if the block raises."""
    conn = get_db_connection()
    try:
        yield conn
    finally:
        conn.close()

def init_db():
    with get_db() as conn:
        c = conn.cursor()
        c.execute('''CREATE TABLE IF NOT EXISTS daily_logs
                     (date TEXT PRIMARY KEY, weight REAL, height REAL, water_ml INTEGER DEFAULT 0,
                      protein_g INTEGER DEFAULT 0, creatine_g REAL DEFAULT 0, mental_state TEXT, body_feeling TEXT,
                      braces_used TEXT, brace_comfort INTEGER, steps INTEGER DEFAULT 0)''')
        c.execute('''CREATE TABLE IF NOT EXISTS activities
                     (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, activity_name TEXT,
                      duration_min INTEGER, extra_weight_kg REAL)''')
        c.execute('''CREATE TABLE IF NOT EXISTS calisthenics
                     (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, exercise TEXT,
                      progression TEXT, sets INTEGER, reps INTEGER, comfortable BOOLEAN)''')
        c.execute('''CREATE TABLE IF NOT EXISTS therapies
                     (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, therapy_name TEXT,
                      duration_min INTEGER, mental_state TEXT, body_feeling TEXT)''')
        c.execute('''CREATE TABLE IF NOT EXISTS liquid_logs
                     (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, drink_type TEXT, amount_ml INTEGER)''')
        c.execute('''CREATE TABLE IF NOT EXISTS settings
                     (key TEXT PRIMARY KEY, value TEXT)''')
        c.execute('''CREATE TABLE IF NOT EXISTS weather_cache
                     (date TEXT, lat REAL, lon REAL, temp_c REAL, humidity_pct REAL, pressure_hpa REAL,
                      PRIMARY KEY (date, lat, lon))''')
        # Phase 2 — "Soreness or Crash?" quick-check log (see check_soreness_or_crash()).
        # One row per check (a day can have more than one, e.g. morning and next-day follow-up).
        c.execute('''CREATE TABLE IF NOT EXISTS soreness_checks
                     (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, onset TEXT,
                      spread TEXT, trend TEXT, verdict TEXT, verdict_label TEXT)''')

        # Safe upgrades for older DBs
        try:
            c.execute("ALTER TABLE calisthenics ADD COLUMN comfort_score REAL DEFAULT 0.0")
        except sqlite3.OperationalError:
            pass
        for table in ["activities", "calisthenics"]:
            for col in ["mental_state", "body_feeling"]:
                try:
                    c.execute(f"ALTER TABLE {table} ADD COLUMN {col} TEXT")
                except sqlite3.OperationalError:
                    pass
        # Phase 1 — contraction-mode tag (concentric/eccentric/isometric/mixed) per calisthenics set.
        try:
            c.execute("ALTER TABLE calisthenics ADD COLUMN contraction_mode TEXT")
        except sqlite3.OperationalError:
            pass
        for col_def in ["is_rest_day BOOLEAN DEFAULT 0", "fat_percentage REAL DEFAULT 0.0", "is_flare_day BOOLEAN DEFAULT 0"]:
            try:
                c.execute(f"ALTER TABLE daily_logs ADD COLUMN {col_def}")
            except sqlite3.OperationalError:
                pass
        try:
            c.execute("ALTER TABLE liquid_logs ADD COLUMN hydration_ml REAL DEFAULT 0")
        except sqlite3.OperationalError:
            pass

        # Seed default settings
        for k, v in DEFAULT_SETTINGS.items():
            c.execute("INSERT OR IGNORE INTO settings (key, value) VALUES (?, ?)", (k, v))

        conn.commit()

init_db()

# =========================================================
# 3. SETTINGS HELPERS
# =========================================================
@st.cache_data(ttl=5)
def get_all_settings():
    with get_db() as conn:
        df = pd.read_sql_query("SELECT * FROM settings", conn)
    return dict(zip(df['key'], df['value']))

def set_setting(key, value):
    with get_db() as conn:
        conn.execute("INSERT INTO settings (key, value) VALUES (?, ?) ON CONFLICT(key) DO UPDATE SET value=excluded.value", (key, str(value)))
        conn.commit()
    get_all_settings.clear()

SETTINGS = get_all_settings()
GROWTH_GOAL = float(SETTINGS.get("growth_goal_pct", 1.01))
CAUTION_PCT = float(SETTINGS.get("caution_pct", 1.10))
COMFORT_THRESHOLD = float(SETTINGS.get("comfort_threshold", 3.8))
WATER_GOAL = int(float(SETTINGS.get("water_goal_ml", 2000)))
PROTEIN_GOAL = int(float(SETTINGS.get("protein_goal_g", 100)))
LOCATION_NAME = SETTINGS.get("location_name", "")
LOCATION_LAT = SETTINGS.get("location_lat", "")
LOCATION_LON = SETTINGS.get("location_lon", "")

# =========================================================
# 4. DATA HELPER FUNCTIONS
# =========================================================
def ensure_day_exists(date_str):
    with get_db() as conn:
        conn.execute("INSERT OR IGNORE INTO daily_logs (date, water_ml, protein_g, creatine_g, steps, is_rest_day) VALUES (?, 0, 0, 0, 0, 0)", (date_str,))
        conn.commit()

def get_day_data(date_str):
    with get_db() as conn:
        df = pd.read_sql_query("SELECT * FROM daily_logs WHERE date=?", conn, params=(date_str,))
    return {} if df.empty else df.iloc[0].to_dict()

def get_weekly_average_steps(target_date_str, lookback_days=14):
    """Average steps from the most recent *logged, non-rest, non-flare* days.
    Uses a wider lookback window (default 14 calendar days) so that a stretch
    of illness or flares doesn't shrink the sample down to nothing or quietly
    drag the baseline toward days that weren't representative of capacity."""
    target = datetime.datetime.strptime(target_date_str, "%Y-%m-%d").date()
    start = (target - datetime.timedelta(days=lookback_days)).strftime("%Y-%m-%d")
    with get_db() as conn:
        df = pd.read_sql_query(
            """SELECT steps FROM daily_logs
               WHERE date >= ? AND date < ? AND steps > 0
               AND (is_rest_day IS NULL OR is_rest_day = 0)
               AND (is_flare_day IS NULL OR is_flare_day = 0)
               ORDER BY date DESC LIMIT 7""",
            conn, params=(start, target_date_str))
    if df.empty:
        return 0
    return df['steps'].mean()

def get_range_daily(days=30, end_date_str=None):
    end = datetime.datetime.strptime(end_date_str, "%Y-%m-%d").date() if end_date_str else datetime.date.today()
    start = (end - datetime.timedelta(days=days)).strftime("%Y-%m-%d")
    with get_db() as conn:
        df = pd.read_sql_query("SELECT * FROM daily_logs WHERE date >= ? AND date <= ? ORDER BY date ASC",
                                conn, params=(start, end.strftime("%Y-%m-%d")))
    return df

def get_day_summary_counts(date_str):
    with get_db() as conn:
        df = pd.read_sql_query(
            """SELECT
                 (SELECT COUNT(*) FROM activities WHERE date=?) AS act,
                 (SELECT COUNT(*) FROM calisthenics WHERE date=?) AS cal,
                 (SELECT COUNT(*) FROM therapies WHERE date=?) AS ther""",
            conn, params=(date_str, date_str, date_str))
    row = df.iloc[0]
    return int(row['act']), int(row['cal']), int(row['ther'])

def check_calisthenics_comfort(exercise, target_date_str):
    with get_db() as conn:
        df = pd.read_sql_query("SELECT comfort_score FROM calisthenics WHERE exercise=? AND date <= ? ORDER BY date DESC LIMIT 3",
                                conn, params=(exercise, target_date_str))
    return len(df) == 3 and df['comfort_score'].mean() >= COMFORT_THRESHOLD

def get_recent_eccentric_session(target_date_str, lookback_days=3):
    """Was any Eccentric-tagged calisthenics set logged in the last `lookback_days`?
    Used to give the Phase 2 soreness-vs-crash check a relevant default, since ordinary
    DOMS is specifically tied to unaccustomed eccentric/lengthening loading."""
    target = datetime.datetime.strptime(target_date_str, "%Y-%m-%d").date()
    start = (target - datetime.timedelta(days=lookback_days)).strftime("%Y-%m-%d")
    with get_db() as conn:
        df = pd.read_sql_query(
            """SELECT date, exercise FROM calisthenics
               WHERE date >= ? AND date <= ? AND contraction_mode LIKE 'Eccentric%'
               ORDER BY date DESC LIMIT 1""",
            conn, params=(start, target_date_str))
    return None if df.empty else df.iloc[0].to_dict()

def get_latest_body_metrics(before_date_str):
    """Weight/height/body-fat don't change day to day, so a fresh day shouldn't start blank —
    carry forward the most recent recorded value until the user actually updates it."""
    with get_db() as conn:
        df = pd.read_sql_query(
            """SELECT weight, height, fat_percentage FROM daily_logs
               WHERE date <= ? AND (weight > 0 OR height > 0 OR fat_percentage > 0)
               ORDER BY date DESC LIMIT 1""",
            conn, params=(before_date_str,))
    return {} if df.empty else df.iloc[0].to_dict()

def get_total_checkins():
    """All-time count of days with any sign of life logged — the 'stripes earned' counter."""
    with get_db() as conn:
        df = pd.read_sql_query(
            """SELECT COUNT(*) as c FROM daily_logs
               WHERE water_ml > 0 OR steps > 0 OR is_rest_day = 1 OR is_flare_day = 1""",
            conn)
    return int(df.iloc[0]['c'])

def get_month_chapter_data(any_date_str):
    """Daily-log rows plus activity/calisthenics/therapy counts for the calendar month containing this date."""
    d = datetime.datetime.strptime(any_date_str, "%Y-%m-%d").date()
    month_start = d.replace(day=1)
    next_month_start = d.replace(year=d.year + 1, month=1, day=1) if d.month == 12 else d.replace(month=d.month + 1, day=1)
    month_end = next_month_start - datetime.timedelta(days=1)
    start_str, end_str = month_start.strftime("%Y-%m-%d"), month_end.strftime("%Y-%m-%d")
    with get_db() as conn:
        df_month = pd.read_sql_query("SELECT * FROM daily_logs WHERE date >= ? AND date <= ? ORDER BY date ASC", conn, params=(start_str, end_str))
        act_n = pd.read_sql_query("SELECT COUNT(*) c FROM activities WHERE date >= ? AND date <= ?", conn, params=(start_str, end_str)).iloc[0]['c']
        cal_n = pd.read_sql_query("SELECT COUNT(*) c FROM calisthenics WHERE date >= ? AND date <= ?", conn, params=(start_str, end_str)).iloc[0]['c']
        ther_n = pd.read_sql_query("SELECT COUNT(*) c FROM therapies WHERE date >= ? AND date <= ?", conn, params=(start_str, end_str)).iloc[0]['c']
    return month_start, df_month, int(act_n), int(cal_n), int(ther_n)

def build_month_chapter(month_start, df_month, act_n, cal_n, ther_n):
    """A gentle narrative recap of the month — reflection, not a scorecard."""
    if df_month.empty:
        return "A Quiet Chapter", "No entries logged yet this month — and that's alright. This chapter is still unwritten; pick it up whenever you're ready."

    checkins = len(df_month[(df_month['water_ml'] > 0) | (df_month['steps'] > 0) |
                             (df_month['is_rest_day'] == 1) | (df_month.get('is_flare_day', 0) == 1)])
    if checkins == 0:
        return "A Quiet Chapter", "No entries logged yet this month — and that's alright. This chapter is still unwritten; pick it up whenever you're ready."

    rest_n = int(df_month['is_rest_day'].sum()) if 'is_rest_day' in df_month.columns else 0
    flare_n = int(df_month['is_flare_day'].sum()) if 'is_flare_day' in df_month.columns else 0
    mental_scores = df_month['mental_state'].map(MENTAL_SCALE).dropna()
    body_scores = df_month['body_feeling'].map(BODY_SCALE).dropna()

    if (flare_n + rest_n) > 0 and (flare_n + rest_n) >= max(checkins // 2, 1):
        title = "Learning to Rest"
    elif (act_n + cal_n) >= 8:
        title = "Gentle Exploration"
    elif checkins >= 15:
        title = "Steady Noticing"
    else:
        title = "Finding the Rhythm"

    lines = [f"You showed up **{checkins}** time{'s' if checkins != 1 else ''} this month."]
    if rest_n or flare_n:
        bits = []
        if rest_n: bits.append(f"{rest_n} Rest Day{'s' if rest_n != 1 else ''}")
        if flare_n: bits.append(f"{flare_n} Flare Day{'s' if flare_n != 1 else ''}")
        lines.append("You honored " + " and ".join(bits) + " — protecting your body counts as showing up too.")
    if act_n or cal_n or ther_n:
        bits = []
        if act_n: bits.append(f"{act_n} activity log{'s' if act_n != 1 else ''}")
        if cal_n: bits.append(f"{cal_n} calisthenics session{'s' if cal_n != 1 else ''}")
        if ther_n: bits.append(f"{ther_n} recovery session{'s' if ther_n != 1 else ''}")
        lines.append("Movement and recovery this month: " + ", ".join(bits) + ".")
    if len(mental_scores) and len(body_scores):
        lines.append(f"Your mental state moved between **{MENTAL_OPTIONS[int(mental_scores.min()) - 1]}** and **{MENTAL_OPTIONS[int(mental_scores.max()) - 1]}**, "
                      f"and body/pain between **{BODY_OPTIONS[int(body_scores.min()) - 1]}** and **{BODY_OPTIONS[int(body_scores.max()) - 1]}**.")
    return title, " ".join(lines)

def get_comfort_emoji(score):
    if score >= 4.5: return "🤩 Brilliant/Stable"
    elif score >= 3.8: return "🙂 Comfortable/Good"
    elif score >= 2.5: return "😐 Okay/Stiff"
    elif score >= 1.5: return "🙁 Achy/Struggled"
    else: return "😣 Painful/Unstable"

def feeling_control(label, options, emoji_map, default, key):
    """Tap-target segmented control instead of a drag slider — friendlier on tremor/pain days."""
    val = st.segmented_control(label, options=options, default=default,
                                format_func=lambda x: f"{emoji_map[x]} {x}", key=key)
    return val if val is not None else default

# --- Phase 2: Soreness-or-Crash quick check ---------------------------------
# Grounded in two things kept distinct on purpose:
#  - Ordinary DOMS after eccentric/unaccustomed loading: localized to the muscles worked,
#    peaks ~24-72h, eases with the "repeated bout effect" (Hody et al. 2019; Nosaka 2026).
#  - PEM/crash: often more widespread or systemic (fatigue, brain fog, flu-like), can be
#    disproportionate to the triggering activity, and tends to *not* ease day over day —
#    this is a different mechanism than local muscle soreness and needs a different response.
# This is a descriptive heuristic for the person's own reflection, not a diagnostic tool.

def evaluate_soreness_or_crash(onset, spread, trend):
    """Returns (verdict_key, label, message) from three simple self-report answers."""
    if spread == "Widespread / systemic" or trend == "Getting worse":
        return (
            "possible_crash",
            "🌩️ More consistent with a crash/PEM pattern",
            "Widespread or worsening symptoms — rather than easing, localized muscle soreness — line up more with "
            "post-exertional malaise than ordinary exercise soreness. Consider treating today (and maybe tomorrow) "
            "as a Rest or Flare Day, and it's worth mentioning this pattern to your care team if it keeps happening."
        )
    if spread == "Localized to muscles worked" and trend in ("Easing", "About the same") and onset in ("1 day after", "2-3 days after"):
        return (
            "likely_doms",
            "💪 Sounds like ordinary post-exercise soreness (DOMS)",
            "Localized soreness that peaks a day or two after effort and then eases is the typical pattern for "
            "delayed-onset muscle soreness — especially after eccentric (lowering/controlled) work. It's not usually "
            "a signal to worry, and it tends to lessen further with repeated, gentle exposure (the 'repeated bout effect')."
        )
    return (
        "unclear",
        "🤔 No clear pattern yet",
        "Not enough of a clear signal either way from these answers. Worth logging again tomorrow, and mentioning "
        "to your care team if this keeps recurring or feels different from your usual soreness."
    )

def save_soreness_check(date_str, onset, spread, trend, verdict_key, verdict_label):
    with get_db() as conn:
        conn.execute(
            "INSERT INTO soreness_checks (date, onset, spread, trend, verdict, verdict_label) VALUES (?, ?, ?, ?, ?, ?)",
            (date_str, onset, spread, trend, verdict_key, verdict_label))
        conn.commit()

def get_soreness_checks(date_str):
    with get_db() as conn:
        df = pd.read_sql_query("SELECT * FROM soreness_checks WHERE date=? ORDER BY id DESC", conn, params=(date_str,))
    return df

# --- Data ownership: export / import / delete everything, no lock-in ---
DATA_TABLES = ["daily_logs", "activities", "calisthenics", "therapies", "liquid_logs", "settings", "weather_cache", "soreness_checks"]

def export_all_data():
    payload = {"exported_at": datetime.datetime.now().isoformat(), "tables": {}}
    with get_db() as conn:
        for table in DATA_TABLES:
            df = pd.read_sql_query(f"SELECT * FROM {table}", conn)
            payload["tables"][table] = df.to_dict(orient="records")
    return payload

def import_all_data(payload, mode="merge"):
    """mode='merge' inserts/ignores existing rows; mode='replace' wipes each table first."""
    with get_db() as conn:
        c = conn.cursor()
        for table, rows in payload.get("tables", {}).items():
            if table not in DATA_TABLES or not rows:
                continue
            if mode == "replace":
                c.execute(f"DELETE FROM {table}")
            cols = list(rows[0].keys())
            placeholders = ",".join(["?"] * len(cols))
            col_list = ",".join(cols)
            for row in rows:
                values = [row.get(col) for col in cols]
                try:
                    c.execute(f"INSERT OR IGNORE INTO {table} ({col_list}) VALUES ({placeholders})", values)
                except sqlite3.OperationalError:
                    pass  # skip rows that don't match current schema
        conn.commit()
    get_all_settings.clear()

def delete_all_data():
    with get_db() as conn:
        c = conn.cursor()
        for table in DATA_TABLES:
            if table == "settings":
                continue  # keep configured thresholds/goals
            c.execute(f"DELETE FROM {table}")
        conn.commit()

# --- Weather (Open-Meteo — no API key, matches the source ZebraUp already uses) ---
def geocode_location(name):
    """Returns (display_name, lat, lon) or None if not found."""
    try:
        r = requests.get("https://geocoding-api.open-meteo.com/v1/search",
                          params={"name": name, "count": 1, "language": "en", "format": "json"}, timeout=10)
        r.raise_for_status()
        results = r.json().get("results")
        if not results:
            return None
        top = results[0]
        display = f"{top['name']}, {top.get('admin1', '')} {top.get('country', '')}".strip()
        return display, top["latitude"], top["longitude"]
    except Exception:
        return None

def fetch_weather_range(lat, lon, start_date_str, end_date_str):
    """Returns a daily-resolution DataFrame [date, temp_c, humidity_pct, pressure_hpa].
    Cached in weather_cache so repeat visits don't re-hit the API for the same days."""
    with get_db() as conn:
        cached = pd.read_sql_query(
            "SELECT * FROM weather_cache WHERE lat=? AND lon=? AND date >= ? AND date <= ?",
            conn, params=(lat, lon, start_date_str, end_date_str))
        all_dates = pd.date_range(start_date_str, end_date_str, freq="D").strftime("%Y-%m-%d")
        missing = sorted(set(all_dates) - set(cached['date']))

        if missing:
            try:
                r = requests.get(
                    "https://archive-api.open-meteo.com/v1/archive",
                    params={
                        "latitude": lat, "longitude": lon,
                        "start_date": min(missing), "end_date": max(missing),
                        "hourly": "temperature_2m,relative_humidity_2m,surface_pressure",
                        "timezone": "auto",
                    },
                    timeout=20,
                )
                r.raise_for_status()
                hourly = r.json().get("hourly", {})
                if hourly:
                    df_h = pd.DataFrame({
                        "time": pd.to_datetime(hourly["time"]),
                        "temp_c": hourly["temperature_2m"],
                        "humidity_pct": hourly["relative_humidity_2m"],
                        "pressure_hpa": hourly["surface_pressure"],
                    })
                    df_h["date"] = df_h["time"].dt.strftime("%Y-%m-%d")
                    df_daily_weather = df_h.groupby("date").mean(numeric_only=True).reset_index()
                    c = conn.cursor()
                    for _, row in df_daily_weather.iterrows():
                        c.execute(
                            "INSERT OR REPLACE INTO weather_cache (date, lat, lon, temp_c, humidity_pct, pressure_hpa) VALUES (?, ?, ?, ?, ?, ?)",
                            (row["date"], lat, lon, row["temp_c"], row["humidity_pct"], row["pressure_hpa"]))
                    conn.commit()
            except Exception as e:
                st.warning(f"Couldn't reach the weather service right now ({e}). Showing whatever is already cached.")

        result = pd.read_sql_query(
            "SELECT * FROM weather_cache WHERE lat=? AND lon=? AND date >= ? AND date <= ? ORDER BY date ASC",
            conn, params=(lat, lon, start_date_str, end_date_str))
    return result

# --- Doctor-visit PDF summary ---
def generate_doctor_pdf(start_date_str, end_date_str, df_daily, df_act, df_cal, df_ther, pem_note=None, weather_note=None):
    pdf = FPDF()
    pdf.set_auto_page_break(auto=True, margin=15)
    pdf.add_page()

    pdf.set_font("Helvetica", "B", 16)
    pdf.cell(0, 10, "ZebraPace - Pacing Summary", ln=True)
    pdf.set_font("Helvetica", "", 10)
    pdf.cell(0, 6, f"Range: {start_date_str} to {end_date_str}  |  Generated: {datetime.date.today().isoformat()}", ln=True)
    pdf.set_font("Helvetica", "I", 9)
    pdf.multi_cell(0, 5, "Patient-reported pacing data (PRO/EMA style). Not a diagnostic tool; intended to support, not replace, clinical judgment.")
    pdf.ln(3)

    d = df_daily.copy()
    days_span = max((datetime.datetime.strptime(end_date_str, "%Y-%m-%d") - datetime.datetime.strptime(start_date_str, "%Y-%m-%d")).days + 1, 1)
    days_logged = len(d)
    rest_days = int(d['is_rest_day'].sum()) if 'is_rest_day' in d.columns and days_logged else 0
    flare_days = int(d['is_flare_day'].sum()) if 'is_flare_day' in d.columns and days_logged else 0
    avg_steps = d.loc[d['steps'] > 0, 'steps'].mean() if days_logged and (d['steps'] > 0).any() else 0
    avg_water = d['water_ml'].mean() if days_logged else 0
    avg_protein = d['protein_g'].mean() if days_logged else 0
    avg_mental = d['mental_state'].map(MENTAL_SCALE).mean() if days_logged else None
    avg_body = d['body_feeling'].map(BODY_SCALE).mean() if days_logged else None

    pdf.set_font("Helvetica", "B", 12)
    pdf.cell(0, 8, "Overview", ln=True)
    pdf.set_font("Helvetica", "", 10)
    rows = [
        ("Days in range", f"{days_span}"),
        ("Days logged", f"{days_logged}"),
        ("Rest days", f"{rest_days}"),
        ("Flare / sick days", f"{flare_days}"),
        ("Average daily steps (active days)", f"{avg_steps:.0f}" if avg_steps else "n/a"),
        ("Average liquids", f"{avg_water:.0f} ml" if days_logged else "n/a"),
        ("Average protein", f"{avg_protein:.0f} g" if days_logged else "n/a"),
        ("Average mental state (1-5)", f"{avg_mental:.1f}" if avg_mental and not pd.isna(avg_mental) else "n/a"),
        ("Average body/pain feeling (1-5)", f"{avg_body:.1f}" if avg_body and not pd.isna(avg_body) else "n/a"),
    ]
    for label, val in rows:
        pdf.cell(90, 6, label, border=0)
        pdf.cell(0, 6, val, border=0, ln=True)
    pdf.ln(2)

    pdf.set_font("Helvetica", "B", 12)
    pdf.cell(0, 8, "Movement & Recovery", ln=True)
    pdf.set_font("Helvetica", "", 10)
    pdf.cell(0, 6, f"Custom activities logged: {len(df_act)}   |   Passive therapy sessions: {len(df_ther)}", ln=True)
    if not df_cal.empty:
        pdf.ln(1)
        pdf.set_font("Helvetica", "B", 10)
        pdf.cell(0, 6, "Calisthenics - latest status per exercise:", ln=True)
        pdf.set_font("Helvetica", "", 10)
        for ex, group in df_cal.sort_values('date').groupby('exercise'):
            last3 = group.tail(3)
            avg_comfort = last3['comfort_score'].mean()
            latest_tier = group.iloc[-1]['progression']
            latest_mode = group.iloc[-1]['contraction_mode'] if 'contraction_mode' in group.columns else None
            mode_str = f", last mode: {latest_mode}" if latest_mode else ""
            pdf.cell(0, 6, f"  - {ex}: current tier '{latest_tier}', last-3-session avg comfort {avg_comfort:.1f}/5{mode_str}", ln=True)
    pdf.ln(2)

    if pem_note:
        pdf.set_font("Helvetica", "B", 12)
        pdf.cell(0, 8, "Delayed Symptom Pattern (patient-observed)", ln=True)
        pdf.set_font("Helvetica", "", 10)
        pdf.multi_cell(0, 6, pem_note)
        pdf.ln(2)

    if weather_note:
        pdf.set_font("Helvetica", "B", 12)
        pdf.cell(0, 8, "Weather Context", ln=True)
        pdf.set_font("Helvetica", "", 10)
        pdf.multi_cell(0, 6, weather_note)
        pdf.ln(2)

    if not df_ther.empty:
        pdf.set_font("Helvetica", "B", 12)
        pdf.cell(0, 8, "Recent Passive Therapies", ln=True)
        pdf.set_font("Helvetica", "", 9)
        for _, row in df_ther.sort_values('date', ascending=False).head(10).iterrows():
            pdf.cell(0, 5, f"  {row['date']}  -  {row['therapy_name']} ({row['duration_min']} min)  -  body: {row['body_feeling']}", ln=True)

    out = pdf.output()
    return bytes(out)

# The Adaptive Body Philosophy — evidence-based principles for chronic pain / hypermobility (EDS, HSD)
# pacing, replacing generic encouragement with specific, cited reasoning. Full text + citations are
# shown in the "Why this app works this way" expander in Insights; short forms rotate as daily tips.
ADAPTIVE_BODY_PRINCIPLES = [
    {
        "title": "Movement Quality > Movement Quantity",
        "fact": "For EDS/HSD, low-load exercise focused on motor control reduces pain and improves function more reliably than high-volume training.",
        "inspiration": "Your joints don't need endless reps — they need mindful, precise control. Training proprioception is what stabilizes loose joints, not pushing them to their limit.",
        "citation": "Buryk-Iggers et al., 2022, Arch Rehabil Res Clin Transl",
    },
    {
        "title": "Respecting the Biological Healing Clock",
        "fact": "Tendons, ligaments, and joint capsules have limited blood supply and heal far slower than muscle — EDS extends this further.",
        "inspiration": "\"Start low, go slow\" isn't a lack of progress — it's a clinical necessity that lets your nervous system rebuild stabilizing muscle without overstressing fragile ligaments.",
        "citation": "Stasiak, Woźniak & Woźniak, 2025, Quality in Sport",
    },
    {
        "title": "Validating Delayed Soreness (DOMS)",
        "fact": "Hypermobile individuals experience significantly greater, more intense delayed-onset muscle soreness than non-hypermobile people after eccentric exercise.",
        "inspiration": "Soreness days later doesn't mean you're broken — your muscles are working harder to stabilize loose joints. Extra recovery time is biology, not a failure of will.",
        "citation": "Ostuni et al., 2024, Int J Sports Phys Ther",
    },
    {
        "title": "Rejecting the Auto-Escalation Trap",
        "fact": "Commercial trackers that auto-raise goals after a big day can push chronic pain / dysautonomia patients past what their nervous system needs for recovery.",
        "inspiration": "Rest isn't a missed day. Your capacity is a range that shifts daily with sleep, hydration, and pain — not an arbitrary target that only ever goes up. This is why this app's baseline excludes rest and flare days instead of averaging them in.",
        "citation": "Buryk-Iggers et al., 2022, Arch Rehabil Res Clin Transl",
    },
    {
        "title": "Rescuing the 'Cinderella Muscles'",
        "fact": "Lax joints force stabilizing muscles into constant low-level contraction (the 'Cinderella hypothesis'), causing metabolic overload and trigger points.",
        "inspiration": "Your stabilizing muscles work a 24-hour shift just to hold you upright. Frequent gentle micro-breaks — twists, isometric holds — restore blood flow and break the pain cycle.",
        "citation": "Ahmed et al., 2018, J Exerc Rehabil",
    },
    {
        "title": "The Stiffness Paradox",
        "fact": "Fascia can thicken (densify) to compensate for lax joints, creating stiffness despite loose ligaments — aggressive stretching can worsen instability.",
        "inspiration": "Tightness is often your body protecting your joints. Gentle fascial gliding and core stabilization reassure your nervous system more safely than a deep stretch.",
        "citation": "Wang, Stecco, Hakim & Schleip, 2025, Int J Mol Sci",
    },
    {
        "title": "Eccentric Work: More Strength for Fewer Spoons",
        "fact": "Eccentric (lengthening) contractions generate high force at a lower metabolic and cardiovascular cost than concentric (lifting) contractions of the same intensity — and unaccustomed muscle damage is largely preventable through gradual, low-intensity progression.",
        "inspiration": "This is why 'Eccentric' work is worth tagging separately here — it's a way to build real strength without spending spoons you don't have, especially useful if dysautonomia limits how much cardiovascular effort you can spare on a given day.",
        "citation": "Hody et al., 2019, Front Physiol; Nosaka, 2026, J Sport Health Sci",
    },
    {
        "title": "Soreness Fades With Practice — the Repeated Bout Effect",
        "fact": "After an initial bout of eccentric exercise, the same movement causes markedly less soreness and muscle damage the next time — protection that can last weeks to months.",
        "inspiration": "If a new eccentric exercise leaves you sore the first couple of times, that's expected and it's not a sign to stop — it typically eases on its own as your muscles adapt, faster than you might expect.",
        "citation": "Hody et al., 2019, Front Physiol; Nosaka, 2026, J Sport Health Sci",
    },
    {
        "title": "An Important Caveat: Muscle Damage ≠ Joint Safety",
        "fact": "The eccentric-exercise research above was done in general and older-adult populations, not specifically in hypermobile connective tissue. 'Muscle damage is usually fine' is not the same claim as 'joint and capsule loading is fine' for EDS/HSD bodies.",
        "inspiration": "Treat muscle soreness and joint/capsule signals as two separate things worth tracking separately — easing muscle soreness is a good sign, but pain, instability, or swelling around a joint is its own signal and deserves its own caution, regardless of what the muscle soreness is doing.",
        "citation": "App-level synthesis, not from the source studies directly",
    },
]

REST_FACTS = [f"{p['title']}: {p['inspiration']}" for p in ADAPTIVE_BODY_PRINCIPLES] + [
    "There is no 'behind' in a chronic condition. The only comparison that matters is you-today to you-yesterday, gently.",
    "Every log entry — even 'I rested' or 'I couldn't log anything' — is useful data for you and your care team. It all counts.",
    "A flare isn't a step backward in your data. Your averages are built to exclude flare days automatically, on purpose.",
]

MOTIVATION_LOW_STEPS = [
    "Fewer steps today isn't a setback — bodies with connective tissue differences have real day-to-day variability. This is expected, not a failure.",
    "Some days are recovery days even when you didn't plan them. Your nervous system is doing quiet work you can't see.",
    "The trend over weeks matters far more than any single day. One quieter day doesn't undo your progress.",
]

MOTIVATION_STEADY = [
    "Showing up consistently, even at a steady pace, is exactly how sustainable progress with EDS/dysautonomia looks.",
    "Maintaining your baseline is a genuine achievement — it means your pacing strategy is working.",
]

MOTIVATION_GROWTH = [
    "You gently expanded your capacity today. Small, sustainable growth is the whole strategy — no need to push further.",
    "That's real progress. Consider this your cue to rest well tonight so your body can consolidate the gain.",
]

# =========================================================
# 5. MAIN APP
# =========================================================
st.title("🦓 ZebraPace")
st.markdown("##### The 1% Journey")

# A zebra earns its stripes by showing up, not by hitting numbers — one stripe per
# STRIPE_INTERVAL all-time check-ins, never resets, never graded. No countdown is shown
# day-to-day (that would just be a streak in disguise) — a stripe unlocking gets a quiet
# celebration the moment it happens, then goes back to being just a picture of your journey.
STRIPE_SLOTS = 20
STRIPE_INTERVAL = 5
total_checkins = get_total_checkins()
stripes_earned = min(total_checkins // STRIPE_INTERVAL, STRIPE_SLOTS)

if 'prev_total_checkins' not in st.session_state:
    st.session_state.prev_total_checkins = total_checkins  # don't celebrate on first-ever load
prev_stripes = min(st.session_state.prev_total_checkins // STRIPE_INTERVAL, STRIPE_SLOTS)
just_unlocked = stripes_earned > prev_stripes
st.session_state.prev_total_checkins = total_checkins

segments_html = "".join(
    f'<div class="stripe-segment{" earned" if i < stripes_earned else ""}"></div>' for i in range(STRIPE_SLOTS)
)
st.markdown(f'<div class="stripe-track">{segments_html}</div>', unsafe_allow_html=True)

if just_unlocked:
    st.success(f"🦓 Look — you unlocked a stripe! ({stripes_earned}/{STRIPE_SLOTS}) This isn't a streak to keep or a strike to beat, just a record of caring for your body, at your pace.")
elif stripes_earned >= STRIPE_SLOTS:
    st.caption(f"🦓 Fully striped — {total_checkins} check-ins and counting. This zebra earned every stripe.")
elif stripes_earned > 0:
    st.caption(f"🦓 {stripes_earned} stripe{'s' if stripes_earned != 1 else ''} earned so far — a record of showing up, not a streak to keep.")
else:
    st.caption("🦓 Every stripe here is earned by showing up — however that looks today. Can't do anything today? Marking a Rest or Flare Day counts too.")

st.markdown("*Doing a little is better than pushing too hard. Rest is a success. Progress isn't linear — and that's normal.*")

if 'date_picker' not in st.session_state:
    st.session_state.date_picker = datetime.date.today()

def _jump_to_today():
    # Runs before the script reruns, so it's safe to touch a keyed widget's
    # state here — doing this after st.date_input() below would raise
    # StreamlitAPIException ("cannot be modified after the widget ... is instantiated").
    st.session_state.date_picker = datetime.date.today()

col_d1, col_d2 = st.columns([3, 1])
with col_d1:
    selected_date = st.date_input("🗓️ Select Date for Entry", key="date_picker")
with col_d2:
    st.write("")
    st.button("📅 Today", on_click=_jump_to_today)

date_str = selected_date.strftime("%Y-%m-%d")

day_data = get_day_data(date_str)
ensure_day_exists(date_str)

# --- STATUS BAR: Rest Day / Flare Day ---
# Lives above the tabs on purpose: on a flare/brain-fog day, reaching this shouldn't require
# clicking into a tab and scrolling first. Declaring a status also collapses the optional
# sections in the tabs below (see is_low_energy_day).
st.write("**How are you today?**")
st.caption("Can't do anything today? Just tap Rest or Flare below — that's a complete entry on its own.")
col_rest, col_flare = st.columns(2)
with col_rest:
    is_rest = bool(day_data.get('is_rest_day', 0)) if day_data else False
    if is_rest:
        if st.button("🛡️ Rest Day active — tap to undo", use_container_width=True, type="primary"):
            with get_db() as conn:
                conn.execute("UPDATE daily_logs SET is_rest_day = 0 WHERE date = ?", (date_str,))
                conn.commit()
            st.rerun()
    else:
        if st.button("🛡️ Declare Today a Rest Day", use_container_width=True):
            with get_db() as conn:
                conn.execute("UPDATE daily_logs SET is_rest_day = 1 WHERE date = ?", (date_str,))
                conn.commit()
            st.rerun()
with col_flare:
    is_flare = bool(day_data.get('is_flare_day', 0)) if day_data else False
    if is_flare:
        if st.button("🌩️ Flare Day active — tap to undo", use_container_width=True, type="primary"):
            with get_db() as conn:
                conn.execute("UPDATE daily_logs SET is_flare_day = 0 WHERE date = ?", (date_str,))
                conn.commit()
            st.rerun()
    else:
        if st.button("🌩️ Mark as a Flare/Sick Day", use_container_width=True):
            with get_db() as conn:
                conn.execute("UPDATE daily_logs SET is_flare_day = 1 WHERE date = ?", (date_str,))
                conn.commit()
            st.rerun()

is_low_energy_day = is_rest or is_flare
if is_flare:
    st.warning("🌩️ Flare/Sick Day noted. Take the care you need — this day is automatically left out of your averages and comparisons. Non-essential sections below are collapsed; open anything you're up for.")
elif is_rest:
    st.success("🛡️ Rest Day Shield active for today. Protecting your body is the work today. Non-essential sections below are collapsed; open anything you're up for.")
st.caption("Marking a status needs no other entry to count — even with zero other data, it's enough, and it's never held against a trend or comparison.")

st.divider()

tabs = st.tabs(["💧 Daily Vitals & Fuel", "🏃‍♀️ Movement & Calisthenics", "📊 Insights & Trends", "⚙️ Settings"])

# ==========================================
# TAB 1: DAILY VITALS & NUTRITION
# ==========================================
with tabs[0]:
    df_week = get_range_daily(days=6, end_date_str=date_str)
    days_logged = len(df_week)
    water_today = day_data.get('water_ml', 0) if day_data else 0
    steps_today = day_data.get('steps', 0) if day_data else 0
    mental_today = (day_data.get('mental_state') or None) if day_data else None
    body_today = (day_data.get('body_feeling') or None) if day_data else None

    act_count, cal_count, ther_count = get_day_summary_counts(date_str)
    total_events = act_count + cal_count + ther_count

    m1, m2, m3, m4 = st.columns(4)
    m1.metric("💧 Liquids", f"{water_today} ml", f"goal {WATER_GOAL} ml", delta_color="off")
    m2.metric("👣 Steps", f"{int(steps_today)}")
    m3.metric("🥩 Protein", f"{int(day_data.get('protein_g', 0) or 0)} g", f"goal {PROTEIN_GOAL} g", delta_color="off")
    m4.metric("✅ Logged acts today", total_events)

    def _plural(n, noun):
        return f"{n} {noun}" + ("" if n == 1 else "s")

    summary_text = "🌱 **Today's gentle overview:** "
    if is_flare:
        summary_text += "🌩️ You're navigating a flare or feeling unwell today. Anything logged — or nothing at all — is completely fine."
    else:
        if is_rest:
            summary_text += "🛡️ You chose a Rest Day and protected your body. "
        feeling_bits = []
        if mental_today:
            feeling_bits.append(f"mental state logged as **{mental_today}**")
        if body_today:
            feeling_bits.append(f"body/pain as **{body_today}**")
        if feeling_bits:
            summary_text += "Today's " + " and ".join(feeling_bits) + ". "
        breakdown = []
        if act_count:
            breakdown.append(_plural(act_count, "custom activity").replace("activitys", "activities"))
        if cal_count:
            breakdown.append(_plural(cal_count, "calisthenics session"))
        if ther_count:
            breakdown.append(_plural(ther_count, "therapy session"))
        if breakdown:
            summary_text += "Logged: " + ", ".join(breakdown) + "."
        elif not feeling_bits and not is_rest:
            summary_text += "Nothing logged yet today — whatever you do (or don't), it's exactly enough."
    st.info(summary_text)

    if days_logged > 1:
        rest_days_count = df_week['is_rest_day'].sum() if 'is_rest_day' in df_week.columns else 0
        rest_text = f" (including {int(rest_days_count)} Rest Day(s))" if rest_days_count > 0 else ""
        week_scores = df_week.assign(
            mental_score=df_week['mental_state'].map(MENTAL_SCALE),
            body_score=df_week['body_feeling'].map(BODY_SCALE),
        )
        score_bits = []
        if week_scores['mental_score'].notna().any():
            score_bits.append(f"mental state averaged **{week_scores['mental_score'].mean():.1f}/5**")
        if week_scores['body_score'].notna().any():
            score_bits.append(f"body/pain averaged **{week_scores['body_score'].mean():.1f}/5**")
        score_text = (" Over that stretch, your " + " and ".join(score_bits) + ".") if score_bits else ""
        st.success(f"💙 You've checked in **{days_logged}** time(s) over the last 7 days{rest_text}.{score_text}")
    else:
        st.success("💙 First check-in for this stretch — welcome. Take everything at your own pace.")

    st.divider()

    st.subheader("🧠 Mind & Body")
    with st.form("mind_body_form"):
        mental_val = day_data.get('mental_state', "Okay") or "Okay"
        mental_state = feeling_control("Mental State", MENTAL_OPTIONS, MENTAL_EMOJI, mental_val, key="mind_mental")

        body_val = day_data.get('body_feeling', "Manageable") or "Manageable"
        body_feeling = feeling_control("Body/Pain Feeling", BODY_OPTIONS, BODY_EMOJI, body_val, key="mind_body")

        saved_braces_str = day_data.get('braces_used', "[]") or "[]"
        try:
            saved_braces = eval(saved_braces_str, {"__builtins__": {}}, {})
        except Exception:
            saved_braces = []

        braces = st.multiselect("Braces Used", ["None", "Wrist", "Knee", "SI Belt", "Ring Splints", "Ankle", "Neck"], default=saved_braces)
        brace_comfort = st.slider("Brace Comfort/Helpfulness", 1, 10, int(day_data.get('brace_comfort', 5) or 5))

        if st.form_submit_button("Save Mind & Body State"):
            with get_db() as conn:
                conn.execute("UPDATE daily_logs SET mental_state=?, body_feeling=?, braces_used=?, brace_comfort=? WHERE date=?",
                             (mental_state, body_feeling, str(braces), brace_comfort, date_str))
                conn.commit()
            st.success("Updated successfully!")
            st.rerun()

    # --- Phase 2: Soreness-or-Crash quick check ---
    # Auto-expanded when today's body feeling looks rough, since that's when the question
    # actually matters; otherwise available but tucked away so it's not noise on good days.
    body_feeling_now = day_data.get('body_feeling') or body_feeling
    looks_rough_today = body_feeling_now in ("Severe Pain/Stiff", "Achy")
    recent_eccentric = get_recent_eccentric_session(date_str)

    with st.expander("🔍 Soreness or Crash? A quick check", expanded=looks_rough_today):
        st.caption(
            "Ordinary muscle soreness (DOMS) after exercise and a PEM/crash aren't the same thing, and they call for "
            "different responses. This is three quick questions to help tell them apart — a reflection tool, not a diagnosis."
        )
        if recent_eccentric:
            st.caption(f"📎 For context: you logged Eccentric-tagged **{recent_eccentric['exercise']}** on {recent_eccentric['date']}.")

        with st.form("soreness_check_form"):
            onset = st.radio(
                "When did this start, relative to any activity?",
                ["Same day", "1 day after", "2-3 days after", "Not tied to activity / not sure"],
                horizontal=False,
            )
            spread = st.radio(
                "Is it mostly in the specific muscles you worked, or more all-over / flu-like / foggy?",
                ["Localized to muscles worked", "Widespread / systemic"],
                horizontal=False,
            )
            trend = st.radio(
                "Compared to yesterday, is it:",
                ["Easing", "About the same", "Getting worse"],
                horizontal=False,
            )
            if st.form_submit_button("Check this pattern"):
                verdict_key, verdict_label, verdict_msg = evaluate_soreness_or_crash(onset, spread, trend)
                save_soreness_check(date_str, onset, spread, trend, verdict_key, verdict_label)
                if verdict_key == "possible_crash":
                    st.warning(f"**{verdict_label}**\n\n{verdict_msg}")
                elif verdict_key == "likely_doms":
                    st.success(f"**{verdict_label}**\n\n{verdict_msg}")
                else:
                    st.info(f"**{verdict_label}**\n\n{verdict_msg}")

        todays_checks = get_soreness_checks(date_str)
        if not todays_checks.empty:
            st.caption("Today's check(s) so far:")
            for _, row in todays_checks.iterrows():
                st.caption(f"• {row['verdict_label']} — onset: {row['onset']}, spread: {row['spread']}, trend: {row['trend']}")

    st.divider()

    with st.expander("☕ Hydration & Liquids", expanded=not is_low_energy_day):
        with get_db() as conn:
            liquid_df = pd.read_sql_query("SELECT * FROM liquid_logs WHERE date=?", conn, params=(date_str,))

        total_hydration = liquid_df['hydration_ml'].sum() if not liquid_df.empty else (day_data.get('water_ml', 0) or 0)
        total_poured = liquid_df['amount_ml'].sum() if not liquid_df.empty else (day_data.get('water_ml', 0) or 0)
        st.progress(min(total_hydration / WATER_GOAL, 1.0) if WATER_GOAL else 0, text=f"{int(total_hydration)} / {WATER_GOAL} ml hydration credit")
        if total_poured != total_hydration:
            st.caption(f"{int(total_poured)} ml poured — caffeine/alcohol count for less, milk/electrolytes a little more. Estimate only, not medical guidance.")

        with st.form("liquid_form"):
            ll1, ll2 = st.columns(2)
            with ll1:
                drink_options = list(DRINK_HYDRATION_FACTOR.keys()) + ["Other (Type below)"]
                drink_type_sel = st.selectbox("Drink Type", drink_options)
                drink_type_custom = st.text_input("If 'Other', specify:", placeholder="e.g. Milk")
            with ll2:
                drink_amount = st.number_input("Amount (ml)", min_value=1, value=250, step=10)
                shake_protein_g = st.number_input("Protein in this drink (g) — only if it's a shake", min_value=0.0, value=0.0, step=1.0)

            if st.form_submit_button("➕ Add Liquid"):
                final_drink = drink_type_custom if "Other" in drink_type_sel and drink_type_custom else drink_type_sel
                factor = DRINK_HYDRATION_FACTOR.get(final_drink, 1.0)
                hydration_ml = round(drink_amount * factor)
                with get_db() as conn:
                    conn.execute("INSERT INTO liquid_logs (date, drink_type, amount_ml, hydration_ml) VALUES (?, ?, ?, ?)",
                                 (date_str, final_drink, drink_amount, hydration_ml))
                    conn.execute("UPDATE daily_logs SET water_ml = water_ml + ? WHERE date = ?", (hydration_ml, date_str))
                    if drink_type_sel == "Protein Shake" and shake_protein_g > 0:
                        conn.execute("UPDATE daily_logs SET protein_g = protein_g + ? WHERE date = ?", (round(shake_protein_g), date_str))
                    conn.commit()
                st.rerun()

        if not liquid_df.empty:
            st.write("**Today's Log:**")
            for _, row in liquid_df.iterrows():
                if row['amount_ml'] == row['hydration_ml']:
                    st.caption(f"• {row['amount_ml']} ml — {row['drink_type']}")
                else:
                    st.caption(f"• {row['amount_ml']} ml — {row['drink_type']} (≈{int(row['hydration_ml'])} ml hydration)")
            if st.button("🗑️ Reset Today's Liquids"):
                with get_db() as conn:
                    conn.execute("DELETE FROM liquid_logs WHERE date=?", (date_str,))
                    conn.execute("UPDATE daily_logs SET water_ml = 0 WHERE date=?", (date_str,))
                    conn.commit()
                st.rerun()

    with st.expander("🥩 Nutrition & Supplements", expanded=not is_low_energy_day):
        current_protein = int(day_data.get('protein_g', 0) or 0)
        current_creatine = float(day_data.get('creatine_g', 0.0) or 0.0)

        st.progress(min(current_protein / PROTEIN_GOAL, 1.0) if PROTEIN_GOAL else 0, text=f"{current_protein} / {PROTEIN_GOAL} g protein")
        st.caption(f"Creatine today: {current_creatine} g")

        with st.form("protein_form"):
            pf1, pf2 = st.columns([2, 1])
            with pf1:
                protein_amount = st.number_input("Protein amount", min_value=0.0, value=25.0, step=1.0)
            with pf2:
                protein_unit = st.selectbox("Unit", list(PROTEIN_UNIT_GRAMS.keys()))
            if st.form_submit_button("➕ Add Protein"):
                grams_to_add = round(protein_amount * PROTEIN_UNIT_GRAMS[protein_unit])
                with get_db() as conn:
                    conn.execute("UPDATE daily_logs SET protein_g = protein_g + ? WHERE date = ?", (grams_to_add, date_str))
                    conn.commit()
                st.rerun()

        cp2, cp3 = st.columns(2)
        if cp2.button("+ 5g Creatine"):
            with get_db() as conn:
                conn.execute("UPDATE daily_logs SET creatine_g = creatine_g + 5 WHERE date = ?", (date_str,))
                conn.commit()
            st.rerun()
        if cp3.button("Reset Nutrition"):
            with get_db() as conn:
                conn.execute("UPDATE daily_logs SET protein_g=0, creatine_g=0 WHERE date = ?", (date_str,))
                conn.commit()
            st.rerun()

    with st.expander("📏 Body Metrics (weight, height, body fat)", expanded=False):
        st.caption("These don't change much day to day — carries forward your last recorded value, so you only need to touch it when something actually changes.")
        latest_metrics = get_latest_body_metrics(date_str)
        with st.form("body_metrics_form"):
            weight = st.number_input("Weight (kg)", min_value=0.0, value=float(day_data.get('weight') or latest_metrics.get('weight') or 0.0), step=0.1)
            height = st.number_input("Height (cm)", min_value=0.0, value=float(day_data.get('height') or latest_metrics.get('height') or 0.0), step=0.1)
            fat_pct = st.number_input("Body Fat (%)", min_value=0.0, value=float(day_data.get('fat_percentage') or latest_metrics.get('fat_percentage') or 0.0), step=0.1)

            if st.form_submit_button("Save Body Metrics"):
                with get_db() as conn:
                    conn.execute("UPDATE daily_logs SET weight=?, height=?, fat_percentage=? WHERE date=?",
                                 (weight, height, fat_pct, date_str))
                    conn.commit()
                st.success("Metrics updated!")
                st.rerun()

# ==========================================
# TAB 2: MOVEMENT & CALISTHENICS
# ==========================================
with tabs[1]:
    st.header("👣 Steps & The Gentle-Growth Rule")
    avg_steps = get_weekly_average_steps(date_str)
    goal_steps = int(avg_steps * GROWTH_GOAL)
    caution_steps = int(avg_steps * CAUTION_PCT)

    c1, c2, c3 = st.columns(3)
    c1.metric("Recent baseline", int(avg_steps), help="Average of your last 7 logged, non-rest, non-flare days — flares and rest days are excluded so a hard stretch never quietly lowers the bar.")
    c2.metric("Gentle growth goal", goal_steps)
    c3.metric("Caution line", caution_steps)
    if is_flare:
        st.caption("This is a Flare/Sick Day — the comparison below is informational only, and today's number won't feed back into your baseline.")

    col_st1, col_st2 = st.columns([2, 1])
    with col_st1:
        steps = st.number_input("Total Steps Today", min_value=0, step=100, value=int(day_data.get('steps', 0) or 0))
    with col_st2:
        st.write("")
        st.write("")
        if st.button("Save Steps"):
            with get_db() as conn:
                conn.execute("UPDATE daily_logs SET steps = ? WHERE date = ?", (steps, date_str))
                conn.commit()

            if is_flare:
                st.info("🌩️ Logged. Flare/sick days are excluded from your baseline automatically — no comparison needed today.")
            elif avg_steps > 0:
                if steps > caution_steps:
                    st.warning("💛 Higher than your recent baseline. Not a problem — just data. Some people find extra rest and hydration helpful after a day like this; that's your call to make.")
                elif steps >= goal_steps:
                    st.success("🎉 " + random.choice(MOTIVATION_GROWTH))
                elif steps < avg_steps * 0.85:
                    st.info("🌤️ " + random.choice(MOTIVATION_LOW_STEPS))
                else:
                    st.success("✅ " + random.choice(MOTIVATION_STEADY))
            else:
                st.success("Logged! Every entry builds your baseline.")

    st.divider()

    with st.expander("🚴‍♀️ Custom Activities", expanded=not is_low_energy_day):
        col_a, col_b, col_c = st.columns(3)
        with col_a:
            act_name = st.text_input("Activity (e.g., Walked with Niece)")
        with col_b:
            act_dur = st.number_input("Duration (minutes)", min_value=0, step=5)
        with col_c:
            act_weight = st.number_input("Added External Weight (kg)", min_value=0.0, step=0.1)

        st.write("How did you feel doing this?")
        col_af1, col_af2 = st.columns(2)
        with col_af1:
            act_mental = feeling_control("Mental State", MENTAL_OPTIONS, MENTAL_EMOJI, "Okay", key="act_mental")
        with col_af2:
            act_body = feeling_control("Body/Pain Feeling", BODY_OPTIONS, BODY_EMOJI, "Manageable", key="act_body")

        if st.button("Log Activity"):
            with get_db() as conn:
                conn.execute("INSERT INTO activities (date, activity_name, duration_min, extra_weight_kg, mental_state, body_feeling) VALUES (?, ?, ?, ?, ?, ?)",
                             (date_str, act_name, act_dur, act_weight, act_mental, act_body))
                conn.commit()
            st.success(f"Logged {act_name or 'activity'}! Every little bit counts.")

    with st.expander("💆‍♀️ Recovery & Passive Therapies", expanded=not is_low_energy_day):
        st.write("TENS, massage, heat, acupuncture — passive recovery is vital self-care, not optional extra credit.")
        col_t1, col_t2 = st.columns(2)
        with col_t1:
            ther_name = st.text_input("Therapy (e.g., TENS, Massage, Heat Pad)")
        with col_t2:
            ther_dur = st.number_input("Duration (minutes)", min_value=0, step=5, key="ther_dur")

        st.write("How did you feel during/after this?")
        col_tf1, col_tf2 = st.columns(2)
        with col_tf1:
            ther_mental = feeling_control("Mental State", MENTAL_OPTIONS, MENTAL_EMOJI, "Okay", key="ther_mental")
        with col_tf2:
            ther_body = feeling_control("Body/Pain Feeling", BODY_OPTIONS, BODY_EMOJI, "Manageable", key="ther_body")

        if st.button("Log Therapy"):
            with get_db() as conn:
                conn.execute("INSERT INTO therapies (date, therapy_name, duration_min, mental_state, body_feeling) VALUES (?, ?, ?, ?, ?)",
                             (date_str, ther_name, ther_dur, ther_mental, ther_body))
                conn.commit()
            st.success(f"Logged {ther_name or 'therapy'}! Healing is hard work.")

    with st.expander("🤸 Hybrid Calisthenics", expanded=not is_low_energy_day):
        st.caption(f"Guideline: average a comfort score of {COMFORT_THRESHOLD}+ across your last 3 sessions before considering the next progression — never a requirement, always your call.")

        cal_type = st.selectbox("Exercise Type", ["Pushups", "Squats", "Pullups", "Leg Raises", "Bridges", "Twists"])
        progressions = {
            "Pushups": ["Wall Pushups (~35% BW)", "Incline Pushups (~50% BW)", "Knee Pushups (~60% BW)", "Full Pushups (~70% BW)"],
            "Squats": ["Jackknife Squats", "Assisted Squats", "Half Squats", "Full Squats"]
        }
        cal_prog = st.selectbox("Progression Tier", progressions.get(cal_type, ["Tier 1", "Tier 2", "Tier 3"]))
        cal_mode = st.selectbox(
            "Contraction Mode", CONTRACTION_MODES,
            help="Eccentric = the slow/controlled lowering phase. Tagging this lets Insights track your eccentric "
                 "work separately — it's the mode most linked to the 'more strength for less spoons' effect, and "
                 "also the one most linked to first-time soreness (see the science note in Insights).",
        )

        col_c1, col_c2 = st.columns([1, 2])
        with col_c1:
            cal_sets = st.number_input("Sets", min_value=0, value=2)
            cal_reps = st.number_input("Reps (per set)", min_value=0, value=10)
        with col_c2:
            comfort_score = st.slider("Comfort Level (1 = Painful, 5 = Stable/Great)", 1.0, 5.0, 3.0, 0.1)
            st.info(f"**Current Status:** {get_comfort_emoji(comfort_score)}")

        st.write("How did you feel doing this?")
        col_cf1, col_cf2 = st.columns(2)
        with col_cf1:
            cal_mental = feeling_control("Mental State", MENTAL_OPTIONS, MENTAL_EMOJI, "Okay", key="cal_mental")
        with col_cf2:
            cal_body = feeling_control("Body/Pain Feeling", BODY_OPTIONS, BODY_EMOJI, "Manageable", key="cal_body")

        if st.button("Log Calisthenics"):
            with get_db() as conn:
                conn.execute(
                    "INSERT INTO calisthenics (date, exercise, progression, sets, reps, comfort_score, mental_state, body_feeling, contraction_mode) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                    (date_str, cal_type, cal_prog, cal_sets, cal_reps, comfort_score, cal_mental, cal_body, cal_mode))
                conn.commit()
            st.success("Logged! Staying at your current tier is just as celebrated here as moving up.")

            if check_calisthenics_comfort(cal_type, date_str):
                st.balloons()
                st.success(f"🌟 Your last 3 sessions for {cal_type} averaged {COMFORT_THRESHOLD}+ comfort. That's your data telling you this tier has been consistently comfortable — worth weighing alongside how you feel before deciding on the next progression, entirely at your own pace.")

# ==========================================
# TAB 3: INSIGHTS & TRENDS
# ==========================================
with tabs[2]:
    st.header("📖 Insights & Trends")

    chapter_month_start, df_chapter_month, chapter_act_n, chapter_cal_n, chapter_ther_n = get_month_chapter_data(date_str)
    chapter_title, chapter_body = build_month_chapter(chapter_month_start, df_chapter_month, chapter_act_n, chapter_cal_n, chapter_ther_n)
    st.subheader(f"📅 {chapter_month_start.strftime('%B %Y')} — Chapter: {chapter_title}")
    st.write(chapter_body)
    st.caption("Not a scorecard — a reflection on showing up, however that looked this month.")
    st.divider()

    st.info("💡 " + random.choice(REST_FACTS))
    with st.expander("📚 Why this app works this way — the science"):
        st.caption("Evidence-based principles behind this app's pacing philosophy, for chronic pain, dysautonomia, and hypermobility (EDS/HSD). Not medical advice — for context alongside your care team.")
        for p in ADAPTIVE_BODY_PRINCIPLES:
            st.markdown(f"**{p['title']}**")
            st.write(p['fact'])
            st.write(p['inspiration'])
            st.caption(f"— {p['citation']}")
            st.divider()

    range_choice = st.radio("Show trends for the last:", ["14 days", "30 days", "90 days"], horizontal=True, index=1)
    days_map = {"14 days": 14, "30 days": 30, "90 days": 90}
    df_range = get_range_daily(days=days_map[range_choice], end_date_str=date_str)

    with get_db() as conn:
        df_daily = pd.read_sql_query("SELECT * FROM daily_logs ORDER BY date ASC", conn)
        df_act = pd.read_sql_query("SELECT * FROM activities", conn)
        df_cal = pd.read_sql_query("SELECT * FROM calisthenics", conn)
        df_ther = pd.read_sql_query("SELECT * FROM therapies", conn)

    if df_range.empty or df_range['steps'].fillna(0).sum() == 0 and df_range['water_ml'].fillna(0).sum() == 0:
        st.warning("Not enough data yet in this range to show trends. Keep checking in — the picture builds over time.")
    else:
        df_range = df_range.copy()
        df_range['date'] = pd.to_datetime(df_range['date'])
        df_range['mental_score'] = df_range['mental_state'].map(MENTAL_SCALE)
        df_range['body_score'] = df_range['body_feeling'].map(BODY_SCALE)

        # --- Row: Steps + Water trend ---
        col_ch1, col_ch2 = st.columns(2)
        with col_ch1:
            fig_steps = go.Figure()
            fig_steps.add_trace(go.Bar(x=df_range['date'], y=df_range['steps'], name="Steps", marker_color=PRIMARY))
            rolling = df_range['steps'].rolling(7, min_periods=1).mean()
            fig_steps.add_trace(go.Scatter(x=df_range['date'], y=rolling, name="7-day average", line=dict(color=ACCENT, width=3)))
            fig_steps.update_layout(title="Steps over time (bars) vs. 7-day trend (line)", height=320,
                                     plot_bgcolor="white", paper_bgcolor="white", margin=dict(t=40, b=20))
            st.plotly_chart(fig_steps, use_container_width=True)
            st.caption("The trend line matters far more than any single day's bar.")

        with col_ch2:
            fig_water = px.bar(df_range, x='date', y='water_ml', title="Daily Liquids (ml)", color_discrete_sequence=[PRIMARY])
            fig_water.add_hline(y=WATER_GOAL, line_dash="dot", line_color=ACCENT, annotation_text="goal")
            fig_water.update_layout(height=320, plot_bgcolor="white", paper_bgcolor="white", margin=dict(t=40, b=20))
            st.plotly_chart(fig_water, use_container_width=True)

        # --- Row: Mental + Body trend ---
        col_ch3, col_ch4 = st.columns(2)
        with col_ch3:
            fig_mental = px.line(df_range, x='date', y='mental_score', markers=True, title="Mental State Trend (1=Exhausted, 5=Energized)")
            fig_mental.update_traces(line_color=PRIMARY)
            fig_mental.update_yaxes(range=[0.5, 5.5])
            fig_mental.update_layout(height=300, plot_bgcolor="white", paper_bgcolor="white", margin=dict(t=40, b=20))
            st.plotly_chart(fig_mental, use_container_width=True)
        with col_ch4:
            fig_body = px.line(df_range, x='date', y='body_score', markers=True, title="Body/Pain Trend (1=Severe, 5=Loose & Stable)")
            fig_body.update_traces(line_color=ACCENT)
            fig_body.update_yaxes(range=[0.5, 5.5])
            fig_body.update_layout(height=300, plot_bgcolor="white", paper_bgcolor="white", margin=dict(t=40, b=20))
            st.plotly_chart(fig_body, use_container_width=True)

        # --- Consistency calendar-style strip ---
        st.subheader("🗓️ Check-in Consistency")
        flare_days = set(df_daily.loc[df_daily.get('is_flare_day', 0) == 1, 'date']) if 'is_flare_day' in df_daily.columns else set()
        rest_days = set(df_daily.loc[df_daily['is_rest_day'] == 1, 'date']) - flare_days
        activity_days = set(df_daily.loc[(df_daily['water_ml'] > 0) | (df_daily['steps'] > 0), 'date']) - flare_days - rest_days
        strip = df_range[['date']].copy()
        strip['date_str'] = strip['date'].dt.strftime("%Y-%m-%d")

        def _status(d):
            if d in flare_days:
                return "Flare/Sick"
            if d in rest_days:
                return "Rest"
            if d in activity_days:
                return "Logged"
            return "No entry"

        strip['status'] = strip['date_str'].apply(_status)
        fig_strip = px.scatter(strip, x='date', y=[1]*len(strip), color='status',
                                color_discrete_map={"Logged": PRIMARY, "Rest": SAND, "Flare/Sick": TEAL, "No entry": "#E8E8E8"},
                                title=None, height=140)
        fig_strip.update_traces(marker=dict(size=16, symbol='square'))
        fig_strip.update_yaxes(visible=False)
        fig_strip.update_layout(plot_bgcolor="white", paper_bgcolor="white", margin=dict(t=10, b=20), showlegend=True)
        st.plotly_chart(fig_strip, use_container_width=True)
        st.caption("This is a record, not a scoreboard. Flare days are marked, not blank — they're honored the same as any other entry, and none of these squares are meant to be filled in every day.")

        # --- Calisthenics comfort trend ---
        if not df_cal.empty:
            st.subheader("🤸 Calisthenics Comfort by Exercise")
            df_cal_plot = df_cal.copy()
            df_cal_plot['date'] = pd.to_datetime(df_cal_plot['date'])
            cal_group_choice = st.radio(
                "Group by:", ["Exercise", "Contraction mode"], horizontal=True, key="cal_group_choice",
                help="Grouping by contraction mode makes it easy to see whether Eccentric-tagged sets are trending "
                     "toward comfort as fast as (or faster than) Concentric ones — a rough proxy for the repeated bout effect.",
            )
            group_col = 'exercise' if cal_group_choice == "Exercise" else 'contraction_mode'
            df_cal_grouped = df_cal_plot.dropna(subset=[group_col]) if group_col == 'contraction_mode' else df_cal_plot
            if df_cal_grouped.empty:
                st.caption("No contraction-mode-tagged sessions logged yet — tag a set as Eccentric/Concentric/Isometric in Movement & Calisthenics to see this view.")
            else:
                fig_cal = px.line(df_cal_grouped.sort_values('date'), x='date', y='comfort_score', color=group_col, markers=True)
                fig_cal.add_hline(y=COMFORT_THRESHOLD, line_dash="dot", line_color=SUCCESS, annotation_text="progression threshold")
                fig_cal.update_layout(height=320, plot_bgcolor="white", paper_bgcolor="white", margin=dict(t=20, b=20))
                st.plotly_chart(fig_cal, use_container_width=True)

    st.divider()

    # --- PEM / delayed symptom pattern check ---
    st.subheader("🔬 Delayed Symptom Patterns (PEM check)")
    st.caption("Post-exertional malaise often shows up 1-3 days after exertion, not same-day. This compares a day's steps against your body/mental scores that many days later — purely descriptive, not a diagnosis.")

    pem_note = None
    lag = st.select_slider("Look this many days ahead", options=[1, 2, 3], value=1)
    df_pem = get_range_daily(days=days_map[range_choice], end_date_str=date_str).copy()
    if not df_pem.empty:
        df_pem['date'] = pd.to_datetime(df_pem['date'])
        df_pem = df_pem.sort_values('date').reset_index(drop=True)
        df_pem['body_score'] = df_pem['body_feeling'].map(BODY_SCALE)
        df_pem['mental_score'] = df_pem['mental_state'].map(MENTAL_SCALE)
        df_pem[f'body_score_+{lag}d'] = df_pem['body_score'].shift(-lag)
        pem_valid = df_pem.dropna(subset=['steps', f'body_score_+{lag}d'])
        pem_valid = pem_valid[pem_valid['steps'] > 0]

        if len(pem_valid) >= 4:
            baseline = pem_valid['steps'].mean()
            pem_valid = pem_valid.copy()
            pem_valid['exertion'] = pem_valid['steps'].apply(lambda s: "Higher exertion day" if s > baseline else "Typical/lower day")

            col_p1, col_p2 = st.columns(2)
            with col_p1:
                fig_pem = px.scatter(pem_valid, x='steps', y=f'body_score_+{lag}d', color='exertion',
                                      color_discrete_map={"Higher exertion day": TEAL, "Typical/lower day": PRIMARY},
                                      title=f"Steps vs. body/pain score {lag} day(s) later")
                fig_pem.update_layout(height=320, plot_bgcolor="white", paper_bgcolor="white", margin=dict(t=40, b=20))
                st.plotly_chart(fig_pem, use_container_width=True)
            with col_p2:
                bucket_avg = pem_valid.groupby('exertion')[f'body_score_+{lag}d'].mean().reset_index()
                fig_bucket = px.bar(bucket_avg, x='exertion', y=f'body_score_+{lag}d',
                                     title=f"Average body/pain score {lag} day(s) after each type of day",
                                     color='exertion', color_discrete_map={"Higher exertion day": TEAL, "Typical/lower day": PRIMARY})
                fig_bucket.update_yaxes(range=[0, 5.5])
                fig_bucket.update_layout(height=320, plot_bgcolor="white", paper_bgcolor="white", margin=dict(t=40, b=20), showlegend=False)
                st.plotly_chart(fig_bucket, use_container_width=True)

            corr = pem_valid['steps'].corr(pem_valid[f'body_score_+{lag}d'])
            n = len(pem_valid)
            st.caption(f"Correlation coefficient: r = {corr:.2f} (n = {n} day-pairs). With this few data points, treat this as a pattern worth watching, not a conclusion — it firms up as you log more days.")
            pem_note = (f"Comparing daily steps against body/pain score {lag} day(s) later over the last {days_map[range_choice]} days "
                        f"(n={n} pairs): correlation r={corr:.2f}. Higher-exertion days averaged a body/pain score of "
                        f"{bucket_avg.loc[bucket_avg['exertion']=='Higher exertion day', f'body_score_+{lag}d'].mean():.1f}/5 "
                        f"vs {bucket_avg.loc[bucket_avg['exertion']=='Typical/lower day', f'body_score_+{lag}d'].mean():.1f}/5 for typical/lower days, "
                        f"{lag} day(s) later. Patient-observed pattern, not a clinical finding.")
        else:
            st.info("Not enough overlapping data yet for this window (need at least 4 days with both steps and a body-feeling entry a few days later). Keep logging — this fills in over time.")
    else:
        st.info("No data yet in this range for the PEM check.")

    st.divider()

    # --- Soreness-or-Crash check history ---
    with get_db() as conn:
        df_soreness = pd.read_sql_query(
            "SELECT * FROM soreness_checks WHERE date >= ? AND date <= ? ORDER BY date DESC",
            conn, params=(df_range['date'].min().strftime("%Y-%m-%d") if not df_range.empty else date_str,
                          df_range['date'].max().strftime("%Y-%m-%d") if not df_range.empty else date_str))
    if not df_soreness.empty:
        st.subheader("🔍 Soreness-or-Crash Check History")
        st.caption("Every 'Soreness or Crash?' check you've logged in this range, most recent first.")
        st.dataframe(
            df_soreness[['date', 'verdict_label', 'onset', 'spread', 'trend']].rename(columns={'verdict_label': 'verdict'}),
            use_container_width=True,
        )
        st.divider()

    # --- Weather overlay ---
    st.subheader("🌦️ Weather Context")
    weather_note = None
    if not LOCATION_LAT or not LOCATION_LON:
        st.info("Add a location in ⚙️ Settings to see atmospheric pressure, temperature, and humidity plotted against your trends — useful for spotting weather-linked flares, especially with dysautonomia.")
    else:
        w_start = df_range['date'].min() if not df_range.empty else date_str
        w_end = df_range['date'].max() if not df_range.empty else date_str
        w_start_str = w_start.strftime("%Y-%m-%d") if hasattr(w_start, "strftime") else str(w_start)[:10]
        w_end_str = w_end.strftime("%Y-%m-%d") if hasattr(w_end, "strftime") else str(w_end)[:10]
        df_weather = fetch_weather_range(float(LOCATION_LAT), float(LOCATION_LON), w_start_str, w_end_str)

        if df_weather.empty:
            st.info("No weather data cached yet for this range — it fetches automatically once you have logged days in this window.")
        else:
            df_w = df_weather.copy()
            df_w['date'] = pd.to_datetime(df_w['date'])
            df_body = get_range_daily(days=days_map[range_choice], end_date_str=date_str).copy()
            if not df_body.empty:
                df_body['date'] = pd.to_datetime(df_body['date'])
                df_body['body_score'] = df_body['body_feeling'].map(BODY_SCALE)
                merged = pd.merge(df_w, df_body[['date', 'body_score']], on='date', how='inner')
            else:
                merged = pd.DataFrame()

            fig_w = make_subplots(specs=[[{"secondary_y": True}]])
            fig_w.add_trace(go.Scatter(x=df_w['date'], y=df_w['pressure_hpa'], name="Pressure (hPa)", line=dict(color=TEAL)), secondary_y=False)
            if not merged.empty:
                fig_w.add_trace(go.Scatter(x=merged['date'], y=merged['body_score'], name="Body/pain score", line=dict(color=PRIMARY, dash='dot')), secondary_y=True)
            fig_w.update_layout(title=f"Pressure vs. body/pain score — {LOCATION_NAME or 'your location'}", height=340,
                                 plot_bgcolor="white", paper_bgcolor="white", margin=dict(t=40, b=20))
            fig_w.update_yaxes(title_text="Pressure (hPa)", secondary_y=False)
            fig_w.update_yaxes(title_text="Body/pain score (1-5)", range=[0, 5.5], secondary_y=True)
            st.plotly_chart(fig_w, use_container_width=True)

            if not merged.empty and len(merged) >= 4:
                corr_w = merged['pressure_hpa'].corr(merged['body_score'])
                st.caption(f"Correlation between pressure and same-day body/pain score: r = {corr_w:.2f} (n = {len(merged)}). Exploratory only.")
                weather_note = (f"Average atmospheric pressure over the period: {df_w['pressure_hpa'].mean():.1f} hPa. "
                                 f"Correlation with same-day body/pain score: r={corr_w:.2f} (n={len(merged)}). Exploratory, patient-observed.")
            else:
                st.caption("Not enough overlapping days yet to compute a correlation.")

    st.divider()

    # --- Encouraging summary stats (framed around effort, not just output) ---
    st.subheader("🏅 Things worth celebrating")
    total_checkins = len(df_daily[(df_daily['water_ml'] > 0) | (df_daily['steps'] > 0) | (df_daily['is_rest_day'] == 1) | (df_daily.get('is_flare_day', 0) == 1)])
    total_rest_days = int(df_daily['is_rest_day'].sum()) if 'is_rest_day' in df_daily.columns else 0
    total_flare_days = int(df_daily['is_flare_day'].sum()) if 'is_flare_day' in df_daily.columns else 0
    total_therapy_sessions = len(df_ther)
    total_activities_logged = len(df_act) + len(df_cal)

    e1, e2, e3, e4, e5 = st.columns(5)
    e1.metric("Total check-ins", total_checkins)
    e2.metric("Rest days honored", total_rest_days)
    e3.metric("Flare/sick days cared for", total_flare_days)
    e4.metric("Recovery sessions", total_therapy_sessions)
    e5.metric("Movement logs", total_activities_logged)
    st.caption("Every number above represents a choice to show up for yourself, in whatever way was possible that day. None of them need to be higher to count — and unlogged days aren't counted against you either.")

    st.divider()

    # --- EXPORT ---
    st.subheader("📥 Export")
    exp_col1, exp_col2 = st.columns(2)
    with exp_col1:
        if not df_daily.empty:
            csv = df_daily.to_csv(index=False).encode('utf-8')
            st.download_button(label="Download Vitals CSV (raw)", data=csv, file_name='zebrapace_vitals.csv', mime='text/csv', use_container_width=True)
    with exp_col2:
        pdf_start = df_range['date'].min() if not df_range.empty else date_str
        pdf_end = df_range['date'].max() if not df_range.empty else date_str
        pdf_start_str = pdf_start.strftime("%Y-%m-%d") if hasattr(pdf_start, "strftime") else str(pdf_start)[:10]
        pdf_end_str = pdf_end.strftime("%Y-%m-%d") if hasattr(pdf_end, "strftime") else str(pdf_end)[:10]
        df_act_range = df_act[(df_act['date'] >= pdf_start_str) & (df_act['date'] <= pdf_end_str)] if not df_act.empty else df_act
        df_cal_range = df_cal[(df_cal['date'] >= pdf_start_str) & (df_cal['date'] <= pdf_end_str)] if not df_cal.empty else df_cal
        df_ther_range = df_ther[(df_ther['date'] >= pdf_start_str) & (df_ther['date'] <= pdf_end_str)] if not df_ther.empty else df_ther
        df_daily_range = get_range_daily(days=days_map[range_choice], end_date_str=date_str)

        pdf_bytes = generate_doctor_pdf(pdf_start_str, pdf_end_str, df_daily_range, df_act_range, df_cal_range, df_ther_range,
                                         pem_note=pem_note, weather_note=weather_note)
        st.download_button(label="🩺 Doctor Visit Report (PDF)", data=pdf_bytes,
                            file_name=f"zebrapace_report_{pdf_start_str}_to_{pdf_end_str}.pdf",
                            mime="application/pdf", use_container_width=True)
    st.caption(f"The PDF summarizes the same {range_choice} window shown above, including the PEM and weather notes if enough data was available.")

    st.subheader("Daily Vitals History")
    if not df_daily.empty:
        st.dataframe(df_daily.sort_values('date', ascending=False)[
            ['date', 'mental_state', 'body_feeling', 'steps', 'water_ml', 'protein_g', 'weight', 'fat_percentage']
        ], use_container_width=True)
    else:
        st.write("No daily logs found yet.")

    col_h1, col_h2 = st.columns(2)
    with col_h1:
        st.subheader("Recent Activities")
        if not df_act.empty:
            st.dataframe(df_act.sort_values('date', ascending=False)[['date', 'activity_name', 'duration_min', 'mental_state', 'body_feeling']].head(10), use_container_width=True)
        st.subheader("Recent Therapies")
        if not df_ther.empty:
            st.dataframe(df_ther.sort_values('date', ascending=False)[['date', 'therapy_name', 'duration_min', 'mental_state', 'body_feeling']].head(10), use_container_width=True)
    with col_h2:
        st.subheader("Recent Calisthenics")
        if not df_cal.empty:
            cols_to_show = ['date', 'exercise', 'progression', 'comfort_score', 'mental_state', 'body_feeling']
            if 'contraction_mode' in df_cal.columns:
                cols_to_show.insert(3, 'contraction_mode')
            st.dataframe(df_cal.sort_values('date', ascending=False)[cols_to_show].head(10), use_container_width=True)

# ==========================================
# TAB 4: SETTINGS
# ==========================================
with tabs[3]:
    st.header("⚙️ Settings")
    st.caption("Tune the app's thresholds and goals to fit you — none of these are fixed rules.")

    with st.form("settings_form"):
        st.subheader("Movement pacing")
        new_growth = st.number_input("Gentle growth goal (multiplier over 7-day avg)", min_value=1.0, max_value=1.5,
                                      value=GROWTH_GOAL, step=0.01, help="1.01 = aim for 1% more steps than your recent average.")
        new_caution = st.number_input("Caution line (multiplier over 7-day avg)", min_value=1.0, max_value=2.0,
                                       value=CAUTION_PCT, step=0.01, help="Above this, the app gently suggests extra recovery.")

        st.subheader("Calisthenics")
        new_comfort = st.number_input("Comfort threshold to consider next progression (1-5)", min_value=1.0, max_value=5.0,
                                       value=COMFORT_THRESHOLD, step=0.1)

        st.subheader("Daily goals")
        new_water_goal = st.number_input("Water/liquid goal (ml)", min_value=0, value=WATER_GOAL, step=100)
        new_protein_goal = st.number_input("Protein goal (g)", min_value=0, value=PROTEIN_GOAL, step=5)

        st.caption("Note: baselines and comparisons already exclude Rest and Flare/Sick days automatically — there's no setting needed for that, it's built in.")

        if st.form_submit_button("💾 Save Settings"):
            set_setting("growth_goal_pct", new_growth)
            set_setting("caution_pct", new_caution)
            set_setting("comfort_threshold", new_comfort)
            set_setting("water_goal_ml", new_water_goal)
            set_setting("protein_goal_g", new_protein_goal)
            st.success("Settings saved!")
            st.rerun()

    st.divider()
    st.subheader("📍 Location (for weather correlation)")
    if LOCATION_NAME:
        st.caption(f"Currently set to: **{LOCATION_NAME}** ({float(LOCATION_LAT):.2f}, {float(LOCATION_LON):.2f})")
    else:
        st.caption("Not set yet — the Insights tab's weather overlay needs this to fetch pressure/temperature/humidity data.")
    loc_col1, loc_col2 = st.columns([3, 1])
    with loc_col1:
        loc_query = st.text_input("City or place name", placeholder="e.g. Santiago, Chile", label_visibility="collapsed")
    with loc_col2:
        if st.button("Find location", use_container_width=True) and loc_query:
            found = geocode_location(loc_query)
            if found:
                name, lat, lon = found
                set_setting("location_name", name)
                set_setting("location_lat", lat)
                set_setting("location_lon", lon)
                st.success(f"Location set to {name}")
                st.rerun()
            else:
                st.error("Couldn't find that place — try a nearby larger city.")
    st.caption("Uses Open-Meteo's free geocoding and archive weather API (no key required, nothing sent beyond the place name and coordinates).")

    with st.expander("Or enter coordinates directly (e.g. copied from Google Maps)"):
        coord_col1, coord_col2, coord_col3 = st.columns([1, 1, 1])
        with coord_col1:
            manual_lat = st.number_input("Latitude", min_value=-90.0, max_value=90.0,
                                          value=float(LOCATION_LAT) if LOCATION_LAT else 0.0, step=0.0001, format="%.4f")
        with coord_col2:
            manual_lon = st.number_input("Longitude", min_value=-180.0, max_value=180.0,
                                          value=float(LOCATION_LON) if LOCATION_LON else 0.0, step=0.0001, format="%.4f")
        with coord_col3:
            st.write("")
            if st.button("Set coordinates", use_container_width=True):
                set_setting("location_name", f"{manual_lat:.4f}, {manual_lon:.4f}")
                set_setting("location_lat", manual_lat)
                set_setting("location_lon", manual_lon)
                st.success("Location set from coordinates.")
                st.rerun()
        st.caption("In Google Maps: long-press (or right-click) the spot, then tap the lat/lon numbers shown at the top to copy them.")

    st.divider()
    
    st.divider()
    st.subheader("📦 Your data, your property")
    st.caption("Export, import, and delete are rights here, not premium features — everything lives in your local SQLite file, nothing is sent anywhere by this app.")

    col_exp, col_imp = st.columns(2)
    with col_exp:
        st.markdown("**Export everything**")
        export_payload = export_all_data()
        st.download_button(
            "⬇️ Download full data (JSON)",
            data=json.dumps(export_payload, indent=2, default=str).encode('utf-8'),
            file_name=f"zebrapace_export_{datetime.date.today().isoformat()}.json",
            mime="application/json",
            use_container_width=True,
        )

    with col_imp:
        st.markdown("**Import from a file**")
        uploaded = st.file_uploader("Upload a ZebraPace JSON export", type=["json"], label_visibility="collapsed")
        import_mode = st.radio("Import mode", ["Merge (keep existing + add new)", "Replace (wipe then load)"], horizontal=False)
        if uploaded is not None and st.button("Import now", use_container_width=True):
            try:
                payload = json.loads(uploaded.read().decode('utf-8'))
                import_all_data(payload, mode="replace" if "Replace" in import_mode else "merge")
                st.success("Import complete.")
                st.rerun()
            except Exception as e:
                st.error(f"Couldn't read that file: {e}")

    st.markdown("**Delete everything**")
    st.caption("Two taps, as promised — no hidden confirmation flows.")
    confirm_delete = st.checkbox("I understand this permanently deletes all logged data (settings are kept).")
    if st.button("🗑️ Delete all my data", disabled=not confirm_delete):
        delete_all_data()
        st.success("All data deleted.")
        st.rerun()
