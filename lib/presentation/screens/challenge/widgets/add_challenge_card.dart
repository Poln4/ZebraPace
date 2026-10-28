import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/defaults.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/challenge.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../../providers/cloud_sync_providers.dart';
import '../../../../providers/challenge_providers.dart';
import '../../../widgets/section_card.dart';

enum _Mode { join, create }

const _maxWeeks = 12;

/// Lets the signed-in user either join an existing challenge by its invite
/// code or start a brand-new one. Shown full-page when they have no
/// challenges yet, or in a modal sheet (pushed from ChallengeTab's "+"
/// button) to add another one alongside challenges they're already in.
///
/// Only asks for what every kind needs (code, name; plus kind and length
/// when creating). The kind-specific part — starting weight or daily goal
/// — comes right after, in ChallengeSetupCard, because someone joining by
/// code doesn't know the challenge's kind until they're in.
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
  ChallengeKind _kind = ChallengeKind.steps;
  int _weeks = 4;
  bool _prefilled = false;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _codeController.dispose();
    _challengeNameController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (!_prefilled) {
      _prefilled = true;
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
            Text(l10n.challengeTabKindLabel,
                style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final kind in ChallengeKind.values)
                  _KindChip(
                    kind: kind,
                    selected: kind == _kind,
                    onTap: () => setState(() => _kind = kind),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(l10n.challengeTabDurationLabel,
                      style: const TextStyle(fontSize: 13, color: ZebraColors.black)),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(32, 32),
                  onPressed: _weeks > 1 ? () => setState(() => _weeks--) : null,
                  child: const Icon(CupertinoIcons.minus_circle),
                ),
                SizedBox(
                  width: 84,
                  child: Text(l10n.challengeTabWeeksLabel(_weeks),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(32, 32),
                  onPressed: _weeks < _maxWeeks ? () => setState(() => _weeks++) : null,
                  child: const Icon(CupertinoIcons.plus_circle),
                ),
              ],
            ),
            const SizedBox(height: 8),
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

  Future<void> _submit() async {
    final code = _codeController.text.trim();
    final name = _nameController.text.trim();
    final challengeName = _challengeNameController.text.trim();
    if (code.isEmpty || name.isEmpty) return;
    if (_mode == _Mode.create && challengeName.isEmpty) return;

    final user = ref.read(cloudUserProvider);
    if (user == null) return;

    setState(() { _busy = true; _error = null; });
    try {
      final repo = ref.read(challengeRepositoryProvider);
      final String challengeId;
      if (_mode == _Mode.join) {
        final entry = await repo.joinChallenge(code: code, displayName: name);
        challengeId = entry.challengeId;
      } else {
        final challenge = await repo.createChallenge(
          name: challengeName,
          code: code,
          kind: _kind,
          startsOn: DateTime.now(),
          weeks: _weeks,
          targetPercent: WeightChallengeDefaults.targetPercent,
          displayName: name,
        );
        challengeId = challenge.id;
      }

      ref.invalidate(myChallengesProvider);
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

class _KindChip extends StatelessWidget {
  const _KindChip({required this.kind, required this.selected, required this.onTap});

  final ChallengeKind kind;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      minimumSize: Size.zero,
      color: selected ? ZebraColors.brandTeal : ZebraColors.cardBorder,
      borderRadius: BorderRadius.circular(16),
      onPressed: onTap,
      child: Text(
        '${kind.emoji} ${kind.label(l10n)}',
        style: TextStyle(fontSize: 13, color: selected ? ZebraColors.onColor : ZebraColors.black),
      ),
    );
  }
}
