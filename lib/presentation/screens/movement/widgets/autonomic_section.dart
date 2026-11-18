import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/id_gen.dart';
import '../../../../data/healthkit/health_kit_service.dart';
import '../../../../domain/models/autonomic.dart';
import '../../../../domain/services/autonomic_service.dart';
import '../../../../domain/services/readiness_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../../providers/autonomic_providers.dart';
import '../../../widgets/entry_actions.dart';
import '../../../widgets/section_card.dart';
import '../../plan/widgets/plan_form.dart';
import '../stand_test_screen.dart';
import 'autonomic_labels.dart';

/// Autonomic signals: the rest side (HRV, resting HR), the standing
/// response, cuff blood pressure and sweating — each on its own line,
/// against the person's own history. Never combined into a "balance".
class AutonomicSection extends ConsumerWidget {
  const AutonomicSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final date = ref.watch(selectedDateProvider);
    return SectionCard(
      title: l10n.autonomicTitle,
      caption: l10n.autonomicCaption,
      collapsible: true,
      initiallyExpanded: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _VagalLane(date: date),
          const _Divider(),
          const _StandLane(),
          const _Divider(),
          const _PressureLane(),
          const _Divider(),
          _SweatLane(date: date),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) => Container(
        height: 1,
        margin: const EdgeInsets.symmetric(vertical: 12),
        color: ZebraColors.cardBorder,
      );
}

class _LaneTitle extends StatelessWidget {
  const _LaneTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
      );
}

const _grey = TextStyle(fontSize: 12.5, color: CupertinoColors.systemGrey);

class _VagalLane extends ConsumerWidget {
  const _VagalLane({required this.date});

  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final r = ref.watch(readinessProvider(date)).valueOrNull ?? ReadinessResult.unknown;
    String usual(double? value, int days) => value != null
        ? l10n.readinessUsual(value.round())
        : l10n.readinessUsualPending(ReadinessService.minBaselineReadings - days);
    final lines = [
      if (r.restingHeartRateToday case final bpm?)
        '${r.restingHeartRateFromSleep ? l10n.readinessSleepingLine(bpm.round()) : l10n.readinessRestingLine(bpm.round())}'
            ' · ${usual(r.restingHeartRateUsual, r.restingHeartRateHistoryDays)}',
      if (r.hrvToday case final ms?)
        '${l10n.readinessHrvLine(ms.round())} · ${usual(r.hrvUsual, r.hrvHistoryDays)}',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LaneTitle(l10n.autonomicVagalTitle),
        if (lines.isEmpty)
          Text(l10n.autonomicVagalEmpty, style: const TextStyle(fontSize: 13))
        else ...[
          for (final l in lines) Text(l, style: const TextStyle(fontSize: 13.5)),
          if (r.reasons.contains(ReadinessReason.restingHeartRateUp))
            Text('· ${l10n.readinessReasonRestingHeartRate((r.restingHeartRateDelta ?? 0).round())}',
                style: const TextStyle(fontSize: 12.5)),
          if (r.reasons.contains(ReadinessReason.hrvDown))
            Text('· ${l10n.readinessReasonHrv((r.hrvPercentBelow ?? 0).round())}',
                style: const TextStyle(fontSize: 12.5)),
          if (r.hrvToday != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                usesHealthConnect ? l10n.autonomicHrvMetricAndroid : l10n.autonomicHrvMetricIos,
                style: _grey,
              ),
            ),
        ],
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(l10n.autonomicVagalNote, style: _grey),
        ),
      ],
    );
  }
}

String _signed(int v) => v > 0 ? '+$v' : '$v';

