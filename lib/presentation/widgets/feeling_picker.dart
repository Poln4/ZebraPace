import 'package:flutter/cupertino.dart';

import '../../core/theme/zebra_theme.dart';

/// Tap-target segmented control (mirrors app.py's feeling_control helper —
/// a segmented control instead of a drag slider, friendlier on tremor/pain days).
class FeelingPicker<T> extends StatelessWidget {
  const FeelingPicker({
    super.key,
    required this.label,
    required this.options,
    required this.emojiOf,
    required this.labelOf,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final List<T> options;
  final String Function(T) emojiOf;
  final String Function(T) labelOf;
  final T? value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700, color: ZebraColors.black)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: options.map((o) {
            final selected = o == value;
            return GestureDetector(
              onTap: () => onChanged(o),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? ZebraColors.brandTeal : ZebraColors.paper,
                  border: Border.all(color: ZebraColors.cardBorder),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${emojiOf(o)} ${labelOf(o)}',
                  style: const TextStyle(
                    // Black in both states: white-on-brandTeal (the
                    // selected state's background) is only 3.3:1, under
                    // WCAG AA's 4.5:1 — black clears 6.4:1 there.
                    color: ZebraColors.onColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
