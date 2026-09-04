import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/content.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/bold_markdown_text.dart';
import '../../../widgets/section_card.dart';
import 'insights_providers.dart';

class MonthChapterCard extends ConsumerWidget {
  const MonthChapterCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final chapterAsync = ref.watch(monthChapterProvider(l10n));
    final facts = restFacts(l10n);
    final tip = facts[Random().nextInt(facts.length)];
    final selected = ref.watch(selectedDateProvider);
    final locale = Localizations.localeOf(context).toString();
    // This narrative always summarizes the calendar month containing the
    // selected date — independent of the 14/30/90-day range picker further
    // down the tab, which drives the charts instead. Labeling it avoids the
    // two looking like they're describing the same window.
    final monthLabel = DateFormat.yMMMM(locale).format(dateFromKey(selected));

    return chapterAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (e, st) => const SizedBox.shrink(),
      data: (chapter) => SectionCard(
        title: chapter.title,
        caption: monthLabel,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoldMarkdownText(chapter.body, style: const TextStyle(fontSize: 13, height: 1.4, color: ZebraColors.black)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ZebraColors.bg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('💡 $tip',
                  style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
            ),
          ],
        ),
      ),
    );
  }
}
