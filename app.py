import streamlit as st
import sqlite3
import pandas as pd
import datetime
import random
import plotly.express as px
import plotly.graph_objects as go

# =========================================================
# STANDARDIZED SCALES
# =========================================================
MENTAL_OPTIONS = ["Exhausted/Brain Fog", "Low", "Okay", "Good", "Energized"]
BODY_OPTIONS = ["Severe Pain/Stiff", "Achy", "Manageable", "Good", "Loose & Stable"]
MENTAL_SCALE = {v: i + 1 for i, v in enumerate(MENTAL_OPTIONS)}   # 1-5
BODY_SCALE = {v: i + 1 for i, v in enumerate(BODY_OPTIONS)}       # 1-5

# =========================================================
# CONFIGURATION / THEME
# =========================================================
st.set_page_config(page_title="ZebraPace", page_icon="🦓", layout="wide")

# Zebra palette: black & white stripes, turquoise as the signature accent,
# with teal/sand held in reserve for chart series and secondary highlights.
BLACK = "#1A1A1A"
WHITE = "#FFFFFF"
TURQUOISE = "#2EC4C6"    # signature accent (ZebraUp-style)
TEAL = "#1F7A7A"         # secondary accent / chart series
SAND = "#E8C39E"         # tertiary accent / chart series
SUCCESS = "#3FA796"
BG = "#FAFAFA"
CARD_BORDER = "#E6E6E6"

PRIMARY = TURQUOISE
ACCENT = SAND

STRIPE_BLACK_WHITE = f"repeating-linear-gradient(45deg, {BLACK}, {BLACK} 10px, {WHITE} 10px, {WHITE} 20px)"
STRIPE_TEAL_SAND = f"repeating-linear-gradient(45deg, {TEAL}, {TEAL} 10px, {SAND} 10px, {SAND} 20px)"

