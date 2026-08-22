import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/activity.dart';
import '../../../../domain/models/detected_workout.dart';
import '../../../../domain/services/mets_estimation_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/section_card.dart';

/// "Import with review" flow (plan §4): detected HealthKit workouts show as
/// dismissable suggestion cards the user must tap Add/Edit/Dismiss on —
/// never silently auto-inserted into Activities.
class HealthKitWorkoutSuggestions extends ConsumerStatefulWidget {
  const HealthKitWorkoutSuggestions({super.key});

  @override
  ConsumerState<HealthKitWorkoutSuggestions> createState() => _HealthKitWorkoutSuggestionsState();
}

class _HealthKitWorkoutSuggestionsState extends ConsumerState<HealthKitWorkoutSuggestions> {
  final _dismissed = <String>{};

  @override
  Widget build(BuildContext context) {
    // HealthKit only exists on iOS — never show this section on web.
    if (kIsWeb) return const SizedBox.shrink();

    final date = ref.watch(selectedDateProvider);
    final workoutsAsync = ref.watch(detectedWorkoutsProvider(date));
    final healthKitEnabledAsync = ref.watch(healthKitEnabledProvider);

    return healthKitEnabledAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (e, st) => const SizedBox.shrink(),
      data: (enabled) {
        if (!enabled) return const _ConnectAppleHealthCard();

        return workoutsAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (e, st) => const SizedBox.shrink(),
          data: (workouts) {
            final visible = workouts.where((w) => !_dismissed.contains(w.healthkitUuid)).toList();
            if (visible.isEmpty) return const SizedBox.shrink();
            return Column(
              children: visible
                  .map((w) => _WorkoutCard(
                        workout: w,
                        onDismiss: () => setState(() => _dismissed.add(w.healthkitUuid)),
                      ))
                  .toList(),
            );
          },
        );
      },
    );
  }
}

class _ConnectAppleHealthCard extends ConsumerWidget {
  const _ConnectAppleHealthCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      title: l10n.healthkitWorkoutSuggestionsConnectTitle,
      caption: l10n.healthkitWorkoutSuggestionsConnectCaption,
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          color: ZebraColors.brandTeal,
          onPressed: () async {
            await ref.read(healthKitServiceProvider).requestAuthorization();
            ref.invalidate(healthKitEnabledProvider);
          },
          child: Text(l10n.healthkitWorkoutSuggestionsConnectButton,
              style: const TextStyle(color: ZebraColors.onColor)),
        ),
      ),
    );
  }
}

class _WorkoutCard extends ConsumerWidget {
  const _WorkoutCard({required this.workout, required this.onDismiss});

  final DetectedWorkout workout;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      title: l10n.healthkitWorkoutSuggestionsDetectedTitle(workout.activityLabel),
      child: FutureBuilder<MetsEstimate>(
        future: _estimateMets(ref),
        builder: (context, snapshot) {
          final estimate = snapshot.data;
          final metsText = estimate?.value == null
              ? ''
              : ' · ${estimate!.isApproximate ? '~' : ''}${estimate.value!.toStringAsFixed(1)} METs';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${workout.durationMin} min'
                '${workout.activeEnergyKcal != null ? ' · ${workout.activeEnergyKcal!.round()} kcal' : ''}'
                '$metsText',
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: CupertinoButton(
                      color: ZebraColors.brandTeal,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      onPressed: () => _confirm(context, ref, estimate),
                      child: Text(l10n.healthkitWorkoutSuggestionsAddButton,
                          style: const TextStyle(fontSize: 13)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CupertinoButton(
                      color: ZebraColors.cardBorder,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      onPressed: onDismiss,
                      child: Text(l10n.healthkitWorkoutSuggestionsDismissButton,
                          style: const TextStyle(fontSize: 13, color: ZebraColors.black)),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Future<MetsEstimate> _estimateMets(WidgetRef ref) async {
    final date = ref.read(selectedDateProvider);
    final bodyMetrics = await ref.read(bodyMetricsServiceProvider).getCarryForward(date);
    return ref.read(metsEstimationServiceProvider).estimate(
          metsFromMetadata: workout.metsFromMetadata,
          activeEnergyKcal: workout.activeEnergyKcal,
          duration: workout.end.difference(workout.start),
          bodyweightKg: bodyMetrics?.weightKg,
          activityType: workout.activityType,
        );
  }

  Future<void> _confirm(BuildContext context, WidgetRef ref, MetsEstimate? estimate) async {
    final date = ref.read(selectedDateProvider);
    await ref.read(activityRepositoryProvider).insert(
          date: date,
          activityName: workout.activityLabel,
          durationMin: workout.durationMin,
          source: ActivitySource.healthkit,
          healthkitUuid: workout.healthkitUuid,
          metsAvg: estimate?.value,
          activeEnergyKcal: workout.activeEnergyKcal,
        );
    ref.invalidate(detectedWorkoutsProvider(date));
  }
}
