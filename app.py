import streamlit as st
import sqlite3
import pandas as pd
import datetime
import random

# --- STANDARDIZED SCALES ---
MENTAL_OPTIONS = ["Exhausted/Brain Fog", "Low", "Okay", "Good", "Energized"]
BODY_OPTIONS = ["Severe Pain/Stiff", "Achy", "Manageable", "Good", "Loose & Stable"]

# --- CONFIGURATION ---
st.set_page_config(page_title="ZebraPace Beta", page_icon="🦓", layout="wide")

st.markdown("""
<style>
    /* Creates a subtle zebra-stripe background behind all headers */
    h1, h2, h3 {
        background: repeating-linear-gradient(
            45deg,
            rgba(128, 128, 128, 0.1),
            rgba(128, 128, 128, 0.1) 10px,
            rgba(128, 128, 128, 0.0) 10px,
            rgba(128, 128, 128, 0.0) 20px
        );
        padding: 10px 15px;
        border-radius: 8px;
        border-left: 5px solid #40E0D0; /* Adds a turquoise accent line */
    }
</style>
""", unsafe_allow_html=True)

# --- 1. SIMPLE PASSWORD GATE ---
APP_PASSWORD = st.secrets.get("APP_PASSWORD", "runrunCarlacorrecorre") 

def check_password():
    """Returns True if the user enters the correct password."""
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

# Block execution until logged in
if not check_password():
    st.stop()

# --- 2. DATABASE SETUP ---
DB_FILE = 'zebra_data.db'

def init_db():
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    # Daily Vitals & Nutrition
    c.execute('''CREATE TABLE IF NOT EXISTS daily_logs
                 (date TEXT PRIMARY KEY, weight REAL, height REAL, water_ml INTEGER DEFAULT 0, 
                  protein_g INTEGER DEFAULT 0, creatine_g REAL DEFAULT 0, mental_state TEXT, body_feeling TEXT,
                  braces_used TEXT, brace_comfort INTEGER, steps INTEGER DEFAULT 0)''')
    # Custom Activities
    c.execute('''CREATE TABLE IF NOT EXISTS activities
                 (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, activity_name TEXT, 
                  duration_min INTEGER, extra_weight_kg REAL)''')
    # Hybrid Calisthenics
    c.execute('''CREATE TABLE IF NOT EXISTS calisthenics
                 (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, exercise TEXT, 
                  progression TEXT, sets INTEGER, reps INTEGER, comfortable BOOLEAN)''')
    
    # Safely add the new comfort_score column if it doesn't exist (Database Upgrade)
    try:
        c.execute("ALTER TABLE calisthenics ADD COLUMN comfort_score REAL DEFAULT 0.0")
    except sqlite3.OperationalError:
        pass # Column already exists

    # Safely add the new feeling columns to activities and calisthenics
    for table in ["activities", "calisthenics"]:
        for col in ["mental_state", "body_feeling"]:
            try:
                c.execute(f"ALTER TABLE {table} ADD COLUMN {col} TEXT")
            except sqlite3.OperationalError:
                pass

    # Safely add the is_rest_day and fat_percentage columns if they don't exist
    for col_def in ["is_rest_day BOOLEAN DEFAULT 0", "fat_percentage REAL DEFAULT 0.0"]:
        try:
            c.execute(f"ALTER TABLE daily_logs ADD COLUMN {col_def}")
        except sqlite3.OperationalError:
            pass

    # Recovery Therapies Table
    c.execute('''CREATE TABLE IF NOT EXISTS therapies
                 (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, therapy_name TEXT, 
                  duration_min INTEGER, mental_state TEXT, body_feeling TEXT)''')

    # Custom Liquids Table
    c.execute('''CREATE TABLE IF NOT EXISTS liquid_logs
                 (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, drink_type TEXT, amount_ml INTEGER)''')

    conn.commit()
    conn.close()

init_db()

# --- 3. HELPER FUNCTIONS ---
def get_db_connection():
    return sqlite3.connect(DB_FILE)

def ensure_day_exists(date_str):
    """Ensures a row exists for the given date before doing partial updates."""
    conn = get_db_connection()
    c = conn.cursor()
    c.execute("INSERT OR IGNORE INTO daily_logs (date, water_ml, protein_g, creatine_g, steps, is_rest_day) VALUES (?, 0, 0, 0, 0, 0)", (date_str,))
    conn.commit()
    conn.close()

