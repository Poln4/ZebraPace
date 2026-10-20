import '../../core/constants/enums.dart';
import '../../l10n/app_localizations.dart';

class CalisthenicsSet {
  const CalisthenicsSet({
    required this.id,
    required this.date,
    required this.exercise,
    required this.progression,
    required this.setValues,
    this.unit = SetUnit.reps,
    this.comfortScore = 0,
    this.mentalState,
    this.bodyFeeling,
    this.contractionMode,
    this.heartRateMinBpm,
    this.heartRateMaxBpm,
  });

  final String id;
  final String date;
  final CalisthenicsExercise exercise;
  final String progression;

  /// Each set's reps, or seconds held when [unit] is [SetUnit.seconds].
  final List<int> setValues;
  final SetUnit unit;
  final double comfortScore;
  final MentalState? mentalState;
  final BodyFeeling? bodyFeeling;
  final ContractionMode? contractionMode;
  final int? heartRateMinBpm;
  final int? heartRateMaxBpm;

  int get sets => setValues.length;
}

/// "3 × 30 reps" when every set matches, otherwise "30 · 20 · 23 reps";
/// holds read "3 × 60s" / "60s · 45s · 30s".
String formatSetValues(AppLocalizations l10n, List<int> values, SetUnit unit) {
  if (values.isEmpty) return '';
  String one(int v) => unit == SetUnit.seconds ? l10n.calisthenicsSetValueSeconds(v) : '$v';
  final uniform = values.length > 1 && values.every((v) => v == values.first);
  final joined =
      uniform ? '${values.length} × ${one(values.first)}' : values.map(one).join(' · ');
  return unit == SetUnit.seconds ? joined : l10n.calisthenicsSetValuesReps(joined);
}

/// Ported from app.py's get_comfort_emoji.
String comfortLabel(AppLocalizations l10n, double score) {
  if (score >= 4.5) return l10n.comfortLabelBrilliant;
  if (score >= 3.8) return l10n.comfortLabelComfortable;
  if (score >= 2.5) return l10n.comfortLabelOkay;
  if (score >= 1.5) return l10n.comfortLabelAchy;
  return l10n.comfortLabelPainful;
}
