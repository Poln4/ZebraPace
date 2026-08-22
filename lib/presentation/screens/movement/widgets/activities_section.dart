import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/feeling_picker.dart';
import '../../../widgets/section_card.dart';

class ActivitiesSection extends ConsumerStatefulWidget {
  const ActivitiesSection({super.key});

  @override
  ConsumerState<ActivitiesSection> createState() => _ActivitiesSectionState();
}

class _ActivitiesSectionState extends ConsumerState<ActivitiesSection> {
  final _nameController = TextEditingController();
  final _durationController = TextEditingController(text: '20');
  final _weightController = TextEditingController(text: '0');
  MentalState? _mental;
  BodyFeeling? _body;

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = ref.watch(selectedDateProvider);
    final activitiesAsync = ref.watch(_activitiesForDateProvider(date));
    final isLowEnergyDay = ref.watch(dailyLogProvider).valueOrNull?.isLowEnergyDay ?? false;

    return SectionCard(
      title: l10n.activitiesSectionTitle,
      collapsible: true,
      initiallyExpanded: !isLowEnergyDay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoTextField(
              controller: _nameController, placeholder: l10n.activitiesSectionNamePlaceholder),
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
              color: ZebraColors.brandTeal,
              onPressed: _save,
              child: Text(l10n.activitiesSectionLogButton,
                  style: const TextStyle(color: ZebraColors.onColor)),
            ),
          ),
          const SizedBox(height: 10),
          activitiesAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (e, st) => Text('$e'),
            data: (activities) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: activities
                  .map((a) => Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(
                            l10n.activitiesSectionListItem(a.activityName, a.durationMin),
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
    await ref.read(activityRepositoryProvider).insert(
          date: date,
          activityName: name,
          durationMin: int.tryParse(_durationController.text) ?? 0,
          extraWeightKg: double.tryParse(_weightController.text) ?? 0,
          mentalState: _mental,
          bodyFeeling: _body,
        );
    _nameController.clear();
  }
}

final _activitiesForDateProvider = StreamProvider.family((ref, String date) {
  return ref.watch(activityRepositoryProvider).watchForDate(date);
});
