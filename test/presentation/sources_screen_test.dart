import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/sources.dart';
import 'package:zebrapace_app/l10n/app_localizations.dart';
import 'package:zebrapace_app/presentation/screens/sources/sources_screen.dart';

Widget _app(Widget home, {Locale locale = const Locale('en')}) => CupertinoApp(
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    );

void main() {
  testWidgets('Sources screen lists every topic and source', (tester) async {
    await tester.pumpWidget(_app(const SourcesScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Sources & references'), findsOneWidget);
    // Scroll through and count every tile that comes into view.
    final seen = <Source>{};
    for (var i = 0; i < 40; i++) {
      for (final e in tester.widgetList<SourceTile>(find.byType(SourceTile))) {
        seen.add(e.source);
      }
      await tester.drag(find.byType(ListView), const Offset(0, -400));
      await tester.pumpAndSettle();
    }
    expect(seen, kSources.values.toSet());
    expect(tester.takeException(), isNull);
  });

  for (final locale in const [Locale('es'), Locale('zh')]) {
    testWidgets('Sources link opens the topic sheet ($locale)', (tester) async {
      await tester.pumpWidget(_app(
        const CupertinoPageScaffold(
            child: Center(child: SourcesLink([SourceTopic.standTest]))),
        locale: locale,
      ));
      await tester.tap(find.byType(SourcesLink));
      await tester.pumpAndSettle();
      expect(find.byType(SourceTile), findsNWidgets(2));
      expect(tester.takeException(), isNull);
    });
  }
}