st.markdown(f"""
<style>
    .stApp {{
        background-color: {BG};
    }}
    h1 {{
        font-family: 'Georgia', serif;
        color: {BLACK};
        border-bottom: 4px solid {TURQUOISE};
        padding-bottom: 8px;
        background: none;
    }}
    h2, h3 {{
        font-family: 'Georgia', serif;
        color: {BLACK};
        border-left: 5px solid {TURQUOISE};
        padding: 8px 16px;
        background: linear-gradient(90deg, rgba(46,196,198,0.08), transparent 70%);
        border-radius: 4px;
        position: relative;
    }}
    .zebra-stripe-bar {{
        height: 16px;
        background: {STRIPE_BLACK_WHITE};
        border-top: 3px solid {TURQUOISE};
        border-bottom: 3px solid {TURQUOISE};
        border-radius: 3px;
        margin: 4px 0 20px 0;
    }}
    .zebra-stripe-bar.thin {{
        height: 8px;
        border-top: 2px solid {TURQUOISE};
        border-bottom: 2px solid {TURQUOISE};
        margin: 2px 0 14px 0;
    }}
    .flare-badge {{
        display: inline-block;
        background: {WHITE};
        color: {BLACK};
        border: 2px dashed {TEAL};
        padding: 6px 16px;
        border-radius: 20px;
        font-weight: 600;
        font-size: 0.9em;
    }}
    div[data-testid="stMetric"] {{
        background-color: {WHITE};
        border: 1px solid {CARD_BORDER};
        border-radius: 12px;
        padding: 16px 16px 12px 16px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.06);
        position: relative;
        overflow: hidden;
    }}
    div[data-testid="stMetric"]::before {{
        content: '';
        display: block;
        position: absolute;
        top: 0; left: 0; right: 0;
        height: 6px;
        background: {STRIPE_BLACK_WHITE};
    }}
    div[data-testid="stForm"] {{
        background-color: {WHITE};
        border: 1px solid {CARD_BORDER};
        border-top: 4px solid {TURQUOISE};
        border-radius: 14px;
        padding: 18px;
    }}
    .stButton>button {{
        border-radius: 10px;
        border: 2px solid {TURQUOISE};
        color: {BLACK};
        background-color: {WHITE};
        font-weight: 600;
    }}
    .stButton>button:hover {{
        border-color: {BLACK};
        background-color: {TURQUOISE};
        color: {BLACK};
    }}
    .stTabs [aria-selected="true"] {{
        color: {TURQUOISE} !important;
        border-bottom-color: {TURQUOISE} !important;
    }}
    div[data-testid="stForm"] button[kind="formSubmit"] {{
        background-color: {TURQUOISE};
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
}

def get_db_connection():
    return sqlite3.connect(DB_FILE)

def init_db():
    conn = get_db_connection()
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
    for col_def in ["is_rest_day BOOLEAN DEFAULT 0", "fat_percentage REAL DEFAULT 0.0", "is_flare_day BOOLEAN DEFAULT 0"]:
        try:
            c.execute(f"ALTER TABLE daily_logs ADD COLUMN {col_def}")
        except sqlite3.OperationalError:
            pass

    # Seed default settings
    for k, v in DEFAULT_SETTINGS.items():
        c.execute("INSERT OR IGNORE INTO settings (key, value) VALUES (?, ?)", (k, v))

    conn.commit()
    conn.close()

init_db()

# =========================================================
# 3. SETTINGS HELPERS
# =========================================================
@st.cache_data(ttl=5)
def get_all_settings():
    conn = get_db_connection()
    df = pd.read_sql_query("SELECT * FROM settings", conn)
    conn.close()
    return dict(zip(df['key'], df['value']))

def set_setting(key, value):
    conn = get_db_connection()
    conn.execute("INSERT INTO settings (key, value) VALUES (?, ?) ON CONFLICT(key) DO UPDATE SET value=excluded.value", (key, str(value)))
    conn.commit()
    conn.close()
    get_all_settings.clear()

SETTINGS = get_all_settings()
GROWTH_GOAL = float(SETTINGS.get("growth_goal_pct", 1.01))
CAUTION_PCT = float(SETTINGS.get("caution_pct", 1.10))
COMFORT_THRESHOLD = float(SETTINGS.get("comfort_threshold", 3.8))
WATER_GOAL = int(float(SETTINGS.get("water_goal_ml", 2000)))
PROTEIN_GOAL = int(float(SETTINGS.get("protein_goal_g", 100)))

# =========================================================
# 4. DATA HELPER FUNCTIONS
# =========================================================
def ensure_day_exists(date_str):
    conn = get_db_connection()
    conn.execute("INSERT OR IGNORE INTO daily_logs (date, water_ml, protein_g, creatine_g, steps, is_rest_day) VALUES (?, 0, 0, 0, 0, 0)", (date_str,))
    conn.commit()
    conn.close()

def get_day_data(date_str):
    conn = get_db_connection()
    df = pd.read_sql_query("SELECT * FROM daily_logs WHERE date=?", conn, params=(date_str,))
    conn.close()
    return {} if df.empty else df.iloc[0].to_dict()

def get_weekly_average_steps(target_date_str, lookback_days=14):
    """Average steps from the most recent *logged, non-rest, non-flare* days.
    Uses a wider lookback window (default 14 calendar days) so that a stretch
    of illness or flares doesn't shrink the sample down to nothing or quietly
    drag the baseline toward days that weren't representative of capacity."""
    conn = get_db_connection()
    target = datetime.datetime.strptime(target_date_str, "%Y-%m-%d").date()
    start = (target - datetime.timedelta(days=lookback_days)).strftime("%Y-%m-%d")
    df = pd.read_sql_query(
        """SELECT steps FROM daily_logs
           WHERE date >= ? AND date < ? AND steps > 0
           AND (is_rest_day IS NULL OR is_rest_day = 0)
           AND (is_flare_day IS NULL OR is_flare_day = 0)
           ORDER BY date DESC LIMIT 7""",
        conn, params=(start, target_date_str))
    conn.close()
    if df.empty:
        return 0
    return df['steps'].mean()

def get_range_daily(days=30, end_date_str=None):
    conn = get_db_connection()
    end = datetime.datetime.strptime(end_date_str, "%Y-%m-%d").date() if end_date_str else datetime.date.today()
    start = (end - datetime.timedelta(days=days)).strftime("%Y-%m-%d")
    df = pd.read_sql_query("SELECT * FROM daily_logs WHERE date >= ? AND date <= ? ORDER BY date ASC",
                            conn, params=(start, end.strftime("%Y-%m-%d")))
    conn.close()
    return df

def get_day_summary_counts(date_str):
    conn = get_db_connection()
    act_count = pd.read_sql_query("SELECT COUNT(*) as c FROM activities WHERE date=?", conn, params=(date_str,)).iloc[0]['c']
    cal_count = pd.read_sql_query("SELECT COUNT(*) as c FROM calisthenics WHERE date=?", conn, params=(date_str,)).iloc[0]['c']
    ther_count = pd.read_sql_query("SELECT COUNT(*) as c FROM therapies WHERE date=?", conn, params=(date_str,)).iloc[0]['c']
    conn.close()
    return act_count, cal_count, ther_count

def check_calisthenics_comfort(exercise, target_date_str):
    conn = get_db_connection()
    df = pd.read_sql_query("SELECT comfort_score FROM calisthenics WHERE exercise=? AND date <= ? ORDER BY date DESC LIMIT 3",
                            conn, params=(exercise, target_date_str))
    conn.close()
    return len(df) == 3 and df['comfort_score'].mean() >= COMFORT_THRESHOLD

def get_comfort_emoji(score):
    if score >= 4.5: return "🤩 Brilliant/Stable"
    elif score >= 3.8: return "🙂 Comfortable/Good"
    elif score >= 2.5: return "😐 Okay/Stiff"
    elif score >= 1.5: return "🙁 Achy/Struggled"
    else: return "😣 Painful/Unstable"

# --- Data ownership: export / import / delete everything, no lock-in ---
DATA_TABLES = ["daily_logs", "activities", "calisthenics", "therapies", "liquid_logs", "settings"]

def export_all_data():
    conn = get_db_connection()
    payload = {"exported_at": datetime.datetime.now().isoformat(), "tables": {}}
    for table in DATA_TABLES:
        df = pd.read_sql_query(f"SELECT * FROM {table}", conn)
        payload["tables"][table] = df.to_dict(orient="records")
    conn.close()
    return payload

def import_all_data(payload, mode="merge"):
    """mode='merge' inserts/ignores existing rows; mode='replace' wipes each table first."""
    conn = get_db_connection()
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
    conn.close()
    get_all_settings.clear()

def delete_all_data():
    conn = get_db_connection()
    c = conn.cursor()
    for table in DATA_TABLES:
        if table == "settings":
            continue  # keep configured thresholds/goals
        c.execute(f"DELETE FROM {table}")
    conn.commit()
    conn.close()

REST_FACTS = [
    "Rest days let fibroblasts repair collagen micro-tears. With EDS this takes a little longer — rest is literally when you build strength.",
    "Your parasympathetic nervous system needs dedicated downtime to reset, especially with dysautonomia. Resting is maintenance, not laziness.",
    "Connective tissue adapts more slowly than muscle. An extra rest day now can prevent chronic tendon flare-ups later.",
    "Mental fatigue affects physical coordination. Protecting your mental energy is also protecting your joints.",
    "There is no 'behind' in a chronic condition. The only comparison that matters is you-today to you-yesterday, gently.",
    "Symptoms fluctuate day to day for reasons outside your control. A lower number today is data, not a verdict on your effort.",
    "Consistency in chronic illness looks like showing up in small, sustainable ways — never unbroken runs of intensity.",
    "Pacing (the 'spoon theory' approach) is a recognized management strategy for EDS and dysautonomia, not a consolation prize.",
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
st.markdown('<div class="zebra-stripe-bar"></div>', unsafe_allow_html=True)
st.markdown("*Doing a little is better than pushing too hard. Rest is a success. Progress isn't linear — and that's normal.*")

if 'selected_date' not in st.session_state:
    st.session_state.selected_date = datetime.date.today()

col_d1, col_d2 = st.columns([3, 1])
with col_d1:
    selected_date = st.date_input("🗓️ Select Date for Entry", st.session_state.selected_date, key="date_picker")
with col_d2:
    st.write("")
    if st.button("📅 Today"):
        st.session_state.selected_date = datetime.date.today()
        st.rerun()

st.session_state.selected_date = selected_date
date_str = selected_date.strftime("%Y-%m-%d")

day_data = get_day_data(date_str)
ensure_day_exists(date_str)

tabs = st.tabs(["💧 Daily Vitals & Fuel", "🏃‍♀️ Movement & Calisthenics", "📊 Insights & Trends", "⚙️ Settings"])

# ==========================================
# TAB 1: DAILY VITALS & NUTRITION
# ==========================================
with tabs[0]:
    df_week = get_range_daily(days=6, end_date_str=date_str)
    days_logged = len(df_week)
    water_today = day_data.get('water_ml', 0) if day_data else 0
    steps_today = day_data.get('steps', 0) if day_data else 0
    is_rest = day_data.get('is_rest_day', 0) if day_data else 0
    is_flare = day_data.get('is_flare_day', 0) if day_data else 0

    act_count, cal_count, ther_count = get_day_summary_counts(date_str)
    total_events = act_count + cal_count + ther_count

    m1, m2, m3, m4 = st.columns(4)
    m1.metric("💧 Liquids", f"{water_today} ml", f"goal {WATER_GOAL} ml", delta_color="off")
    m2.metric("👣 Steps", f"{int(steps_today)}")
    m3.metric("🥩 Protein", f"{int(day_data.get('protein_g', 0) or 0)} g", f"goal {PROTEIN_GOAL} g", delta_color="off")
    m4.metric("✅ Logged acts today", total_events)

    summary_text = "🌱 **Today's gentle overview:** "
    if is_flare:
        summary_text += "🌩️ You're navigating a flare or feeling unwell today. Anything logged — or nothing at all — is completely fine."
    else:
        if total_events > 0:
            summary_text += f"You've logged **{total_events}** intentional act(s) of movement or recovery. "
        if is_rest:
            summary_text += "🛡️ You chose a Rest Day and protected your body — that counts fully."
        else:
            summary_text += "Whatever you did today, it was exactly enough."
    st.info(summary_text)

    if days_logged > 1:
        rest_days_count = df_week['is_rest_day'].sum() if 'is_rest_day' in df_week.columns else 0
        rest_text = f" (including {int(rest_days_count)} Rest Day(s))" if rest_days_count > 0 else ""
        st.success(f"💙 You've checked in **{days_logged}** time(s) over the last 7 days{rest_text}. Consistency, not intensity, is the goal here.")
    else:
        st.success("💙 First check-in for this stretch — welcome. Take everything at your own pace.")

    st.divider()

    col_mind, col_metrics = st.columns(2)

    with col_mind:
        st.subheader("🧠 Mind, Body & Orthopedics")
        with st.form("mind_body_form"):
            mental_val = day_data.get('mental_state', "Okay") or "Okay"
            mental_state = st.select_slider("Mental State", options=MENTAL_OPTIONS, value=mental_val)

            body_val = day_data.get('body_feeling', "Manageable") or "Manageable"
            body_feeling = st.select_slider("Body/Pain Feeling", options=BODY_OPTIONS, value=body_val)

            saved_braces_str = day_data.get('braces_used', "[]") or "[]"
            try:
                saved_braces = eval(saved_braces_str, {"__builtins__": {}}, {})
            except Exception:
                saved_braces = []

            braces = st.multiselect("Braces Used", ["None", "Wrist", "Knee", "SI Belt", "Ring Splints", "Ankle", "Neck"], default=saved_braces)
            brace_comfort = st.slider("Brace Comfort/Helpfulness", 1, 10, int(day_data.get('brace_comfort', 5) or 5))

            if st.form_submit_button("Save Mind & Body State"):
                conn = get_db_connection()
                conn.execute("UPDATE daily_logs SET mental_state=?, body_feeling=?, braces_used=?, brace_comfort=? WHERE date=?",
                             (mental_state, body_feeling, str(braces), brace_comfort, date_str))
                conn.commit(); conn.close(); st.success("Updated successfully!"); st.rerun()

    with col_metrics:
        st.subheader("📏 Body Metrics")
        st.caption("Tracked separately from how you feel — numbers are neutral data, not judgments.")
        with st.form("body_metrics_form"):
            weight = st.number_input("Weight (kg)", min_value=0.0, value=float(day_data.get('weight', 0.0) or 0.0), step=0.1)
            height = st.number_input("Height (cm)", min_value=0.0, value=float(day_data.get('height', 0.0) or 0.0), step=0.1)
            fat_pct = st.number_input("Body Fat (%)", min_value=0.0, value=float(day_data.get('fat_percentage', 0.0) or 0.0), step=0.1)

            if st.form_submit_button("Save Body Metrics"):
                conn = get_db_connection()
                conn.execute("UPDATE daily_logs SET weight=?, height=?, fat_percentage=? WHERE date=?",
                             (weight, height, fat_pct, date_str))
                conn.commit(); conn.close(); st.success("Metrics updated!"); st.rerun()

    st.divider()

    col_liquid, col_protein = st.columns(2)

    with col_liquid:
        st.subheader("☕ Hydration & Liquids")
        conn = get_db_connection()
        liquid_df = pd.read_sql_query("SELECT * FROM liquid_logs WHERE date=?", conn, params=(date_str,))
        conn.close()

        total_liquid = liquid_df['amount_ml'].sum() if not liquid_df.empty else (day_data.get('water_ml', 0) or 0)
        st.progress(min(total_liquid / WATER_GOAL, 1.0) if WATER_GOAL else 0, text=f"{total_liquid} / {WATER_GOAL} ml")

        with st.form("liquid_form"):
            ll1, ll2 = st.columns(2)
            with ll1:
                drink_options = ["Water", "Tea", "Coffee", "Electrolytes", "Protein Shake", "Juice", "Broth/Soup", "Other (Type below)"]
                drink_type_sel = st.selectbox("Drink Type", drink_options)
                drink_type_custom = st.text_input("If 'Other', specify:", placeholder="e.g. Milk")
            with ll2:
                drink_amount = st.number_input("Amount (ml)", min_value=1, value=250, step=10)

            if st.form_submit_button("➕ Add Liquid"):
                final_drink = drink_type_custom if "Other" in drink_type_sel and drink_type_custom else drink_type_sel
                conn = get_db_connection()
                conn.execute("INSERT INTO liquid_logs (date, drink_type, amount_ml) VALUES (?, ?, ?)", (date_str, final_drink, drink_amount))
                conn.execute("UPDATE daily_logs SET water_ml = water_ml + ? WHERE date = ?", (drink_amount, date_str))
                conn.commit(); conn.close(); st.rerun()

        if not liquid_df.empty:
            st.write("**Today's Log:**")
            for _, row in liquid_df.iterrows():
                st.caption(f"• {row['amount_ml']} ml — {row['drink_type']}")
            if st.button("🗑️ Reset Today's Liquids"):
                conn = get_db_connection()
                conn.execute("DELETE FROM liquid_logs WHERE date=?", (date_str,))
                conn.execute("UPDATE daily_logs SET water_ml = 0 WHERE date=?", (date_str,))
                conn.commit(); conn.close(); st.rerun()

    with col_protein:
        st.subheader("🥩 Nutrition & Supplements")
        current_protein = int(day_data.get('protein_g', 0) or 0)
        current_creatine = float(day_data.get('creatine_g', 0.0) or 0.0)

        st.progress(min(current_protein / PROTEIN_GOAL, 1.0) if PROTEIN_GOAL else 0, text=f"{current_protein} / {PROTEIN_GOAL} g protein")
        st.caption(f"Creatine today: {current_creatine} g")

        cp1, cp2 = st.columns(2)
        if cp1.button("+ 25g Protein (Shake/Meal)"):
            conn = get_db_connection()
            conn.execute("UPDATE daily_logs SET protein_g = protein_g + 25 WHERE date = ?", (date_str,))
            conn.commit(); conn.close(); st.rerun()
        if cp2.button("+ 5g Creatine"):
            conn = get_db_connection()
            conn.execute("UPDATE daily_logs SET creatine_g = creatine_g + 5 WHERE date = ?", (date_str,))
            conn.commit(); conn.close(); st.rerun()
        if st.button("Reset Nutrition"):
            conn = get_db_connection()
            conn.execute("UPDATE daily_logs SET protein_g=0, creatine_g=0 WHERE date = ?", (date_str,))
            conn.commit(); conn.close(); st.rerun()

# ==========================================
# TAB 2: MOVEMENT & CALISTHENICS
# ==========================================
with tabs[1]:
    st.header("🛡️ The Rest Day Shield")
    st.write("Resting is an active choice to protect your joints and pace your energy — not an absence of effort.")

    col_rest, col_flare = st.columns(2)

    with col_rest:
        is_rest = day_data.get('is_rest_day', 0) if day_data else 0
        if is_rest:
            st.success("🛡️ Rest Day Shield active for today. Protecting your body is the work today.")
            if st.button("Undo Rest Day"):
                conn = get_db_connection()
                conn.execute("UPDATE daily_logs SET is_rest_day = 0 WHERE date = ?", (date_str,))
                conn.commit(); conn.close(); st.rerun()
        else:
            if st.button("🛡️ Declare Today a Rest Day", use_container_width=True):
                conn = get_db_connection()
                conn.execute("UPDATE daily_logs SET is_rest_day = 1 WHERE date = ?", (date_str,))
                conn.commit(); conn.close(); st.rerun()

    with col_flare:
        is_flare = day_data.get('is_flare_day', 0) if day_data else 0
        if is_flare:
            st.warning("🌩️ Flare/Sick Day noted. Take the care you need — this day is automatically left out of your averages and comparisons.")
            if st.button("Undo Flare Day"):
                conn = get_db_connection()
                conn.execute("UPDATE daily_logs SET is_flare_day = 0 WHERE date = ?", (date_str,))
                conn.commit(); conn.close(); st.rerun()
        else:
            if st.button("🌩️ Mark as a Flare/Sick Day", use_container_width=True):
                conn = get_db_connection()
                conn.execute("UPDATE daily_logs SET is_flare_day = 1 WHERE date = ?", (date_str,))
                conn.commit(); conn.close(); st.rerun()

    st.caption("A flare or sick day needs no other entry to count. Marking it — even with zero other data — is enough, and it will never be used against you in a trend or comparison.")

    st.divider()

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
            conn = get_db_connection()
            conn.execute("UPDATE daily_logs SET steps = ? WHERE date = ?", (steps, date_str))
            conn.commit(); conn.close()

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

    st.header("🚴‍♀️ Custom Activities")
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
        act_mental = st.select_slider("Mental State", options=MENTAL_OPTIONS, value="Okay", key="act_mental")
    with col_af2:
        act_body = st.select_slider("Body/Pain Feeling", options=BODY_OPTIONS, value="Manageable", key="act_body")

    if st.button("Log Activity"):
        conn = get_db_connection()
        conn.execute("INSERT INTO activities (date, activity_name, duration_min, extra_weight_kg, mental_state, body_feeling) VALUES (?, ?, ?, ?, ?, ?)",
                     (date_str, act_name, act_dur, act_weight, act_mental, act_body))
        conn.commit(); conn.close()
        st.success(f"Logged {act_name or 'activity'}! Every little bit counts.")

    st.divider()

    st.header("💆‍♀️ Recovery & Passive Therapies")
    st.write("TENS, massage, heat, acupuncture — passive recovery is vital self-care, not optional extra credit.")
    col_t1, col_t2 = st.columns(2)
    with col_t1:
        ther_name = st.text_input("Therapy (e.g., TENS, Massage, Heat Pad)")
    with col_t2:
        ther_dur = st.number_input("Duration (minutes)", min_value=0, step=5, key="ther_dur")

    st.write("How did you feel during/after this?")
    col_tf1, col_tf2 = st.columns(2)
    with col_tf1:
        ther_mental = st.select_slider("Mental State", options=MENTAL_OPTIONS, value="Okay", key="ther_mental")
    with col_tf2:
        ther_body = st.select_slider("Body/Pain Feeling", options=BODY_OPTIONS, value="Manageable", key="ther_body")

    if st.button("Log Therapy"):
        conn = get_db_connection()
        conn.execute("INSERT INTO therapies (date, therapy_name, duration_min, mental_state, body_feeling) VALUES (?, ?, ?, ?, ?)",
                     (date_str, ther_name, ther_dur, ther_mental, ther_body))
        conn.commit(); conn.close()
        st.success(f"Logged {ther_name or 'therapy'}! Healing is hard work.")

    st.divider()

    st.header("🤸 Hybrid Calisthenics")
    st.caption(f"Guideline: average a comfort score of {COMFORT_THRESHOLD}+ across your last 3 sessions before considering the next progression — never a requirement, always your call.")

    cal_type = st.selectbox("Exercise Type", ["Pushups", "Squats", "Pullups", "Leg Raises", "Bridges", "Twists"])
    progressions = {
        "Pushups": ["Wall Pushups (~35% BW)", "Incline Pushups (~50% BW)", "Knee Pushups (~60% BW)", "Full Pushups (~70% BW)"],
        "Squats": ["Jackknife Squats", "Assisted Squats", "Half Squats", "Full Squats"]
    }
    cal_prog = st.selectbox("Progression Tier", progressions.get(cal_type, ["Tier 1", "Tier 2", "Tier 3"]))

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
        cal_mental = st.select_slider("Mental State", options=MENTAL_OPTIONS, value="Okay", key="cal_mental")
    with col_cf2:
        cal_body = st.select_slider("Body/Pain Feeling", options=BODY_OPTIONS, value="Manageable", key="cal_body")

    if st.button("Log Calisthenics"):
        conn = get_db_connection()
        conn.execute("INSERT INTO calisthenics (date, exercise, progression, sets, reps, comfort_score, mental_state, body_feeling) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                     (date_str, cal_type, cal_prog, cal_sets, cal_reps, comfort_score, cal_mental, cal_body))
        conn.commit(); conn.close()
        st.success("Logged! Staying at your current tier is just as celebrated here as moving up.")

        if check_calisthenics_comfort(cal_type, date_str):
            st.balloons()
            st.success(f"🌟 Your last 3 sessions for {cal_type} averaged {COMFORT_THRESHOLD}+ comfort. That's your data telling you this tier has been consistently comfortable — worth weighing alongside how you feel before deciding on the next progression, entirely at your own pace.")

# ==========================================
# TAB 3: INSIGHTS & TRENDS
# ==========================================
with tabs[2]:
    st.header("📖 Insights & Trends")
    st.info("💡 " + random.choice(REST_FACTS))

    range_choice = st.radio("Show trends for the last:", ["14 days", "30 days", "90 days"], horizontal=True, index=1)
    days_map = {"14 days": 14, "30 days": 30, "90 days": 90}
    df_range = get_range_daily(days=days_map[range_choice], end_date_str=date_str)

    conn = get_db_connection()
    df_daily = pd.read_sql_query("SELECT * FROM daily_logs ORDER BY date ASC", conn)
    df_act = pd.read_sql_query("SELECT * FROM activities", conn)
    df_cal = pd.read_sql_query("SELECT * FROM calisthenics", conn)
    df_ther = pd.read_sql_query("SELECT * FROM therapies", conn)
    conn.close()

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
            fig_cal = px.line(df_cal_plot.sort_values('date'), x='date', y='comfort_score', color='exercise', markers=True)
            fig_cal.add_hline(y=COMFORT_THRESHOLD, line_dash="dot", line_color=SUCCESS, annotation_text="progression threshold")
            fig_cal.update_layout(height=320, plot_bgcolor="white", paper_bgcolor="white", margin=dict(t=20, b=20))
            st.plotly_chart(fig_cal, use_container_width=True)

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
    if not df_daily.empty:
        csv = df_daily.to_csv(index=False).encode('utf-8')
        st.download_button(label="Download Vitals CSV (for your care team)", data=csv, file_name='zebrapace_vitals.csv', mime='text/csv')

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
            st.dataframe(df_cal.sort_values('date', ascending=False)[['date', 'exercise', 'progression', 'comfort_score', 'mental_state', 'body_feeling']].head(10), use_container_width=True)

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
    st.subheader("About the password gate")
    st.caption("The app password is set via `st.secrets['APP_PASSWORD']` in your Streamlit deployment settings, not stored in the database.")

    st.divider()
    st.subheader("📦 Your data, your property")
    st.caption("Export, import, and delete are rights here, not premium features — everything lives in your local SQLite file, nothing is sent anywhere by this app.")

    import json as _json

    col_exp, col_imp = st.columns(2)
    with col_exp:
        st.markdown("**Export everything**")
        export_payload = export_all_data()
        st.download_button(
            "⬇️ Download full data (JSON)",
            data=_json.dumps(export_payload, indent=2, default=str).encode('utf-8'),
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
                payload = _json.loads(uploaded.read().decode('utf-8'))
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
