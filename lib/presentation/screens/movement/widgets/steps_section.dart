import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/content.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/daily_log.dart';
import '../../../../domain/services/pacing_service.dart';
import '../../../../domain/services/readiness_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/health_source_row.dart';
import '../../../widgets/section_card.dart';

/// Ported from app.py's "Steps & The Gentle-Growth Rule" — the app's central
/// safety feature: a 14-day baseline, a gentle 1% growth goal, and a >10%
/// caution line (the "PEM precaution" the README describes).
class StepsSection extends ConsumerStatefulWidget {
  const StepsSection({super.key});

  @override
  ConsumerState<StepsSection> createState() => _StepsSectionState();
}

class _StepsSectionState extends ConsumerState<StepsSection> {
  final _controller = TextEditingController();
  String? _lastMessage;
  String? _loadedForDate;
  int? _shownSteps;

  /// With Health connected the day's steps are shown, not typed; this is
  /// the secondary "Edit" path.
  bool _editing = false;

  /// The tip shown with a synced count, kept until the count changes so
  /// it doesn't reshuffle on every rebuild.
  (int, String)? _syncedMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = ref.watch(selectedDateProvider);
    final log = ref.watch(dailyLogProvider).valueOrNull;
    final evaluationAsync = ref.watch(_pacingEvaluationProvider(date));
    // Connected: steps sync into the log on their own (healthSyncProvider)
    // and typing is optional. Not connected: typing is the way in.
    final connected = ref.watch(healthKitEnabledProvider).valueOrNull ?? false;

    if (_loadedForDate != date) {
      _editing = false;
      _lastMessage = null;
      _syncedMessage = null;
    }
    if (log != null && (_loadedForDate != date || (!_editing && log.steps != _shownSteps))) {
      _loadedForDate = date;
      _shownSteps = log.steps;
      _controller.text = log.steps > 0 ? log.steps.toString() : '';
    }

    return SectionCard(
      title: l10n.stepsSectionTitle,
      // Keep showing the card while a save or sync re-evaluates it, instead
      // of flashing a spinner that hides the result.
      child: evaluationAsync.when(
        skipLoadingOnReload: true,
        loading: () => const CupertinoActivityIndicator(),
        error: (e, st) => Text('$e'),
        data: (evaluation) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _MiniStat(l10n.stepsSectionBaselineLabel, evaluation.avgSteps.round().toString()),
                  _MiniStat(
                    evaluation.isReduced
                        ? l10n.stepsSectionTodayGoalLabel
                        : l10n.stepsSectionGrowthGoalLabel,
                    evaluation.goalSteps.toString(),
                  ),
                  _MiniStat(l10n.stepsSectionCautionLineLabel, evaluation.cautionSteps.toString()),
                ],
              ),
              if (_showVerdict(log?.isFlareDay ?? false, evaluation) ||
                  evaluation.readiness.restingHeartRateToday != null ||
                  evaluation.readiness.hrvToday != null) ...[
                const SizedBox(height: 10),
                _ReadinessNote(
                  evaluation.readiness,
                  showVerdict: _showVerdict(log?.isFlareDay ?? false, evaluation),
                ),
              ],
              const SizedBox(height: 12),
              if (connected && !_editing && log != null) ...[
                Text(
                  log.steps > 0
                      ? l10n.stepsSectionStepsValue(log.steps)
                      : l10n.stepsSectionWaitingForHealth,
                  style: TextStyle(
                    fontSize: log.steps > 0 ? 22 : 14,
                    fontWeight: log.steps > 0 ? FontWeight.w700 : FontWeight.normal,
                    color: ZebraColors.black,
                  ),
                ),
                HealthSourceRow(
                  source: log.stepsSource,
                  onEdit: () => setState(() {
                    _editing = true;
                    _lastMessage = null;
                    _controller.text = log.steps > 0 ? log.steps.toString() : '';
                  }),
                  onUseHealth: () => useHealthValue(ref, date, steps: true),
                ),
                if (log.steps > 0) ...[
                  const SizedBox(height: 4),
                  Text(_syncedMessageFor(l10n, log, evaluation),
                      style: const TextStyle(fontSize: 13)),
                ],
              ] else ...[
                CupertinoTextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  placeholder: l10n.stepsSectionTodayStepsPlaceholder,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    color: ZebraColors.brandTeal,
                    onPressed: log == null
                        ? null
                        : () => _save(date, log.isFlareDay, evaluation),
                    child: Text(l10n.stepsSectionSaveButton,
                        style: const TextStyle(color: ZebraColors.onColor)),
                  ),
                ),
                if (connected && _editing)
                  Center(
                    child: CupertinoButton(
                      onPressed: () => setState(() => _editing = false),
                      child: Text(l10n.healthCancelEditButton,
                          style: const TextStyle(fontSize: 13)),
                    ),
                  ),
                if (_lastMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(_lastMessage!, style: const TextStyle(fontSize: 13)),
                ],
              ],
            ],
          );
        },
      ),
    );
  }

  Future<void> _save(String date, bool isFlareDay, PacingEvaluation evaluation) async {
    final l10n = AppLocalizations.of(context);
    final steps = int.tryParse(_controller.text) ?? 0;
    final repo = ref.read(dailyLogRepositoryProvider);
    final log = await repo.getOrCreateDailyLog(date);
    await repo.upsertDailyLog(log.copyWith(steps: steps, stepsSource: ValueSource.manual));
    _editing = false;

    final kind = ref.read(pacingServiceProvider).evaluateStepsMessage(
          steps: steps,
          isFlareDay: isFlareDay,
          evaluation: evaluation,
        );
    setState(() => _lastMessage = _messageFor(l10n, kind));
  }

  final _random = math.Random();

  String _syncedMessageFor(AppLocalizations l10n, DailyLog log, PacingEvaluation evaluation) {
    final cached = _syncedMessage;
    if (cached != null && cached.$1 == log.steps) return cached.$2;
    final kind = ref.read(pacingServiceProvider).evaluateStepsMessage(
          steps: log.steps,
          isFlareDay: log.isFlareDay,
          evaluation: evaluation,
        );
    final message = _messageFor(l10n, kind);
    _syncedMessage = (log.steps, message);
    return message;
  }

  String _messageFor(AppLocalizations l10n, PacingMessageKind kind) => switch (kind) {
        PacingMessageKind.flareNeutral => l10n.stepsSectionMessageFlareNeutral,
        PacingMessageKind.caution => l10n.stepsSectionMessageCaution,
        PacingMessageKind.goalCelebration =>
          l10n.stepsSectionMessageGoalCelebration(_pick(motivationGrowth(l10n))),
        PacingMessageKind.gentleLow =>
          l10n.stepsSectionMessageGentleLow(_pick(motivationLowSteps(l10n))),
        PacingMessageKind.readinessHonored => l10n.stepsSectionMessageReadinessHonored,
        PacingMessageKind.steady => l10n.stepsSectionMessageSteady(_pick(motivationSteady(l10n))),
        PacingMessageKind.noBaseline => l10n.stepsSectionMessageNoBaseline,
      };

  String _pick(List<String> options) => options[_random.nextInt(options.length)];
}