class _StandLane extends ConsumerWidget {
  const _StandLane();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tests = ref.watch(standTestsProvider).valueOrNull ?? const [];
    final last = tests.lastOrNull;
    final summary = last == null
        ? null
        : AutonomicService.summarize(last, earlier: tests.sublist(0, tests.length - 1));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LaneTitle(l10n.autonomicStandTitle),
        if (last == null || summary == null)
          Text(l10n.autonomicStandEmpty, style: const TextStyle(fontSize: 13))
        else ...[
          Text(
            [
              l10n.autonomicStandLast(last.date),
              if (last.stoppedEarly) l10n.autonomicStoppedEarly,
            ].join(' · '),
            style: _grey,
          ),
          if (summary.hrRise case final rise?)
            Text(
              '${l10n.autonomicHrRise(_signed(rise))} · ${summary.usualHrRise != null ? l10n.autonomicHrRiseUsual(summary.usualHrRise!.round()) : l10n.autonomicHrRisePending(AutonomicService.minTestsForUsual - summary.previousCount)}',
              style: const TextStyle(fontSize: 13.5),
            ),
          if (summary.sysChange != null && summary.diaChange != null)
            Text(
              l10n.autonomicPressureChange(_signed(summary.sysChange!), _signed(summary.diaChange!)),
              style: const TextStyle(fontSize: 13.5),
            ),
          if (last.symptoms.isNotEmpty)
            Text(last.symptoms.map((s) => standSymptomLabel(l10n, s)).join(', '),
                style: const TextStyle(fontSize: 12.5)),
          if (summary.heartRatePattern) _Hint(l10n.autonomicPotsHint),
          if (summary.pressureDropPattern) _Hint(l10n.autonomicOhHint),
        ],
        Row(
          children: [
            CupertinoButton(
              padding: const EdgeInsets.only(top: 6, right: 16),
              minimumSize: const Size(0, 32),
              // Full screen, above the tab bar: switching tabs mid-test
              // would leave the timer running out of sight.
              onPressed: () => Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute<void>(builder: (_) => const StandTestScreen()),
              ),
              child: Text(l10n.autonomicStandStart,
                  style: const TextStyle(fontSize: 14, color: ZebraColors.brandTeal)),
            ),
            if (tests.isNotEmpty)
              CupertinoButton(
                padding: const EdgeInsets.only(top: 6),
                minimumSize: const Size(0, 32),
                onPressed: () => _history(context, ref, tests),
                child: Text(l10n.autonomicAllTests, style: const TextStyle(fontSize: 14)),
              ),
          ],
        ),
      ],
    );
  }

  Future<void> _history(BuildContext context, WidgetRef ref, List<StandTest> tests) async {
    final l10n = AppLocalizations.of(context);
    final picked = await showCupertinoModalPopup<StandTest>(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: Text(l10n.autonomicAllTests),
        message: Text(l10n.autonomicTapToDelete),
        actions: [
          for (final t in tests.reversed)
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(ctx).pop(t),
              child: Text(
                [
                  t.date,
                  if (AutonomicService.summarize(t).hrRise case final r?) '${_signed(r)} bpm',
                  if (t.stoppedEarly) l10n.autonomicStoppedEarly,
                ].join(' · '),
                style: const TextStyle(fontSize: 15),
              ),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(l10n.commonCancelButton),
        ),
      ),
    );
    if (picked == null || !context.mounted) return;
    if (await confirmDelete(context, l10n)) {
      await ref.read(autonomicRepositoryProvider).deleteStandTest(picked.id);
    }
  }
}

class _Hint extends StatelessWidget {
  const _Hint(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ZebraColors.sand.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text, style: const TextStyle(fontSize: 12.5)),
      );
}

String _positionLabel(AppLocalizations l10n, String p) => switch (p) {
      'lying' => l10n.bpPositionLying,
      'standing' => l10n.bpPositionStanding,
      _ => l10n.bpPositionSitting,
    };

String _bpLine(AppLocalizations l10n, BloodPressureReading r) => [
      '${r.systolic}/${r.diastolic} mmHg',
      if (r.pulse != null) l10n.autonomicBpPulse(r.pulse!),
      _positionLabel(l10n, r.position),
    ].join(' · ');

class _PressureLane extends ConsumerWidget {
  const _PressureLane();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final all = ref.watch(bloodPressureProvider).valueOrNull ?? const [];
    final last = all.lastOrNull;
    final usual = last == null ? null : AutonomicService.usualPressure(all, last);
    final samePosition = last == null
        ? 0
        : all.where((r) => r.id != last.id && r.position == last.position).length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LaneTitle(l10n.autonomicBpTitle),
        if (last == null)
          Text(l10n.autonomicBpEmpty, style: const TextStyle(fontSize: 13))
        else ...[
          Text(_formatTime(last.takenAt), style: _grey),
          Text(_bpLine(l10n, last), style: const TextStyle(fontSize: 13.5)),
          Text(
            usual != null
                ? l10n.autonomicBpUsual(usual.$1.round(), usual.$2.round())
                : l10n.autonomicBpUsualPending(
                    (AutonomicService.minTestsForUsual - samePosition).clamp(1, 99)),
            style: _grey,
          ),
        ],
        Row(
          children: [
            CupertinoButton(
              padding: const EdgeInsets.only(top: 6, right: 16),
              minimumSize: const Size(0, 32),
              onPressed: () => showBloodPressureSheet(context, ref),
              child: Text(l10n.autonomicBpAdd,
                  style: const TextStyle(fontSize: 14, color: ZebraColors.brandTeal)),
            ),
            if (all.isNotEmpty)
              CupertinoButton(
                padding: const EdgeInsets.only(top: 6),
                minimumSize: const Size(0, 32),
                onPressed: () => _history(context, ref, all),
                child: Text(l10n.bpAllReadings, style: const TextStyle(fontSize: 14)),
              ),
          ],
        ),
      ],
    );
  }

  Future<void> _history(
      BuildContext context, WidgetRef ref, List<BloodPressureReading> all) async {
    final l10n = AppLocalizations.of(context);
    final picked = await showCupertinoModalPopup<BloodPressureReading>(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: Text(l10n.bpAllReadings),
        message: Text(l10n.bpTapToDelete),
        actions: [
          for (final r in all.reversed)
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(ctx).pop(r),
              child: Text('${_formatTime(r.takenAt)} · ${_bpLine(l10n, r)}',
                  style: const TextStyle(fontSize: 14)),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(l10n.commonCancelButton),
        ),
      ),
    );
    if (picked == null || !context.mounted) return;
    if (await confirmDelete(context, l10n)) {
      await ref.read(autonomicRepositoryProvider).deleteBloodPressure(picked.id);
    }
  }
}

