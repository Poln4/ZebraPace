import 'package:flutter/cupertino.dart';

import '../../core/theme/zebra_theme.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.progress, this.height = 10, this.fadeColor});

  final double progress;
  final double height;

  /// When set, the fill color interpolates from brandTeal (at progress 1.0)
  /// towards this color (at progress 0.0) instead of staying a flat teal —
  /// used by the energy bar so "running low" reads as a color shift, not
  /// just a shrinking bar.
  final Color? fadeColor;

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);
    final fillColor =
        fadeColor == null ? ZebraColors.brandTeal : Color.lerp(fadeColor, ZebraColors.brandTeal, clamped)!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: height,
            width: constraints.maxWidth,
            color: ZebraColors.bg,
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: clamped,
                child: Container(color: fillColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
