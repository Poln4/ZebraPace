import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:zebrapace_app/domain/services/long_term_pem_service.dart';
import 'package:zebrapace_app/l10n/app_localizations.dart';
import 'package:zebrapace_app/presentation/screens/insights/widgets/insights_providers.dart';
import 'package:zebrapace_app/presentation/screens/insights/widgets/long_term_pattern_section.dart';
import 'package:zebrapace_app/providers/plus_providers.dart';

Future<void> _pump(WidgetTester tester, {required bool plus, LongTermPemPattern? pattern}) async {
  await tester.pumpWidget(ProviderScope(
    overrides: [
      isPlusProvider.overrideWithValue(plus),
      longTermPemProvider.overrideWith((ref) async => pattern),
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
        child: SingleChildScrollView(child: LongTermPatternSection()),
      ),
    ),
  ));
  await tester.pumpAndSettle();
}

const _pattern = LongTermPemPattern(
  daysCovered: 200,
  lags: [
    LagDip(lagDays: 1, dip: 0.1, pairs: 150),
    LagDip(lagDays: 2, dip: 0.9, pairs: 150),
    LagDip(lagDays: 3, dip: 0.4, pairs: 150),
    LagDip(lagDays: 4, dip: null, pairs: 2),
  ],
  usualLagDays: 2,
  months: [
    MonthDip(month: '2026-05', dip: 1.2, pairs: 25),
    MonthDip(month: '2026-06', dip: 1.1, pairs: 25),
    MonthDip(month: '2026-07', dip: 1.0, pairs: 25),
    MonthDip(month: '2026-08', dip: 0.6, pairs: 25),
    MonthDip(month: '2026-09', dip: 0.5, pairs: 25),
    MonthDip(month: '2026-10', dip: 0.4, pairs: 25),
  ],
  trend: DipTrend.smaller,
);

void main() {
  setUpAll(() => initializeDateFormatting('en'));

  testWidgets('free: explains the view and offers Zebras+, no analysis shown', (tester) async {
    await _pump(tester, plus: false, pattern: _pattern);
    expect(find.text('🧭 Your pattern over months'), findsOneWidget);
    expect(find.text('See Zebras+'), findsOneWidget);
    expect(find.textContaining('usual delay'), findsNothing);
  });

  testWidgets('Zebras+: usual delay, bars, trend and footnote', (tester) async {
    await _pump(tester, plus: true, pattern: _pattern);
    expect(find.textContaining('about 0.9 points lower 2 days after bigger days'), findsOneWidget);
    expect(find.text('Dip 2 days later, month by month'), findsOneWidget);
    expect(find.text('May'), findsOneWidget);
    expect(find.text('–'), findsOneWidget); // 4-day delay: not enough pairs
    expect(find.text('Your dips have gotten smaller than in your first months.'), findsOneWidget);
    expect(find.textContaining('not a diagnosis'), findsOneWidget);
    expect(find.text('See Zebras+'), findsNothing);
  });

  testWidgets('Zebras+ with too little history says how much there is', (tester) async {
    await _pump(
      tester,
      plus: true,
      pattern: const LongTermPemPattern(
        daysCovered: 20,
        lags: [],
        usualLagDays: null,
        months: [],
        trend: null,
      ),
    );
    expect(find.textContaining('So far: 20 days.'), findsOneWidget);
  });
}
