import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/enums.dart';
import 'package:zebrapace_app/domain/services/soreness_check_service.dart';
import 'package:zebrapace_app/l10n/app_localizations_en.dart';

void main() {
  final service = SorenessCheckService();
  final l10n = AppLocalizationsEn();

  test('widespread symptoms are flagged as a possible crash regardless of trend', () {
    final v = service.evaluate(
      l10n: l10n,
      onset: SorenessOnset.oneDayAfter,
      spread: SorenessSpread.widespread,
      trend: SorenessTrend.easing,
    );
    expect(v.key, 'possible_crash');
  });

  test('worsening trend is flagged as a possible crash regardless of spread', () {
    final v = service.evaluate(
      l10n: l10n,
      onset: SorenessOnset.sameDay,
      spread: SorenessSpread.localized,
      trend: SorenessTrend.worse,
    );
    expect(v.key, 'possible_crash');
  });

  test('localized, easing/same, delayed onset reads as ordinary DOMS', () {
    final v = service.evaluate(
      l10n: l10n,
      onset: SorenessOnset.twoToThreeDaysAfter,
      spread: SorenessSpread.localized,
      trend: SorenessTrend.same,
    );
    expect(v.key, 'likely_doms');
  });

  test('localized but same-day onset does not qualify as DOMS (falls through to unclear)', () {
    final v = service.evaluate(
      l10n: l10n,
      onset: SorenessOnset.sameDay,
      spread: SorenessSpread.localized,
      trend: SorenessTrend.easing,
    );
    expect(v.key, 'unclear');
  });
}
