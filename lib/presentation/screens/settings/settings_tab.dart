import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/defaults.dart';
import '../../../core/theme/zebra_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_providers.dart';
import '../../../providers/auth_providers.dart';
import '../../../providers/cloud_sync_providers.dart';
import '../../../providers/locale_providers.dart';
import '../../../providers/text_scale_providers.dart';
import '../../widgets/kofi_support_button.dart';
import '../../widgets/section_card.dart';
import '../welcome/welcome_screen.dart';

class SettingsTab extends ConsumerStatefulWidget {
  const SettingsTab({super.key});

  @override
  ConsumerState<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends ConsumerState<SettingsTab> {
  final _growthGoalController = TextEditingController();
  final _cautionController = TextEditingController();
  final _comfortController = TextEditingController();
  final _waterGoalController = TextEditingController();
  final _proteinGoalController = TextEditingController();
  final _locationSearchController = TextEditingController();
  final _locationNameController = TextEditingController();
  final _latController = TextEditingController();
  final _lonController = TextEditingController();
  bool _loaded = false;
  bool _confirmDelete = false;
  bool _geocoding = false;
  bool _replaceOnImport = false;
  String? _statusMessage;

  @override
  void dispose() {
    _growthGoalController.dispose();
    _cautionController.dispose();
    _comfortController.dispose();
    _waterGoalController.dispose();
    _proteinGoalController.dispose();
    _locationSearchController.dispose();
    _locationNameController.dispose();
    _latController.dispose();
    _lonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settingsAsync = ref.watch(settingsSnapshotProvider);

    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      navigationBar: CupertinoNavigationBar(
        middle: Text(l10n.settingsTabTitle),
        backgroundColor: ZebraColors.paper,
      ),
      child: SafeArea(
        child: settingsAsync.when(
          loading: () => const Center(child: CupertinoActivityIndicator()),
          error: (e, st) => Center(child: Text('$e')),
          data: (settings) {
            if (!_loaded) {
              _loaded = true;
              _growthGoalController.text = settings.growthGoalPct.toString();
              _cautionController.text = settings.cautionPct.toString();
              _comfortController.text = settings.comfortThreshold.toString();
              _waterGoalController.text = settings.waterGoalMl.toString();
              _proteinGoalController.text = settings.proteinGoalG.toString();
              _locationNameController.text = settings.locationName;
              _latController.text = settings.locationLat?.toString() ?? '';
              _lonController.text = settings.locationLon?.toString() ?? '';
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const _LanguageSection(),
                const _TextSizeSection(),
                SectionCard(
                  title: l10n.settingsTabGoalsTitle,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LabeledField(l10n.settingsTabGrowthGoalLabel, _growthGoalController),
                      _LabeledField(l10n.settingsTabCautionMultiplierLabel, _cautionController),
                      _LabeledField(l10n.settingsTabComfortThresholdLabel, _comfortController),
                      _LabeledField(l10n.settingsTabWaterGoalLabel, _waterGoalController),
                      _LabeledField(l10n.settingsTabProteinGoalLabel, _proteinGoalController),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          color: ZebraColors.brandTeal,
                          onPressed: _saveGoals,
                          child: Text(l10n.commonSaveButton,
                              style: const TextStyle(color: ZebraColors.onColor)),
                        ),
                      ),
                    ],
                  ),
                ),
                SectionCard(
                  title: l10n.settingsTabLocationTitle,
                  caption: l10n.settingsTabLocationCaption,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CupertinoTextField(
                              controller: _locationSearchController,
                              placeholder: l10n.settingsTabLocationSearchPlaceholder,
                            ),
                          ),
                          const SizedBox(width: 8),
                          CupertinoButton(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            color: ZebraColors.brandTeal,
                            onPressed: _geocoding ? null : _searchLocation,
                            child: _geocoding
                                ? const CupertinoActivityIndicator()
                                : Text(l10n.settingsTabLocationSearchButton,
                                    style: const TextStyle(color: ZebraColors.onColor)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(l10n.settingsTabLocationManualHint,
                          style: const TextStyle(fontSize: 11.5, color: CupertinoColors.systemGrey)),
                      const SizedBox(height: 6),
                      _LabeledField(l10n.settingsTabLocationNameLabel, _locationNameController,
                          numeric: false),
                      _LabeledField(l10n.settingsTabLatitudeLabel, _latController),
                      _LabeledField(l10n.settingsTabLongitudeLabel, _lonController),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          color: ZebraColors.teal,
                          onPressed: _saveLocation,
                          child: Text(l10n.settingsTabSaveLocationButton,
                              style: const TextStyle(color: ZebraColors.onColor)),
                        ),
                      ),
                    ],
                  ),
                ),
                const _HealthKitSection(),
                const _CloudSyncSection(),
                const _AboutSection(),
                SectionCard(
                  title: l10n.settingsTabAppLockTitle,
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      color: ZebraColors.cardBorder,
                      onPressed: () => ref.read(authProvider.notifier).lock(),
                      child: Text(l10n.settingsTabLockNowButton,
                          style: const TextStyle(color: ZebraColors.black)),
                    ),
                  ),
                ),
                SectionCard(
                  title: l10n.settingsTabDataOwnershipTitle,
                  caption: l10n.settingsTabDataOwnershipCaption,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          color: ZebraColors.brandTeal,
                          onPressed: _exportJson,
                          child: Text(l10n.settingsTabExportJsonButton,
                              style: const TextStyle(color: ZebraColors.onColor)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _replaceOnImport
                                  ? l10n.settingsTabImportModeReplace
                                  : l10n.settingsTabImportModeMerge,
                              style: const TextStyle(fontSize: 12.5),
                            ),
                          ),
                          CupertinoSwitch(
                            value: _replaceOnImport,
                            onChanged: (v) => setState(() => _replaceOnImport = v),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          color: ZebraColors.teal,
                          onPressed: _importJson,
                          child: Text(l10n.settingsTabImportJsonButton,
                              style: const TextStyle(color: ZebraColors.onColor)),
                        ),
                      ),
                      if (_statusMessage != null) ...[
                        const SizedBox(height: 8),
                        Text(_statusMessage!,
                            style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
                      ],
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.settingsTabDeleteLoggedDataLabel,
                              style: const TextStyle(fontSize: 12.5),
                            ),
                          ),
                          CupertinoSwitch(
                            value: _confirmDelete,
                            onChanged: (v) => setState(() => _confirmDelete = v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          color: _confirmDelete
                              ? CupertinoColors.destructiveRed
                              : ZebraColors.cardBorder,
                          onPressed: _confirmDelete ? _deleteAll : null,
                          child: Text(l10n.settingsTabDeleteAllButton,
                              style: const TextStyle(color: ZebraColors.onColor)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _saveGoals() async {
    final repo = ref.read(settingsRepositoryProvider);
    await repo.set(SettingsKeys.growthGoalPct, _growthGoalController.text);
    await repo.set(SettingsKeys.cautionPct, _cautionController.text);
    await repo.set(SettingsKeys.comfortThreshold, _comfortController.text);
    await repo.set(SettingsKeys.waterGoalMl, _waterGoalController.text);
    await repo.set(SettingsKeys.proteinGoalG, _proteinGoalController.text);
  }

  Future<void> _saveLocation() async {
    final repo = ref.read(settingsRepositoryProvider);
    await repo.set(SettingsKeys.locationName, _locationNameController.text);
    await repo.set(SettingsKeys.locationLat, _latController.text);
    await repo.set(SettingsKeys.locationLon, _lonController.text);
  }

  Future<void> _searchLocation() async {
    final l10n = AppLocalizations.of(context);
    final query = _locationSearchController.text.trim();
    if (query.isEmpty) return;
    setState(() => _geocoding = true);
    final result = await ref.read(weatherServiceProvider).geocode(query);
    setState(() {
      _geocoding = false;
      if (result != null) {
        _locationNameController.text = result.displayName;
        _latController.text = result.lat.toString();
        _lonController.text = result.lon.toString();
      } else {
        _statusMessage = l10n.settingsTabLocationNotFound;
      }
    });
  }

  Future<void> _exportJson() async {
    final json = await ref.read(exportImportServiceProvider).exportAllDataJson();
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/zebrapace_export.json');
    await file.writeAsString(json);
    await Share.shareXFiles([XFile(file.path)]);
  }

  Future<void> _importJson() async {
    final l10n = AppLocalizations.of(context);
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    final path = result?.files.single.path;
    if (path == null) return;

    try {
      final content = await File(path).readAsString();
      // Validate it's parseable JSON before handing it to the import service.
      jsonDecode(content);
      await ref
          .read(exportImportServiceProvider)
          .importAllDataJson(content, replace: _replaceOnImport);
      setState(() => _statusMessage = l10n.settingsTabImportComplete);
    } catch (e) {
      setState(() => _statusMessage = l10n.settingsTabImportFailed(e.toString()));
    }
  }

  Future<void> _deleteAll() async {
    await ref.read(exportImportServiceProvider).deleteAllDataExceptSettings();
    setState(() => _confirmDelete = false);
  }
}

/// If permission was already hard-denied, iOS won't let requestAuthorization
/// re-prompt — the only way back in is the Settings app, so this deep-links
/// there rather than silently doing nothing on a second tap.
class _HealthKitSection extends ConsumerWidget {
  const _HealthKitSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // HealthKit only exists on iOS — never show this section on web.
    if (kIsWeb) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context);
    final enabledAsync = ref.watch(healthKitEnabledProvider);
    final enabled = enabledAsync.valueOrNull ?? false;

    return SectionCard(
      title: l10n.settingsTabHealthKitTitle,
      caption: enabled
          ? l10n.settingsTabHealthKitConnectedCaption
          : l10n.settingsTabHealthKitDisconnectedCaption,
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          color: enabled ? ZebraColors.cardBorder : ZebraColors.brandTeal,
          onPressed: () async {
            if (enabled) {
              await launchUrl(Uri.parse('app-settings:'));
            } else {
              await ref.read(healthKitServiceProvider).requestAuthorization();
              ref.invalidate(healthKitEnabledProvider);
            }
          },
          child: Text(
            enabled
                ? l10n.settingsTabHealthKitOpenSettingsButton
                : l10n.settingsTabHealthKitConnectButton,
            style: const TextStyle(color: ZebraColors.onColor),
          ),
        ),
      ),
    );
  }
}

