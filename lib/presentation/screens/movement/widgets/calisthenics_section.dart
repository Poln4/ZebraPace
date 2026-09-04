import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/calisthenics_progressions.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/calisthenics_set.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/enum_wrap.dart';
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
  String? _goalCelebration;

  bool _logIssue = false;
  InjuryZone _issueZone = InjuryZone.wrist;
  InjuryKind _issueKind = InjuryKind.joint;
  InjuryType _issueType = InjuryType.subluxation;
  final _issueNoteController = TextEditingController();
  bool _issueLogged = false;

  @override
  void initState() {
    super.initState();
    _setsController.addListener(_onInputChanged);
    _repsController.addListener(_onInputChanged);
  }

  void _onInputChanged() => setState(() {});

  @override
  void dispose() {
    _setsController.dispose();
    _repsController.dispose();
    _issueNoteController.dispose();
    super.dispose();
  }

  CalisthenicsLevel _levelFor(AppLocalizations l10n) {
    final levels = _exercise.levels(l10n);
    return levels.firstWhere((lvl) => lvl.name == _progression, orElse: () => levels.first);
  }

  String _goalLabel(AppLocalizations l10n, CalisthenicsLevel level) {
    if (level.unit == GoalUnit.secondsHold) {
      return level.bothSides
          ? l10n.calisthenicsSectionGoalHoldBothSides(level.targetSets, level.targetValue)
          : l10n.calisthenicsSectionGoalHold(level.targetSets, level.targetValue);
    }
    return level.bothSides
        ? l10n.calisthenicsSectionGoalRepsBothSides(level.targetSets, level.targetValue)
        : l10n.calisthenicsSectionGoalReps(level.targetSets, level.targetValue);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final levels = _exercise.levels(l10n);
    _progression ??= levels.first.name;
    final currentLevel = _levelFor(l10n);
    final isLowEnergyDay = ref.watch(dailyLogProvider).valueOrNull?.isLowEnergyDay ?? false;

    final enteredSets = int.tryParse(_setsController.text) ?? 0;
    final enteredValue = int.tryParse(_repsController.text) ?? 0;
    final metGoal = enteredSets >= currentLevel.targetSets && enteredValue >= currentLevel.targetValue;
    final valueProgress =
        currentLevel.targetValue == 0 ? 0.0 : (enteredValue / currentLevel.targetValue).clamp(0.0, 1.0);

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
                _progression = v.levels(l10n).first.name;
              });
            },
          ),
          const SizedBox(height: 10),
          Text(l10n.calisthenicsSectionProgressionTierLabel,
              style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          EnumWrap<String>(
            options: [for (final lvl in levels) lvl.name],
            labelOf: (name) => name,
            value: _progression!,
            onChanged: (v) => setState(() => _progression = v),
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
          Row(
            children: [
              Expanded(
                child: Text(_goalLabel(l10n, currentLevel),
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5)),
              ),
              if (metGoal)
                Text(l10n.calisthenicsSectionGoalMetBadge,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 10,
              child: Stack(
                children: [
                  Container(color: ZebraColors.bg),
                  FractionallySizedBox(
                    widthFactor: valueProgress,
                    child: Container(
                        color: metGoal ? ZebraColors.brandTeal : ZebraColors.teal),
                  ),
                ],
              ),
            ),
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
          Row(
            children: [
              Expanded(
                child: Text(l10n.calisthenicsSectionLogIssueToggle,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
              CupertinoSwitch(
                value: _logIssue,
                onChanged: (v) => setState(() => _logIssue = v),
              ),
            ],
          ),
          if (_logIssue) ...[
            const SizedBox(height: 8),
            Text(l10n.injuriesSectionZoneLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            EnumWrap<InjuryZone>(
              options: InjuryZone.values,
              labelOf: (z) => z.label(l10n),
              value: _issueZone,
              onChanged: (v) => setState(() => _issueZone = v),
            ),
            const SizedBox(height: 10),
            Text(l10n.injuriesSectionKindLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            EnumWrap<InjuryKind>(
              options: InjuryKind.values,
              labelOf: (k) => k.label(l10n),
              value: _issueKind,
              onChanged: (v) => setState(() => _issueKind = v),
            ),
            const SizedBox(height: 10),
            Text(l10n.injuriesSectionTypeLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            EnumWrap<InjuryType>(
              options: InjuryType.values,
              labelOf: (t) => t.label(l10n),
              value: _issueType,
              onChanged: (v) => setState(() => _issueType = v),
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              controller: _issueNoteController,
              placeholder: l10n.injuriesSectionNotePlaceholder,
              maxLines: 2,
            ),
          ],
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
          if (_goalCelebration != null) ...[
            const SizedBox(height: 8),
            Text(_goalCelebration!,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ],
          if (_issueLogged) ...[
            const SizedBox(height: 8),
            Text(l10n.calisthenicsSectionIssueLoggedConfirmation,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ],
      ),
    );
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final date = ref.read(selectedDateProvider);
    final settings = ref.read(settingsSnapshotProvider).valueOrNull;
    final level = _levelFor(l10n);
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

    final loggedIssue = _logIssue;
    if (loggedIssue) {
      final exerciseLabel = _exercise.label(l10n);
      final note = _issueNoteController.text.trim();
      await ref.read(injuryRepositoryProvider).insert(
            dateStarted: date,
            zone: _issueZone,
            kind: _issueKind,
            type: _issueType,
            note: note.isEmpty ? exerciseLabel : '$exerciseLabel — $note',
          );
      _issueNoteController.clear();
    }

    final comfortMilestone = await ref.read(calisthenicsServiceProvider).checkComfortMilestone(
          _exercise.db,
          date,
          comfortThreshold: settings?.comfortThreshold ?? 3.8,
        );
    final goalMilestone = await ref.read(calisthenicsServiceProvider).checkGoalMilestone(
          _exercise.db,
          date,
          targetSets: level.targetSets,
          targetValue: level.targetValue,
        );
    setState(() {
      _celebration = comfortMilestone
          ? l10n.calisthenicsSectionMilestoneCelebration(_exercise.label(l10n))
          : null;
      _goalCelebration = goalMilestone
          ? l10n.calisthenicsSectionGoalMilestoneCelebration(_exercise.label(l10n))
          : null;
      _issueLogged = loggedIssue;
      _logIssue = false;
    });
  }
}
