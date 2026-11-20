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
    required this.sourceIds,
    this.appSynthesis = false,
  });

  final String title;
  final String fact;
  final String inspiration;
  /// Keys into kSources (core/constants/sources.dart), shown as links.
  final List<String> sourceIds;

  /// The fact is ZebraPace's own summary of [sourceIds], not a finding
  /// stated in them.
  final bool appSynthesis;
}

List<AdaptiveBodyPrinciple> adaptiveBodyPrinciples(AppLocalizations l10n) => [
      AdaptiveBodyPrinciple(
        title: l10n.principleMovementQualityTitle,
        fact: l10n.principleMovementQualityFact,
        inspiration: l10n.principleMovementQualityInspiration,
        sourceIds: ['buryk2022'],
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleHealingClockTitle,
        fact: l10n.principleHealingClockFact,
        inspiration: l10n.principleHealingClockInspiration,
        sourceIds: ['stasiak2025'],
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleDelayedSorenessTitle,
        fact: l10n.principleDelayedSorenessFact,
        inspiration: l10n.principleDelayedSorenessInspiration,
        sourceIds: ['ostuni2024'],
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleAutoEscalationTitle,
        fact: l10n.principleAutoEscalationFact,
        inspiration: l10n.principleAutoEscalationInspiration,
        sourceIds: ['buryk2022'],
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleCinderellaMusclesTitle,
        fact: l10n.principleCinderellaMusclesFact,
        inspiration: l10n.principleCinderellaMusclesInspiration,
        sourceIds: ['ahmed2018'],
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleStiffnessParadoxTitle,
        fact: l10n.principleStiffnessParadoxFact,
        inspiration: l10n.principleStiffnessParadoxInspiration,
        sourceIds: ['wang2025'],
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleEccentricWorkTitle,
        fact: l10n.principleEccentricWorkFact,
        inspiration: l10n.principleEccentricWorkInspiration,
        sourceIds: ['hody2019', 'nosaka2026'],
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleRepeatedBoutEffectTitle,
        fact: l10n.principleRepeatedBoutEffectFact,
        inspiration: l10n.principleRepeatedBoutEffectInspiration,
        sourceIds: ['hody2019', 'nosaka2026'],
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleMuscleDamageCaveatTitle,
        fact: l10n.principleMuscleDamageCaveatFact,
        inspiration: l10n.principleMuscleDamageCaveatInspiration,
        sourceIds: ['hody2019', 'nosaka2026'],
        appSynthesis: true,
      ),
      // Autonomic signals and the Plan tab (added 2026-11-18). Citations
      // checked against PubMed and publisher records at abstract level.
      AdaptiveBodyPrinciple(
        title: l10n.principleNoBalanceNumberTitle,
        fact: l10n.principleNoBalanceNumberFact,
        inspiration: l10n.principleNoBalanceNumberInspiration,
        sourceIds: ['goldberger2006', 'martinmaki2006'],
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleOwnBaselineTitle,
        fact: l10n.principleOwnBaselineFact,
        inspiration: l10n.principleOwnBaselineInspiration,
        sourceIds: ['gronwald2024', 'zhang2020'],
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleSignalsInformTitle,
        fact: l10n.principleSignalsInformFact,
        inspiration: l10n.principleSignalsInformInspiration,
        sourceIds: ['pecchia2018', 'cole1999'],
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleStandTestTitle,
        fact: l10n.principleStandTestFact,
        inspiration: l10n.principleStandTestInspiration,
        sourceIds: ['freeman2011', 'sheldon2015'],
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleSweatSignalTitle,
        fact: l10n.principleSweatSignalFact,
        inspiration: l10n.principleSweatSignalInspiration,
        sourceIds: ['sletten2012'],
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principlePainMonitoringTitle,
        fact: l10n.principlePainMonitoringFact,
        inspiration: l10n.principlePainMonitoringInspiration,
        sourceIds: ['thomee1997', 'silbernagel2007'],
      ),
      AdaptiveBodyPrinciple(
        title: l10n.principleGradedExposureTitle,
        fact: l10n.principleGradedExposureFact,
        inspiration: l10n.principleGradedExposureInspiration,
        sourceIds: ['vlaeyen2000'],
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
