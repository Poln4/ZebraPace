import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/feeling_picker.dart';
import '../../../widgets/health_source_row.dart';
import '../../../widgets/section_card.dart';

/// Duration (hours+minutes via a native time picker), quality, and sleeping
/// heart rate range — the raw inputs EnergyBatteryCard's readout is derived
/// from — plus morning resting HR and HRV. Deliberately one of the
/// "essentials" VitalsTab still shows on Rest/Flare days: this is the input
/// the energy display depends on, so it stays visible alongside
/// QuickCheckinSection rather than being tucked behind "Show all sections".
///
/// With Apple Health / Health Connect connected, everything but quality
/// syncs into the log on its own (healthSyncProvider) and is shown as
/// values; editing is the secondary "Edit" path. Without it, the form is
/// the way in.
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
  bool _editing = false;

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
    final connected = ref.watch(healthKitEnabledProvider).valueOrNull ?? false;
    final showValues = connected && !_editing && log != null;

    if (_loadedForDate != date) _editing = false;
    // While values are shown (synced), keep the form in step with the log
    // so "Edit" opens on what's there now; while typing, leave it alone.
    if (log != null && (_loadedForDate != date || showValues)) {
      _loadedForDate = date;
      _load(log);
    }

    return SectionCard(
      title: l10n.sleepSectionTitle,
      child: showValues ? _values(l10n, date, log) : _form(l10n, date, connected),
    );
  }

  Widget _values(AppLocalizations l10n, String date, DailyLog log) {
    final hasSleep = log.sleepHours != null;
    final hasRange = log.sleepHeartRateMin != null || log.sleepHeartRateMax != null;
    final edited = log.sleepSource == ValueSource.manual || log.heartSource == ValueSource.manual;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hasSleep
              ? l10n.sleepSectionDurationValue(_totalMinutes! ~/ 60, _totalMinutes! % 60)
              : l10n.sleepSectionWaitingForHealth,
          style: TextStyle(
            fontSize: hasSleep ? 22 : 14,
            fontWeight: hasSleep ? FontWeight.w700 : FontWeight.normal,
            color: ZebraColors.black,
          ),
        ),
        if (hasRange) ...[
          const SizedBox(height: 4),
          Text(l10n.sleepSectionHeartRateRangeValue(
              '${log.sleepHeartRateMin ?? '–'}', '${log.sleepHeartRateMax ?? '–'}')),
        ],
        if (log.restingHeartRate != null || log.hrvMs != null) ...[
          const SizedBox(height: 2),
          Text([
            if (log.restingHeartRate case final bpm?) l10n.sleepSectionRestingValue(bpm),
            if (log.hrvMs case final ms?) l10n.sleepSectionHrvValue(ms.round()),
          ].join(' · ')),
        ],
        HealthSourceRow(
          source: edited ? ValueSource.manual : ValueSource.health,
          onEdit: () => setState(() => _editing = true),
          onUseHealth: () => useHealthValue(ref, date, sleep: true, heart: true),
        ),
        const SizedBox(height: 8),
        // Health has no "how did it feel", so quality stays the person's
        // own and saves on tap.
        FeelingPicker<SleepQuality>(
          label: l10n.sleepSectionQualityLabel,
          options: SleepQuality.values,
          emojiOf: (q) => q.emoji,
          labelOf: (q) => q.label(l10n),
          value: _quality,
          onChanged: (q) async {
            setState(() => _quality = q);
            final repo = ref.read(dailyLogRepositoryProvider);
            final current = await repo.getOrCreateDailyLog(date);
            await repo.upsertDailyLog(current.copyWith(sleepQuality: q));
          },
        ),
      ],
    );
  }

  Widget _form(AppLocalizations l10n, String date, bool connected) {
    const label = TextStyle(fontWeight: FontWeight.w700, color: ZebraColors.black);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.sleepSectionDurationLabel, style: label),
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
        Text(l10n.sleepSectionHeartRateLabel, style: label),
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
        // reading); synced from Health otherwise.
        Text(l10n.sleepSectionMorningLabel, style: label),
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
        if (connected && _editing)
          Center(
            child: CupertinoButton(
              onPressed: () => setState(() => _editing = false),
              child: Text(l10n.healthCancelEditButton, style: const TextStyle(fontSize: 13)),
            ),
          ),
      ],
    );
  }

  void _load(DailyLog log) {
    _totalMinutes = log.sleepHours == null ? null : (log.sleepHours! * 60).round();
    _quality = log.sleepQuality;
    _hrMinController.text = log.sleepHeartRateMin?.toString() ?? '';
    _hrMaxController.text = log.sleepHeartRateMax?.toString() ?? '';
    _restingController.text = log.restingHeartRate?.toString() ?? '';
    _hrvController.text = log.hrvMs == null ? '' : log.hrvMs!.round().toString();
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

  /// A group whose values changed becomes the person's own for the day, so
  /// sync stops overwriting it; an untouched group keeps following Health.
  Future<void> _save(String date) async {
    final repo = ref.read(dailyLogRepositoryProvider);
    final log = await repo.getOrCreateDailyLog(date);
    final sleepHours = _totalMinutes == null ? null : _totalMinutes! / 60.0;
    final hrMin = int.tryParse(_hrMinController.text);
    final hrMax = int.tryParse(_hrMaxController.text);
    final resting = int.tryParse(_restingController.text);
    final hrv = double.tryParse(_hrvController.text.replaceAll(',', '.'));
    final sleepChanged = sleepHours != log.sleepHours ||
        hrMin != log.sleepHeartRateMin ||
        hrMax != log.sleepHeartRateMax;
    final heartChanged =
        resting != log.restingHeartRate || hrv?.round() != log.hrvMs?.round();
    await repo.upsertDailyLog(
      log.copyWith(
        sleepHours: sleepHours,
        sleepQuality: _quality,
        sleepHeartRateMin: hrMin,
        sleepHeartRateMax: hrMax,
        restingHeartRate: resting,
        hrvMs: heartChanged ? hrv : log.hrvMs,
        sleepSource: sleepChanged ? ValueSource.manual : log.sleepSource,
        heartSource: heartChanged ? ValueSource.manual : log.heartSource,
      ),
    );
    setState(() => _editing = false);
  }
}
