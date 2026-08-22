import 'package:flutter/cupertino.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../l10n/app_localizations.dart';
import 'widgets/activities_section.dart';
import 'widgets/calisthenics_section.dart';
import 'widgets/healthkit_workout_suggestions.dart';
import 'widgets/injuries_section.dart';
import 'widgets/steps_section.dart';
import 'widgets/therapies_section.dart';

class MovementTab extends StatelessWidget {
  const MovementTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      navigationBar: CupertinoNavigationBar(
        middle: Text(l10n.movementTabTitle),
        backgroundColor: ZebraColors.paper,
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            StepsSection(),
            HealthKitWorkoutSuggestions(),
            ActivitiesSection(),
            TherapiesSection(),
            CalisthenicsSection(),
            InjuriesSection(),
          ],
        ),
      ),
    );
  }
}
