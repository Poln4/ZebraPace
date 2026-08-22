import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/feeling_picker.dart';
import '../../../widgets/section_card.dart';

class MindBodyForm extends ConsumerStatefulWidget {
  const MindBodyForm({super.key, required this.log});

  final DailyLog log;

  @override
  ConsumerState<MindBodyForm> createState() => _MindBodyFormState();
}

class _MindBodyFormState extends ConsumerState<MindBodyForm> {
  late MentalState? _mental = widget.log.mentalState;
  late BodyFeeling? _body = widget.log.bodyFeeling;
  late Set<BraceType> _braces = widget.log.bracesUsed.toSet();
  late double _braceComfort = (widget.log.braceComfort ?? 5).toDouble();

  @override
  void didUpdateWidget(covariant MindBodyForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.log.id != widget.log.id) {
      _mental = widget.log.mentalState;
      _body = widget.log.bodyFeeling;
      _braces = widget.log.bracesUsed.toSet();
      _braceComfort = (widget.log.braceComfort ?? 5).toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      title: l10n.mindBodyFormTitle,
      caption: l10n.mindBodyFormCaption,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FeelingPicker<MentalState>(
            label: l10n.commonMentalStateLabel,
            options: MentalState.values,
            emojiOf: (o) => o.emoji,
            labelOf: (o) => o.label(l10n),
            value: _mental,
            onChanged: (v) => setState(() => _mental = v),
          ),
          const SizedBox(height: 12),
          FeelingPicker<BodyFeeling>(
            label: l10n.mindBodyFormBodyPainFeelingLabel,
            options: BodyFeeling.values,
            emojiOf: (o) => o.emoji,
            labelOf: (o) => o.label(l10n),
            value: _body,
            onChanged: (v) => setState(() => _body = v),
          ),
          const SizedBox(height: 12),
          Text(l10n.mindBodyFormBracesUsedLabel,
              style: const TextStyle(fontWeight: FontWeight.w700, color: ZebraColors.black)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: BraceType.values.map((b) {
              final selected = _braces.contains(b);
              return GestureDetector(
                onTap: () => setState(() {
                  selected ? _braces.remove(b) : _braces.add(b);
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? ZebraColors.teal : ZebraColors.bg,
                    border: Border.all(color: ZebraColors.cardBorder),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    b.label(l10n),
                    style: const TextStyle(
                      color: ZebraColors.onColor,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          if (_braces.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(l10n.mindBodyFormBraceComfort(_braceComfort.round()),
                style: const TextStyle(fontWeight: FontWeight.w700)),
            CupertinoSlider(
              value: _braceComfort,
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (v) => setState(() => _braceComfort = v),
            ),
          ],
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton.filled(
              onPressed: _save,
              child: Text(l10n.commonSaveButton),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final repo = ref.read(dailyLogRepositoryProvider);
    await repo.upsertDailyLog(
      widget.log.copyWith(
        mentalState: _mental,
        bodyFeeling: _body,
        bracesUsed: _braces.toList(),
        braceComfort: _braces.isEmpty ? null : _braceComfort.round(),
      ),
    );
  }
}
