#!/bin/bash
# Store screenshots from the iOS simulator with demo data.
# Usage: tool/screenshots.sh <simulator-udid> <lang: en|es|zh> <out-dir>
# WARNING: wipes the app's data on that simulator.
set -euo pipefail
SIM=$1; LANG_CODE=$2; OUT=$3
mkdir -p "$OUT"
xcrun simctl status_bar "$SIM" override --time 9:41 --batteryState charged --batteryLevel 100 --cellularBars 4 --wifiBars 3
flutter test integration_test/screenshots_test.dart -d "$SIM" --dart-define=SHOT_LANG="$LANG_CODE" 2>&1 |
  while IFS= read -r line; do
    echo "$line"
    if [[ "$line" =~ SHOT\ ([A-Za-z0-9_]+) ]]; then
      xcrun simctl io "$SIM" screenshot "$OUT/${LANG_CODE}_${BASH_REMATCH[1]}.png" >/dev/null 2>&1 &
    fi
  done
wait
