import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/content.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/services/pacing_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/section_card.dart';

/// Ported from app.py's "Steps & The Gentle-Growth Rule" — the app's central
/// safety feature: a 7-day baseline, a gentle 1% growth goal, and a >10%
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
    // HealthKit steps pre-fill the field (still fully editable) only when
    // nothing has been manually saved for the day yet — see plan §4. Wait
    // for the HealthKit lookup to finish before locking in the prefill, so
    // a slow/async HK response isn't silently missed on first build.
    final healthKitStepsAsync = ref.watch(healthKitStepsProvider(date));

    if (log != null &&
        _loadedForDate != date &&
        (log.steps > 0 || !healthKitStepsAsync.isLoading)) {
      _loadedForDate = date;
      final prefill = log.steps > 0 ? log.steps : healthKitStepsAsync.valueOrNull ?? 0;
      _controller.text = prefill > 0 ? prefill.toString() : '';
      _lastMessage = null;
    }

    return SectionCard(
      title: l10n.stepsSectionTitle,
      child: evaluationAsync.when(
        loading: () => const CupertinoActivityIndicator(),
        error: (e, st) => Text('$e'),
        data: (evaluation) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _MiniStat(l10n.stepsSectionBaselineLabel, evaluation.avgSteps.round().toString()),
                  _MiniStat(l10n.stepsSectionGrowthGoalLabel, evaluation.goalSteps.toString()),
                  _MiniStat(l10n.stepsSectionCautionLineLabel, evaluation.cautionSteps.toString()),
                ],
              ),
              const SizedBox(height: 12),
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
              if (_lastMessage != null) ...[
                const SizedBox(height: 8),
                Text(_lastMessage!, style: const TextStyle(fontSize: 13)),
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
    await repo.upsertDailyLog(log.copyWith(steps: steps));

    final kind = ref.read(pacingServiceProvider).evaluateStepsMessage(
          steps: steps,
          isFlareDay: isFlareDay,
          evaluation: evaluation,
        );
    setState(() => _lastMessage = _messageFor(l10n, kind));
  }

  final _random = math.Random();

  String _messageFor(AppLocalizations l10n, PacingMessageKind kind) => switch (kind) {
        PacingMessageKind.flareNeutral => l10n.stepsSectionMessageFlareNeutral,
        PacingMessageKind.caution => l10n.stepsSectionMessageCaution,
        PacingMessageKind.goalCelebration =>
          l10n.stepsSectionMessageGoalCelebration(_pick(motivationGrowth(l10n))),
        PacingMessageKind.gentleLow =>
          l10n.stepsSectionMessageGentleLow(_pick(motivationLowSteps(l10n))),
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

final _pacingEvaluationProvider = FutureProvider.family((ref, String date) {
  final settings = ref.watch(settingsSnapshotProvider).valueOrNull;
  return ref.read(pacingServiceProvider).evaluateForDate(
        date,
        growthGoalPct: settings?.growthGoalPct ?? 1.01,
        cautionPct: settings?.cautionPct ?? 1.10,
      );
});
