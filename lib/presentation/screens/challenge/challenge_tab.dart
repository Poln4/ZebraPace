import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/cloud_sync_providers.dart';
import '../../../providers/weight_challenge_providers.dart';
import '../settings/settings_tab.dart';
import 'widgets/join_challenge_card.dart';
import 'widgets/leaderboard_list.dart';
import 'widgets/my_progress_card.dart';

/// The 3-friend "lose 5% of bodyweight" competition — reads/writes the
/// shared Supabase table `weight_challenge_entries` (see
/// weight_challenge_repository.dart), so every state here branches on
/// whether the user is signed in (cloud_sync_providers.dart) and whether
/// they've already joined (myWeightChallengeEntryProvider).
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
      ),
      child: SafeArea(
        child: user == null
            ? _SignInPrompt(l10n: l10n)
            : _ChallengeBody(l10n: l10n, userId: user.id),
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
    final entriesAsync = ref.watch(weightChallengeEntriesProvider);
    final myEntry = ref.watch(myWeightChallengeEntryProvider);

    return entriesAsync.when(
      loading: () => const Center(child: CupertinoActivityIndicator()),
      error: (error, _) => Center(
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
      ),
      data: (entries) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (myEntry == null)
              const JoinChallengeCard()
            else
              MyProgressCard(entry: myEntry),
            if (entries.isNotEmpty) LeaderboardList(entries: entries, myUserId: userId),
          ],
        );
      },
    );
  }
}
