import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:zebrapace_app/domain/services/period_comparison_service.dart';
import 'package:zebrapace_app/l10n/app_localizations.dart';
import 'package:zebrapace_app/presentation/screens/insights/widgets/insights_providers.dart';
import 'package:zebrapace_app/presentation/screens/insights/widgets/period_comparison_section.dart';
import 'package:zebrapace_app/providers/plus_providers.dart';

PeriodSummary _summary(String start, String end,
        {int days = 90, double? steps, double? body, int rest = 0}) =>
    PeriodSummary(
      start: start,
      end: end,
      daysLogged: days,
      avgSteps: steps,
      avgBodyScore: body,
      avgMentalScore: null,
      avgSleepHours: null,
      avgRestingHr: null,
      avgHrvMs: null,
      restDays: rest,
      flareDays: 0,
    );

Future<void> _pump(WidgetTester tester,
    {required bool plus, ({PeriodSummary earlier, PeriodSummary recent})? pair}) async {
  // Phone width: the four-column table must fit without overflow.
  tester.view.physicalSize = const Size(360 * 3, 1600 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(ProviderScope(
    overrides: [
      isPlusProvider.overrideWithValue(plus),
      periodComparisonProvider.overrideWith((ref) async => pair),
    ],
    child: CupertinoApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CupertinoPageScaffold(
        child: SingleChildScrollView(child: PeriodComparisonSection()),
      ),
    ),
  ));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() => initializeDateFormatting('en'));

  testWidgets('free: teaser and a way in, no numbers', (tester) async {
    await _pump(tester, plus: false);
    expect(find.text('⚖️ Compare periods'), findsOneWidget);
    expect(find.text('See Zebras+'), findsOneWidget);
    expect(find.text('Days logged'), findsNothing);
  });

  testWidgets('Zebras+: both periods, signed changes, dashes for missing values', (tester) async {
    await _pump(tester, plus: true, pair: (
      earlier: _summary('2026-05-23', '2026-08-22', steps: 5200, body: 2.8, rest: 10),
      recent: _summary('2026-08-23', '2026-11-22', steps: 4100, body: 3.4, rest: 14),
    ));
    expect(find.text('Days logged'), findsOneWidget);
    expect(find.text('−1,100'), findsOneWidget); // steps
    expect(find.text('+0.6'), findsOneWidget); // body score
    expect(find.text('+4'), findsOneWidget); // rest days
    expect(find.text('–'), findsWidgets); // sleep, HR, HRV not logged
    expect(find.textContaining('Recent: Aug 23, 2026'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('no earlier logs says so', (tester) async {
    await _pump(tester, plus: true, pair: (
      earlier: _summary('2025-08-23', '2025-11-22', days: 0),
      recent: _summary('2026-08-23', '2026-11-22', steps: 4100),
    ));
    expect(find.text('No logs in the earlier period yet.'), findsOneWidget);
  });
}
