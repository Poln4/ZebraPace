import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/challenge.dart';
import '../../../../domain/models/challenge_entry.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/challenge_providers.dart';
import '../../../widgets/section_card.dart';

/// Who's in the challenge, the creator's "Remove" for other members, and
/// everyone's "Leave this challenge". Both go through SECURITY DEFINER
/// functions (009_leave_and_remove_members.sql), which also enforce that
/// only the creator can remove, so hiding the button here is UI only.
class MembersCard extends ConsumerStatefulWidget {
  const MembersCard({
    super.key,
    required this.challenge,
    required this.entries,
    required this.myUserId,
  });

  final Challenge challenge;
  final List<ChallengeEntry> entries;
  final String myUserId;

  @override
  ConsumerState<MembersCard> createState() => _MembersCardState();
}

class _MembersCardState extends ConsumerState<MembersCard> {
  bool _busy = false;
  String? _error;

  bool get _iCreatedIt => widget.challenge.createdBy == widget.myUserId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      title: l10n.challengeMembersTitle,
      caption: _iCreatedIt ? l10n.challengeMembersOwnerCaption : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final e in widget.entries) _row(l10n, e),
          if (_error != null) ...[
            const SizedBox(height: 6),
            Text(_error!,
                style: const TextStyle(fontSize: 12, color: CupertinoColors.destructiveRed)),
          ],
          const SizedBox(height: 8),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: _busy ? null : _confirmLeave,
            child: Text(l10n.challengeLeaveButton,
                style: const TextStyle(fontSize: 14, color: CupertinoColors.destructiveRed)),
          ),
        ],
      ),
    );
  }

  Widget _row(AppLocalizations l10n, ChallengeEntry e) {
    final isMe = e.userId == widget.myUserId;
    final isCreator = e.userId == widget.challenge.createdBy;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: isMe ? l10n.challengeTabYouLabel(e.displayName) : e.displayName,
                  style: const TextStyle(fontSize: 14, color: ZebraColors.black),
                ),
                if (isCreator)
                  TextSpan(
                    text: ' · ${l10n.challengeMemberCreatorBadge}',
                    style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
                  ),
              ]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (_iCreatedIt && !isMe)
            CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size.zero,
              onPressed: _busy ? null : () => _confirmRemove(e),
              child: Text(l10n.challengeRemoveMemberButton,
                  style: const TextStyle(fontSize: 13, color: CupertinoColors.destructiveRed)),
            ),
        ],
      ),
    );
  }

  Future<void> _confirmLeave() async {
    final l10n = AppLocalizations.of(context);
    final others = widget.entries.where((e) => e.userId != widget.myUserId).length;
    final extra = !_iCreatedIt
        ? null
        : others == 0
            ? l10n.challengeLeaveLastMember
            : l10n.challengeLeaveOwnerHandover;
    final ok = await _confirm(
      title: l10n.challengeLeaveTitle,
      message: extra == null ? l10n.challengeLeaveMessage : '${l10n.challengeLeaveMessage}\n\n$extra',
      confirm: l10n.challengeLeaveConfirm,
    );
    if (!ok) return;
    await _run(() async {
      await ref.read(challengeRepositoryProvider).leaveChallenge(widget.challenge.id);
      // Back to whichever challenge is left (or the add card).
      ref.read(currentChallengeIdProvider.notifier).state = null;
      ref.invalidate(myChallengesProvider);
    });
  }

  Future<void> _confirmRemove(ChallengeEntry e) async {
    final l10n = AppLocalizations.of(context);
    final ok = await _confirm(
      title: l10n.challengeRemoveMemberTitle(e.displayName),
      message: l10n.challengeRemoveMemberMessage,
      confirm: l10n.challengeRemoveMemberButton,
    );
    if (!ok) return;
    await _run(() => ref
        .read(challengeRepositoryProvider)
        .removeMember(challengeId: widget.challenge.id, userId: e.userId));
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } catch (_) {
      if (mounted) setState(() => _error = AppLocalizations.of(context).challengeLeaveRemoveError);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<bool> _confirm({
    required String title,
    required String message,
    required String confirm,
  }) async {
    final l10n = AppLocalizations.of(context);
    final result = await showCupertinoDialog<bool>(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.commonCancelButton),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(confirm),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
