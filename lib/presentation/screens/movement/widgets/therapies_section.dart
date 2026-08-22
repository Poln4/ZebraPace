import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/feeling_picker.dart';
import '../../../widgets/section_card.dart';

class TherapiesSection extends ConsumerStatefulWidget {
  const TherapiesSection({super.key});

  @override
  ConsumerState<TherapiesSection> createState() => _TherapiesSectionState();
}

class _TherapiesSectionState extends ConsumerState<TherapiesSection> {
  final _nameController = TextEditingController();
  final _durationController = TextEditingController(text: '15');
  MentalState? _mental;
  BodyFeeling? _body;

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = ref.watch(selectedDateProvider);
    final therapiesAsync = ref.watch(_therapiesForDateProvider(date));
    final isLowEnergyDay = ref.watch(dailyLogProvider).valueOrNull?.isLowEnergyDay ?? false;

    return SectionCard(
      title: l10n.therapiesSectionTitle,
      collapsible: true,
      initiallyExpanded: !isLowEnergyDay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoTextField(
              controller: _nameController, placeholder: l10n.therapiesSectionNamePlaceholder),
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
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.teal,
              onPressed: _save,
              child: Text(l10n.therapiesSectionLogButton,
                  style: const TextStyle(color: ZebraColors.onColor)),
            ),
          ),
          const SizedBox(height: 10),
          therapiesAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (e, st) => Text('$e'),
            data: (therapies) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: therapies
                  .map((t) => Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(l10n.therapiesSectionListItem(t.therapyName, t.durationMin),
                            style: const TextStyle(fontSize: 12.5)),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    final date = ref.read(selectedDateProvider);
    await ref.read(therapyRepositoryProvider).insert(
          date: date,
          therapyName: name,
          durationMin: int.tryParse(_durationController.text) ?? 0,
          mentalState: _mental,
          bodyFeeling: _body,
        );
    _nameController.clear();
  }
}

final _therapiesForDateProvider = StreamProvider.family((ref, String date) {
  return ref.watch(therapyRepositoryProvider).watchForDate(date);
});
