import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/therapy.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/feeling_picker.dart';

/// Modal sheet for editing an already-logged Therapy — reachable by tapping
/// a row in TherapiesSection's list, then "Edit" on the action sheet.
Future<void> showEditTherapySheet(BuildContext context, Therapy therapy) {
  return showCupertinoModalPopup(
    context: context,
    builder: (_) => _EditTherapySheet(therapy: therapy),
  );
}

class _EditTherapySheet extends ConsumerStatefulWidget {
  const _EditTherapySheet({required this.therapy});

  final Therapy therapy;

  @override
  ConsumerState<_EditTherapySheet> createState() => _EditTherapySheetState();
}

class _EditTherapySheetState extends ConsumerState<_EditTherapySheet> {
  late final _nameController = TextEditingController(text: widget.therapy.therapyName);
  late final _durationController =
      TextEditingController(text: widget.therapy.durationMin.toString());
  late MentalState? _mental = widget.therapy.mentalState;
  late BodyFeeling? _body = widget.therapy.bodyFeeling;

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
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
                Text(l10n.therapiesSectionEditTitle,
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
                        placeholder: l10n.therapiesSectionNamePlaceholder),
                    const SizedBox(height: 8),
                    CupertinoTextField(
                      controller: _durationController,
                      keyboardType: TextInputType.number,
                      placeholder: l10n.commonDurationMinPlaceholder,
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
    await ref.read(therapyRepositoryProvider).update(
          id: widget.therapy.id,
          therapyName: name,
          durationMin: int.tryParse(_durationController.text) ?? widget.therapy.durationMin,
          mentalState: _mental,
          bodyFeeling: _body,
        );
    if (mounted) Navigator.of(context).pop();
  }
}
