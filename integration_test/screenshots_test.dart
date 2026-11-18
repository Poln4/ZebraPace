// App Store / Play screenshots with made-up demo data — never anyone's real
// health data. Run with tool/screenshots.sh, which watches for the
// "SHOT <name>" lines printed here and captures the simulator screen
// (status bar included) while the test holds still.
//
// WARNING: wipes the app's database on the device it runs on.

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:integration_test/integration_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zebrapace_app/app.dart';
import 'package:zebrapace_app/core/config/supabase_config.dart';
import 'package:zebrapace_app/data/db/app_database.dart';
import 'package:zebrapace_app/l10n/app_localizations.dart';
import 'package:zebrapace_app/providers/app_providers.dart';
import 'package:zebrapace_app/providers/auth_providers.dart';

const _lang = String.fromEnvironment('SHOT_LANG', defaultValue: 'en');

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('screenshots', (tester) async {
    GoogleFonts.config.allowRuntimeFetching = false;
    await Supabase.initialize(url: SupabaseConfig.url, publishableKey: SupabaseConfig.anonKey);

    final container = ProviderContainer();
    final db = container.read(appDatabaseProvider);
    await _seed(db);

    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: const ZebraPaceApp()));
    await _wait(tester, 3);
    await container.read(authProvider.notifier).setupPassword('zebra1234');
    await _wait(tester, 3);

    // Tab bar order: Vitals, Movement, Plan, Insights, Together.
    final tabs = find.byType(CupertinoTabBar);
    Future<void> tab(int i) async {
      final bar = tester.getRect(tabs);
      await tester.tapAt(Offset(bar.left + bar.width * (i + 0.5) / 5, bar.top + 20));
      await _wait(tester, 3);
    }

    final l10n = AppLocalizations.of(tester.element(tabs));

    await _shot(tester, '1_vitals');
    await tab(1);
    await _shot(tester, '2_movement');
    // Open the Autonomic signals card and bring it to the top.
    final autonomic = find.text(l10n.autonomicTitle);
    await tester.tap(autonomic);
    await _wait(tester, 2);
    await Scrollable.ensureVisible(tester.element(autonomic), alignment: 0.02);
    await _wait(tester, 2);
    await _shot(tester, '3_autonomic');
    await tab(2);
    await _shot(tester, '4_plan');
    await tab(3);
    await _shot(tester, '5_insights');
    await tester.tap(find.text(l10n.insightsViewTrends));
    await _wait(tester, 3);
    await _shot(tester, '6_trends');
  });
}