/// Cloud account identity only (Supabase email/magic-link sign-in) — not
/// the local device lock (see `_HealthKitSection`'s sibling `authProvider`
/// usage elsewhere in this file for that). Signing in here doesn't move any
/// data yet; it just connects the account sync will eventually use.
class _CloudSyncSection extends ConsumerStatefulWidget {
  const _CloudSyncSection();

  @override
  ConsumerState<_CloudSyncSection> createState() => _CloudSyncSectionState();
}

class _CloudSyncSectionState extends ConsumerState<_CloudSyncSection> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(cloudUserProvider);
    final authState = ref.watch(cloudAuthControllerProvider);

    if (user != null) {
      return SectionCard(
        title: l10n.settingsTabCloudSyncTitle,
        caption: l10n.settingsTabCloudSyncSignedInAs(user.email ?? ''),
        child: SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            color: ZebraColors.cardBorder,
            onPressed: () => ref.read(cloudAuthControllerProvider.notifier).signOut(),
            child: Text(l10n.settingsTabCloudSyncSignOutButton,
                style: const TextStyle(color: ZebraColors.black)),
          ),
        ),
      );
    }

    final sending = authState.action == CloudAuthAction.sending;
    return SectionCard(
      title: l10n.settingsTabCloudSyncTitle,
      caption: l10n.settingsTabCloudSyncCaption,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoTextField(
            controller: _emailController,
            placeholder: l10n.settingsTabCloudSyncEmailPlaceholder,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.brandTeal,
              onPressed: sending
                  ? null
                  : () => ref
                      .read(cloudAuthControllerProvider.notifier)
                      .sendMagicLink(_emailController.text.trim()),
              child: sending
                  ? const CupertinoActivityIndicator()
                  : Text(l10n.settingsTabCloudSyncSendLinkButton,
                      style: const TextStyle(color: ZebraColors.onColor)),
            ),
          ),
          if (authState.action == CloudAuthAction.linkSent) ...[
            const SizedBox(height: 8),
            Text(l10n.settingsTabCloudSyncLinkSent,
                style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
          ],
          if (authState.action == CloudAuthAction.error) ...[
            const SizedBox(height: 8),
            Text(authState.error ?? '',
                style: const TextStyle(fontSize: 12, color: CupertinoColors.destructiveRed)),
          ],
        ],
      ),
    );
  }
}

