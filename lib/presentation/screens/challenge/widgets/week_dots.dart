import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../core/utils/intl_locale.dart';
import '../../../../domain/models/challenge_day.dart';

/// Seven dots for one week of a daily-goal challenge: filled when the goal
/// was met, sand-colored for a rest/flare day counted as met, outlined
/// when not met, faint when there's no data (future, or not synced yet).
class WeekDots extends StatelessWidget {
  const WeekDots({required this.dates, required this.days, this.showLetters = false, super.key});

  final List<DateTime> dates;

  /// Same length and order as [dates].
  final List<ChallengeDay?> days;
  final bool showLetters;

  static const double _size = 14;

  @override
  Widget build(BuildContext context) {
    final locale = intlLocaleOf(context);
    final letterFormat = DateFormat('EEEEE', locale);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < dates.length; i++)
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showLetters) ...[
                  Text(letterFormat.format(dates[i]),
                      style: const TextStyle(fontSize: 9, color: CupertinoColors.systemGrey)),
                  const SizedBox(height: 2),
                ],
                _Dot(day: days[i]),
              ],
            ),
          ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.day});

  final ChallengeDay? day;

  @override
  Widget build(BuildContext context) {
    final day = this.day;
    final Color fill;
    final Color border;
    if (day == null) {
      fill = const Color(0x00000000);
      border = ZebraColors.cardBorder;
    } else if (day.goalMet && day.restDay) {
      fill = ZebraColors.sand;
      border = ZebraColors.sand;
    } else if (day.goalMet) {
      fill = ZebraColors.success;
      border = ZebraColors.success;
    } else {
      fill = const Color(0x00000000);
      border = CupertinoColors.systemGrey;
    }
    return Container(
      width: WeekDots._size,
      height: WeekDots._size,
      decoration: BoxDecoration(
        color: fill,
        shape: BoxShape.circle,
        border: Border.all(color: border, width: 1.5),
      ),
    );
  }
}
