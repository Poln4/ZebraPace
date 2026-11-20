import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/presentation/screens/insights/widgets/insights_range.dart';
import 'package:zebrapace_app/providers/app_providers.dart';
import 'package:zebrapace_app/providers/plus_providers.dart';

void main() {
  ProviderContainer make({required bool plus, String? earliest, String selected = '2026-11-21'}) {
    final c = ProviderContainer(overrides: [
      isPlusProvider.overrideWithValue(plus),
      selectedDateProvider.overrideWith((ref) => selected),
      earliestLogDateProvider.overrideWith((ref) async => earliest),
    ]);
    addTearDown(c.dispose);
    return c;
  }

  test('14/30/90 days are free; 6 months, 1 year and All need Zebras+', () {
    expect(InsightsRangeOption.ninetyDays.needsPlus, isFalse);
    expect(
      InsightsRangeOption.values.where((o) => o.needsPlus),
      [InsightsRangeOption.sixMonths, InsightsRangeOption.oneYear, InsightsRangeOption.all],
    );
  });

  test('fixed ranges end on the selected day and span exactly N days', () {
    final c = make(plus: true);
    c.read(insightsRangeOptionProvider.notifier).state = InsightsRangeOption.ninetyDays;
    final r = c.read(insightsDateRangeProvider);
    expect(r.end, '2026-11-21');
    expect(r.days, 90);
    c.read(insightsRangeOptionProvider.notifier).state = InsightsRangeOption.oneYear;
    expect(c.read(insightsDateRangeProvider).days, 365);
  });

  test('a Zebras+ range falls back to 90 days without the plan', () {
    final c = make(plus: false);
    c.read(insightsRangeOptionProvider.notifier).state = InsightsRangeOption.oneYear;
    expect(c.read(effectiveInsightsRangeOptionProvider), InsightsRangeOption.ninetyDays);
    expect(c.read(insightsDateRangeProvider).days, 90);
  });

  test('free windows can sit anywhere in the history (depth is paid, not date)', () {
    final c = make(plus: false, selected: '2024-03-10');
    final r = c.read(insightsDateRangeProvider);
    expect(r.end, '2024-03-10');
    expect(r.days, 30);
  });

  test('All runs from the first logged day', () async {
    final c = make(plus: true, earliest: '2025-02-01');
    c.read(insightsRangeOptionProvider.notifier).state = InsightsRangeOption.all;
    await c.read(earliestLogDateProvider.future);
    expect(c.read(insightsDateRangeProvider).start, '2025-02-01');
  });

  test('All with an empty log shows a year', () async {
    final c = make(plus: true);
    c.read(insightsRangeOptionProvider.notifier).state = InsightsRangeOption.all;
    await c.read(earliestLogDateProvider.future);
    expect(c.read(insightsDateRangeProvider).days, 365);
  });

  group('dateRangeFor (also used by the PDF summary, free for any period)', () {
    test('any option works without consulting the plan', () {
      final r = dateRangeFor(InsightsRangeOption.oneYear, selected: '2026-11-21');
      expect(r.start, '2025-11-22');
      expect(r.days, 365);
    });

    test('All from the first logged day, never after the selected day', () {
      expect(
        dateRangeFor(InsightsRangeOption.all, selected: '2026-11-21', earliest: '2024-06-01').start,
        '2024-06-01',
      );
      expect(
        dateRangeFor(InsightsRangeOption.all, selected: '2024-01-01', earliest: '2024-06-01').start,
        '2024-01-01',
      );
    });
  });
}