/// Revisits the welcome/disclaimer screen (welcome_screen.dart) that
/// otherwise only shows once, on first launch, plus the same optional
/// Ko-fi support link.
class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      title: l10n.settingsTabAboutTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.cardBorder,
              onPressed: () => Navigator.of(context).push(
                CupertinoPageRoute(builder: (_) => const WelcomeScreen()),
              ),
              child: Text(l10n.settingsTabAboutViewWelcomeButton,
                  style: const TextStyle(color: ZebraColors.black)),
            ),
          ),
          const SizedBox(height: 10),
          const KofiSupportButton(),
        ],
      ),
    );
  }
}

class _LanguageSection extends ConsumerWidget {
  const _LanguageSection();

  static const _codes = supportedAppLanguageCodes;

  String _labelFor(AppLocalizations l10n, String code) => switch (code) {
        'en' => l10n.settingsTabLanguageEnglish,
        'es' => l10n.settingsTabLanguageSpanish,
        'zh_TW' => l10n.settingsTabLanguageChineseTaiwan,
        _ => l10n.settingsTabLanguageSystem,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final currentCode = ref.watch(languageCodeProvider).valueOrNull ?? 'system';

    return SectionCard(
      title: l10n.settingsTabLanguageTitle,
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          color: ZebraColors.cardBorder,
          onPressed: () => _showPicker(context, ref, l10n, currentCode),
          child: Text(_labelFor(l10n, currentCode),
              style: const TextStyle(color: ZebraColors.black)),
        ),
      ),
    );
  }

  Future<void> _showPicker(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    String currentCode,
  ) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(l10n.settingsTabLanguageTitle),
        actions: [
          for (final code in _codes)
            CupertinoActionSheetAction(
              onPressed: () {
                ref.read(settingsRepositoryProvider).set(SettingsKeys.languageCode, code);
                Navigator.pop(context);
              },
              isDefaultAction: code == currentCode,
              child: Text(_labelFor(l10n, code)),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancelButton),
        ),
      ),
    );
  }
}

