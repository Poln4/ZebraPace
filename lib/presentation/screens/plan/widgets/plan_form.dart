import 'package:flutter/cupertino.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/services/plan_progress_service.dart';
import '../../../../l10n/app_localizations.dart';

/// Bottom sheet with Cancel / title / Save, shared by the plan editor's
/// small forms. [onSave] returns false to keep the sheet open (e.g. a
/// required name is empty).
class PlanSheet extends StatelessWidget {
  const PlanSheet({
    super.key,
    required this.title,
    required this.children,
    required this.onSave,
    this.onDelete,
  });

  final String title;
  final List<Widget> children;
  final Future<bool> Function() onSave;
  final Future<void> Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: ZebraColors.paper,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.commonCancelButton),
                ),
                Flexible(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                CupertinoButton(
                  onPressed: () async {
                    final close = await onSave();
                    if (close && context.mounted) Navigator.of(context).pop();
                  },
                  child: Text(l10n.commonSaveButton),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                children: [
                  ...children,
                  if (onDelete != null) ...[
                    const SizedBox(height: 24),
                    CupertinoButton(
                      onPressed: () async {
                        await onDelete!();
                        if (context.mounted) Navigator.of(context).pop();
                      },
                      child: Text(
                        l10n.commonDeleteButton,
                        style: const TextStyle(color: CupertinoColors.destructiveRed),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A caption above a text field.
class PlanField extends StatelessWidget {
  const PlanField({
    super.key,
    required this.label,
    required this.controller,
    this.placeholder,
    this.number = false,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final String? placeholder;
  final bool number;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          CupertinoTextField(
            controller: controller,
            placeholder: placeholder,
            keyboardType: number ? TextInputType.number : TextInputType.multiline,
            minLines: 1,
            maxLines: maxLines,
          ),
        ],
      ),
    );
  }
}

/// A labelled on/off row.
class PlanSwitchRow extends StatelessWidget {
  const PlanSwitchRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.caption,
  });

  final String label;
  final String? caption;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                if (caption != null)
                  Text(
                    caption!,
                    style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
                  ),
              ],
            ),
          ),
          CupertinoSwitch(
            value: value,
            activeTrackColor: ZebraColors.brandTeal,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

String? trimmedOrNull(TextEditingController c) {
  final t = c.text.trim();
  return t.isEmpty ? null : t;
}

Color painZoneColor(PainZone zone) => switch (zone) {
  PainZone.safe => ZebraColors.success,
  PainZone.acceptable => ZebraColors.sand,
  PainZone.tooMuch => CupertinoColors.destructiveRed,
};

/// 0–10 pain chips coloured by the pain-monitoring zones, a "sharp,
/// catching or giving way" toggle, and the zone's plain-language advice.
class PainPicker extends StatelessWidget {
  const PainPicker({
    super.key,
    required this.pain,
    required this.sharp,
    required this.onPainChanged,
    required this.onSharpChanged,
  });

  final int? pain;
  final bool sharp;
  final ValueChanged<int?> onPainChanged;
  final ValueChanged<bool> onSharpChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final zone = PlanProgressService.painZone(pain, sharp: sharp);
    final advice = pain == null && !sharp
        ? null
        : switch (zone) {
            PainZone.safe => l10n.planPainSafe,
            PainZone.acceptable => l10n.planPainAcceptable,
            PainZone.tooMuch => l10n.planPainTooMuch,
          };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.planPainLabel, style: const TextStyle(fontSize: 12.5)),
        const SizedBox(height: 4),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            for (var i = 0; i <= 10; i++)
              GestureDetector(
                onTap: () => onPainChanged(pain == i ? null : i),
                child: Semantics(
                  selected: pain == i,
                  button: true,
                  child: Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: pain == i
                          ? painZoneColor(PlanProgressService.painZone(i))
                          : ZebraColors.paper,
                      border: Border.all(
                        color: painZoneColor(PlanProgressService.painZone(i)),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$i',
                      style: TextStyle(
                        fontWeight: pain == i ? FontWeight.w700 : FontWeight.w400,
                        color: pain == i ? ZebraColors.onColor : ZebraColors.black,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        Row(
          children: [
            Expanded(child: Text(l10n.planPainSharp, style: const TextStyle(fontSize: 12.5))),
            CupertinoSwitch(
              value: sharp,
              activeTrackColor: CupertinoColors.destructiveRed,
              onChanged: onSharpChanged,
            ),
          ],
        ),
        if (advice != null)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: painZoneColor(zone).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(advice, style: const TextStyle(fontSize: 12.5)),
          ),
      ],
    );
  }
}

/// A neutral 0–10 picker (fear ratings), tap again to clear.
class ScalePicker extends StatelessWidget {
  const ScalePicker({super.key, required this.label, required this.value, required this.onChanged});

  final String label;
  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              for (var i = 0; i <= 10; i++)
                GestureDetector(
                  onTap: () => onChanged(value == i ? null : i),
                  child: Semantics(
                    selected: value == i,
                    button: true,
                    child: Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: value == i ? ZebraColors.brandTeal : ZebraColors.paper,
                        border: Border.all(color: ZebraColors.cardBorder),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$i',
                        style: TextStyle(
                          fontWeight: value == i ? FontWeight.w700 : FontWeight.w400,
                          color: value == i ? ZebraColors.onColor : ZebraColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
