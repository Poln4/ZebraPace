=======
# 🦓 ZebraPace: The 1% Journey #

ZebraPace is a compassionate, pacing-focused health and fitness tracker designed specifically for individuals managing Ehlers-Danlos Syndromes (EDS), Post-Exercise Malaise (PEM), Dysautonomia and comorbidities.

Traditional fitness apps rely on linear progression, streaks, and pushing limits—which can actively harm patients with chronic, cyclical conditions. ZebraPace flips the script. It operates on the philosophy of Atomic Habits (the 1% rule) and actively celebrates rest, maintenance, and listening to your body.

## ✨ Core Features & Philosophy ##

The "Spoon" Battery Graphic: A visual representation of your daily energy capacity (based on "Spoon Theory"). Your daily battery level adjusts based on your morning physical score and sleep quality, providing an immediate, visual reminder to pace yourself on low-energy days.

Sleep & Recovery Tracking: Recognizing that sleep is the primary driver of recovery for dysautonomia and connective tissue repair, the app tracks sleep patterns as a direct input for your daily energy and pacing recommendations.

The 1% Rule & PEM Protection: The app calculates your 7-day rolling average for steps/activity. It sets a gentle 1% growth goal. If you exceed your average by more than 10%, the app triggers a "Dysautonomia/PEM Precaution" alert, reminding you to hydrate, take electrolytes, and plan for a rest day.

The "3 Comfortable Sessions" Rule: Using Hampton's Hybrid Calisthenics methodology, the app tracks exercise comfort rather than just reps. You are only encouraged to move up a progression tier if you have completed the previous tier comfortably for 3 consecutive sessions.

Rest is Success: Resting is framed biologically as the time when fibroblasts repair micro-tears in connective tissue. Taking a rest day does not break a streak; it counts as a successful health intervention.

Real-World Load Tracking: Allows you to log custom activities with "Added External Weight" (e.g., carrying a heavy bag or a child) to account for the true mechanical load on your joints.

Open Liquid & Hydration Tracking: Easily track all forms of hydration, including tea, coffee, protein shakes, and electrolytes, independent of your other body metrics.

Isolated Body Metrics: Weight, height, and body fat percentage are tracked in a completely separate, dedicated section to prevent blending physical measurements with mental/pain symptom logging.

#### If you want to give it a try too, below are the indications. ####

## 🚀 Installation & Setup ##

This is a lightweight Streamlit application that uses a local SQLite database, ensuring the health data remains 100% private.

Prerequisites

Python 3.8 or higher installed on your machine.

1. Clone the Repository

git clone [https://github.com/yourusername/zebrapace.git](https://github.com/yourusername/zebrapace.git)
cd zebrapace


2. Install Dependencies

pip install -r requirements.txt


3. Set Up the Password Gate (Secrets)

To keep your dashboard private, the app requires a password.

Create a folder named .streamlit in the root directory.

Inside that folder, create a file named secrets.toml.

Add your secure password to the file:

# .streamlit/secrets.toml
APP_PASSWORD = "your-secure-password"


(Note: .streamlit/secrets.toml should be added to your .gitignore file so it is never uploaded to GitHub).

4. Run the Application

streamlit run app.py


The app will automatically open in your default web browser at http://localhost:8501.

## 📂 Project Structure ##

app.py: The main Streamlit application script containing the UI and database logic.

requirements.txt: The Python dependencies needed to run the app (streamlit, pandas).

.streamlit/config.toml: Contains the custom dark-mode and turquoise accent color configuration for accessibility.

zebra_data.db: The local SQLite database generated automatically on your first run (Keep this in .gitignore).


Built For Zebras from a cebra. 

This app is a personal case study and companion tool. It was built from the dual perspective of a patient and a developer, acknowledging that for chronic illness, doing a little is always better than pushing too hard.
>>>>>>> ad992c1992fa846ac9ffabe684c4a0fbde81c4eb
