import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/defaults.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../../providers/cloud_sync_providers.dart';
import '../../../../providers/weight_challenge_providers.dart';
import '../../../widgets/section_card.dart';

/// Shown once, before the signed-in user has a row in
/// `weight_challenge_entries` — sets their starting weight, which then
/// never changes (percentLost is always measured against it).
class JoinChallengeCard extends ConsumerStatefulWidget {
  const JoinChallengeCard({super.key});

  @override
  ConsumerState<JoinChallengeCard> createState() => _JoinChallengeCardState();
}

class _JoinChallengeCardState extends ConsumerState<JoinChallengeCard> {
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  bool _prefilled = false;
  bool _joining = false;

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (!_prefilled) {
      _prefilled = true;
      _prefillWeight();
      final name = ref.read(userNameProvider).valueOrNull;
      if (name != null && name.isNotEmpty) _nameController.text = name;
    }

    return SectionCard(
      title: l10n.challengeTabJoinTitle,
      caption: l10n.challengeTabJoinCaption(
        WeightChallengeDefaults.targetPercent.toStringAsFixed(0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoTextField(
            controller: _nameController,
            placeholder: l10n.challengeTabNamePlaceholder,
          ),
          const SizedBox(height: 8),
          CupertinoTextField(
            controller: _weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            placeholder: l10n.challengeTabStartWeightPlaceholder,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.brandTeal,
              onPressed: _joining ? null : _join,
              child: _joining
                  ? const CupertinoActivityIndicator()
                  : Text(l10n.challengeTabJoinButton,
                      style: const TextStyle(color: ZebraColors.onColor)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _prefillWeight() async {
    final log = await ref.read(bodyMetricsServiceProvider).getCarryForward(todayKey());
    if (!mounted || log?.weightKg == null) return;
    _weightController.text = log!.weightKg.toString();
    setState(() {});
  }

  Future<void> _join() async {
    final name = _nameController.text.trim();
    final weight = double.tryParse(_weightController.text);
    if (name.isEmpty || weight == null || weight <= 0) return;

    final user = ref.read(cloudUserProvider);
    if (user == null) return;

    setState(() => _joining = true);
    try {
      await ref.read(weightChallengeRepositoryProvider).joinChallenge(
            userId: user.id,
            displayName: name,
            startWeightKg: weight,
          );
    } finally {
      if (mounted) setState(() => _joining = false);
    }
  }
}