class _MiniStat extends StatelessWidget {
  const _MiniStat(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(fontWeight: FontWeight.w700, color: ZebraColors.brandTeal)),
          Text(label, style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
        ],
      ),
    );
  }
}

/// The readiness headline and reasons only apply when they can change the
/// envelope; today's numbers show whenever there are any.
bool _showVerdict(bool isFlareDay, PacingEvaluation evaluation) =>
    !isFlareDay && evaluation.hasBaseline && evaluation.readiness.level != ReadinessLevel.unknown;

class _ReadinessNote extends StatelessWidget {
  const _ReadinessNote(this.readiness, {required this.showVerdict});

  final ReadinessResult readiness;
  final bool showVerdict;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final headline = switch (readiness.level) {
      ReadinessLevel.low => l10n.readinessLowHeadline,
      ReadinessLevel.lower => l10n.readinessLowerHeadline,
      _ => l10n.readinessSteadyHeadline,
    };
    final reasons = [
      for (final reason in ReadinessReason.values)
        if (readiness.reasons.contains(reason))
          switch (reason) {
            ReadinessReason.restingHeartRateUp => l10n.readinessReasonRestingHeartRate(
                (readiness.restingHeartRateDelta ?? 0).round()),
            ReadinessReason.hrvDown =>
              l10n.readinessReasonHrv((readiness.hrvPercentBelow ?? 0).round()),
            ReadinessReason.recoveryWindowExceeded => l10n.readinessReasonRecoveryWindow,
            ReadinessReason.possibleCrash => l10n.readinessReasonPossibleCrash,
          },
    ];
    String usual(double? value, int historyDays) => value != null
        ? l10n.readinessUsual(value.round())
        : l10n.readinessUsualPending(ReadinessService.minBaselineReadings - historyDays);
    final numbers = [
      if (readiness.restingHeartRateToday case final bpm?)
        '${readiness.restingHeartRateFromSleep ? l10n.readinessSleepingLine(bpm.round()) : l10n.readinessRestingLine(bpm.round())}'
            ' · ${usual(readiness.restingHeartRateUsual, readiness.restingHeartRateHistoryDays)}',
      if (readiness.hrvToday case final ms?)
        '${l10n.readinessHrvLine(ms.round())} · ${usual(readiness.hrvUsual, readiness.hrvHistoryDays)}',
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ZebraColors.bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showVerdict) ...[
            Text(headline, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            for (final reason in reasons)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('· $reason', style: const TextStyle(fontSize: 12)),
              ),
          ],
          for (final (i, line) in numbers.indexed)
            Padding(
              padding: EdgeInsets.only(top: showVerdict || i > 0 ? 4 : 0),
              child: Text(line,
                  style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
            ),
        ],
      ),
    );
  }
}

final _pacingEvaluationProvider = FutureProvider.autoDispose.family((ref, String date) async {
  final settings = ref.watch(settingsSnapshotProvider).valueOrNull;
  final cautionPct = settings?.cautionPct ?? 1.10;
  final pacing = ref.read(pacingServiceProvider);
  final base = await pacing.evaluateForDate(
    date,
    growthGoalPct: settings?.growthGoalPct ?? 1.01,
    cautionPct: cautionPct,
  );
  // Readiness only ever narrows the envelope; if it can't be worked out,
  // the usual envelope still shows.
  ReadinessResult readiness;
  try {
    readiness = await ref.watch(readinessProvider(date).future);
  } catch (_) {
    readiness = ReadinessResult.unknown;
  }
  return pacing.applyReadiness(base, readiness, cautionPct: cautionPct);
});
