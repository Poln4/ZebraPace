import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../domain/models/weight_challenge.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/cloud_sync_providers.dart';
import '../../../providers/weight_challenge_providers.dart';
import '../settings/settings_tab.dart';
import 'widgets/add_challenge_card.dart';
import 'widgets/challenge_progress_chart.dart';
import 'widgets/leaderboard_list.dart';
import 'widgets/my_progress_card.dart';

/// Every challenge the signed-in user has joined — reads/writes the shared
/// Supabase tables `weight_challenges`/`weight_challenge_entries` (see
/// weight_challenge_repository.dart). A challenge is a named, code-gated
/// group: RLS scopes every entry/weigh-in to members of the same
/// challenge, so joining or creating one never surfaces another group's
/// data. State branches on whether the user is signed in
/// (cloud_sync_providers.dart) and, once signed in, on which (if any)
/// challenges they've joined (myWeightChallengesProvider).
class ChallengeTab extends ConsumerWidget {
  const ChallengeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(cloudUserProvider);

    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      navigationBar: CupertinoNavigationBar(
        middle: Text(l10n.challengeTabTitle),
        backgroundColor: ZebraColors.paper,
        trailing: user == null
            ? null
            : CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _openAddChallengeSheet(context),
                child: const Icon(CupertinoIcons.add_circled, color: ZebraColors.brandTeal),
              ),
      ),
      child: SafeArea(
        child: user == null
            ? _SignInPrompt(l10n: l10n)
            : _ChallengeBody(l10n: l10n, userId: user.id),
      ),
    );
  }

  void _openAddChallengeSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (sheetContext) => CupertinoPopupSurface(
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: AddChallengeCard(onDone: (_) => Navigator.of(sheetContext).pop()),
          ),
        ),
      ),
    );
  }
}

class _SignInPrompt extends StatelessWidget {
  const _SignInPrompt({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🤝', style: TextStyle(fontSize: 40)),
            const SizedBox(height: 12),
            Text(
              l10n.challengeTabSignInPrompt,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, color: ZebraColors.black),
            ),
            const SizedBox(height: 16),
            CupertinoButton(
              color: ZebraColors.brandTeal,
              onPressed: () => Navigator.of(context).push(
                CupertinoPageRoute(builder: (_) => const SettingsTab()),
              ),
              child: Text(l10n.challengeTabSignInButton,
                  style: const TextStyle(color: ZebraColors.onColor)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChallengeBody extends ConsumerWidget {
  const _ChallengeBody({required this.l10n, required this.userId});

  final AppLocalizations l10n;
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengesAsync = ref.watch(myWeightChallengesProvider);

    return challengesAsync.when(
      loading: () => const Center(child: CupertinoActivityIndicator()),
      error: (error, _) => _ErrorView(l10n: l10n, error: error),
      data: (challenges) {
        if (challenges.isEmpty) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: const [AddChallengeCard()],
          );
        }

        final currentId = ref.watch(currentChallengeIdProvider);
        final selected =
            challenges.firstWhere((c) => c.id == currentId, orElse: () => challenges.first);

        final entriesAsync = ref.watch(weightChallengeEntriesProvider(selected.id));
        final historyAsync = ref.watch(weightChallengeHistoryProvider(selected.id));
        final myEntry = ref.watch(myWeightChallengeEntryProvider(selected.id));

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (challenges.length > 1) ...[
              _ChallengePicker(
                challenges: challenges,
                selectedId: selected.id,
                onSelected: (id) => ref.read(currentChallengeIdProvider.notifier).state = id,
              ),
              const SizedBox(height: 8),
            ],
            _ChallengeCodeRow(challenge: selected),
            const SizedBox(height: 12),
            entriesAsync.when(
              loading: () => const Center(child: CupertinoActivityIndicator()),
              error: (error, _) => _ErrorView(l10n: l10n, error: error),
              data: (entries) => Column(
                children: [
                  // Shouldn't normally happen — myWeightChallengesProvider
                  // only lists challenges this user has already joined —
                  // but the one-shot fetch and this realtime stream can
                  // momentarily disagree right after joining.
                  if (myEntry == null)
                    const CupertinoActivityIndicator()
                  else
                    MyProgressCard(entry: myEntry, targetPercent: selected.targetPercent),
                  if (entries.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    ChallengeProgressChart(
                      entries: entries,
                      history: historyAsync.valueOrNull ?? const [],
                      targetPercent: selected.targetPercent,
                    ),
                    const SizedBox(height: 12),
                    LeaderboardList(
                      entries: entries,
                      myUserId: userId,
                      targetPercent: selected.targetPercent,
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.l10n, required this.error});

  final AppLocalizations l10n;
  final Object error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.challengeTabLoadError, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            // The generic message above covers every failure mode the
            // same way (missing table, RLS denial, a real network drop),
            // which makes them impossible to tell apart from the outside.
            // Showing the raw error trades a little polish for actually
            // being debuggable.
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey),
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal row of chips — only shown once the user belongs to more than
/// one challenge, so a single-challenge member (the common case today)
/// sees no picker at all.
class _ChallengePicker extends StatelessWidget {
  const _ChallengePicker({
    required this.challenges,
    required this.selectedId,
    required this.onSelected,
  });

  final List<WeightChallenge> challenges;
  final String selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: challenges.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final challenge = challenges[i];
          final selected = challenge.id == selectedId;
          return CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            color: selected ? ZebraColors.brandTeal : ZebraColors.cardBorder,
            borderRadius: BorderRadius.circular(16),
            onPressed: () => onSelected(challenge.id),
            child: Text(
              challenge.name,
              style: TextStyle(fontSize: 13, color: selected ? ZebraColors.onColor : ZebraColors.black),
            ),
          );
        },
      ),
    );
  }
}

/// The selected challenge's invite code, with a tap-to-copy shortcut — this
/// is how a member grows their own group without touching anyone else's.
class _ChallengeCodeRow extends StatefulWidget {
  const _ChallengeCodeRow({required this.challenge});

  final WeightChallenge challenge;

  @override
  State<_ChallengeCodeRow> createState() => _ChallengeCodeRowState();
}

class _ChallengeCodeRowState extends State<_ChallengeCodeRow> {
  bool _copied = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.challengeTabInviteHint(widget.challenge.code),
            style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
          ),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _copy,
          child: Text(
            _copied ? l10n.challengeTabCodeCopied : l10n.challengeTabCopyCodeButton,
            style: const TextStyle(
              fontSize: 12,
              color: ZebraColors.brandTeal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.challenge.code));
    if (!mounted) return;
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }
}
