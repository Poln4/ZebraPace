import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/core/pdf/physio_report_pdf.dart';
import 'package:zebrapace_app/domain/models/soreness_check.dart';
import 'package:zebrapace_app/domain/services/period_comparison_service.dart';
import 'package:zebrapace_app/domain/services/physio_report_service.dart';
import 'package:zebrapace_app/l10n/app_localizations.dart';

PeriodSummary _summary() => PeriodComparisonService.summarize('2026-11-01', '2026-11-30', []);

/// The fullest report the caps allow, with long text everywhere.
PhysioReportData _worstCase({String questions = ''}) => PhysioReportData(
      name: 'Paulina Valenzuela Lagos',
      startDate: '2026-11-01',
      endDate: '2026-11-30',
      generatedAt: '2026-11-30 10:00',
      current: _summary(),
      previous: _summary(),
      sorenessTally: const SorenessTally(likelySoreness: 12, possibleCrash: 9, unclear: 7),
      recentChecks: [
        for (var i = 0; i < PhysioReportService.maxChecks; i++)
          SorenessCheck(
            id: '$i',
            date: '2026-11-${(i + 10).toString()}',
            onset: SorenessOnset.twoToThreeDaysAfter,
            spread: SorenessSpread.widespread,
            trend: SorenessTrend.worse,
            verdict: 'possible_crash',
            verdictLabel: '',
          ),
      ],
      followUps: [
        for (var i = 0; i < PhysioReportService.maxFollowUps; i++)
          SessionFollowUp(
            date: '2026-11-${(i + 10).toString()}',
            sessions: const [
              'Hydrotherapy with resistance bands',
              'Wall squats (assisted, partial range)',
              'Neck isometrics',
              'Gentle evening walk around the block',
            ],
            scoreSameDay: 3,
            scoreDay1: 2,
            scoreDay2: null,
          ),
      ],
      usualLagDays: 2,
      questions: questions,
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  for (final locale in const ['en', 'es']) {
    test('worst case fits in ${PhysioReportPdf.maxPages} pages ($locale)', () async {
      final l10n = lookupAppLocalizations(Locale(locale));
      final data = _worstCase(questions: 'Q' * (PhysioReportService.maxQuestionsLength + 1));
      final doc = await PhysioReportPdf().build(l10n, data, locale: locale);
      // MultiPage throws TooManyPagesException past maxPages.
      final bytes = await doc.save();
      expect(bytes, isNotEmpty);
      expect(doc.document.pdfPageList.pages.length, lessThanOrEqualTo(PhysioReportPdf.maxPages));
    });
  }

  test('empty period still renders (no sessions, no checks, blank question lines)', () async {
    final l10n = lookupAppLocalizations(const Locale('en'));
    final data = PhysioReportData(
      name: '',
      startDate: '2026-11-01',
      endDate: '2026-11-30',
      generatedAt: '2026-11-30 10:00',
      current: _summary(),
      previous: _summary(),
      sorenessTally: const SorenessTally(likelySoreness: 0, possibleCrash: 0, unclear: 0),
      recentChecks: const [],
      followUps: const [],
      usualLagDays: null,
      questions: '',
    );
    final doc = await PhysioReportPdf().build(l10n, data, locale: 'en');
    expect(await doc.save(), isNotEmpty);
    expect(doc.document.pdfPageList.pages.length, 1);
  });

  test('withoutEmoji strips label emoji but keeps text, dashes and minus signs', () {
    expect(PhysioReportPdf.withoutEmoji('🌩️ More consistent with a crash/PEM pattern'),
        'More consistent with a crash/PEM pattern');
    expect(PhysioReportPdf.withoutEmoji('💪 Dolor – común −1 ✅'), 'Dolor – común −1');
  });
}
