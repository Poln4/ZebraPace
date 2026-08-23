import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/progress_bar.dart';
import '../../../widgets/section_card.dart';

class NutritionSection extends ConsumerStatefulWidget {
  const NutritionSection({super.key});

  @override
  ConsumerState<NutritionSection> createState() => _NutritionSectionState();
}

class _NutritionSectionState extends ConsumerState<NutritionSection> {
  ProteinUnit _unit = ProteinUnit.grams;
  final _amountController = TextEditingController(text: '20');

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final log = ref.watch(dailyLogProvider).valueOrNull;
    final settings = ref.watch(settingsSnapshotProvider).valueOrNull;
    final goal = settings?.proteinGoalG ?? 100;
    final protein = log?.proteinG ?? 0;
    final progress = goal == 0 ? 0.0 : (protein / goal).clamp(0.0, 1.0);

    return SectionCard(
      title: l10n.nutritionSectionTitle,
      collapsible: true,
      initiallyExpanded: !(log?.isLowEnergyDay ?? false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProgressBar(progress: progress),
          const SizedBox(height: 4),
          Text(l10n.nutritionSectionProteinProgress(protein, goal),
              style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Text(l10n.nutritionSectionCreatineToday((log?.creatineG ?? 0).toStringAsFixed(1)),
              style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: CupertinoTextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  placeholder: l10n.nutritionSectionAmountPlaceholder,
                ),
              ),
              const SizedBox(width: 8),
              CupertinoSlidingSegmentedControl<ProteinUnit>(
                groupValue: _unit,
                children: {
                  for (final u in ProteinUnit.values)
                    u: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(u.label(l10n), style: const TextStyle(fontSize: 11)),
                    ),
                },
                onValueChanged: (v) {
                  if (v != null) setState(() => _unit = v);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: CupertinoButton(
                  color: ZebraColors.brandTeal,
                  onPressed: _addProtein,
                  child: Text(l10n.nutritionSectionAddProteinButton,
                      style: const TextStyle(color: ZebraColors.onColor)),
                ),
              ),
              const SizedBox(width: 8),
              CupertinoButton(
                color: ZebraColors.sand,
                onPressed: _addCreatine,
                child: Text(l10n.nutritionSectionAddCreatineButton,
                    style: const TextStyle(color: ZebraColors.onColor)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 14,
            runSpacing: 2,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _setExactProteinTotal(context, l10n),
                child: Text(l10n.nutritionSectionSetTotalButton,
                    style: const TextStyle(fontSize: 12, color: ZebraColors.brandTeal)),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _setExactCreatineTotal(context, l10n),
                child: Text(l10n.nutritionSectionSetCreatineTotalButton,
                    style: const TextStyle(fontSize: 12, color: ZebraColors.brandTeal)),
              ),
            ],
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: _reset,
            child: Text(l10n.nutritionSectionResetButton,
                style: const TextStyle(fontSize: 12, color: CupertinoColors.destructiveRed)),
          ),
        ],
      ),
    );
  }

  Future<void> _addProtein() async {
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0) return;
    final grams = (amount * _unit.gramsPerUnit).round();
    final date = ref.read(selectedDateProvider);
    final repo = ref.read(dailyLogRepositoryProvider);
    final log = await repo.getOrCreateDailyLog(date);
    await repo.upsertDailyLog(log.copyWith(proteinG: log.proteinG + grams));
  }

  Future<void> _setExactProteinTotal(BuildContext context, AppLocalizations l10n) async {
    final current = ref.read(dailyLogProvider).valueOrNull?.proteinG ?? 0;
    final result = await _promptForAmount(
      context,
      title: l10n.nutritionSectionSetTotalDialogTitle,
      l10n: l10n,
      initial: current.toString(),
    );
    final grams = int.tryParse(result ?? '');
    if (grams == null || grams < 0) return;
    final date = ref.read(selectedDateProvider);
    final repo = ref.read(dailyLogRepositoryProvider);
    final log = await repo.getOrCreateDailyLog(date);
    await repo.upsertDailyLog(log.copyWith(proteinG: grams));
  }

  Future<void> _setExactCreatineTotal(BuildContext context, AppLocalizations l10n) async {
    final current = ref.read(dailyLogProvider).valueOrNull?.creatineG ?? 0;
    final result = await _promptForAmount(
      context,
      title: l10n.nutritionSectionSetCreatineTotalDialogTitle,
      l10n: l10n,
      initial: current.toString(),
    );
    final grams = double.tryParse(result ?? '');
    if (grams == null || grams < 0) return;
    final date = ref.read(selectedDateProvider);
    final repo = ref.read(dailyLogRepositoryProvider);
    final log = await repo.getOrCreateDailyLog(date);
    await repo.upsertDailyLog(log.copyWith(creatineG: grams));
  }

  Future<String?> _promptForAmount(
    BuildContext context, {
    required String title,
    required AppLocalizations l10n,
    required String initial,
  }) {
    final controller = TextEditingController(text: initial);
    return showCupertinoDialog<String>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: CupertinoTextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            autofocus: true,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.commonCancelButton),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.of(dialogContext).pop(controller.text),
            child: Text(l10n.commonSaveButton),
          ),
        ],
      ),
    );
  }

  Future<void> _addCreatine() async {
    final date = ref.read(selectedDateProvider);
    final repo = ref.read(dailyLogRepositoryProvider);
    final log = await repo.getOrCreateDailyLog(date);
    await repo.upsertDailyLog(log.copyWith(creatineG: log.creatineG + 5));
  }

  Future<void> _reset() async {
    final date = ref.read(selectedDateProvider);
    final repo = ref.read(dailyLogRepositoryProvider);
    final log = await repo.getOrCreateDailyLog(date);
    await repo.upsertDailyLog(log.copyWith(proteinG: 0, creatineG: 0));
  }
}
