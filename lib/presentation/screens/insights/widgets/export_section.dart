import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/pdf/doctor_report_pdf.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/section_card.dart';
import 'insights_providers.dart';
import 'insights_range.dart';

/// CSV export is deliberately a separate path from the PDF: the CSV covers
/// the FULL unfiltered daily_logs history, while the PDF is scoped to the
/// currently selected Insights range — matching app.py, where these are two
/// different exports, not the same one.
class ExportSection extends ConsumerWidget {
  const ExportSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      title: l10n.exportSectionTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.brandTeal,
              onPressed: () => _generateAndSharePdf(context, ref),
              child: Text(l10n.exportSectionPdfButton,
                  style: const TextStyle(color: ZebraColors.onColor)),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.teal,
              onPressed: () => _shareCsv(ref),
              child: Text(l10n.exportSectionCsvButton,
                  style: const TextStyle(color: ZebraColors.onColor)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _generateAndSharePdf(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final range = ref.read(insightsDateRangeProvider);
    final reportService = ref.read(doctorReportServiceProvider);

    final logs = await ref.read(dailyLogRepositoryProvider).getRange(range.start, range.end);
    final activities = await ref.read(activityRepositoryProvider).getRange(range.start, range.end);
    final therapies = await ref.read(therapyRepositoryProvider).getRange(range.start, range.end);
    final calisthenics =
        await ref.read(calisthenicsRepositoryProvider).getRange(range.start, range.end);
    final injuries =
        await ref.read(injuryRepositoryProvider).getRelevantToRange(range.start, range.end);

    final pemLag = ref.read(pemLagDaysProvider);
    final pemResult =
        await ref.read(pemServiceProvider).analyze(range.start, range.end, lagDays: pemLag);
    final rangeDays = ref.read(insightsRangeOptionProvider).days;
    final pemNote = reportService.buildPemNote(l10n, pemResult, pemLag, rangeDays);

    String? weatherNote;
    final settings = await ref.read(settingsSnapshotProvider.future);
    if (settings.hasLocation) {
      final correlation = await ref.read(weatherServiceProvider).correlateWithBodyScore(
            settings.locationLat!,
            settings.locationLon!,
            range.start,
            range.end,
          );
      weatherNote = reportService.buildWeatherNote(l10n, correlation);
    }

    final data = reportService.build(
      l10n: l10n,
      startDate: range.start,
      endDate: range.end,
      logsInRange: logs,
      activitiesInRange: activities,
      therapiesInRange: therapies,
      calisthenicsInRange: calisthenics,
      relevantInjuries: injuries,
      pemNote: pemNote,
      weatherNote: weatherNote,
    );

    final doc = await DoctorReportPdf().build(l10n, data);
    final bytes = await doc.save();
    await Printing.sharePdf(bytes: bytes, filename: 'zebrapace_pacing_summary.pdf');
  }

  Future<void> _shareCsv(WidgetRef ref) async {
    final csv = await ref.read(exportImportServiceProvider).exportDailyLogsCsv();
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/zebrapace_vitals.csv');
    await file.writeAsString(csv);
    await Share.shareXFiles([XFile(file.path)]);
  }
}
