import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/calisthenics_set.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/feeling_picker.dart';

/// Modal sheet for editing an already-logged calisthenics set — reachable by
/// tapping a row in CalisthenicsSection's list, then "Edit" on the action
/// sheet. Exercise/progression stay fixed (see CalisthenicsRepository.update
/// for why) — shown here read-only for context.
Future<void> showEditCalisthenicsSheet(BuildContext context, CalisthenicsSet set) {
  return showCupertinoModalPopup(
    context: context,
    builder: (_) => _EditCalisthenicsSheet(set: set),
  );
}

class _EditCalisthenicsSheet extends ConsumerStatefulWidget {
  const _EditCalisthenicsSheet({required this.set});

  final CalisthenicsSet set;

  @override
  ConsumerState<_EditCalisthenicsSheet> createState() => _EditCalisthenicsSheetState();
}

class _EditCalisthenicsSheetState extends ConsumerState<_EditCalisthenicsSheet> {
  late final _setsController = TextEditingController(text: widget.set.sets.toString());
  late final _repsController = TextEditingController(text: widget.set.reps.toString());
  late final _hrMinController =
      TextEditingController(text: widget.set.heartRateMinBpm?.toString() ?? '');
  late final _hrMaxController =
      TextEditingController(text: widget.set.heartRateMaxBpm?.toString() ?? '');
  late double _comfort = widget.set.comfortScore;
  late MentalState? _mental = widget.set.mentalState;
  late BodyFeeling? _body = widget.set.bodyFeeling;
  late ContractionMode? _contractionMode = widget.set.contractionMode;

  @override
  void dispose() {
    _setsController.dispose();
    _repsController.dispose();
    _hrMinController.dispose();
    _hrMaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: ZebraColors.paper,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.commonCancelButton),
                ),
                Text(l10n.calisthenicsSectionEditTitle,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                CupertinoButton(
                  onPressed: _save,
                  child: Text(l10n.commonSaveButton),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.set.exercise.label(l10n)} — ${widget.set.progression}',
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
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
                    Text(l10n.commonHeartRateLabel,
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoTextField(
                            controller: _hrMinController,
                            keyboardType: TextInputType.number,
                            placeholder: l10n.commonHeartRateMinPlaceholder,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CupertinoTextField(
                            controller: _hrMaxController,
                            keyboardType: TextInputType.number,
                            placeholder: l10n.commonHeartRateMaxPlaceholder,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    await ref.read(calisthenicsRepositoryProvider).update(
          id: widget.set.id,
          sets: int.tryParse(_setsController.text) ?? widget.set.sets,
          reps: int.tryParse(_repsController.text) ?? widget.set.reps,
          comfortScore: _comfort,
          mentalState: _mental,
          bodyFeeling: _body,
          contractionMode: _contractionMode,
          heartRateMinBpm: int.tryParse(_hrMinController.text),
          heartRateMaxBpm: int.tryParse(_hrMaxController.text),
        );
    if (mounted) Navigator.of(context).pop();
  }
}
