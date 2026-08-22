import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/feeling_picker.dart';
import '../../../widgets/section_card.dart';

/// Duration (hours+minutes via a native time picker), quality, and sleeping
/// heart rate range — the raw inputs EnergyBatteryCard's readout is derived
/// from. Deliberately not auto-collapsed on Rest/Flare days like the other
/// Vitals sections (see SectionCard's collapsible support): this is the
/// input the energy display depends on, so it stays visible alongside
/// MindBodyForm rather than defaulting closed like the "extra" sections.
class SleepSection extends ConsumerStatefulWidget {
  const SleepSection({super.key});

  @override
  ConsumerState<SleepSection> createState() => _SleepSectionState();
}

class _SleepSectionState extends ConsumerState<SleepSection> {
  int? _totalMinutes;
  SleepQuality? _quality;
  final _hrMinController = TextEditingController();
  final _hrMaxController = TextEditingController();
  String? _loadedForDate;

  @override
  void dispose() {
    _hrMinController.dispose();
    _hrMaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = ref.watch(selectedDateProvider);
    final log = ref.watch(dailyLogProvider).valueOrNull;

    if (log != null && _loadedForDate != date) {
      _loadedForDate = date;
      _prefill(log);
    }

    return SectionCard(
      title: l10n.sleepSectionTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.sleepSectionDurationLabel,
              style: const TextStyle(fontWeight: FontWeight.w700, color: ZebraColors.black)),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.paper,
              padding: const EdgeInsets.symmetric(vertical: 10),
              onPressed: () => _pickDuration(context),
              child: Text(
                _totalMinutes == null
                    ? l10n.sleepSectionDurationPlaceholder
                    : l10n.sleepSectionDurationValue(_totalMinutes! ~/ 60, _totalMinutes! % 60),
                style: const TextStyle(color: ZebraColors.black),
              ),
            ),
          ),
          const SizedBox(height: 12),
          FeelingPicker<SleepQuality>(
            label: l10n.sleepSectionQualityLabel,
            options: SleepQuality.values,
            emojiOf: (q) => q.emoji,
            labelOf: (q) => q.label(l10n),
            value: _quality,
            onChanged: (q) => setState(() => _quality = q),
          ),
          const SizedBox(height: 12),
          Text(l10n.sleepSectionHeartRateLabel,
              style: const TextStyle(fontWeight: FontWeight.w700, color: ZebraColors.black)),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: CupertinoTextField(
                  controller: _hrMinController,
                  keyboardType: TextInputType.number,
                  placeholder: l10n.sleepSectionHeartRateMinPlaceholder,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CupertinoTextField(
                  controller: _hrMaxController,
                  keyboardType: TextInputType.number,
                  placeholder: l10n.sleepSectionHeartRateMaxPlaceholder,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.teal,
              onPressed: () => _save(date),
              child: Text(l10n.sleepSectionSaveButton,
                  style: const TextStyle(color: ZebraColors.onColor)),
            ),
          ),
        ],
      ),
    );
  }

  void _prefill(DailyLog log) {
    _totalMinutes = log.sleepHours == null ? null : (log.sleepHours! * 60).round();
    _quality = log.sleepQuality;
    _hrMinController.text = log.sleepHeartRateMin?.toString() ?? '';
    _hrMaxController.text = log.sleepHeartRateMax?.toString() ?? '';
  }

  Future<void> _pickDuration(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    var picked = Duration(minutes: _totalMinutes ?? 0);
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => Container(
        height: 260,
        color: ZebraColors.paper,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                initialTimerDuration: picked,
                onTimerDurationChanged: (d) => picked = d,
              ),
            ),
            CupertinoButton(
              child: Text(l10n.appShellDoneButton),
              onPressed: () {
                setState(() => _totalMinutes = picked.inMinutes);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save(String date) async {
    final repo = ref.read(dailyLogRepositoryProvider);
    final log = await repo.getOrCreateDailyLog(date);
    await repo.upsertDailyLog(
      log.copyWith(
        sleepHours: _totalMinutes == null ? null : _totalMinutes! / 60.0,
        sleepQuality: _quality,
        sleepHeartRateMin: int.tryParse(_hrMinController.text),
        sleepHeartRateMax: int.tryParse(_hrMaxController.text),
      ),
    );
  }
}
