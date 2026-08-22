import 'package:flutter/cupertino.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/daily_log.dart';

enum _DayStatus { logged, rest, flareSick, none }

/// A single-row calendar strip colored by day status — kept as simple
/// colored cells rather than forcing fl_chart's ScatterChart into a
/// calendar-grid layout it wasn't designed for.
class CheckinConsistencyStrip extends StatelessWidget {
  const CheckinConsistencyStrip({super.key, required this.logs, required this.dates});

  final List<DailyLog> logs;
  final List<String> dates; // full date range, including days with no row

  @override
  Widget build(BuildContext context) {
    final byDate = {for (final l in logs) l.date: l};

    return SizedBox(
      height: 36,
      child: Row(
        children: dates.map((date) {
          final log = byDate[date];
          final status = _statusFor(log);
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0.5),
              decoration: BoxDecoration(
                color: _colorFor(status),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  _DayStatus _statusFor(DailyLog? log) {
    if (log == null) return _DayStatus.none;
    if (log.isFlareDay) return _DayStatus.flareSick;
    if (log.isRestDay) return _DayStatus.rest;
    if (log.waterMlCredit > 0 || log.steps > 0) return _DayStatus.logged;
    return _DayStatus.none;
  }

  Color _colorFor(_DayStatus status) => switch (status) {
        _DayStatus.logged => ZebraColors.brandTeal,
        _DayStatus.rest => ZebraColors.teal,
        _DayStatus.flareSick => ZebraColors.sand,
        _DayStatus.none => ZebraColors.cardBorder,
      };
}
