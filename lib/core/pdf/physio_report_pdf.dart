import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../domain/models/soreness_check.dart';
import '../../domain/services/physio_report_service.dart';
import '../../l10n/app_localizations.dart';
import 'pdf_fonts.dart';

/// Renders the Zebras+ physio report: at most two A4 pages — "In 30
/// seconds", symptoms after sessions, and the person's questions. The
/// tables are capped in PhysioReportService so the content always fits;
/// MultiPage's maxPages is the hard stop.
///
/// Fonts come from PdfFonts (Nunito, with a Chinese fallback).
class PhysioReportPdf {
  static const maxPages = 2;
  static const _teal = PdfColor.fromInt(0xFF2E6B61);
  static const _border = PdfColor.fromInt(0xFFE6D9C3);
  static const _shade = PdfColor.fromInt(0xFFF6EFE3);

  Future<pw.Document> build(AppLocalizations l10n, PhysioReportData data, {required String locale}) async {
    final doc = pw.Document(theme: await PdfFonts.theme());

    final whole = NumberFormat.decimalPattern(locale)..maximumFractionDigits = 0;
    final oneDecimal = NumberFormat.decimalPattern(locale)
      ..minimumFractionDigits = 1
      ..maximumFractionDigits = 1;

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        maxPages: maxPages,
        build: (context) => [
          pw.Text(l10n.physioReportHeading,
              style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold, color: _teal)),
          pw.SizedBox(height: 3),
          if (data.name.isNotEmpty)
            pw.Text(l10n.physioReportFor(PdfFonts.withoutEmoji(data.name)), style: const pw.TextStyle(fontSize: 10)),
          pw.Text(l10n.doctorReportRangeLine(data.startDate, data.endDate, data.generatedAt),
              style: const pw.TextStyle(fontSize: 9)),
          pw.SizedBox(height: 3),
          pw.Text(l10n.doctorReportDisclaimer,
              style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic)),
          pw.SizedBox(height: 10),
          _summaryBox(l10n, data, whole, oneDecimal),
          pw.SizedBox(height: 12),
          _heading(l10n.physioSymptomsHeading),
          ..._soreness(l10n, data),
          pw.SizedBox(height: 10),
          ..._followUps(l10n, data),
          pw.SizedBox(height: 12),
          // Kept together so the heading never strands at a page bottom.
          pw.Inseparable(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [_heading(l10n.physioQuestionsTitle), ..._questions(data.questions)],
            ),
          ),
        ],
      ),
    );
    return doc;
  }

  pw.Widget _heading(String text) => pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 4),
        child: pw.Text(text,
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: _teal)),
      );

  pw.Widget _summaryBox(
    AppLocalizations l10n,
    PhysioReportData data,
    NumberFormat whole,
    NumberFormat oneDecimal,
  ) {
    final c = data.current;
    final p = data.previous;
    final na = l10n.doctorReportNotAvailable;

    String withChange(String line, num? now, num? before, NumberFormat f) {
      if (now == null || before == null) return line;
      final diff = now - before;
      final abs = f.format(diff.abs());
      final signed = abs == f.format(0) ? abs : '${diff > 0 ? '+' : '−'}$abs';
      return '$line (${l10n.physioSummaryVsPrevious(signed, data.daysInRange)})';
    }

    final lines = <String>[
      l10n.physioSummaryLogged(c.daysLogged, data.daysInRange),
      withChange(
        l10n.physioSummarySteps(c.avgSteps == null ? na : whole.format(c.avgSteps)),
        c.avgSteps,
        p.avgSteps,
        whole,
      ),
      withChange(
        l10n.physioSummaryBody(c.avgBodyScore == null ? na : oneDecimal.format(c.avgBodyScore)),
        c.avgBodyScore,
        p.avgBodyScore,
        oneDecimal,
      ),
      l10n.physioSummaryRestFlare(c.restDays, c.flareDays),
      l10n.physioSummaryCrashChecks(data.sorenessTally.possibleCrash),
      if (data.usualLagDays != null)
        l10n.physioSummaryUsualDelay(l10n.insightsTabPemLagDays(data.usualLagDays!)),
    ];

    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: _shade,
        border: pw.Border.all(color: _border),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(l10n.physioSummaryHeading,
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: _teal)),
          pw.SizedBox(height: 4),
          for (final line in lines)
            pw.Bullet(text: line, style: const pw.TextStyle(fontSize: 10), bulletSize: 3),
        ],
      ),
    );
  }

  List<pw.Widget> _soreness(AppLocalizations l10n, PhysioReportData data) {
    final t = data.sorenessTally;
    if (t.total == 0) {
      return [pw.Text(l10n.physioNoSorenessChecks, style: const pw.TextStyle(fontSize: 9.5))];
    }
    return [
      pw.Text(l10n.physioSorenessTally(t.likelySoreness, t.possibleCrash, t.unclear),
          style: const pw.TextStyle(fontSize: 9.5)),
      pw.SizedBox(height: 4),
      _table(
        [l10n.physioColDate, l10n.physioColOnset, l10n.physioColSpread, l10n.physioColTrend, l10n.physioColVerdict],
        [
          for (final c in data.recentChecks)
            [c.date, c.onset.label(l10n), c.spread.label(l10n), c.trend.label(l10n), _verdict(l10n, c)],
        ],
        widths: const [1.1, 1.6, 1.1, 1.0, 1.8],
      ),
    ];
  }

  String _verdict(AppLocalizations l10n, SorenessCheck c) => PdfFonts.withoutEmoji(switch (c.verdict) {
        'possible_crash' => l10n.sorenessVerdictCrashLabel,
        'likely_doms' => l10n.sorenessVerdictDomsLabel,
        _ => l10n.sorenessVerdictUnclearLabel,
      });


  List<pw.Widget> _followUps(AppLocalizations l10n, PhysioReportData data) {
    if (data.followUps.isEmpty) {
      return [pw.Text(l10n.physioNoSessions, style: const pw.TextStyle(fontSize: 9.5))];
    }
    String score(int? s) => s == null ? '–' : '$s';
    return [
      pw.Text(l10n.physioFollowUpIntro, style: const pw.TextStyle(fontSize: 9.5)),
      pw.SizedBox(height: 4),
      _table(
        [l10n.physioColDate, l10n.physioColSession, l10n.physioColSameDay, l10n.physioColDay1, l10n.physioColDay2],
        [
          for (final f in data.followUps)
            [f.date, PdfFonts.withoutEmoji(f.sessions.join(', ')), score(f.scoreSameDay), score(f.scoreDay1), score(f.scoreDay2)],
        ],
        widths: const [1.1, 3.0, 0.9, 0.8, 0.8],
        centerFrom: 2,
      ),
    ];
  }

  List<pw.Widget> _questions(String questions) {
    if (questions.isNotEmpty) {
      return [pw.Text(PdfFonts.withoutEmoji(questions), style: const pw.TextStyle(fontSize: 10))];
    }
    // Room to write by hand on a printed copy.
    return [
      for (var i = 0; i < 4; i++)
        pw.Container(
          height: 20,
          decoration: const pw.BoxDecoration(
            border: pw.Border(bottom: pw.BorderSide(color: _border)),
          ),
        ),
    ];
  }

  pw.Widget _table(
    List<String> headers,
    List<List<String>> rows, {
    required List<double> widths,
    int? centerFrom,
  }) {
    pw.Widget cell(String text, int col, {bool header = false}) => pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2.5),
          child: pw.Text(
            text,
            maxLines: 2,
            textAlign: centerFrom != null && col >= centerFrom ? pw.TextAlign.center : pw.TextAlign.left,
            style: pw.TextStyle(fontSize: 8.5, fontWeight: header ? pw.FontWeight.bold : null),
          ),
        );
    return pw.Table(
      border: pw.TableBorder(
        horizontalInside: const pw.BorderSide(color: _border, width: 0.5),
        bottom: const pw.BorderSide(color: _border, width: 0.5),
        top: const pw.BorderSide(color: _border, width: 0.5),
      ),
      columnWidths: {for (var i = 0; i < widths.length; i++) i: pw.FlexColumnWidth(widths[i])},
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: _shade),
          children: [for (var i = 0; i < headers.length; i++) cell(headers[i], i, header: true)],
        ),
        for (final r in rows)
          pw.TableRow(children: [for (var i = 0; i < r.length; i++) cell(r[i], i)]),
      ],
    );
  }
}
