import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/feeling_picker.dart';
import '../../../widgets/section_card.dart';
import 'intraday_fluctuation_chart.dart';

/// Intraday check-ins (app2.py) — purely additive to the one official daily
/// summary above: as many of these as the user wants per day.
class QuickCheckinSection extends ConsumerStatefulWidget {
  const QuickCheckinSection({super.key});

  @override
  ConsumerState<QuickCheckinSection> createState() => _QuickCheckinSectionState();
}

class _QuickCheckinSectionState extends ConsumerState<QuickCheckinSection> {
  MentalState _mental = MentalState.okay;
  BodyFeeling _body = BodyFeeling.manageable;
  final _noteController = TextEditingController();

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

    return SectionCard(
      title: l10n.quickCheckinSectionTitle,
      caption: l10n.quickCheckinSectionCaption,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              onPressed: () async {
                await ref.read(checkinRepositoryProvider).insert(
                      date: date,
                      mentalState: _mental,
                      bodyFeeling: _body,
                      note: _noteController.text,
                    );
                _noteController.clear();
              },
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
}

final _checkinsForDateProvider = StreamProvider.family((ref, String date) {
  return ref.watch(checkinRepositoryProvider).watchForDate(date);
});
