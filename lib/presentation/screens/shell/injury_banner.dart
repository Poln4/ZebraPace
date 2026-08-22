import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/zebra_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_providers.dart';

/// Persistent banner (app2.py): visible regardless of active tab until every
/// active injury is resolved. Deliberately separate from Flare-Day banners —
/// an injury is a discrete, localized, dateable event, not systemic.
class InjuryBanner extends ConsumerWidget {
  const InjuryBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeInjuries = ref.watch(activeInjuriesProvider).valueOrNull ?? const [];
    if (activeInjuries.isEmpty) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context);
    final zoneLabels =
        activeInjuries.map((i) => '${i.zone.label(l10n)} (${i.kind.name})').join(', ');

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: ZebraColors.sand.withValues(alpha: 0.3),
        border: Border.all(color: ZebraColors.cardBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Text('🩹 ', style: TextStyle(fontSize: 14)),
          Expanded(
            child: Text(
              l10n.injuryBannerActiveLabel(zoneLabels),
              style: const TextStyle(fontSize: 12.5, color: ZebraColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
