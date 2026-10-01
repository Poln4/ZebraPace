import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/feeling_picker.dart';
import '../../../widgets/section_card.dart';
import 'intraday_fluctuation_chart.dart';

/// The one place to log how you feel — as many check-ins per day as the
/// user wants (app2.py's intraday check-ins). Each check-in also becomes the
/// day's summary mentalState/bodyFeeling on DailyLog (latest wins), which is
/// what baselines, trends, and the PEM check read. This replaced a separate
/// "official summary" Mind & Body form that asked the same two questions.
class QuickCheckinSection extends ConsumerStatefulWidget {
  const QuickCheckinSection({super.key, required this.log});

  final DailyLog log;

  @override
  ConsumerState<QuickCheckinSection> createState() => _QuickCheckinSectionState();
}

class _QuickCheckinSectionState extends ConsumerState<QuickCheckinSection> {
  // Pickers start at the day's current summary, so re-logging "same as
  // before" is a single tap.
  late MentalState _mental = widget.log.mentalState ?? MentalState.okay;
  late BodyFeeling _body = widget.log.bodyFeeling ?? BodyFeeling.manageable;
  final _noteController = TextEditingController();

  @override
  void didUpdateWidget(covariant QuickCheckinSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.log.id != widget.log.id) {
      _mental = widget.log.mentalState ?? MentalState.okay;
      _body = widget.log.bodyFeeling ?? BodyFeeling.manageable;
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = ref.watch(selectedDateProvider);
    final checkinsAsync = ref.watch(_checkinsForDateProvider(date));
    final summaryMental = widget.log.mentalState;
    final summaryBody = widget.log.bodyFeeling;

    return SectionCard(
      title: l10n.quickCheckinSectionTitle,
      caption: l10n.quickCheckinSectionCaption,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (summaryMental != null && summaryBody != null) ...[
            Text(
              l10n.quickCheckinSectionSummary(
                '${summaryMental.emoji} ${summaryMental.label(l10n)}',
                '${summaryBody.emoji} ${summaryBody.label(l10n)}',
              ),
              style: const TextStyle(fontWeight: FontWeight.w600, color: ZebraColors.black),
            ),
            const SizedBox(height: 10),
          ],
          FeelingPicker<MentalState>(
            label: l10n.quickCheckinSectionMentalStateLabel,
            options: MentalState.values,
            emojiOf: (o) => o.emoji,
            labelOf: (o) => o.label(l10n),
            value: _mental,
            onChanged: (v) => setState(() => _mental = v),
          ),
          const SizedBox(height: 10),
          FeelingPicker<BodyFeeling>(
            label: l10n.quickCheckinSectionBodyPainLabel,
            options: BodyFeeling.values,
            emojiOf: (o) => o.emoji,
            labelOf: (o) => o.label(l10n),
            value: _body,
            onChanged: (v) => setState(() => _body = v),
          ),
          const SizedBox(height: 10),
          CupertinoTextField(
            controller: _noteController,
            placeholder: l10n.quickCheckinSectionNotePlaceholder,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.teal,
              onPressed: () => _logCheckin(date),
              child: Text(l10n.quickCheckinSectionLogButton,
                  style: const TextStyle(color: ZebraColors.onColor)),
            ),
          ),
          const SizedBox(height: 10),
          checkinsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (e, st) => Text('$e'),
            data: (checkins) {
              if (checkins.isEmpty) {
                return Text(l10n.quickCheckinSectionEmpty,
                    style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntradayFluctuationChart(checkins: checkins),
                  if (checkins.length >= 2) const SizedBox(height: 8),
                  ...checkins.reversed.map((c) {
                    final note = c.note.isNotEmpty ? ' — ${c.note}' : '';
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '${c.loggedAt} — ${c.mentalState.label(l10n)} / ${c.bodyFeeling.label(l10n)}$note',
                        style: const TextStyle(fontSize: 12.5),
                      ),
                    );
                  }),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _logCheckin(String date) async {
    await ref.read(checkinRepositoryProvider).insert(
          date: date,
          mentalState: _mental,
          bodyFeeling: _body,
          note: _noteController.text,
        );
    final repo = ref.read(dailyLogRepositoryProvider);
    final log = await repo.getOrCreateDailyLog(date);
    await repo.upsertDailyLog(log.copyWith(mentalState: _mental, bodyFeeling: _body));
    _noteController.clear();
  }
}

final _checkinsForDateProvider = StreamProvider.family((ref, String date) {
  return ref.watch(checkinRepositoryProvider).watchForDate(date);
});
