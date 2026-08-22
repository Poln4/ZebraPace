import 'package:flutter/cupertino.dart';

import '../../core/theme/zebra_theme.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.progress, this.height = 10});

  final double progress;
  final double height;

  @override
  Widget build(BuildContext context) {
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
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(color: ZebraColors.brandTeal),
              ),
            ),
          );
        },
      ),
    );
  }
}
