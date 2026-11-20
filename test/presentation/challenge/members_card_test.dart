import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/data/repositories/challenge_repository.dart';
import 'package:zebrapace_app/domain/models/challenge.dart';
import 'package:zebrapace_app/domain/models/challenge_entry.dart';
import 'package:zebrapace_app/l10n/app_localizations.dart';
import 'package:zebrapace_app/presentation/screens/challenge/widgets/members_card.dart';
import 'package:zebrapace_app/providers/challenge_providers.dart';

class _FakeRepo implements ChallengeRepository {
  final calls = <String>[];

  @override
  Future<void> leaveChallenge(String challengeId) async => calls.add('leave $challengeId');

  @override
  Future<void> removeMember({required String challengeId, required String userId}) async =>
      calls.add('remove $challengeId $userId');

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Challenge _challenge(String createdBy) => Challenge(
      id: 'c1',
      name: 'Walk',
      code: 'WALK',
      kind: ChallengeKind.steps,
      targetPercent: 5,
      createdBy: createdBy,
      createdAt: DateTime(2026, 11, 1),
    );

ChallengeEntry _entry(String id, String name) => ChallengeEntry(
      challengeId: 'c1',
      userId: id,
      displayName: name,
      updatedAt: DateTime(2026, 11, 1),
    );

Future<_FakeRepo> _pump(WidgetTester tester, {required String createdBy, List<ChallengeEntry>? entries}) async {
  final repo = _FakeRepo();
  await tester.pumpWidget(ProviderScope(
    overrides: [challengeRepositoryProvider.overrideWithValue(repo)],
    child: CupertinoApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: CupertinoPageScaffold(
        child: SingleChildScrollView(
          child: MembersCard(
            challenge: _challenge(createdBy),
            entries: entries ?? [_entry('me', 'Pau'), _entry('ana', 'Ana'), _entry('leo', 'Leo')],
            myUserId: 'me',
          ),
        ),
      ),
    ),
  ));
  return repo;
}

void main() {
  testWidgets('the creator can remove others, never themself', (tester) async {
    final repo = await _pump(tester, createdBy: 'me');
    expect(find.text('Remove'), findsNWidgets(2));
    expect(find.textContaining('created it'), findsOneWidget);
    expect(find.textContaining('Pau (you)'), findsOneWidget);

    await tester.tap(find.text('Remove').first);
    await tester.pumpAndSettle();
    expect(find.text('Remove Ana?'), findsOneWidget);
    await tester.tap(find.widgetWithText(CupertinoDialogAction, 'Remove'));
    await tester.pumpAndSettle();
    expect(repo.calls, ['remove c1 ana']);
  });

  testWidgets('other members see no Remove button', (tester) async {
    await _pump(tester, createdBy: 'ana');
    expect(find.text('Remove'), findsNothing);
  });

  testWidgets('cancelling a removal does nothing', (tester) async {
    final repo = await _pump(tester, createdBy: 'me');
    await tester.tap(find.text('Remove').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(repo.calls, isEmpty);
  });

  testWidgets('leaving explains a handover when the creator leaves', (tester) async {
    final repo = await _pump(tester, createdBy: 'me');
    await tester.tap(find.text('Leave this challenge'));
    await tester.pumpAndSettle();
    expect(find.textContaining('passes to another member'), findsOneWidget);
    await tester.tap(find.widgetWithText(CupertinoDialogAction, 'Leave'));
    await tester.pumpAndSettle();
    expect(repo.calls, ['leave c1']);
  });

  testWidgets('the last member is told the challenge is deleted', (tester) async {
    await _pump(tester, createdBy: 'me', entries: [_entry('me', 'Pau')]);
    await tester.tap(find.text('Leave this challenge'));
    await tester.pumpAndSettle();
    expect(find.textContaining('the challenge itself is deleted'), findsOneWidget);
  });

  testWidgets('a non-creator leaving gets no handover note', (tester) async {
    await _pump(tester, createdBy: 'ana');
    await tester.tap(find.text('Leave this challenge'));
    await tester.pumpAndSettle();
    expect(find.textContaining('passes to'), findsNothing);
    expect(find.textContaining('rejoin later with the code'), findsOneWidget);
  });
}