/// Discrete "A" glyphs scaled to each step's relative size — self-explanatory
/// without needing a translated label per step, per WCAG 1.4.4 (resize
/// text). Multiplies on top of the OS/browser's own text-scale setting
/// rather than replacing it — see text_scale_providers.dart.
class _TextSizeSection extends ConsumerWidget {
  const _TextSizeSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final current =
        ref.watch(textScaleFactorProvider).valueOrNull ?? DefaultSettings.textScaleFactor;

    return SectionCard(
      title: l10n.settingsTabTextSizeTitle,
      caption: l10n.settingsTabTextSizeCaption,
      child: CupertinoSlidingSegmentedControl<double>(
        groupValue: textScaleSteps.contains(current) ? current : DefaultSettings.textScaleFactor,
        children: {
          for (final step in textScaleSteps)
            step: Semantics(
              label: l10n.settingsTabTextSizeSemanticLabel((step * 100).round()),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text('A', style: TextStyle(fontSize: 14 * step)),
              ),
            ),
        },
        onValueChanged: (value) {
          if (value == null) return;
          ref
              .read(settingsRepositoryProvider)
              .set(SettingsKeys.textScaleFactor, value.toString());
        },
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField(this.label, this.controller, {this.numeric = true});

  final String label;
  final TextEditingController controller;
  final bool numeric;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
          const SizedBox(height: 4),
          CupertinoTextField(
            controller: controller,
            keyboardType: numeric
                ? const TextInputType.numberWithOptions(decimal: true, signed: true)
                : TextInputType.text,
          ),
        ],
      ),
    );
  }
}
