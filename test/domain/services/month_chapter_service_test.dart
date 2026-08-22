import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/domain/models/daily_log.dart';
import 'package:zebrapace_app/domain/services/month_chapter_service.dart';
import 'package:zebrapace_app/l10n/app_localizations_en.dart';

void main() {
  final service = MonthChapterService();
  final l10n = AppLocalizationsEn();

  DailyLog log(String date, {int steps = 0, bool rest = false, bool flare = false, MentalState? mental, BodyFeeling? body}) {
    return DailyLog(
      id: date,
      date: date,
      steps: steps,
      isRestDay: rest,
      isFlareDay: flare,
      mentalState: mental,
      bodyFeeling: body,
    );
  }

  test('empty month reads as A Quiet Chapter', () {
    final chapter = service.build(
      l10n: l10n,
      monthLogs: const [],
      activityCount: 0,
      calisthenicsCount: 0,
      therapyCount: 0,
    );
    expect(chapter.title, 'A Quiet Chapter');
  });

  test('mostly rest/flare days titles as Learning to Rest', () {
    final logs = [
      log('2026-01-01', rest: true),
      log('2026-01-02', rest: true),
      log('2026-01-03', flare: true),
      log('2026-01-04', steps: 3000),
    ];
    final chapter = service.build(
      l10n: l10n,
      monthLogs: logs,
      activityCount: 0,
      calisthenicsCount: 0,
      therapyCount: 0,
    );
    expect(chapter.title, 'Learning to Rest');
  });

  test('8+ activity/calisthenics logs titles as Gentle Exploration', () {
    final logs = [log('2026-01-01', steps: 3000)];
    final chapter = service.build(
      l10n: l10n,
      monthLogs: logs,
      activityCount: 5,
      calisthenicsCount: 4,
      therapyCount: 0,
    );
    expect(chapter.title, 'Gentle Exploration');
  });

  test('summarizes mental/body score range when present', () {
    final logs = [
      log('2026-01-01', steps: 1000, mental: MentalState.low, body: BodyFeeling.achy),
      log('2026-01-02', steps: 1000, mental: MentalState.energized, body: BodyFeeling.good),
    ];
    final chapter = service.build(
      l10n: l10n,
      monthLogs: logs,
      activityCount: 0,
      calisthenicsCount: 0,
      therapyCount: 0,
    );
    expect(chapter.body, contains('Low'));
    expect(chapter.body, contains('Energized'));
  });
}
