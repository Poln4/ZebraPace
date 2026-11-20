import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../data/notifications/notification_service.dart';
import '../../../domain/models/reminder_settings.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_providers.dart';
import '../../../providers/reminder_providers.dart';
import '../../widgets/section_card.dart';

/// Settings → Reminders & alerts. Turning anything on is what asks for
/// notification permission; nothing asks on launch.
class RemindersSection extends ConsumerStatefulWidget {
  const RemindersSection({super.key});

  @override
  ConsumerState<RemindersSection> createState() => _RemindersSectionState();
}

class _RemindersSectionState extends ConsumerState<RemindersSection> {
  bool? _permissionGranted;

  @override
  void initState() {
    super.initState();
    _refreshPermission();
  }

  Future<void> _refreshPermission() async {
    final granted = await ref.read(notificationServiceProvider).permissionGranted();
    if (mounted) setState(() => _permissionGranted = granted);
  }

  @override
  Widget build(BuildContext context) {
    if (!NotificationService.supported) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(reminderSettingsProvider).valueOrNull ?? const ReminderSettings();
    final healthEnabled = ref.watch(healthKitEnabledProvider).valueOrNull ?? false;

    return SectionCard(
      title: l10n.remindersSectionTitle,
      caption: l10n.remindersSectionCaption,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (settings.anyEnabled && _permissionGranted == false) ...[
            Text(l10n.remindersPermissionDenied,
                style: const TextStyle(fontSize: 12.5, color: CupertinoColors.destructiveRed)),
            const SizedBox(height: 8),
          ],
          _ToggleRow(
            label: l10n.remindersCheckinToggle,
            caption: l10n.remindersCheckinCaption,
            value: settings.checkinEnabled,
            onChanged: (v) => _save(settings.copyWith(checkinEnabled: v), turningOn: v),
          ),
          if (settings.checkinEnabled)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final minute in settings.checkinMinutes)
                    _TimeChip(
                      label: _format(context, minute),
                      semanticsHint: l10n.remindersRemoveTime,
                      onTap: () => _editCheckinTime(settings, minute),
                    ),
                  if (settings.checkinMinutes.length < ReminderSettings.maxCheckinTimes)
                    _TimeChip(
                      label: '+ ${l10n.remindersAddTime}',
                      onTap: () => _addCheckinTime(settings),
                    ),
                ],
              ),
            ),
          _ToggleRow(
            label: l10n.remindersSorenessToggle,
            caption: l10n.remindersSorenessCaption,
            value: settings.sorenessEnabled,
            time: settings.sorenessEnabled ? _format(context, settings.sorenessMinute) : null,
            onTimeTap: () async {
              final m = await _pickTime(settings.sorenessMinute);
              if (m != null) await _save(settings.copyWith(sorenessMinute: m));
            },
            onChanged: (v) => _save(settings.copyWith(sorenessEnabled: v), turningOn: v),
          ),
          _ToggleRow(
            label: l10n.remindersWeeklyToggle,
            caption: l10n.remindersWeeklyCaption,
            value: settings.weeklyEnabled,
            time: settings.weeklyEnabled ? _format(context, settings.weeklyMinute) : null,
            onTimeTap: () async {
              final m = await _pickTime(settings.weeklyMinute);
              if (m != null) await _save(settings.copyWith(weeklyMinute: m));
            },
            onChanged: (v) => _save(settings.copyWith(weeklyEnabled: v), turningOn: v),
          ),
          _ToggleRow(
            label: l10n.remindersPacingToggle,
            caption: healthEnabled ? l10n.remindersPacingCaption : l10n.remindersPacingNeedsHealth,
            value: settings.pacingEnabled && healthEnabled,
            onChanged: healthEnabled
                ? (v) async {
                    if (v) await ref.read(healthKitServiceProvider).requestBackgroundRead();
                    await _save(settings.copyWith(pacingEnabled: v), turningOn: v);
                  }
                : null,
          ),
        ],
      ),
    );
  }

  Future<void> _save(ReminderSettings next, {bool turningOn = false}) async {
    if (turningOn) {
      final granted = await ref.read(notificationServiceProvider).requestPermission();
      if (mounted) setState(() => _permissionGranted = granted);
    }
    await saveReminderSettings(ref, next);
  }

  Future<void> _addCheckinTime(ReminderSettings settings) async {
    final last = settings.checkinMinutes.isEmpty ? 12 * 60 : settings.checkinMinutes.last;
    final m = await _pickTime((last + 120) % (24 * 60));
    if (m == null) return;
    await _save(settings.copyWith(checkinMinutes: [...settings.checkinMinutes, m]));
  }

  /// Tapping an existing time offers to change or remove it.
  Future<void> _editCheckinTime(ReminderSettings settings, int minute) async {
    final l10n = AppLocalizations.of(context);
    final choice = await showCupertinoModalPopup<String>(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: Text(_format(context, minute)),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(ctx, 'edit'),
            child: Text(l10n.commonEditButton),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(ctx, 'remove'),
            child: Text(l10n.remindersRemoveTime),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(ctx),
          child: Text(l10n.commonCancelButton),
        ),
      ),
    );
    final others = settings.checkinMinutes.where((m) => m != minute).toList();
    if (choice == 'remove') {
      await _save(settings.copyWith(
        checkinMinutes: others,
        checkinEnabled: others.isNotEmpty,
      ));
    } else if (choice == 'edit') {
      final m = await _pickTime(minute);
      if (m != null) await _save(settings.copyWith(checkinMinutes: [...others, m]));
    }
  }

  Future<int?> _pickTime(int initialMinute) async {
    final l10n = AppLocalizations.of(context);
    var picked = initialMinute;
    final now = DateTime.now();
    final confirmed = await showCupertinoModalPopup<bool>(
      context: context,
      builder: (ctx) => Container(
        height: 300,
        color: CupertinoColors.systemBackground.resolveFrom(ctx),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: Text(l10n.remindersTimeDone,
                      style: const TextStyle(color: ZebraColors.black, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  minuteInterval: 5,
                  initialDateTime: DateTime(
                      now.year, now.month, now.day, initialMinute ~/ 60, initialMinute % 60 ~/ 5 * 5),
                  onDateTimeChanged: (d) => picked = d.hour * 60 + d.minute,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return confirmed == true ? picked : null;
  }

  String _format(BuildContext context, int minute) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final now = DateTime.now();
    return DateFormat.jm(locale)
        .format(DateTime(now.year, now.month, now.day, minute ~/ 60, minute % 60));
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.label,
    required this.caption,
    required this.value,
    required this.onChanged,
    this.time,
    this.onTimeTap,
  });

  final String label;
  final String caption;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? time;
  final VoidCallback? onTimeTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(caption,
                    style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
                if (time != null) ...[
                  const SizedBox(height: 6),
                  _TimeChip(label: time!, onTap: onTimeTap ?? () {}),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          CupertinoSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _TimeChip extends StatelessWidget {
  const _TimeChip({required this.label, required this.onTap, this.semanticsHint});

  final String label;
  final VoidCallback onTap;
  final String? semanticsHint;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      hint: semanticsHint,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: ZebraColors.cardBorder),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(label, style: const TextStyle(fontSize: 13, color: ZebraColors.black)),
        ),
      ),
    );
  }
}
