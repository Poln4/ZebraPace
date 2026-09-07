import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../domain/models/weight_challenge_entry.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../../providers/cloud_sync_providers.dart';
import '../../../../providers/weight_challenge_providers.dart';
import '../../../widgets/section_card.dart';

/// Shown once the signed-in user has joined — lets them push an updated
/// current weight to the shared table. Deliberately manual (not an
/// automatic mirror of every local Vitals entry): cloud writes only ever
/// happen on an explicit tap elsewhere in the app too (see
/// _CloudSyncSection), so this stays consistent with that.
class MyProgressCard extends ConsumerStatefulWidget {
  const MyProgressCard({required this.entry, super.key});

  final WeightChallengeEntry entry;

  @override
  ConsumerState<MyProgressCard> createState() => _MyProgressCardState();
}

class _MyProgressCardState extends ConsumerState<MyProgressCard> {
  final _weightController = TextEditingController();
  bool _prefilled = false;
  bool _saving = false;
  bool _prefilledFromAverage = false;

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (!_prefilled) {
      _prefilled = true;
      _prefillWeight();
    }

    final percent = widget.entry.percentLost;
    final percentLabel =
        '${percent >= 0 ? '-' : '+'}${percent.abs().toStringAsFixed(1)}%';

    return SectionCard(
      title: l10n.challengeTabMyProgressTitle,
      caption: l10n.challengeTabMyProgressCaption(percentLabel),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoTextField(
            controller: _weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            placeholder: l10n.challengeTabCurrentWeightPlaceholder,
          ),
          if (_prefilledFromAverage) ...[
            const SizedBox(height: 6),
            Text(l10n.challengeTabCurrentWeightAverageHint,
                style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
          ],
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.teal,
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const CupertinoActivityIndicator()
                  : Text(l10n.challengeTabUpdateWeightButton,
                      style: const TextStyle(color: ZebraColors.onColor)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _prefillWeight() async {
    final average =
        await ref.read(weightChallengeProgressServiceProvider).computeCurrentWeightKg(todayKey());
    if (average != null) {
      if (!mounted) return;
      _weightController.text = average.toStringAsFixed(1);
      setState(() => _prefilledFromAverage = true);
      return;
    }

    // No resting-day weigh-ins in the last 14 days yet — fall back to
    // whatever's most recently logged so the field isn't just empty.
    final log = await ref.read(bodyMetricsServiceProvider).getCarryForward(todayKey());
    if (!mounted) return;
    final weight = log?.weightKg ?? widget.entry.currentWeightKg;
    _weightController.text = weight.toString();
    setState(() {});
  }

  Future<void> _save() async {
    final weight = double.tryParse(_weightController.text);
    if (weight == null || weight <= 0) return;

    final user = ref.read(cloudUserProvider);
    if (user == null) return;

    setState(() => _saving = true);
    try {
      await ref.read(weightChallengeRepositoryProvider).updateCurrentWeight(
            userId: user.id,
            currentWeightKg: weight,
          );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
