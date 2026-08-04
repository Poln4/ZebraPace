import streamlit as st
import sqlite3
import pandas as pd
import datetime
import random

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
APP_PASSWORD = st.secrets.get("APP_PASSWORD", "zebra123") 

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

# --- 2. DATABASE SETUP ---
DB_FILE = 'zebra_data.db'

def init_db():
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    # Daily Vitals & Nutrition
    c.execute('''CREATE TABLE IF NOT EXISTS daily_logs
                 (date TEXT PRIMARY KEY, weight REAL, height REAL, water_ml INTEGER, 
                  protein_g INTEGER, creatine_g REAL, mental_state TEXT, body_feeling TEXT,
                  braces_used TEXT, brace_comfort INTEGER, steps INTEGER)''')
    # Custom Activities
    c.execute('''CREATE TABLE IF NOT EXISTS activities
                 (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, activity_name TEXT, 
                  duration_min INTEGER, extra_weight_kg REAL)''')
    # Hybrid Calisthenics
    c.execute('''CREATE TABLE IF NOT EXISTS calisthenics
                 (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, exercise TEXT, 
                  progression TEXT, sets INTEGER, reps INTEGER, comfortable BOOLEAN)''')
    conn.commit()
    conn.close()

init_db()

# --- 3. HELPER FUNCTIONS ---
def get_db_connection():
    return sqlite3.connect(DB_FILE)

def get_weekly_average_steps(target_date_str):
    """Calculates the 7-day average steps prior to the selected date."""
    conn = get_db_connection()
    target_date_obj = datetime.datetime.strptime(target_date_str, "%Y-%m-%d").date()
    seven_days_ago = (target_date_obj - datetime.timedelta(days=7)).strftime("%Y-%m-%d")
    
    df = pd.read_sql_query(f"SELECT steps FROM daily_logs WHERE date >= '{seven_days_ago}' AND date < '{target_date_str}'", conn)
    conn.close()
    
    if df.empty or df['steps'].isna().all():
        return 0
    return df['steps'].mean()

def check_calisthenics_comfort(exercise, target_date_str):
    """Checks if the last 3 sessions (up to the selected date) were comfortable."""
    conn = get_db_connection()
    df = pd.read_sql_query(f"SELECT comfortable FROM calisthenics WHERE exercise='{exercise}' AND date <= '{target_date_str}' ORDER BY date DESC LIMIT 3", conn)
    conn.close()
    
    if len(df) == 3 and df['comfortable'].all():
        return True
    return False

# Rest Facts
REST_FACTS = [
    "Fact: Rest days allow fibroblasts to repair collagen micro-tears. In EDS, this takes slightly longer, meaning rest is literally when you build strength.",
    "Fact: Your parasympathetic nervous system (rest & digest) needs dedicated time to reset, especially with dysautonomia.",
    "Fact: Connective tissue adapts much slower than muscle. Giving it an extra day of rest prevents chronic tendonitis.",
    "Fact: Mental fatigue directly impacts physical coordination. A mental rest day protects your joints from accidental subluxations."
]

# --- 4. MAIN APP INTERFACE ---
st.title("🦓 ZebraPace: The 1% Journey")
st.markdown("*Doing a little is better than pushing too hard. Rest is a success.*")

# Date Picker for Backlogging (Replaces "today" logic)
selected_date = st.date_input("🗓️ Select Date for Entry", datetime.date.today())
date_str = selected_date.strftime("%Y-%m-%d")

tabs = st.tabs(["💧 Daily Vitals & Nutrition", "🏃‍♀️ Movement & Calisthenics", "📊 Insights & Progress"])

