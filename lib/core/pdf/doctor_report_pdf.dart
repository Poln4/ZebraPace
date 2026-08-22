import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../domain/services/doctor_report_service.dart';
import '../../l10n/app_localizations.dart';

/// Renders a DoctorReportData into a PDF, mirroring generate_doctor_pdf's
/// section order from app.py: Overview, Movement & Recovery, PEM note (if
/// any), Weather note (if any), Recent Passive Therapies, and (new, from
/// app2) Injuries.
class DoctorReportPdf {
  Future<pw.Document> build(AppLocalizations l10n, DoctorReportData data) async {
    final doc = pw.Document();
    final na = l10n.doctorReportNotAvailable;

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Text(l10n.doctorReportHeading,
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 4),
          pw.Text(l10n.doctorReportRangeLine(data.startDate, data.endDate, data.generatedAt),
              style: const pw.TextStyle(fontSize: 10)),
          pw.SizedBox(height: 4),
          pw.Text(
            l10n.doctorReportDisclaimer,
            style: pw.TextStyle(fontSize: 9, fontStyle: pw.FontStyle.italic),
          ),
          pw.SizedBox(height: 10),
          _sectionHeading(l10n.doctorReportOverviewHeading),
          ..._overviewRows(l10n, data.overview),
          pw.SizedBox(height: 8),
          _sectionHeading(l10n.doctorReportMovementHeading),
          pw.Text(
            l10n.doctorReportMovementSummary(data.activityCount, data.therapySessionCount),
            style: const pw.TextStyle(fontSize: 10),
          ),
          if (data.calisthenicsSummaries.isNotEmpty) ...[
            pw.SizedBox(height: 4),
            pw.Text(l10n.doctorReportCalisthenicsHeading,
                style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
            for (final s in data.calisthenicsSummaries)
              pw.Text(
                l10n.doctorReportCalisthenicsLine(
                      s.exerciseLabel,
                      s.latestTier,
                      s.last3AvgComfort.toStringAsFixed(1),
                    ) +
                    (s.lastContractionMode != null
                        ? l10n.doctorReportCalisthenicsLineMode(s.lastContractionMode!)
                        : ''),
                style: const pw.TextStyle(fontSize: 10),
              ),
          ],
          pw.SizedBox(height: 8),
          if (data.pemNote != null) ...[
            _sectionHeading(l10n.doctorReportPemHeading),
            pw.Text(data.pemNote!, style: const pw.TextStyle(fontSize: 10)),
            pw.SizedBox(height: 8),
          ],
          if (data.weatherNote != null) ...[
            _sectionHeading(l10n.doctorReportWeatherHeading),
            pw.Text(data.weatherNote!, style: const pw.TextStyle(fontSize: 10)),
            pw.SizedBox(height: 8),
          ],
          if (data.recentTherapies.isNotEmpty) ...[
            _sectionHeading(l10n.doctorReportTherapiesHeading),
            for (final t in data.recentTherapies)
              pw.Text(
                l10n.doctorReportTherapyLine(
                    t.date, t.therapyName, t.durationMin, t.bodyFeeling?.label(l10n) ?? na),
                style: const pw.TextStyle(fontSize: 9),
              ),
          ],
          if (data.relevantInjuries.isNotEmpty) ...[
            pw.SizedBox(height: 8),
            _sectionHeading(l10n.doctorReportInjuriesHeading),
            for (final i in data.relevantInjuries)
              pw.Text(
                l10n.doctorReportInjuryLine(
                      i.zone.label(l10n),
                      i.kind.label(l10n),
                      i.type.label(l10n),
                      i.dateStarted,
                      i.statusLabel,
                    ) +
                    (i.note.isNotEmpty ? l10n.doctorReportNoteSuffix(i.note) : ''),
                style: const pw.TextStyle(fontSize: 9),
              ),
          ],
          if (data.metsSummary.hasData) ...[
            pw.SizedBox(height: 8),
            _sectionHeading(l10n.doctorReportMetsHeading),
            pw.Text(
              l10n.doctorReportMetsLine(
                data.metsSummary.totalMetMinutes.toStringAsFixed(0),
                data.metsSummary.totalActiveEnergyKcal.toStringAsFixed(0),
              ),
              style: const pw.TextStyle(fontSize: 10),
            ),
          ],
        ],
      ),
    );

    return doc;
  }

  pw.Widget _sectionHeading(String text) => pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 4),
        child: pw.Text(text, style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
      );

  List<pw.Widget> _overviewRows(AppLocalizations l10n, DoctorReportOverview o) {
    final na = l10n.doctorReportNotAvailable;
    final rows = <(String, String)>[
      (l10n.doctorReportDaysInRange, '${o.daysInRange}'),
      (l10n.doctorReportDaysLogged, '${o.daysLogged}'),
      (l10n.doctorReportRestDays, '${o.restDays}'),
      (l10n.doctorReportFlareDays, '${o.flareDays}'),
      (l10n.doctorReportAvgSteps, o.avgSteps != null ? o.avgSteps!.toStringAsFixed(0) : na),
      (l10n.doctorReportAvgLiquids,
          o.daysLogged > 0 ? l10n.doctorReportMlValue(o.avgWaterMl.toStringAsFixed(0)) : na),
      (l10n.doctorReportAvgProtein,
          o.daysLogged > 0 ? l10n.doctorReportGramsValue(o.avgProteinG.toStringAsFixed(0)) : na),
      (l10n.doctorReportAvgMental,
          o.avgMentalScore != null ? o.avgMentalScore!.toStringAsFixed(1) : na),
      (l10n.doctorReportAvgBody, o.avgBodyScore != null ? o.avgBodyScore!.toStringAsFixed(1) : na),
    ];
    return rows
        .map((r) => pw.Row(
              children: [
                pw.SizedBox(width: 220, child: pw.Text(r.$1, style: const pw.TextStyle(fontSize: 10))),
                pw.Text(r.$2, style: const pw.TextStyle(fontSize: 10)),
              ],
            ))
        .toList();
  }
}
