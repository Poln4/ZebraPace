import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../data/healthkit/health_kit_service.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../domain/models/detected_sleep.dart';
import '../../../../domain/services/readiness_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/feeling_picker.dart';
import '../../../widgets/section_card.dart';

/// Duration (hours+minutes via a native time picker), quality, and sleeping
/// heart rate range — the raw inputs EnergyBatteryCard's readout is derived
/// from. Deliberately one of the "essentials" VitalsTab still shows on
/// Rest/Flare days: this is the input the energy display depends on, so it
/// stays visible alongside QuickCheckinSection rather than being tucked
/// behind "Show all sections" like the extra sections.
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
  final _restingController = TextEditingController();
  final _hrvController = TextEditingController();
  String? _loadedForDate;
  bool _filledFromHealth = false;

  @override
  void dispose() {
    _hrMinController.dispose();
    _hrMaxController.dispose();
    _restingController.dispose();
    _hrvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = ref.watch(selectedDateProvider);
    final log = ref.watch(dailyLogProvider).valueOrNull;
    // Like HealthKit steps: wait for the Health lookup before locking in the
    // prefill, so a slow response isn't missed on first build.
    final healthSleepAsync = ref.watch(healthSleepProvider(date));
    final healthAutonomicAsync = ref.watch(healthAutonomicProvider(date));

    if (log != null &&
        _loadedForDate != date &&
        !healthSleepAsync.isLoading &&
        !healthAutonomicAsync.isLoading) {
      _loadedForDate = date;
      _prefill(log, healthSleepAsync.valueOrNull, healthAutonomicAsync.valueOrNull);
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
          const SizedBox(height: 12),
          // Typed in by anyone without a watch (e.g. a finger-on-camera
          // reading); pre-filled from Health otherwise.
          Text(l10n.sleepSectionMorningLabel,
              style: const TextStyle(fontWeight: FontWeight.w700, color: ZebraColors.black)),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: CupertinoTextField(
                  controller: _restingController,
                  keyboardType: TextInputType.number,
                  placeholder: l10n.sleepSectionRestingPlaceholder,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CupertinoTextField(
                  controller: _hrvController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  placeholder: l10n.sleepSectionHrvPlaceholder,
                ),
              ),
            ],
          ),
          if (_filledFromHealth) ...[
            const SizedBox(height: 8),
            Text(
              usesHealthConnect
                  ? l10n.sleepSectionFromHealthConnect
                  : l10n.sleepSectionFromHealth,
              style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
            ),
          ],
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

  /// Saved values always win; Health only fills fields left empty, so a
  /// manual correction is never overwritten.
  void _prefill(DailyLog log, DetectedSleep? health, AutonomicReading? autonomic) {
    final minutes = log.sleepHours == null ? health?.asleepMinutes : (log.sleepHours! * 60).round();
    final hrMin = log.sleepHeartRateMin ?? health?.heartRateMinBpm;
    final hrMax = log.sleepHeartRateMax ?? health?.heartRateMaxBpm;
    final resting = log.restingHeartRate ?? autonomic?.restingHeartRate?.round();
    final hrv = log.hrvMs ?? autonomic?.hrvMs;
    _filledFromHealth = (health != null &&
            ((log.sleepHours == null && health.asleepMinutes > 0) ||
                (log.sleepHeartRateMin == null && health.heartRateMinBpm != null) ||
                (log.sleepHeartRateMax == null && health.heartRateMaxBpm != null))) ||
        (log.restingHeartRate == null && autonomic?.restingHeartRate != null) ||
        (log.hrvMs == null && autonomic?.hrvMs != null);
    _restingController.text = resting?.toString() ?? '';
    _hrvController.text = hrv == null ? '' : hrv.round().toString();
    _totalMinutes = minutes;
    _quality = log.sleepQuality;
    _hrMinController.text = hrMin?.toString() ?? '';
    _hrMaxController.text = hrMax?.toString() ?? '';
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
        restingHeartRate: int.tryParse(_restingController.text),
        hrvMs: double.tryParse(_hrvController.text.replaceAll(',', '.')),
      ),
    );
    setState(() => _filledFromHealth = false);
  }
}