def get_day_data(date_str):
    """Fetches existing data for the selected day."""
    conn = get_db_connection()
    df = pd.read_sql_query(f"SELECT * FROM daily_logs WHERE date='{date_str}'", conn)
    conn.close()
    if df.empty:
        return {}
    return df.iloc[0].to_dict()

def get_weekly_average_steps(target_date_str):
    conn = get_db_connection()
    target_date_obj = datetime.datetime.strptime(target_date_str, "%Y-%m-%d").date()
    seven_days_ago = (target_date_obj - datetime.timedelta(days=7)).strftime("%Y-%m-%d")
    df = pd.read_sql_query(f"SELECT steps FROM daily_logs WHERE date >= '{seven_days_ago}' AND date < '{target_date_str}'", conn)
    conn.close()
    if df.empty or df['steps'].isna().all():
        return 0
    return df['steps'].mean()

def get_weekly_summary_stats(target_date_str):
    """Fetches basic stats for the past 7 days to provide gentle encouragement."""
    conn = get_db_connection()
    target_date_obj = datetime.datetime.strptime(target_date_str, "%Y-%m-%d").date()
    seven_days_ago = (target_date_obj - datetime.timedelta(days=6)).strftime("%Y-%m-%d")
    df = pd.read_sql_query(f"SELECT date, water_ml, steps, is_rest_day FROM daily_logs WHERE date >= '{seven_days_ago}' AND date <= '{target_date_str}'", conn)
    conn.close()
    return df

def get_day_summary_counts(date_str):
    """Fetches the count of all intentional acts of movement and recovery."""
    conn = get_db_connection()
    act_count = pd.read_sql_query(f"SELECT COUNT(*) as c FROM activities WHERE date='{date_str}'", conn).iloc[0]['c']
    cal_count = pd.read_sql_query(f"SELECT COUNT(*) as c FROM calisthenics WHERE date='{date_str}'", conn).iloc[0]['c']
    ther_count = pd.read_sql_query(f"SELECT COUNT(*) as c FROM therapies WHERE date='{date_str}'", conn).iloc[0]['c']
    conn.close()
    return act_count, cal_count, ther_count

def check_calisthenics_comfort(exercise, target_date_str):
    """Checks if the last 3 sessions averaged a comfort score of 3.8 or higher."""
    conn = get_db_connection()
    df = pd.read_sql_query(f"SELECT comfort_score FROM calisthenics WHERE exercise='{exercise}' AND date <= '{target_date_str}' ORDER BY date DESC LIMIT 3", conn)
    conn.close()
    if len(df) == 3 and df['comfort_score'].mean() >= 3.8:
        return True
    return False

def get_comfort_emoji(score):
    if score >= 4.5: return "🤩 Brilliant/Stable"
    elif score >= 3.8: return "🙂 Comfortable/Good"
    elif score >= 2.5: return "😐 Okay/Stiff"
    elif score >= 1.5: return "🙁 Achy/Struggled"
    else: return "😣 Painful/Unstable"

REST_FACTS = [
    "Fact: Rest days allow fibroblasts to repair collagen micro-tears. In EDS, this takes slightly longer, meaning rest is literally when you build strength.",
    "Fact: Your parasympathetic nervous system (rest & digest) needs dedicated time to reset, especially with dysautonomia.",
    "Fact: Connective tissue adapts much slower than muscle. Giving it an extra day of rest prevents chronic tendonitis.",
    "Fact: Mental fatigue directly impacts physical coordination. A mental rest day protects your joints from accidental subluxations."
]

# --- 4. MAIN APP INTERFACE ---
st.title("🦓 ZebraPace: The 1% Journey")
st.markdown("*Doing a little is better than pushing too hard. Rest is a success.*")

# DATE PICKER & TODAY RESET LOGIC
if 'selected_date' not in st.session_state:
    st.session_state.selected_date = datetime.date.today()

col_d1, col_d2 = st.columns([3, 1])
with col_d1:
    selected_date = st.date_input("🗓️ Select Date for Entry", st.session_state.selected_date, key="date_picker")
with col_d2:
    st.write("") 
    if st.button("📅 Back to Today"):
        st.session_state.selected_date = datetime.date.today()
        st.rerun()

# Sync session state with widget
st.session_state.selected_date = selected_date
date_str = selected_date.strftime("%Y-%m-%d")

# Fetch data for the selected day 
day_data = get_day_data(date_str)
ensure_day_exists(date_str)

tabs = st.tabs(["💧 Daily Vitals & Fuel", "🏃‍♀️ Movement & Calisthenics", "📊 Insights & History"])

