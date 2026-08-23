import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/progress_bar.dart';
import '../../../widgets/section_card.dart';

class HydrationSection extends ConsumerStatefulWidget {
  const HydrationSection({super.key});

  @override
  ConsumerState<HydrationSection> createState() => _HydrationSectionState();
}

class _HydrationSectionState extends ConsumerState<HydrationSection> {
  DrinkType _drinkType = DrinkType.water;
  final _amountController = TextEditingController(text: '250');
  final _customLabelController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _customLabelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final log = ref.watch(dailyLogProvider).valueOrNull;
    final settings = ref.watch(settingsSnapshotProvider).valueOrNull;
    final goal = settings?.waterGoalMl ?? 2000;
    final credit = log?.waterMlCredit ?? 0;
    final progress = goal == 0 ? 0.0 : (credit / goal).clamp(0.0, 1.0);
    final date = ref.watch(selectedDateProvider);
    final logsAsync = ref.watch(_liquidLogsForDateProvider(date));

    return SectionCard(
      title: l10n.hydrationSectionTitle,
      collapsible: true,
      initiallyExpanded: !(log?.isLowEnergyDay ?? false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProgressBar(progress: progress),
          const SizedBox(height: 4),
          Text(l10n.hydrationSectionProgress(credit.round(), goal),
              style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: DrinkType.values.map((t) {
              final selected = t == _drinkType;
              return GestureDetector(
                onTap: () => setState(() => _drinkType = t),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: selected ? ZebraColors.brandTeal : ZebraColors.bg,
                    border: Border.all(color: ZebraColors.cardBorder),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(t.label(l10n),
                      style: const TextStyle(fontSize: 11.5, color: ZebraColors.onColor)),
                ),
              );
            }).toList(),
          ),
          if (_drinkType == DrinkType.other) ...[
            const SizedBox(height: 8),
            CupertinoTextField(
              controller: _customLabelController,
              placeholder: l10n.hydrationSectionCustomLabelPlaceholder,
            ),
          ],
          const SizedBox(height: 8),
          CupertinoTextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            placeholder: l10n.hydrationSectionAmountPlaceholder,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.brandTeal,
              onPressed: () async {
                final amount = int.tryParse(_amountController.text) ?? 0;
                if (amount <= 0) return;
                await ref.read(hydrationServiceProvider).logDrink(
                      date: date,
                      drinkType: _drinkType,
                      amountMlRaw: amount,
                      customDrinkLabel: _customLabelController.text,
                    );
              },
              child: Text(l10n.hydrationSectionAddDrinkButton,
                  style: const TextStyle(color: ZebraColors.onColor)),
            ),
          ),
          const SizedBox(height: 10),
          logsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (e, st) => Text('$e'),
            data: (logs) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: logs
                  .map((l) => Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(
                            l10n.hydrationSectionLogItem(l.displayName(l10n), l.amountMlRaw),
                            style: const TextStyle(fontSize: 12.5)),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 6),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => ref.read(hydrationServiceProvider).resetToday(date),
            child: Text(l10n.hydrationSectionResetButton,
                style: const TextStyle(fontSize: 12, color: CupertinoColors.destructiveRed)),
          ),
        ],
      ),
    );
  }
}

final _liquidLogsForDateProvider = StreamProvider.family((ref, String date) {
  return ref.watch(liquidLogRepositoryProvider).watchForDate(date);
});
