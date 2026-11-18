import 'package:flutter/cupertino.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/autonomic.dart';
import '../../../../l10n/app_localizations.dart';

String sweatKindLabel(AppLocalizations l10n, SweatKind k) => switch (k) {
      SweatKind.moreThanUsual => l10n.sweatMoreThanUsual,
      SweatKind.lessThanUsual => l10n.sweatLessThanUsual,
      SweatKind.couldNotSweat => l10n.sweatCouldNotSweat,
      SweatKind.coldClammy => l10n.sweatColdClammy,
      SweatKind.nightSweats => l10n.sweatNightSweats,
      SweatKind.oneSideOrPatchy => l10n.sweatOneSideOrPatchy,
    };

String standSymptomLabel(AppLocalizations l10n, StandSymptom s) => switch (s) {
      StandSymptom.lightheaded => l10n.standSymptomLightheaded,
      StandSymptom.palpitations => l10n.standSymptomPalpitations,
      StandSymptom.blurredVision => l10n.standSymptomBlurredVision,
      StandSymptom.nausea => l10n.standSymptomNausea,
      StandSymptom.sweating => l10n.standSymptomSweating,
      StandSymptom.shaky => l10n.standSymptomShaky,
      StandSymptom.breathless => l10n.standSymptomBreathless,
      StandSymptom.headache => l10n.standSymptomHeadache,
    };

/// A tappable on/off chip.
class AutonomicChip extends StatelessWidget {
  const AutonomicChip({super.key, required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Semantics(
        button: true,
        selected: selected,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: selected ? ZebraColors.brandTeal : ZebraColors.paper,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: selected ? ZebraColors.brandTeal : ZebraColors.cardBorder),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: selected ? ZebraColors.onColor : ZebraColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