# ==========================================
# TAB 1: DAILY VITALS & NUTRITION 
# ==========================================
with tabs[0]:
    # --- GENTLE SUMMARY ---
    df_week = get_weekly_summary_stats(date_str)
    days_logged = len(df_week)
    water_today = day_data.get('water_ml', 0) if day_data else 0
    steps_today = day_data.get('steps', 0) if day_data else 0
    is_rest = day_data.get('is_rest_day', 0) if day_data else 0
    
    act_count, cal_count, ther_count = get_day_summary_counts(date_str)
    total_events = act_count + cal_count + ther_count
    
    summary_text = f"🌱 **Today's gentle overview:** You've nourished your body with **{water_today} ml** of liquids and taken **{steps_today} steps**."
    if total_events > 0:
        summary_text += f" You've also logged **{total_events}** intentional acts of movement or recovery."
    if is_rest:
        summary_text += " 🛡️ **You bravely chose to protect your body with a Rest Day.**"
    summary_text += " Whatever you did today, it was exactly enough."
    
    st.info(summary_text)
    
    if days_logged > 1:
        rest_days_count = df_week['is_rest_day'].sum() if 'is_rest_day' in df_week.columns else 0
        rest_text = f" (including {int(rest_days_count)} Rest Days!)" if rest_days_count > 0 else ""
        st.success(f"💙 **Your week so far:** You've checked in **{days_logged} times** over the last 7 days{rest_text}. Thank you for consistently tuning in to your body's needs. Remember, choosing to rest and protect your joints makes you a hero.")
    else:
        st.success("💙 **Your week so far:** This is your first check-in for the week. Welcome! Take everything at your own pace.")
        
    st.divider()
    
    # --- ROW 1: MIND/BODY AND BODY METRICS ---
    col_mind, col_metrics = st.columns(2)
    
    with col_mind:
        st.subheader("🧠 Mind, Body & Orthopedics")
        with st.form("mind_body_form"):
            mental_val = day_data.get('mental_state', "Okay") or "Okay"
            mental_state = st.select_slider("Mental State", options=MENTAL_OPTIONS, value=mental_val)
            
            body_val = day_data.get('body_feeling', "Manageable") or "Manageable"
            body_feeling = st.select_slider("Body/Pain Feeling", options=BODY_OPTIONS, value=body_val)
            
            saved_braces_str = day_data.get('braces_used', "[]") or "[]"
            try: saved_braces = eval(saved_braces_str)
            except: saved_braces = []
            
            braces = st.multiselect("Braces Used", ["None", "Wrist", "Knee", "SI Belt", "Ring Splints", "Ankle", "Neck"], default=saved_braces)
            brace_comfort = st.slider("Brace Comfort/Helpfulness", 1, 10, int(day_data.get('brace_comfort', 5) or 5))
            
            if st.form_submit_button("Save Mind & Body State"):
                conn = get_db_connection()
                conn.execute("UPDATE daily_logs SET mental_state=?, body_feeling=?, braces_used=?, brace_comfort=? WHERE date=?", 
                          (mental_state, body_feeling, str(braces), brace_comfort, date_str))
                conn.commit(); conn.close(); st.success("Updated successfully!"); st.rerun()

    with col_metrics:
        st.subheader("📏 Body Metrics")
        st.write("Tracked separately from how you feel.")
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

    # --- ROW 2: FUEL & HYDRATION ---
    col_liquid, col_protein = st.columns(2)
    
    with col_liquid:
        st.subheader("☕ Hydration & Liquids")
        
        # Fetch detailed liquid logs
        conn = get_db_connection()
        liquid_df = pd.read_sql_query(f"SELECT * FROM liquid_logs WHERE date='{date_str}'", conn)
        conn.close()
        
        # Sync old water_ml with new table dynamically
        total_liquid = liquid_df['amount_ml'].sum() if not liquid_df.empty else day_data.get('water_ml', 0)
        st.metric("Total Liquid Today", f"{total_liquid} ml")
        
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
                
        # Show what they drank today
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
        current_protein = day_data.get('protein_g', 0)
        current_creatine = day_data.get('creatine_g', 0.0)
        
        st.metric("Protein", f"{current_protein} g", delta="Creatine: " + str(current_creatine) + " g", delta_color="off")
        
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
    # REST DAY SHIELD
    st.header("🛡️ The Rest Day Shield")
    st.write("Resting is an active choice to protect your joints and pace your energy.")
    
    is_rest = day_data.get('is_rest_day', 0) if day_data else 0
    if is_rest:
        st.success("🛡️ You have activated your Rest Day Shield for today. You are a hero for protecting your body!")
        if st.button("Undo Rest Day"):
            conn = get_db_connection()
            conn.execute("UPDATE daily_logs SET is_rest_day = 0 WHERE date = ?", (date_str,))
            conn.commit()
            conn.close()
            st.rerun()
    else:
        if st.button("🛡️ Declare Today a Rest Day", use_container_width=True):
            conn = get_db_connection()
            conn.execute("UPDATE daily_logs SET is_rest_day = 1 WHERE date = ?", (date_str,))
            conn.commit()
            conn.close()
            st.rerun()

    st.divider()

    # STEPS & THE 1% RULE
    st.header("👣 Steps & The 1% Rule")
    avg_steps = get_weekly_average_steps(date_str)
    st.info(f"Your 7-day average leading up to this date is **{int(avg_steps)} steps**. Your 1% growth goal is **{int(avg_steps * 1.01)} steps**.")
    
    col_st1, col_st2 = st.columns([2, 1])
    with col_st1:
        steps = st.number_input("Total Steps Today", min_value=0, step=100, value=int(day_data.get('steps', 0) or 0))
    with col_st2:
        st.write("") # spacing
        st.write("")
        if st.button("Save Steps"):
            conn = get_db_connection()
            conn.execute("UPDATE daily_logs SET steps = ? WHERE date = ?", (steps, date_str))
            conn.commit()
            conn.close()
            
            if avg_steps > 0:
                if steps > avg_steps * 1.10:
                    st.error("🚨 10% OVEREXERTION DETECTED! 🚨")
                    st.warning("ADVICE: Please plan to REST tomorrow. Drink extra water and take Electrolytes now (Dysautonomia precaution).")
                elif steps >= avg_steps * 1.01:
                    st.success("🎉 You hit your 1% growth! Amazing job, stop here and rest.")
                else:
                    st.success("Great job pacing yourself today. Maintaining is succeeding.")

    st.divider()

    # CUSTOM ACTIVITIES (Zero Expectations)
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
        conn.commit()
        conn.close()
        st.success(f"Logged {act_name}! Every little bit counts.")

    st.divider()

    # RECOVERY & THERAPIES
    st.header("💆‍♀️ Recovery & Passive Therapies")
    st.write("Therapies like TENS, massage, and acupuncture are vital self-care. Log them here.")
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
        conn.commit()
        conn.close()
        st.success(f"Logged {ther_name}! Healing is hard work.")

    st.divider()

    # HYBRID CALISTHENICS (The Hampton EDS Way)
    st.header("🤸 Hybrid Calisthenics")
    st.write("Rule: You must average a comfort score of 3.8+ across your last 3 sessions before moving to the next progression.")
    
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
        conn.commit()
        conn.close()
        st.success("Logged! Remember, staying at your current tier is highly celebrated here.")
        
        if check_calisthenics_comfort(cal_type, date_str):
            st.balloons()
            st.success(f"🌟 Your last 3 sessions for {cal_type} averaged a 3.8+ comfort score! You are physically cleared for the next progression, ONLY if you feel mentally up to it.")

# ==========================================
# TAB 3: INSIGHTS & HISTORY
# ==========================================
with tabs[2]:
    st.header("📖 Your Data & Rest")
    st.info(random.choice(REST_FACTS))
    
    conn = get_db_connection()
    df_daily = pd.read_sql_query("SELECT * FROM daily_logs", conn)
    df_act = pd.read_sql_query("SELECT * FROM activities", conn)
    df_cal = pd.read_sql_query("SELECT * FROM calisthenics", conn)
    df_ther = pd.read_sql_query("SELECT * FROM therapies", conn)
    conn.close()
    
    # EXPORT FEATURE
    if not df_daily.empty:
        csv = df_daily.to_csv(index=False).encode('utf-8')
        st.download_button(label="📥 Download Vitals CSV (For Doctor)", data=csv, file_name='zebrapace_vitals.csv', mime='text/csv')

    st.subheader("Daily Vitals History")
    if not df_daily.empty:
        # Display sorted history
        df_daily_sorted = df_daily.sort_values('date', ascending=False)
        st.dataframe(df_daily_sorted[['date', 'mental_state', 'body_feeling', 'steps', 'water_ml', 'protein_g', 'weight', 'fat_percentage']], use_container_width=True)
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
