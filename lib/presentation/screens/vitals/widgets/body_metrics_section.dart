import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/section_card.dart';

/// Weight/height/body-fat kept isolated from mental/pain symptom logging —
/// pre-fills from the most recent day (on/before the selected date) that has
/// a nonzero value, via BodyMetricsService.getCarryForward. Editing a past
/// date never ripples forward.
class BodyMetricsSection extends ConsumerStatefulWidget {
  const BodyMetricsSection({super.key});

  @override
  ConsumerState<BodyMetricsSection> createState() => _BodyMetricsSectionState();
}

class _BodyMetricsSectionState extends ConsumerState<BodyMetricsSection> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _fatController = TextEditingController();
  String? _loadedForDate;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _fatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = ref.watch(selectedDateProvider);
    final log = ref.watch(dailyLogProvider).valueOrNull;

    if (log != null && _loadedForDate != date) {
      _loadedForDate = date;
      _prefill(date, log);
    }

    return SectionCard(
      title: l10n.bodyMetricsSectionTitle,
      collapsible: true,
      initiallyExpanded: !(log?.isLowEnergyDay ?? false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoTextField(
            controller: _weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            placeholder: l10n.bodyMetricsSectionWeightPlaceholder,
          ),
          const SizedBox(height: 8),
          CupertinoTextField(
            controller: _heightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            placeholder: l10n.bodyMetricsSectionHeightPlaceholder,
          ),
          const SizedBox(height: 8),
          CupertinoTextField(
            controller: _fatController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            placeholder: l10n.bodyMetricsSectionBodyFatPlaceholder,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.teal,
              onPressed: () => _save(date),
              child: Text(l10n.bodyMetricsSectionSaveButton,
                  style: const TextStyle(color: ZebraColors.onColor)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _prefill(String date, DailyLog log) async {
    if (log.weightKg != null || log.heightCm != null || log.fatPercentage != null) {
      _weightController.text = log.weightKg?.toString() ?? '';
      _heightController.text = log.heightCm?.toString() ?? '';
      _fatController.text = log.fatPercentage?.toString() ?? '';
      return;
    }
    final carryForward = await ref.read(bodyMetricsServiceProvider).getCarryForward(date);
    if (!mounted || _loadedForDate != date) return;
    _weightController.text = carryForward?.weightKg?.toString() ?? '';
    _heightController.text = carryForward?.heightCm?.toString() ?? '';
    _fatController.text = carryForward?.fatPercentage?.toString() ?? '';
  }

  Future<void> _save(String date) async {
    final repo = ref.read(dailyLogRepositoryProvider);
    final log = await repo.getOrCreateDailyLog(date);
    await repo.upsertDailyLog(
      log.copyWith(
        weightKg: double.tryParse(_weightController.text),
        heightCm: double.tryParse(_heightController.text),
        fatPercentage: double.tryParse(_fatController.text),
      ),
    );
  }
}
