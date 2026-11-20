import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/id_gen.dart';
import '../../../domain/models/autonomic.dart';
import '../../../domain/services/autonomic_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/autonomic_providers.dart';
import '../../widgets/section_card.dart';
import 'widgets/autonomic_labels.dart';
import '../../../core/constants/sources.dart';
import '../sources/sources_screen.dart';

enum _Phase { intro, resting, baseline, standing }

/// The active stand test: safety first, 5 minutes' rest, then heart rate
/// (and blood pressure, optional) at 1, 3 and 10 minutes standing. "Stop
/// test" is on screen the whole time; stopping saves what was recorded.
class StandTestScreen extends ConsumerStatefulWidget {
  const StandTestScreen({super.key});

  static const restSeconds = 300;

  @override
  ConsumerState<StandTestScreen> createState() => _StandTestScreenState();
}

class _Fields {
  final hr = TextEditingController();
  final sys = TextEditingController();
  final dia = TextEditingController();

  StandReading get reading => StandReading(
        hr: VitalRange.hr(int.tryParse(hr.text)),
        sys: VitalRange.sys(int.tryParse(sys.text)),
        dia: VitalRange.dia(int.tryParse(dia.text)),
      );

  void dispose() {
    hr.dispose();
    sys.dispose();
    dia.dispose();
  }
}

class _StandTestScreenState extends ConsumerState<StandTestScreen> {
  _Phase _phase = _Phase.intro;
  String _position = 'lying';
  final _fields = {for (final p in StandPoint.values) p: _Fields()};
  final _symptoms = <StandSymptom>{};
  DateTime? _restStart;
  DateTime? _standStart;
  Timer? _ticker;
  StandPoint? _lastAlerted;
  bool _saving = false;

  @override
  void dispose() {
    _ticker?.cancel();
    for (final f in _fields.values) {
      f.dispose();
    }
    super.dispose();
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    if (!mounted) return;
    if (_phase == _Phase.resting && _restLeft <= 0) {
      HapticFeedback.heavyImpact();
      _phase = _Phase.baseline;
      _ticker?.cancel();
    }
    if (_phase == _Phase.standing) {
      // A buzz as each reading comes due.
      final due = [StandPoint.min1, StandPoint.min3, StandPoint.min10]
          .where((p) => _standingSeconds >= p.atSecond)
          .lastOrNull;
      if (due != null && due != _lastAlerted) {
        _lastAlerted = due;
        HapticFeedback.heavyImpact();
      }
    }
    setState(() {});
  }

  int get _restLeft => _restStart == null
      ? StandTestScreen.restSeconds
      : StandTestScreen.restSeconds - DateTime.now().difference(_restStart!).inSeconds;

  int get _standingSeconds =>
      _standStart == null ? 0 : DateTime.now().difference(_standStart!).inSeconds;

  static String _clock(int seconds) {
    final s = seconds < 0 ? 0 : seconds;
    return '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';
  }

  StandTest _build({required bool stoppedEarly}) => StandTest(
        id: newId(),
        date: dateKey(_standStart ?? DateTime.now()),
        startedAt: (_standStart ?? DateTime.now()).toIso8601String(),
        baselinePosition: _position,
        readings: {for (final e in _fields.entries) e.key: e.value.reading},
        symptoms: [for (final s in StandSymptom.values) if (_symptoms.contains(s)) s],
        stoppedEarly: stoppedEarly,
      );

  bool get _hasAnyReading => _fields.values.any((f) => !f.reading.isEmpty);

