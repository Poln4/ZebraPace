import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/section_card.dart';

/// Braces used today + comfort — part of the day's one summary row, split
/// out of the old Mind & Body form when its mood/body pickers merged into
/// QuickCheckinSection. Collapsed unless braces are already logged, since
/// many days won't involve any.
class BracesSection extends ConsumerStatefulWidget {
  const BracesSection({super.key, required this.log});

  final DailyLog log;

  @override
  ConsumerState<BracesSection> createState() => _BracesSectionState();
}

class _BracesSectionState extends ConsumerState<BracesSection> {
  late Set<BraceType> _braces = widget.log.bracesUsed.toSet();
  late double _braceComfort = (widget.log.braceComfort ?? 5).toDouble();

  @override
  void didUpdateWidget(covariant BracesSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.log.id != widget.log.id) {
      _braces = widget.log.bracesUsed.toSet();
      _braceComfort = (widget.log.braceComfort ?? 5).toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      title: l10n.bracesSectionTitle,
      collapsible: true,
      initiallyExpanded: widget.log.bracesUsed.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        bracesUsed: _braces.toList(),
        braceComfort: _braces.isEmpty ? null : _braceComfort.round(),
      ),
    );
  }
}