Future<void> _wait(WidgetTester tester, int seconds) async {
  for (var i = 0; i < seconds * 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> _shot(WidgetTester tester, String name) async {
  await _wait(tester, 2);
  // ignore: avoid_print
  print('SHOT $name');
  await _wait(tester, 4); // the host script captures during this pause
}

// --- Demo data ------------------------------------------------------------

String _d(int daysAgo) {
  final t = DateTime.now().subtract(Duration(days: daysAgo));
  return '${t.year}-${_p2(t.month)}-${_p2(t.day)}';
}

String _p2(int n) => n.toString().padLeft(2, '0');

Future<void> _ins(AppDatabase db, String table, Map<String, Object?> row) async {
  final r = {'updated_at': DateTime.now().toIso8601String(), ...row};
  final cols = r.keys.join(', ');
  final qs = List.filled(r.length, '?').join(', ');
  await db.customStatement(
    'INSERT OR REPLACE INTO $table ($cols) VALUES ($qs)',
    [for (final v in r.values) v is bool ? (v ? 1 : 0) : v],
  );
}

Future<void> _seed(AppDatabase db) async {
  for (final t in db.allTables) {
    await db.customStatement('DELETE FROM ${t.actualTableName}');
  }
  await _ins(db, 'settings', {'key': 'invite_code_verified', 'value': 'true'});
  await _ins(db, 'settings', {'key': 'welcome_acknowledged', 'value': 'true'});
  await _ins(db, 'settings', {'key': 'language_code', 'value': _lang});

  const moods = ['okay', 'good', 'good', 'okay', 'low', 'good', 'energized'];
  const bodies = ['manageable', 'good', 'manageable', 'achy', 'manageable', 'good', 'looseStable'];
  const sleeps = ['okay', 'good', 'restless', 'good', 'restorative', 'okay', 'good'];
  for (var i = 41; i >= 0; i--) {
    final flare = i == 17 || i == 16;
    final rest = i % 7 == 3 || flare;
    final steps = flare ? 1400 : (rest ? 2300 : 3600 + (i * 487) % 2200);
    await _ins(db, 'daily_logs', {
      'id': 'dl$i',
      'date': _d(i),
      'weight_kg': 61.5 + ((i * 7) % 9) / 10,
      'water_ml_raw': 1700 + (i * 130) % 700,
      'water_ml_credit': 1600 + (i * 130) % 700,
      'protein_g': 70 + (i * 11) % 30,
      'mental_state': flare ? 'low' : moods[i % 7],
      'body_feeling': flare ? 'achy' : bodies[i % 7],
      'steps': steps,
      'steps_source': 'health',
      'is_rest_day': rest,
      'is_flare_day': flare,
      'sleep_hours': 6.5 + ((i * 3) % 5) / 4,
      'sleep_quality': sleeps[i % 7],
      'sleep_source': 'health',
      'resting_heart_rate': 60 + (i * 5) % 6 + (flare ? 5 : 0),
      'hrv_ms': 48.0 - (i * 7) % 11 - (flare ? 10 : 0),
      'heart_source': 'health',
    });
    for (final (n, at) in [(0, '09:10'), (1, '19:40')]) {
      await _ins(db, 'checkins', {
        'id': 'c$i-$n',
        'date': _d(i),
        'logged_at': at,
        'mental_state': flare ? 'low' : moods[(i + n) % 7],
        'body_feeling': flare ? 'achy' : bodies[(i + n) % 7],
      });
    }
    if (!rest && i % 2 == 0) {
      await _ins(db, 'activities', {
        'id': 'a$i',
        'date': _d(i),
        'activity_name': i % 4 == 0 ? 'Swimming' : 'Walking',
        'duration_min': i % 4 == 0 ? 25 : 30,
        'mental_state': 'good',
        'body_feeling': 'good',
        'mets_avg': i % 4 == 0 ? 5.0 : 3.3,
        'heart_rate_min_bpm': 82,
        'heart_rate_max_bpm': 118 + i % 9,
      });
    }
    if (!rest && i % 7 == 1) {
      await _ins(db, 'calisthenics', {
        'id': 'k$i',
        'date': _d(i),
        'exercise': 'Push-up',
        'progression': i > 20 ? 'Wall push-up' : 'Incline push-up',
        'sets': 3,
        'reps': 8,
        'set_values': jsonEncode([8, 8, 6]),
        'comfort_score': 4,
        'mental_state': 'good',
        'body_feeling': 'good',
      });
    }
  }

  // A training plan, as someone would build it in the editor.
  final monday = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1 + 28));
  await _ins(db, 'training_plans', {
    'id': 'p1',
    'name': 'Steady strength',
    'start_date': '${monday.year}-${_p2(monday.month)}-${_p2(monday.day)}',
    'weeks': 12,
    'weekly_ceiling_min': 150,
    'floor_note': '10 calf raises and a 5-minute walk',
    'current_phase_id': 'ph2',
    'test_weeks': '1,6,12',
    'is_active': true,
  });
  final phases = [
    ('ph1', 'Foundation', 'Learn the moves, no flare-ups', 'Easy, 3/10', 'Short walks'),
    ('ph2', 'Build', 'Add a little load each week', 'Moderate, 4–5/10', '20 min, conversational'),
    ('ph3', 'Strengthen', 'Hold the gains', 'Moderate', '25–30 min'),
  ];
  for (final (i, p) in phases.indexed) {
    await _ins(db, 'plan_phases', {
      'id': p.$1, 'plan_id': 'p1', 'position': i, 'name': p.$2, 'goal': p.$3,
      'effort': p.$4, 'cardio': p.$5, 'gate': i == 0 ? 'Two calm weeks in a row' : null,
    });
  }
  await _ins(db, 'plan_sessions', {
    'id': 'sA', 'plan_id': 'p1', 'position': 0, 'name': 'A · Strength', 'weekday': 1,
    'duration_min': 30, 'low_day_note': 'One set of each',
  });
  await _ins(db, 'plan_sessions', {
    'id': 'sB', 'plan_id': 'p1', 'position': 1, 'name': 'B · Cardio', 'weekday': 3,
    'duration_min': 20, 'low_day_note': '10 easy minutes', 'is_cardio': true,
  });
  await _ins(db, 'plan_sessions', {
    'id': 'sC', 'plan_id': 'p1', 'position': 2, 'name': 'C · Strength', 'weekday': 5,
    'duration_min': 30, 'low_day_note': 'One set of each',
  });
  final exercises = [
    ('eA1', 'sA', 'Push', 'Slow on the way down', ['Wall push-up', 'Incline push-up', 'Knee push-up'], 1),
    ('eA2', 'sA', 'Legs', 'Knees track over toes', ['Sit-to-stand', 'Split squat', 'Step-up'], 1),
    ('eA3', 'sA', 'Hinge', 'Ribs down', ['Glute bridge', 'Single-leg bridge'], 0),
    ('eC1', 'sC', 'Pull', null, ['Band row', 'Table row'], 0),
    ('eC2', 'sC', 'Calves', null, ['Calf raise', 'Single-leg calf raise'], 0),
  ];
  for (final (i, e) in exercises.indexed) {
    for (final (j, s) in e.$5.indexed) {
      await _ins(db, 'plan_steps', {
        'id': '${e.$1}s$j', 'exercise_id': e.$1, 'position': j, 'name': s, 'dose': '2–3 × 6–10',
      });
    }
    await _ins(db, 'plan_exercises', {
      'id': e.$1, 'session_id': e.$2, 'position': i, 'name': e.$3, 'cue': e.$4,
      'current_step_id': '${e.$1}s${e.$6}', 'step_changed_on': _d(12),
    });
  }
  for (var w = 0; w < 4; w++) {
    for (final (k, s) in [('sA', 0), ('sB', 2), ('sC', 4)]) {
      final daysAgo = 26 - w * 7 - s;
      if (daysAgo < 1) continue;
      await _ins(db, 'plan_session_logs', {
        'id': 'l$w$k', 'plan_id': 'p1', 'session_id': k, 'date': _d(daysAgo),
        'mode': w == 1 && k == 'sC' ? 'lowDay' : 'full', 'duration_min': 30,
        'next_morning': 'settled',
      });
    }
  }
  await _ins(db, 'plan_tests', {'id': 't1', 'plan_id': 'p1', 'position': 0, 'name': 'Sit-to-stand in 30 s', 'unit': 'reps'});
  await _ins(db, 'plan_test_results', {'id': 'tr1', 'test_id': 't1', 'date': _d(28), 'value': 9});
  await _ins(db, 'fear_items', {'id': 'f1', 'name': 'Stairs without the rail', 'fear': 4, 'initial_fear': 8});

  // Autonomic signals: a few stand tests so "your usual" shows up.
  final stands = [(34, 64, 82, 86, 84), (24, 62, 80, 83, 81), (14, 66, 85, 88, 86), (2, 63, 84, 90, 87)];
  for (final (i, s) in stands.indexed) {
    await _ins(db, 'stand_tests', {
      'id': 'st$i', 'date': _d(s.$1), 'started_at': '${_d(s.$1)}T08:30:00',
      'baseline_hr': s.$2, 'baseline_sys': 112, 'baseline_dia': 72,
      'hr1': s.$3, 'sys1': 108, 'dia1': 74, 'hr3': s.$4, 'sys3': 106, 'dia3': 73, 'hr10': s.$5,
      'symptoms': jsonEncode(i == 3 ? ['lightheaded'] : []),
    });
  }
  for (final (i, d) in [20, 15, 9, 5, 1].indexed) {
    await _ins(db, 'blood_pressure_readings', {
      'id': 'bp$i', 'date': _d(d), 'taken_at': '${_d(d)}T08:15:00',
      'systolic': 110 + i % 3 * 3, 'diastolic': 70 + i % 2 * 3, 'pulse': 64 + i,
    });
  }
  await _ins(db, 'sweat_logs', {'id': 'sw1', 'date': _d(3), 'kinds': jsonEncode(['coldClammy'])});
  await _ins(db, 'sweat_logs', {'id': 'sw0', 'date': _d(0), 'kinds': jsonEncode(['moreThanUsual'])});
}