  Future<void> _stop() async {
    _ticker?.cancel();
    final l10n = AppLocalizations.of(context);
    if (_hasAnyReading) {
      await ref.read(autonomicRepositoryProvider).saveStandTest(_build(stoppedEarly: true));
    }
    if (!mounted) return;
    if (_phase == _Phase.standing) {
      await showCupertinoDialog<void>(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text(l10n.standTestStoppedTitle),
          content: Text(l10n.standTestStoppedBody),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _finish() async {
    setState(() => _saving = true);
    _ticker?.cancel();
    await ref.read(autonomicRepositoryProvider).saveStandTest(_build(stoppedEarly: false));
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PopScope(
      // Mid-test, leaving goes through Stop test so the readings are kept.
      canPop: _phase == _Phase.intro,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _stop();
      },
      child: CupertinoPageScaffold(
        backgroundColor: ZebraColors.bg,
        navigationBar: CupertinoNavigationBar(middle: Text(l10n.standTestTitle)),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: switch (_phase) {
                    _Phase.intro => _intro(l10n),
                    _Phase.resting => _resting(l10n),
                    _Phase.baseline => _baseline(l10n),
                    _Phase.standing => _standing(l10n),
                  },
                ),
              ),
              if (_phase != _Phase.intro)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      color: CupertinoColors.destructiveRed,
                      onPressed: _saving ? null : _stop,
                      child: Text(
                        l10n.standTestStop,
                        style: const TextStyle(
                            color: CupertinoColors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _intro(AppLocalizations l10n) => [
        Text(l10n.standTestIntro, style: const TextStyle(fontSize: 14)),
        const SourcesLink([SourceTopic.standTest]),
        const SizedBox(height: 12),
        SectionCard(
          title: l10n.standTestSafetyTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final t in [
                l10n.standTestSafetyWall,
                l10n.standTestSafetyStop,
                l10n.standTestSafetyCompany,
                l10n.standTestSafetyWhen,
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text('· $t', style: const TextStyle(fontSize: 13.5)),
                ),
            ],
          ),
        ),
        Text(l10n.standTestRestPosition,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          child: CupertinoSlidingSegmentedControl<String>(
            groupValue: _position,
            children: {
              'lying': Text(l10n.standTestLying),
              'sitting': Text(l10n.standTestSitting),
            },
            onValueChanged: (v) => setState(() => _position = v ?? 'lying'),
          ),
        ),
        const SizedBox(height: 16),
        CupertinoButton.filled(
          onPressed: () {
            setState(() {
              _phase = _Phase.resting;
              _restStart = DateTime.now();
            });
            _startTicker();
          },
          child: Text(l10n.standTestBeginRest),
        ),
        CupertinoButton(
          onPressed: () => setState(() => _phase = _Phase.baseline),
          child: Text(l10n.standTestSkipRest),
        ),
      ];

  List<Widget> _resting(AppLocalizations l10n) => [
        const SizedBox(height: 24),
        Center(
          child: Text(
            _clock(_restLeft),
            style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w300),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(l10n.standTestResting(_clock(_restLeft)),
              textAlign: TextAlign.center, style: const TextStyle(fontSize: 14)),
        ),
        CupertinoButton(
          onPressed: () {
            _ticker?.cancel();
            setState(() => _phase = _Phase.baseline);
          },
          child: Text(l10n.standTestSkipRest),
        ),
      ];

  List<Widget> _baseline(AppLocalizations l10n) {
    final ready = _fields[StandPoint.baseline]!.reading.hr != null;
    return [
      Text(l10n.standTestBaselinePrompt, style: const TextStyle(fontSize: 14)),
      const SizedBox(height: 10),
      _ReadingCard(
        title: l10n.standTestBaselineLabel,
        fields: _fields[StandPoint.baseline]!,
        enabled: true,
        onChanged: () => setState(() {}),
      ),
      CupertinoButton.filled(
        onPressed: ready
            ? () {
                setState(() {
                  _phase = _Phase.standing;
                  _standStart = DateTime.now();
                });
                _startTicker();
              }
            : null,
        child: Text(l10n.standTestStandUp),
      ),
    ];
  }

  List<Widget> _standing(AppLocalizations l10n) {
    final secs = _standingSeconds;
    final next = AutonomicService.nextPoint(secs);
    final tenDone = _fields[StandPoint.min10]!.reading.hr != null;
    final allDone = next == null || tenDone;
    return [
      Center(
        child: Text(
          l10n.standTestStanding(_clock(secs)),
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
        ),
      ),
      const SizedBox(height: 4),
      Center(
        child: Text(
          allDone
              ? l10n.standTestAllRead
              : l10n.standTestNextAt(next.atSecond ~/ 60, _clock(next.atSecond - secs)),
          style: const TextStyle(fontSize: 13.5, color: CupertinoColors.systemGrey),
        ),
      ),
      const SizedBox(height: 10),
      for (final p in [StandPoint.min1, StandPoint.min3, StandPoint.min10])
        _ReadingCard(
          title: l10n.standTestPointLabel(p.atSecond ~/ 60),
          fields: _fields[p]!,
          // Open a few seconds early so typing can start as it comes due.
          enabled: secs >= p.atSecond - 5,
          highlight: secs >= p.atSecond && _fields[p]!.reading.hr == null,
          onChanged: () => setState(() {}),
        ),
      SectionCard(
        title: l10n.standTestSymptoms,
        child: Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final s in StandSymptom.values)
              AutonomicChip(
                label: standSymptomLabel(l10n, s),
                selected: _symptoms.contains(s),
                onTap: () => setState(
                    () => _symptoms.contains(s) ? _symptoms.remove(s) : _symptoms.add(s)),
              ),
          ],
        ),
      ),
      if (allDone)
        CupertinoButton.filled(
          onPressed: _saving ? null : _finish,
          child: Text(l10n.standTestFinish),
        ),
    ];
  }
}

class _ReadingCard extends StatelessWidget {
  const _ReadingCard({
    required this.title,
    required this.fields,
    required this.enabled,
    required this.onChanged,
    this.highlight = false,
  });

  final String title;
  final _Fields fields;
  final bool enabled;
  final bool highlight;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Widget field(TextEditingController c, String placeholder) => Expanded(
          child: CupertinoTextField(
            controller: c,
            enabled: enabled,
            placeholder: placeholder,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            onChanged: (_) => onChanged(),
          ),
        );
    return Opacity(
      opacity: enabled ? 1 : 0.45,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ZebraColors.paper,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: highlight ? ZebraColors.brandTeal : ZebraColors.cardBorder,
            width: highlight ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            const SizedBox(height: 6),
            Row(children: [field(fields.hr, '${l10n.standTestHr} (bpm)')]),
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 6),
              child: Text(l10n.standTestHrHint,
                  style: const TextStyle(fontSize: 11.5, color: CupertinoColors.systemGrey)),
            ),
            Text(l10n.standTestBpOptional, style: const TextStyle(fontSize: 12.5)),
            const SizedBox(height: 4),
            Row(children: [
              field(fields.sys, l10n.standTestSys),
              const SizedBox(width: 8),
              field(fields.dia, l10n.standTestDia),
            ]),
          ],
        ),
      ),
    );
  }
}