# ==========================================
# TAB 1: DAILY VITALS & NUTRITION
# ==========================================
with tabs[0]:
    st.header(f"Daily Check-in for {date_str}")
    
    col1, col2 = st.columns(2)
    with col1:
        st.subheader("Body & Mind")
        weight = st.number_input("Weight (kg)", min_value=0.0, value=65.0, step=0.1)
        mental_state = st.select_slider("Mental State", options=["Exhausted/Brain Fog", "Low", "Okay", "Good", "Energized"], value="Okay")
        body_feeling = st.select_slider("Body/Pain Feeling", options=["Severe Pain/Stiff", "Achy", "Manageable", "Good", "Loose & Stable"], value="Manageable")
        
        st.subheader("Orthopedics")
        braces = st.multiselect("Braces Used", ["None", "Wrist", "Knee", "SI Belt", "Ring Splints", "Ankle", "Neck"])
        brace_comfort = st.slider("How comfortable/helpful were the braces? (1=Painful, 10=Very Helpful)", 1, 10, 5)

    with col2:
        st.subheader("Fuel")
        water = st.number_input("Water Intake (ml)", min_value=0, value=1000, step=100)
        protein = st.number_input("Protein (g - from shakes/food)", min_value=0, value=0, step=5)
        creatine = st.number_input("Creatine (g)", min_value=0.0, value=0.0, step=0.5)

    if st.button("Save Daily Vitals"):
        conn = get_db_connection()
        c = conn.cursor()
        c.execute('''INSERT OR REPLACE INTO daily_logs 
                     (date, weight, water_ml, protein_g, creatine_g, mental_state, body_feeling, braces_used, brace_comfort) 
                     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)''', 
                  (date_str, weight, water, protein, creatine, mental_state, body_feeling, str(braces), brace_comfort))
        conn.commit()
        conn.close()
        st.success(f"Vitals saved for {date_str}! Remember: If you need to rest today, that is a valid health choice.")

# ==========================================
# TAB 2: MOVEMENT & CALISTHENICS
# ==========================================
with tabs[1]:
    # STEPS & THE 1% RULE
    st.header("👣 Steps & The 1% Rule")
    avg_steps = get_weekly_average_steps(date_str)
    st.info(f"Your 7-day average leading up to this date is **{int(avg_steps)} steps**. Your 1% growth goal is **{int(avg_steps * 1.01)} steps**.")
    
    steps = st.number_input("Steps", min_value=0, step=100)
    
    if st.button("Log Steps"):
        conn = get_db_connection()
        c = conn.cursor()
        # Create a blank row if vitals haven't been saved yet for this date, then update steps
        c.execute("INSERT OR IGNORE INTO daily_logs (date) VALUES (?)", (date_str,))
        c.execute("UPDATE daily_logs SET steps = ? WHERE date = ?", (steps, date_str))
        conn.commit()
        conn.close()
        
        # Dysautonomia / PEM Logic Check
        if avg_steps > 0:
            if steps > avg_steps * 1.10:
                st.error("🚨 10% OVEREXERTION DETECTED! 🚨")
                st.warning("ADVICE: Please plan to REST tomorrow. Drink extra water and take Electrolytes now (Dysautonomia precaution). You pushed hard, now you must recover hard.")
            elif steps >= avg_steps * 1.01:
                st.success("🎉 You hit your 1% growth! Amazing job, stop here and rest.")
            else:
                st.success("Great job pacing yourself today. Maintaining is succeeding.")

    st.divider()

    # CUSTOM ACTIVITIES (Zero Expectations)
    st.header("🚴‍♀️ Custom Activities")
    st.write("No pre-filled lists. If you went swimming, or just walked with your niece, log it here.")
    col_a, col_b, col_c = st.columns(3)
    with col_a:
        act_name = st.text_input("Activity (e.g., Walked with Niece, Swimming)")
    with col_b:
        act_dur = st.number_input("Duration (minutes)", min_value=0, step=5)
    with col_c:
        act_weight = st.number_input("Added External Weight (kg)", min_value=0.0, step=0.1, help="E.g., 11.3 for carrying your niece")
    
    if st.button("Log Activity"):
        conn = get_db_connection()
        c = conn.cursor()
        c.execute("INSERT INTO activities (date, activity_name, duration_min, extra_weight_kg) VALUES (?, ?, ?, ?)",
                  (date_str, act_name, act_dur, act_weight))
        conn.commit()
        conn.close()
        st.success(f"Logged {act_name} for {date_str}! Every little bit counts.")

    st.divider()

    # HYBRID CALISTHENICS (The Hampton EDS Way)
    st.header("🤸 Hybrid Calisthenics (Modified)")
    st.write("Rule: You must complete an exercise *comfortably* 3 times before moving to the next progression.")
    
    cal_type = st.selectbox("Exercise Type", ["Pushups", "Squats", "Pullups", "Leg Raises", "Bridges", "Twists"])
    
    # Simple progression dictionary
    progressions = {
        "Pushups": ["Wall Pushups (~35% BW)", "Incline Pushups (~50% BW)", "Knee Pushups (~60% BW)", "Full Pushups (~70% BW)"],
        "Squats": ["Jackknife Squats", "Assisted Squats", "Half Squats", "Full Squats"]
    }
    
    cal_prog = st.selectbox("Progression Tier", progressions.get(cal_type, ["Tier 1", "Tier 2", "Tier 3"]))
    
    col_c1, col_c2 = st.columns(2)
    with col_c1:
        cal_sets = st.number_input("Sets", min_value=0, value=2)
        cal_reps = st.number_input("Reps (per set)", min_value=0, value=10)
    with col_c2:
        st.write("Did this feel comfortable on your joints today? (No sharp pain, no extreme strain)")
        cal_comfort = st.checkbox("Yes, felt comfortable and stable.")
        
    if st.button("Log Calisthenics"):
        conn = get_db_connection()
        c = conn.cursor()
        c.execute("INSERT INTO calisthenics (date, exercise, progression, sets, reps, comfortable) VALUES (?, ?, ?, ?, ?, ?)",
                  (date_str, cal_type, cal_prog, cal_sets, cal_reps, cal_comfort))
        conn.commit()
        conn.close()
        st.success("Logged! Remember, not pushing up to the next tier is celebrated here.")
        
        # Check comfort rule
        if check_calisthenics_comfort(cal_type, date_str):
            st.balloons()
            st.info(f"🌟 You've comfortably completed {cal_type} 3 times in a row! You are cleared to try the next progression ONLY if you feel up to it.")

