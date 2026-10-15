import 'package:flutter/cupertino.dart';

import '../../data/healthkit/health_kit_service.dart';
import '../../domain/models/daily_log.dart';
import '../../l10n/app_localizations.dart';

/// "From Apple Health · Edit" under a value that syncs from Health. Editing
/// is the secondary path; once edited, "Use Health value" hands it back.
class HealthSourceRow extends StatelessWidget {
  const HealthSourceRow({
    super.key,
    required this.source,
    required this.onEdit,
    required this.onUseHealth,
  });

  final ValueSource? source;
  final VoidCallback onEdit;
  final VoidCallback onUseHealth;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final edited = source == ValueSource.manual;
    final label = edited
        ? l10n.healthSourceManual
        : usesHealthConnect
            ? l10n.healthSourceHealthConnect
            : l10n.healthSourceAppleHealth;
    const small = TextStyle(fontSize: 12.5);
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
        CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          minimumSize: const Size(0, 30),
          onPressed: onEdit,
          child: Text(l10n.healthEditButton, style: small),
        ),
        if (edited)
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            minimumSize: const Size(0, 30),
            onPressed: onUseHealth,
            child: Text(l10n.healthUseHealthButton, style: small),
          ),
      ],
    );
  }
}
