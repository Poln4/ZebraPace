/// Ported verbatim from app.py's ADAPTIVE_BODY_PRINCIPLES / REST_FACTS /
/// MOTIVATION_* lists — the app's rotating tips, the "why this app works
/// this way" reference material, and the steps-save motivational copy.
/// All localized — callers must pass an [AppLocalizations] instance.
/// Citations (author/year/journal) are bibliographic references and are
/// deliberately left untranslated.
library;

import '../../l10n/app_localizations.dart';

class AdaptiveBodyPrinciple {
  const AdaptiveBodyPrinciple({
    required this.title,
    required this.fact,
    required this.inspiration,
    required this.citation,
  });

  final String title;
  final String fact;
  final String inspiration;
  final String citation;
}

List<AdaptiveBodyPrinciple> adaptiveBodyPrinciples(AppLocalizations l10n) => [
      AdaptiveBodyPrinciple(
        title: l10n.principleMovementQualityTitle,
        fact: l10n.principleMovementQualityFact,
        inspiration: l10n.principleMovementQualityInspiration,
        citation: 'Buryk-Iggers et al., 2022, Arch Rehabil Res Clin Transl',
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleHealingClockTitle,
        fact: l10n.principleHealingClockFact,
        inspiration: l10n.principleHealingClockInspiration,
        citation: 'Stasiak, Woźniak & Woźniak, 2025, Quality in Sport',
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleDelayedSorenessTitle,
        fact: l10n.principleDelayedSorenessFact,
        inspiration: l10n.principleDelayedSorenessInspiration,
        citation: 'Ostuni et al., 2024, Int J Sports Phys Ther',
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleAutoEscalationTitle,
        fact: l10n.principleAutoEscalationFact,
        inspiration: l10n.principleAutoEscalationInspiration,
        citation: 'Buryk-Iggers et al., 2022, Arch Rehabil Res Clin Transl',
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleCinderellaMusclesTitle,
        fact: l10n.principleCinderellaMusclesFact,
        inspiration: l10n.principleCinderellaMusclesInspiration,
        citation: 'Ahmed et al., 2018, J Exerc Rehabil',
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleStiffnessParadoxTitle,
        fact: l10n.principleStiffnessParadoxFact,
        inspiration: l10n.principleStiffnessParadoxInspiration,
        citation: 'Wang, Stecco, Hakim & Schleip, 2025, Int J Mol Sci',
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleEccentricWorkTitle,
        fact: l10n.principleEccentricWorkFact,
        inspiration: l10n.principleEccentricWorkInspiration,
        citation: 'Hody et al., 2019, Front Physiol; Nosaka, 2026, J Sport Health Sci',
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleRepeatedBoutEffectTitle,
        fact: l10n.principleRepeatedBoutEffectFact,
        inspiration: l10n.principleRepeatedBoutEffectInspiration,
        citation: 'Hody et al., 2019, Front Physiol; Nosaka, 2026, J Sport Health Sci',
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleMuscleDamageCaveatTitle,
        fact: l10n.principleMuscleDamageCaveatFact,
        inspiration: l10n.principleMuscleDamageCaveatInspiration,
        citation: 'App-level synthesis, not from the source studies directly',
      ),
    ];

List<String> restFacts(AppLocalizations l10n) => [
      for (final p in adaptiveBodyPrinciples(l10n)) '${p.title}: ${p.inspiration}',
      l10n.restFactNoBehind,
      l10n.restFactEveryEntryCounts,
      l10n.restFactFlareExcluded,
    ];

List<String> motivationLowSteps(AppLocalizations l10n) => [
      l10n.motivationLowSteps1,
      l10n.motivationLowSteps2,
      l10n.motivationLowSteps3,
    ];

List<String> motivationSteady(AppLocalizations l10n) => [
      l10n.motivationSteady1,
      l10n.motivationSteady2,
    ];

List<String> motivationGrowth(AppLocalizations l10n) => [
      l10n.motivationGrowth1,
      l10n.motivationGrowth2,
    ];
