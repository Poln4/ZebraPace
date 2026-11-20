import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/sources.dart';
import '../../../core/theme/zebra_theme.dart';
import '../../../l10n/app_localizations.dart';

String sourceTopicTitle(AppLocalizations l10n, SourceTopic topic) => switch (topic) {
      SourceTopic.pacing => l10n.sourceTopicPacing,
      SourceTopic.pem => l10n.sourceTopicPem,
      SourceTopic.standTest => l10n.sourceTopicStandTest,
      SourceTopic.heartSignals => l10n.sourceTopicHeartSignals,
      SourceTopic.sweating => l10n.sourceTopicSweating,
      SourceTopic.mets => l10n.sourceTopicMets,
      SourceTopic.exercise => l10n.sourceTopicExercise,
      SourceTopic.fearExposure => l10n.sourceTopicFearExposure,
      SourceTopic.sleep => l10n.sourceTopicSleep,
    };

Future<void> openSource(Source source) =>
    launchUrl(Uri.parse(source.url), mode: LaunchMode.externalApplication);

/// Settings → About → Sources & references: every source behind the app's
/// health information, grouped by where it's used.
class SourcesScreen extends StatelessWidget {
  const SourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      navigationBar: CupertinoNavigationBar(middle: Text(l10n.sourcesScreenTitle)),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          children: [
            Text(l10n.sourcesScreenIntro, style: const TextStyle(fontSize: 13.5)),
            const SizedBox(height: 8),
            Text(l10n.sourcesAppDefaultsNote,
                style: const TextStyle(fontSize: 12.5, color: CupertinoColors.systemGrey)),
            for (final topic in SourceTopic.values) ...[
              const SizedBox(height: 20),
              Text(sourceTopicTitle(l10n, topic),
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              const SizedBox(height: 6),
              for (final id in kSourcesByTopic[topic]!) SourceTile(source: kSources[id]!),
            ],
          ],
        ),
      ),
    );
  }
}

/// One reference: authors (year). Title. Venue. Tapping opens it.
class SourceTile extends StatelessWidget {
  const SourceTile({super.key, required this.source});

  final Source source;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => openSource(source),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 12.5, color: ZebraColors.black, height: 1.35),
              children: [
                TextSpan(text: '${source.authors} (${source.year}). '),
                TextSpan(
                  text: source.title,
                  style: const TextStyle(
                      color: ZebraColors.brandTealText, decoration: TextDecoration.underline),
                ),
                TextSpan(text: '. ${source.venue}. ↗'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Bottom sheet with the sources for one part of the app, plus a way to the
/// full list.
Future<void> showSourcesSheet(BuildContext context, List<SourceTopic> topics) {
  final l10n = AppLocalizations.of(context);
  return showCupertinoModalPopup<void>(
    context: context,
    builder: (ctx) => Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.75),
      decoration: const BoxDecoration(
        color: ZebraColors.bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        top: false,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          children: [
            for (final topic in topics) ...[
              Text(sourceTopicTitle(l10n, topic),
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              const SizedBox(height: 4),
              for (final id in kSourcesByTopic[topic]!) SourceTile(source: kSources[id]!),
              const SizedBox(height: 12),
            ],
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const SourcesScreen()));
              },
              child: Text(l10n.sourcesSeeAll,
                  style: const TextStyle(fontSize: 14, color: ZebraColors.brandTealText)),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Small "📖 Sources" link placed next to a health claim.
class SourcesLink extends StatelessWidget {
  const SourcesLink(this.topics, {super.key});

  final List<SourceTopic> topics;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      button: true,
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        minimumSize: Size.zero,
        onPressed: () => showSourcesSheet(context, topics),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(CupertinoIcons.book, size: 14, color: ZebraColors.brandTealText),
            const SizedBox(width: 4),
            Text(l10n.sourcesLinkLabel,
                style: const TextStyle(
                    fontSize: 12.5,
                    color: ZebraColors.brandTealText,
                    decoration: TextDecoration.underline)),
          ],
        ),
      ),
    );
  }
}
