import '../../core/constants/enums.dart';
import '../../l10n/app_localizations.dart';

class CalisthenicsSet {
  const CalisthenicsSet({
    required this.id,
    required this.date,
    required this.exercise,
    required this.progression,
    required this.sets,
    required this.reps,
    this.comfortScore = 0,
    this.mentalState,
    this.bodyFeeling,
    this.contractionMode,
  });

  final String id;
  final String date;
  final CalisthenicsExercise exercise;
  final String progression;
  final int sets;
  final int reps;
  final double comfortScore;
  final MentalState? mentalState;
  final BodyFeeling? bodyFeeling;
  final ContractionMode? contractionMode;
}

/// Ported from app.py's get_comfort_emoji.
String comfortLabel(AppLocalizations l10n, double score) {
  if (score >= 4.5) return l10n.comfortLabelBrilliant;
  if (score >= 3.8) return l10n.comfortLabelComfortable;
  if (score >= 2.5) return l10n.comfortLabelOkay;
  if (score >= 1.5) return l10n.comfortLabelAchy;
  return l10n.comfortLabelPainful;
}