String _formatTime(String iso) {
  final t = DateTime.tryParse(iso);
  if (t == null) return iso;
  return '${dateKey(t)} ${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

/// Typing in a reading from a home cuff.
Future<void> showBloodPressureSheet(BuildContext context, WidgetRef ref) {
  return showCupertinoModalPopup<void>(
    context: context,
    builder: (_) => const _BloodPressureSheet(),
  );
}

class _BloodPressureSheet extends ConsumerStatefulWidget {
  const _BloodPressureSheet();

  @override
  ConsumerState<_BloodPressureSheet> createState() => _BloodPressureSheetState();
}

class _BloodPressureSheetState extends ConsumerState<_BloodPressureSheet> {
  final _sys = TextEditingController();
  final _dia = TextEditingController();
  final _pulse = TextEditingController();
  final _note = TextEditingController();
  String _position = 'sitting';
  DateTime _takenAt = DateTime.now();

  @override
  void dispose() {
    _sys.dispose();
    _dia.dispose();
    _pulse.dispose();
    _note.dispose();
    super.dispose();
  }

  Widget _number(String label, TextEditingController c) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            CupertinoTextField(
              controller: c,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PlanSheet(
      title: l10n.bpSheetTitle,
      onSave: () async {
        final sys = VitalRange.sys(int.tryParse(_sys.text));
        final dia = VitalRange.dia(int.tryParse(_dia.text));
        if (sys == null || dia == null) return false;
        await ref.read(autonomicRepositoryProvider).saveBloodPressure(BloodPressureReading(
              id: newId(),
              date: dateKey(_takenAt),
              takenAt: _takenAt.toIso8601String(),
              systolic: sys,
              diastolic: dia,
              pulse: VitalRange.hr(int.tryParse(_pulse.text)),
              position: _position,
              note: trimmedOrNull(_note),
            ));
        return true;
      },
      children: [
        const SizedBox(height: 10),
        Row(children: [
          _number('${l10n.standTestSys} (mmHg)', _sys),
          const SizedBox(width: 8),
          _number('${l10n.standTestDia} (mmHg)', _dia),
        ]),
        const SizedBox(height: 10),
        Row(children: [_number(l10n.bpPulseOptional, _pulse)]),
        const SizedBox(height: 12),
        Text(l10n.bpPosition, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          child: CupertinoSlidingSegmentedControl<String>(
            groupValue: _position,
            children: {
              'sitting': Text(l10n.bpPositionSitting),
              'lying': Text(l10n.bpPositionLying),
              'standing': Text(l10n.bpPositionStanding),
            },
            onValueChanged: (v) => setState(() => _position = v ?? 'sitting'),
          ),
        ),
        const SizedBox(height: 12),
        Text(l10n.bpTime, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        SizedBox(
          height: 120,
          child: CupertinoDatePicker(
            initialDateTime: _takenAt,
            maximumDate: DateTime.now().add(const Duration(minutes: 1)),
            use24hFormat: true,
            onDateTimeChanged: (t) => _takenAt = t,
          ),
        ),
        PlanField(label: l10n.planNoteLabel, controller: _note, maxLines: 2),
        const SizedBox(height: 10),
        Text(l10n.bpTip, style: _grey),
      ],
    );
  }
}

class _SweatLane extends ConsumerWidget {
  const _SweatLane({required this.date});

  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final logs = ref.watch(sweatLogsProvider(date)).valueOrNull ?? const [];
    final today = logs.where((l) => l.date == date).firstOrNull;
    final selected = today?.kinds.toSet() ?? <SweatKind>{};
    final counts = AutonomicService.sweatCounts(logs);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LaneTitle(l10n.autonomicSweatTitle),
        Text(l10n.autonomicSweatCaption, style: const TextStyle(fontSize: 13)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final k in SweatKind.values)
              AutonomicChip(
                label: sweatKindLabel(l10n, k),
                selected: selected.contains(k),
                onTap: () {
                  final next = {...selected};
                  next.contains(k) ? next.remove(k) : next.add(k);
                  ref.read(autonomicRepositoryProvider).setSweat(
                        date,
                        [for (final s in SweatKind.values) if (next.contains(s)) s],
                        note: today?.note,
                      );
                },
              ),
          ],
        ),
        if (counts.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              l10n.autonomicSweatRecent(
                  counts.map((c) => '${sweatKindLabel(l10n, c.$1)} ×${c.$2}').join(', ')),
              style: _grey,
            ),
          ),
      ],
    );
  }
}
