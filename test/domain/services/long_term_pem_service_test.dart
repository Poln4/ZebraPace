import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/core/utils/date_utils.dart';
import 'package:zebrapace_app/domain/models/daily_log.dart';
import 'package:zebrapace_app/domain/services/long_term_pem_service.dart';

/// [days] consecutive days from [start]. Every 4th day is a big day
/// (8000 steps, others 3000). The body score drops to "achy" (2)
/// [crashLag] days after each big day and is "good" (4) otherwise; with
/// [crashLag] null it never drops. [softenFrom]: from that day index on,
/// the drop is milder ("manageable", 3).
List<DailyLog> _history({
  required int days,
  int? crashLag,
  String start = '2026-01-01',
  int? softenFrom,
}) {
  final first = dateFromKey(start);
  final bigDays = <int>{for (var i = 0; i < days; i++) if (i % 4 == 0) i};
  return [
    for (var i = 0; i < days; i++)
      DailyLog(
        id: '$i',
        date: dateKey(DateTime(first.year, first.month, first.day + i)),
        steps: bigDays.contains(i) ? 8000 : 3000,
        bodyFeeling: crashLag != null && bigDays.contains(i - crashLag)
            ? (softenFrom != null && i >= softenFrom ? BodyFeeling.manageable : BodyFeeling.achy)
            : BodyFeeling.good,
      ),
  ];
}

void main() {
  test('finds the delay with the biggest clear dip', () {
    final p = LongTermPemService.analyze(_history(days: 120, crashLag: 2));
    expect(p.hasEnoughHistory, isTrue);
    expect(p.usualLagDays, 2);
    expect(p.usualDip, closeTo(2.0, 0.01));
    expect(p.lags.map((l) => l.lagDays), [1, 2, 3, 4]);
  });

  test('no clear dip → no usual delay and no months', () {
    final p = LongTermPemService.analyze(_history(days: 120));
    expect(p.usualLagDays, isNull);
    expect(p.months, isEmpty);
    expect(p.trend, isNull);
  });

  test('less than about two months is not enough history', () {
    final p = LongTermPemService.analyze(_history(days: 40, crashLag: 2));
    expect(p.daysCovered, 40);
    expect(p.hasEnoughHistory, isFalse);
  });

  test('month by month at the usual delay, oldest first', () {
    final p = LongTermPemService.analyze(_history(days: 120, crashLag: 3));
    expect(p.months.first.month, '2026-01');
    expect(p.months.map((m) => m.month), ['2026-01', '2026-02', '2026-03', '2026-04']);
    expect(p.months.every((m) => m.dip != null && m.dip! > 1.5), isTrue);
  });

  test('a softening dip reads as smaller; a steady one as similar', () {
    // Seven months; the crash halves from month four on.
    final softer = LongTermPemService.analyze(_history(days: 212, crashLag: 2, softenFrom: 106));
    expect(softer.trend, DipTrend.smaller);
    final steady = LongTermPemService.analyze(_history(days: 212, crashLag: 2));
    expect(steady.trend, DipTrend.similar);
  });

  test('a lagged day in the next month still pairs with its exertion day', () {
    final p = LongTermPemService.analyze(_history(days: 120, crashLag: 4));
    final jan = p.months.firstWhere((m) => m.month == '2026-01');
    // 31 days of January; every exertion day has a score 4 days later
    // because the log continues into February.
    expect(jan.pairs, 31);
  });

  test('empty log', () {
    final p = LongTermPemService.analyze([]);
    expect(p.daysCovered, 0);
    expect(p.hasEnoughHistory, isFalse);
    expect(p.usualLagDays, isNull);
  });
}
