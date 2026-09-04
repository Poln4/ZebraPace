import 'package:flutter/cupertino.dart';

import '../../core/theme/zebra_theme.dart';

/// Tap-to-select chips for a small enum, e.g. injury zone/kind/type.
class EnumWrap<T> extends StatelessWidget {
  const EnumWrap({
    super.key,
    required this.options,
    required this.labelOf,
    required this.value,
    required this.onChanged,
  });

  final List<T> options;
  final String Function(T) labelOf;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: options.map((o) {
        final selected = o == value;
        return GestureDetector(
          onTap: () => onChanged(o),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: selected ? ZebraColors.teal : ZebraColors.bg,
              border: Border.all(color: ZebraColors.cardBorder),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(labelOf(o),
                style: const TextStyle(fontSize: 11.5, color: ZebraColors.onColor)),
          ),
        );
      }).toList(),
    );
  }
}
