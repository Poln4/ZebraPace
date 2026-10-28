import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../domain/models/challenge.dart';
import '../../../../domain/models/challenge_entry.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../../providers/challenge_providers.dart';
import '../../../widgets/section_card.dart';

/// The kind-specific half of joining: a starting weight for weight
/// challenges, a daily goal for steps/sleep/activity. Shown by ChallengeTab
/// in place of the progress card until it's filled in, and again (with
/// [onCancel]) when the member taps "Change" on their goal.
///
/// The field is prefilled — the latest weight from Vitals, or a goal
/// suggestion from ChallengeDayService — so most people only tap Save.
class ChallengeSetupCard extends ConsumerStatefulWidget {
  const ChallengeSetupCard({
    required this.challenge,
    required this.entry,
    this.onCancel,
    super.key,
  });

  final Challenge challenge;
  final ChallengeEntry entry;
  final VoidCallback? onCancel;

  /// Logging has a fixed goal of 1, so it never needs this card.
  static bool isNeeded(Challenge challenge, ChallengeEntry entry) {
    if (challenge.kind == ChallengeKind.weight) return !entry.hasStartWeight;
    return challenge.kind.needsDailyGoal && entry.dailyGoal == null;
  }

  @override
  ConsumerState<ChallengeSetupCard> createState() => _ChallengeSetupCardState();
}

class _ChallengeSetupCardState extends ConsumerState<ChallengeSetupCard> {
  final _controller = TextEditingController();
  bool _busy = false;
  String? _error;

  ChallengeKind get _kind => widget.challenge.kind;

  @override
  void initState() {
    super.initState();
    _prefill();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _prefill() async {
    final double? value;
    if (_kind == ChallengeKind.weight) {
      final log = await ref.read(bodyMetricsServiceProvider).getCarryForward(todayKey());
      value = log?.weightKg;
    } else {
      value = widget.entry.dailyGoal ??
          await ref.read(challengeDayServiceProvider).suggestGoal(_kind, todayKey());
    }
    if (!mounted || value == null || _controller.text.isNotEmpty) return;
    _controller.text = _kind == ChallengeKind.sleep || _kind == ChallengeKind.weight
        ? value.toString()
        : value.round().toString();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isWeight = _kind == ChallengeKind.weight;
    final placeholder = switch (_kind) {
      ChallengeKind.weight => l10n.challengeTabStartWeightPlaceholder,
      ChallengeKind.steps => l10n.challengeGoalStepsPlaceholder,
      ChallengeKind.sleep => l10n.challengeGoalSleepPlaceholder,
      ChallengeKind.activity || ChallengeKind.logging => l10n.challengeGoalActivityPlaceholder,
    };

    return SectionCard(
      title: '${_kind.emoji} ${l10n.challengeTabSetupTitle}',
      caption: isWeight ? l10n.challengeTabSetupWeightCaption : l10n.challengeTabSetupGoalCaption,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoTextField(
            controller: _controller,
            keyboardType: TextInputType.numberWithOptions(
              decimal: isWeight || _kind == ChallengeKind.sleep,
            ),
            placeholder: placeholder,
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!, style: const TextStyle(fontSize: 12, color: CupertinoColors.destructiveRed)),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              if (widget.onCancel != null) ...[
                Expanded(
                  child: CupertinoButton(
                    onPressed: _busy ? null : widget.onCancel,
                    child: Text(l10n.commonCancelButton),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: CupertinoButton(
                  color: ZebraColors.brandTeal,
                  onPressed: _busy ? null : _save,
                  child: _busy
                      ? const CupertinoActivityIndicator()
                      : Text(l10n.challengeTabSaveButton,
                          style: const TextStyle(color: ZebraColors.onColor)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final value = double.tryParse(_controller.text.replaceAll(',', '.'));
    if (value == null || value <= 0) return;

    setState(() { _busy = true; _error = null; });
    try {
      final repo = ref.read(challengeRepositoryProvider);
      if (_kind == ChallengeKind.weight) {
        await repo.setStartWeight(
          challengeId: widget.challenge.id,
          userId: widget.entry.userId,
          startWeightKg: value,
        );
      } else {
        await repo.setDailyGoal(
          challengeId: widget.challenge.id,
          userId: widget.entry.userId,
          dailyGoal: value,
        );
      }
      widget.onCancel?.call();
    } catch (_) {
      if (mounted) setState(() => _error = AppLocalizations.of(context).challengeTabActionError);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}