# ==========================================
# TAB 3: INSIGHTS & TRENDS
# ==========================================
with tabs[2]:
    st.header("Your Data & Rest")
    
    st.info(random.choice(REST_FACTS))
    
    conn = get_db_connection()
    df_daily = pd.read_sql_query("SELECT * FROM daily_logs", conn)
    df_act = pd.read_sql_query("SELECT * FROM activities", conn)
    conn.close()
    
    if not df_daily.empty:
        df_daily['date'] = pd.to_datetime(df_daily['date'])
        df_daily = df_daily.sort_values('date')
        
        st.subheader("Steps Trend")
        st.line_chart(df_daily.set_index('date')['steps'])
        
        col_s1, col_s2 = st.columns(2)
        with col_s1:
            st.subheader("Water Intake (ml)")
            st.bar_chart(df_daily.set_index('date')['water_ml'])
        with col_s2:
            st.subheader("Mental State Over Time")
            # Map mental state to numbers for graphing
            state_map = {"Exhausted/Brain Fog": 1, "Low": 2, "Okay": 3, "Good": 4, "Energized": 5}
            df_daily['mental_score'] = df_daily['mental_state'].map(state_map)
            st.line_chart(df_daily.set_index('date')['mental_score'])
            
    if not df_act.empty:
        st.subheader("Recent Custom Activities")
        st.dataframe(df_act[['date', 'activity_name', 'duration_min', 'extra_weight_kg']].tail(5))
        
        total_extra_weight = df_act['extra_weight_kg'].sum()
        if total_extra_weight > 0:
            st.write(f"💪 Wow! You've carried a total of **{total_extra_weight} kg** of extra weight over time (including your niece!).")
