import 'package:flutter/cupertino.dart';

import '../../core/constants/defaults.dart';
import '../../core/theme/zebra_theme.dart';

/// All-time gamification, non-resetting — mirrors app.py's stripe tracker:
/// 20 fixed segments, filled once total_checkins // 5 crosses each one.
/// Not a streak — missing days never remove earned stripes.
class StripeTrack extends StatelessWidget {
  const StripeTrack({super.key, required this.stripesEarned});

  final int stripesEarned;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(StripeConstants.slots, (i) {
        final earned = i < stripesEarned;
        return Expanded(
          child: Container(
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: earned ? ZebraColors.black : ZebraColors.cardBorder,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );
      }),
    );
  }
}
