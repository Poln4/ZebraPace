import 'package:flutter/cupertino.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../widgets/section_card.dart';

/// Stopping rules for a session: end sets with reps in reserve, move slowly,
/// and the red flags that mean stop now. Static guidance, collapsed by
/// default so it's there when wanted without adding to every visit.
class StopSignalsCard extends StatelessWidget {
  const StopSignalsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const body = TextStyle(fontSize: 13);
    return SectionCard(
      title: l10n.stopSignalsTitle,
      collapsible: true,
      initiallyExpanded: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.stopSignalsReserve, style: body),
          const SizedBox(height: 6),
          Text(l10n.stopSignalsTempo, style: body),
          const SizedBox(height: 10),
          Text(l10n.stopSignalsRedFlagsTitle,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
          for (final flag in [
            l10n.stopSignalsDizziness,
            l10n.stopSignalsRacingHeart,
            l10n.stopSignalsCoordination,
            l10n.stopSignalsJointPain,
          ])
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text('· $flag', style: body),
            ),
          const SizedBox(height: 10),
          Text(l10n.stopSignalsAfterward, style: body),
        ],
      ),
    );
  }
}
