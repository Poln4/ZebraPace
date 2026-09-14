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

enum _Mode { join, create }

/// Lets the signed-in user either join an existing challenge by its invite
/// code or start a brand-new one. Shown full-page when they have no
/// challenges yet, or in a modal sheet (pushed from ChallengeTab's "+"
/// button) to add another one alongside challenges they're already in.
class AddChallengeCard extends ConsumerStatefulWidget {
  const AddChallengeCard({this.onDone, super.key});

  /// Called with the id of the challenge just created/joined — the modal
  /// sheet variant uses this to close itself once done.
  final void Function(String challengeId)? onDone;

  @override
  ConsumerState<AddChallengeCard> createState() => _AddChallengeCardState();
}

class _AddChallengeCardState extends ConsumerState<AddChallengeCard> {
  _Mode _mode = _Mode.join;
  final _codeController = TextEditingController();
  final _challengeNameController = TextEditingController();
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  bool _prefilled = false;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _codeController.dispose();
    _challengeNameController.dispose();
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
      caption: l10n.challengeTabJoinCaption,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoSlidingSegmentedControl<_Mode>(
            groupValue: _mode,
            children: {
              _Mode.join: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(l10n.challengeTabModeJoin),
              ),
              _Mode.create: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(l10n.challengeTabModeCreate),
              ),
            },
            onValueChanged: (mode) {
              if (mode != null) setState(() { _mode = mode; _error = null; });
            },
          ),
          const SizedBox(height: 10),
          if (_mode == _Mode.create) ...[
            CupertinoTextField(
              controller: _challengeNameController,
              placeholder: l10n.challengeTabChallengeNamePlaceholder,
            ),
            const SizedBox(height: 8),
          ],
          CupertinoTextField(
            controller: _codeController,
            textCapitalization: TextCapitalization.characters,
            placeholder: _mode == _Mode.join
                ? l10n.challengeTabCodePlaceholder
                : l10n.challengeTabNewCodePlaceholder,
          ),
          const SizedBox(height: 8),
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
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!, style: const TextStyle(fontSize: 12, color: CupertinoColors.destructiveRed)),
          ],
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.brandTeal,
              onPressed: _busy ? null : _submit,
              child: _busy
                  ? const CupertinoActivityIndicator()
                  : Text(
                      _mode == _Mode.join ? l10n.challengeTabJoinButton : l10n.challengeTabCreateButton,
                      style: const TextStyle(color: ZebraColors.onColor),
                    ),
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

  Future<void> _submit() async {
    final code = _codeController.text.trim();
    final name = _nameController.text.trim();
    final weight = double.tryParse(_weightController.text);
    final challengeName = _challengeNameController.text.trim();
    if (code.isEmpty || name.isEmpty || weight == null || weight <= 0) return;
    if (_mode == _Mode.create && challengeName.isEmpty) return;

    final user = ref.read(cloudUserProvider);
    if (user == null) return;

    setState(() { _busy = true; _error = null; });
    try {
      final repo = ref.read(weightChallengeRepositoryProvider);
      final String challengeId;
      if (_mode == _Mode.join) {
        final entry = await repo.joinChallenge(code: code, displayName: name, startWeightKg: weight);
        challengeId = entry.challengeId;
      } else {
        final challenge = await repo.createChallenge(
          name: challengeName,
          code: code,
          targetPercent: WeightChallengeDefaults.targetPercent,
          displayName: name,
          startWeightKg: weight,
        );
        challengeId = challenge.id;
      }

      ref.invalidate(myWeightChallengesProvider);
      ref.read(currentChallengeIdProvider.notifier).state = challengeId;
      if (mounted) widget.onDone?.call(challengeId);
    } catch (_) {
      if (mounted) {
        setState(() => _error = AppLocalizations.of(context).challengeTabActionError);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}
