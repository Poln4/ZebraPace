import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../../domain/models/challenge.dart';
import '../../../../l10n/app_localizations.dart';

/// "4,000 steps", "7 h of sleep", "20 active min" — a member's daily goal
/// (or a day's value) in the unit of the challenge's kind.
String formatChallengeGoal(BuildContext context, ChallengeKind kind, double value) {
  final l10n = AppLocalizations.of(context);
  final locale = Localizations.localeOf(context).toLanguageTag();
  final number = kind == ChallengeKind.sleep
      ? NumberFormat('0.#', locale).format(value)
      : NumberFormat.decimalPattern(locale).format(value.round());
  return switch (kind) {
    ChallengeKind.steps => l10n.challengeGoalSteps(number),
    ChallengeKind.sleep => l10n.challengeGoalSleep(number),
    ChallengeKind.activity => l10n.challengeGoalActivity(number),
    ChallengeKind.logging => l10n.challengeGoalLogging,
    ChallengeKind.weight => '$number kg',
  };
}
