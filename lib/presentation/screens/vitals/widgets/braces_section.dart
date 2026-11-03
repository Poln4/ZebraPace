import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/brace_use.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../../providers/brace_providers.dart';
import '../../../widgets/section_card.dart';

/// Braces used today + comfort — part of the day's one summary row, split
/// out of the old Mind & Body form when its mood/body pickers merged into
/// QuickCheckinSection. Collapsed unless braces are already logged, since
/// many days won't involve any.
///
/// Each selected brace gets the detail its kind needs (BraceType.amount):
/// left/right/both for paired body parts, a count for ring splints and the
/// person's own braces, nothing for the rest.
class BracesSection extends ConsumerStatefulWidget {
  const BracesSection({super.key, required this.log});

  final DailyLog log;

  @override
  ConsumerState<BracesSection> createState() => _BracesSectionState();
}

class _BracesSectionState extends ConsumerState<BracesSection> {
  static const _maxCount = 20;

  /// Selected braces by BraceUse.key, in the order they were picked.
  late Map<String, BraceUse> _braces = _fromLog();
  late double _braceComfort = (widget.log.braceComfort ?? 5).toDouble();

  Map<String, BraceUse> _fromLog() => {for (final b in widget.log.bracesUsed) b.key: b};

  @override
  void didUpdateWidget(covariant BracesSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.log.id != widget.log.id) {
      _braces = _fromLog();
      _braceComfort = (widget.log.braceComfort ?? 5).toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final custom = ref.watch(customBracesProvider).valueOrNull ?? const <CustomBrace>[];
    // A custom brace removed from the list still shows while it's selected
    // on this day, so it can be unselected.
    final listedIds = {for (final c in custom) c.id};
    final orphaned = [
      for (final b in _braces.values)
        if (b.customId != null && !listedIds.contains(b.customId))
          CustomBrace(id: b.customId!, name: b.customName!),
    ];

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
            children: [
              for (final type in BraceType.values)
                _BraceChip(
                  label: type.label(l10n),
                  selected: _braces.containsKey(type.name),
                  onTap: () => _toggle(BraceUse.builtIn(type)),
                ),
              for (final c in [...custom, ...orphaned])
                _BraceChip(
                  label: c.name,
                  selected: _braces.containsKey('custom:${c.id}'),
                  onTap: () => _toggle(BraceUse.custom(c)),
                  onLongPress: listedIds.contains(c.id) ? () => _confirmRemove(c) : null,
                ),
              _BraceChip(
                label: l10n.bracesSectionAddOwn,
                selected: false,
                outlined: true,
                onTap: _addOwn,
              ),
            ],
          ),
          if (custom.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(l10n.bracesSectionCustomHint,
                style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
          ],
          for (final b in _braces.values)
            if (b.amount != BraceAmount.single) _detailRow(l10n, b),
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

  Widget _detailRow(AppLocalizations l10n, BraceUse b) {
    final label = b.type?.label(l10n) ?? b.customName!;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 14, color: ZebraColors.black)),
          ),
          if (b.amount == BraceAmount.side)
            CupertinoSlidingSegmentedControl<BraceSide>(
              groupValue: b.side,
              children: {
                for (final side in BraceSide.values)
                  side: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Text(side.label(l10n), style: const TextStyle(fontSize: 13)),
                  ),
              },
              onValueChanged: (side) {
                if (side != null) setState(() => _braces[b.key] = b.withSide(side));
              },
            )
          else ...[
            CupertinoButton(
              padding: EdgeInsets.zero,
              minimumSize: const Size(32, 32),
              onPressed: b.count > 1 ? () => setState(() => _braces[b.key] = b.withCount(b.count - 1)) : null,
              child: const Icon(CupertinoIcons.minus_circle),
            ),
            SizedBox(
              width: 32,
              child: Text('${b.count}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              minimumSize: const Size(32, 32),
              onPressed:
                  b.count < _maxCount ? () => setState(() => _braces[b.key] = b.withCount(b.count + 1)) : null,
              child: const Icon(CupertinoIcons.plus_circle),
            ),
          ],
        ],
      ),
    );
  }

  void _toggle(BraceUse brace) {
    setState(() {
      if (_braces.remove(brace.key) == null) _braces[brace.key] = brace;
    });
  }

  Future<void> _addOwn() async {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController();
    final name = await showCupertinoDialog<String>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: Text(l10n.bracesSectionAddTitle),
        content: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: CupertinoTextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            placeholder: l10n.bracesSectionAddPlaceholder,
            onSubmitted: (v) => Navigator.of(dialogContext).pop(v),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.commonCancelButton),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(dialogContext).pop(controller.text),
            child: Text(l10n.bracesSectionAddButton),
          ),
        ],
      ),
    );
    controller.dispose();
    if (name == null || name.trim().isEmpty) return;
    final brace = await addCustomBrace(ref.read(settingsRepositoryProvider), name);
    if (!mounted) return;
    setState(() => _braces.putIfAbsent('custom:${brace.id}', () => BraceUse.custom(brace)));
  }

  Future<void> _confirmRemove(CustomBrace brace) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showCupertinoDialog<bool>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: Text(l10n.bracesSectionRemoveTitle(brace.name)),
        content: Text(l10n.bracesSectionRemoveMessage),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancelButton),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.bracesSectionRemoveButton),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await removeCustomBrace(ref.read(settingsRepositoryProvider), brace.id);
    }
  }

  Future<void> _save() async {
    final repo = ref.read(dailyLogRepositoryProvider);
    await repo.upsertDailyLog(
      widget.log.copyWith(
        bracesUsed: _braces.values.toList(),
        braceComfort: _braces.isEmpty ? null : _braceComfort.round(),
      ),
    );
  }
}

class _BraceChip extends StatelessWidget {
  const _BraceChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.onLongPress,
    this.outlined = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? ZebraColors.teal : ZebraColors.bg,
          border: Border.all(color: outlined ? ZebraColors.brandTeal : ZebraColors.cardBorder),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          // Teal is for the border only: as text on the cream background it
          // falls short of WCAG AA contrast.
          style: TextStyle(
            color: ZebraColors.onColor,
            fontSize: 13,
            fontWeight: outlined ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
