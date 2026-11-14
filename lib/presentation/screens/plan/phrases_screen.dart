import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/plan_providers.dart';
import '../../widgets/section_card.dart';
import 'plan_tab.dart';

/// The person's own phrases (shown first, in rotation with the built-in
/// ones). They show up whatever the day looked like — full, low day,
/// floor or rest.
class PhrasesScreen extends ConsumerStatefulWidget {
  const PhrasesScreen({super.key});

  @override
  ConsumerState<PhrasesScreen> createState() => _PhrasesScreenState();
}

class _PhrasesScreenState extends ConsumerState<PhrasesScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final own = ref.watch(ownPlanPhrasesProvider).valueOrNull ?? const [];
    final builtIn = allPhrases(l10n, const []);

    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      navigationBar: CupertinoNavigationBar(middle: Text(l10n.planPhrasesTitle)),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SectionCard(
              title: l10n.planPhrasesOwnTitle,
              caption: l10n.planPhrasesOwnCaption,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < own.length; i++)
                    Row(
                      children: [
                        Expanded(child: Text('“${own[i]}”', style: const TextStyle(fontSize: 14))),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => saveOwnPlanPhrases(ref, [...own]..removeAt(i)),
                          child: const Icon(
                            CupertinoIcons.delete,
                            size: 18,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  CupertinoTextField(
                    controller: _controller,
                    placeholder: l10n.planPhrasesAddHint,
                    minLines: 1,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 8),
                  CupertinoButton.filled(
                    onPressed: () {
                      final text = _controller.text.trim();
                      if (text.isEmpty) return;
                      saveOwnPlanPhrases(ref, [text, ...own]);
                      _controller.clear();
                    },
                    child: Text(l10n.planPhrasesAdd),
                  ),
                ],
              ),
            ),
            SectionCard(
              title: l10n.planPhrasesBuiltInTitle,
              collapsible: true,
              initiallyExpanded: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final p in builtIn)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text('“$p”', style: const TextStyle(fontSize: 13.5)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
