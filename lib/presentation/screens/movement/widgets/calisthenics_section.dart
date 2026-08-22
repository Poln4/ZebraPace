import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/calisthenics_set.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/feeling_picker.dart';
import '../../../widgets/section_card.dart';

class CalisthenicsSection extends ConsumerStatefulWidget {
  const CalisthenicsSection({super.key});

  @override
  ConsumerState<CalisthenicsSection> createState() => _CalisthenicsSectionState();
}

class _CalisthenicsSectionState extends ConsumerState<CalisthenicsSection> {
  CalisthenicsExercise _exercise = CalisthenicsExercise.pushups;
  String? _progression;
  ContractionMode? _contractionMode;
  final _setsController = TextEditingController(text: '3');
  final _repsController = TextEditingController(text: '10');
  double _comfort = 3.0;
  MentalState? _mental;
  BodyFeeling? _body;
  String? _celebration;

  @override
  void dispose() {
    _setsController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    _progression ??= _exercise.progressions(l10n).first;
    final isLowEnergyDay = ref.watch(dailyLogProvider).valueOrNull?.isLowEnergyDay ?? false;
    return SectionCard(
      title: l10n.calisthenicsSectionTitle,
      collapsible: true,
      initiallyExpanded: !isLowEnergyDay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.calisthenicsSectionExerciseLabel,
              style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          CupertinoSlidingSegmentedControl<CalisthenicsExercise>(
            groupValue: _exercise,
            children: {
              for (final e in CalisthenicsExercise.values)
                e: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(e.label(l10n), style: const TextStyle(fontSize: 11)),
                ),
            },
            onValueChanged: (v) {
              if (v == null) return;
              setState(() {
                _exercise = v;
                _progression = v.progressions(l10n).first;
              });
            },
          ),
          const SizedBox(height: 10),
          Text(l10n.calisthenicsSectionProgressionTierLabel,
              style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          CupertinoSegmentedControl<String>(
            groupValue: _progression,
            children: {
              for (final p in _exercise.progressions(l10n))
                p: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  child: Text(p, style: const TextStyle(fontSize: 10), textAlign: TextAlign.center),
                ),
            },
            onValueChanged: (v) => setState(() => _progression = v),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CupertinoTextField(
                  controller: _setsController,
                  keyboardType: TextInputType.number,
                  placeholder: l10n.calisthenicsSectionSetsPlaceholder,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CupertinoTextField(
                  controller: _repsController,
                  keyboardType: TextInputType.number,
                  placeholder: l10n.calisthenicsSectionRepsPlaceholder,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(l10n.calisthenicsSectionContractionModeLabel,
              style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: ContractionMode.values.map((m) {
              final selected = m == _contractionMode;
              return GestureDetector(
                onTap: () => setState(() => _contractionMode = m),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: selected ? ZebraColors.brandTeal : ZebraColors.bg,
                    border: Border.all(color: ZebraColors.cardBorder),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(m.label(l10n),
                      style: const TextStyle(fontSize: 11, color: ZebraColors.onColor)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Text(
              l10n.calisthenicsSectionComfortLabel(
                  _comfort.toStringAsFixed(1), comfortLabel(l10n, _comfort)),
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
          CupertinoSlider(
            value: _comfort,
            min: 1,
            max: 5,
            divisions: 40,
            onChanged: (v) => setState(() => _comfort = v),
          ),
          const SizedBox(height: 8),
          FeelingPicker<MentalState>(
            label: l10n.calisthenicsSectionMentalStateLabel,
            options: MentalState.values,
            emojiOf: (o) => o.emoji,
            labelOf: (o) => o.label(l10n),
            value: _mental,
            onChanged: (v) => setState(() => _mental = v),
          ),
          const SizedBox(height: 10),
          FeelingPicker<BodyFeeling>(
            label: l10n.calisthenicsSectionBodyFeelingLabel,
            options: BodyFeeling.values,
            emojiOf: (o) => o.emoji,
            labelOf: (o) => o.label(l10n),
            value: _body,
            onChanged: (v) => setState(() => _body = v),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.brandTeal,
              onPressed: _save,
              child: Text(l10n.calisthenicsSectionLogButton,
                  style: const TextStyle(color: ZebraColors.onColor)),
            ),
          ),
          if (_celebration != null) ...[
            const SizedBox(height: 8),
            Text(_celebration!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ],
      ),
    );
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final date = ref.read(selectedDateProvider);
    final settings = ref.read(settingsSnapshotProvider).valueOrNull;
    await ref.read(calisthenicsRepositoryProvider).insert(
          date: date,
          exercise: _exercise,
          progression: _progression!,
          sets: int.tryParse(_setsController.text) ?? 0,
          reps: int.tryParse(_repsController.text) ?? 0,
          comfortScore: _comfort,
          mentalState: _mental,
          bodyFeeling: _body,
          contractionMode: _contractionMode,
        );

    final milestone = await ref.read(calisthenicsServiceProvider).checkComfortMilestone(
          _exercise.db,
          date,
          comfortThreshold: settings?.comfortThreshold ?? 3.8,
        );
    setState(() {
      _celebration =
          milestone ? l10n.calisthenicsSectionMilestoneCelebration(_exercise.label(l10n)) : null;
    });
  }
}
