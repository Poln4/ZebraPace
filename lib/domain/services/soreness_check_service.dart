import '../../core/constants/enums.dart';
import '../../l10n/app_localizations.dart';

class SorenessVerdict {
  const SorenessVerdict(this.key, this.label, this.message);

  final String key;
  final String label;
  final String message;
}

/// Ported verbatim from app.py's evaluate_soreness_or_crash. A descriptive
/// heuristic for the person's own reflection, not a diagnostic tool.
class SorenessCheckService {
  SorenessVerdict evaluate({
    required AppLocalizations l10n,
    required SorenessOnset onset,
    required SorenessSpread spread,
    required SorenessTrend trend,
  }) {
    if (spread == SorenessSpread.widespread || trend == SorenessTrend.worse) {
      return SorenessVerdict(
        'possible_crash',
        l10n.sorenessVerdictCrashLabel,
        l10n.sorenessVerdictCrashMessage,
      );
    }
    final easingOrSame = trend == SorenessTrend.easing || trend == SorenessTrend.same;
    final delayedOnset =
        onset == SorenessOnset.oneDayAfter || onset == SorenessOnset.twoToThreeDaysAfter;
    if (spread == SorenessSpread.localized && easingOrSame && delayedOnset) {
      return SorenessVerdict(
        'likely_doms',
        l10n.sorenessVerdictDomsLabel,
        l10n.sorenessVerdictDomsMessage,
      );
    }
    return SorenessVerdict(
      'unclear',
      l10n.sorenessVerdictUnclearLabel,
      l10n.sorenessVerdictUnclearMessage,
    );
  }
}
