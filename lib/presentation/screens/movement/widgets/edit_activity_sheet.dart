import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/activity.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/feeling_picker.dart';

/// Modal sheet for editing an already-logged Activity — reachable by tapping
/// a row in ActivitiesSection's list, then "Edit" on the action sheet.
/// Deliberately doesn't touch source/healthkitUuid/metsAvg/activeEnergyKcal,
/// which aren't user-editable fields.
Future<void> showEditActivitySheet(BuildContext context, Activity activity) {
  return showCupertinoModalPopup(
    context: context,
    builder: (_) => _EditActivitySheet(activity: activity),
  );
}

class _EditActivitySheet extends ConsumerStatefulWidget {
  const _EditActivitySheet({required this.activity});

  final Activity activity;

  @override
  ConsumerState<_EditActivitySheet> createState() => _EditActivitySheetState();
}

class _EditActivitySheetState extends ConsumerState<_EditActivitySheet> {
  late final _nameController = TextEditingController(text: widget.activity.activityName);
  late final _durationController =
      TextEditingController(text: widget.activity.durationMin.toString());
  late final _weightController =
      TextEditingController(text: widget.activity.extraWeightKg.toString());
  late final _hrMinController =
      TextEditingController(text: widget.activity.heartRateMinBpm?.toString() ?? '');
  late final _hrMaxController =
      TextEditingController(text: widget.activity.heartRateMaxBpm?.toString() ?? '');
  late MentalState? _mental = widget.activity.mentalState;
  late BodyFeeling? _body = widget.activity.bodyFeeling;

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    _weightController.dispose();
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
                Text(l10n.activitiesSectionEditTitle,
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
                    CupertinoTextField(
                        controller: _nameController,
                        placeholder: l10n.activitiesSectionNamePlaceholder),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoTextField(
                            controller: _durationController,
                            keyboardType: TextInputType.number,
                            placeholder: l10n.commonDurationMinPlaceholder,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CupertinoTextField(
                            controller: _weightController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            placeholder: l10n.activitiesSectionWeightPlaceholder,
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
                    FeelingPicker<MentalState>(
                      label: l10n.commonMentalStateLabel,
                      options: MentalState.values,
                      emojiOf: (o) => o.emoji,
                      labelOf: (o) => o.label(l10n),
                      value: _mental,
                      onChanged: (v) => setState(() => _mental = v),
                    ),
                    const SizedBox(height: 10),
                    FeelingPicker<BodyFeeling>(
                      label: l10n.commonBodyFeelingLabel,
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
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    await ref.read(activityRepositoryProvider).update(
          id: widget.activity.id,
          activityName: name,
          durationMin: int.tryParse(_durationController.text) ?? widget.activity.durationMin,
          extraWeightKg: double.tryParse(_weightController.text) ?? 0,
          mentalState: _mental,
          bodyFeeling: _body,
          heartRateMinBpm: int.tryParse(_hrMinController.text),
          heartRateMaxBpm: int.tryParse(_hrMaxController.text),
        );
    if (mounted) Navigator.of(context).pop();
  }
}
