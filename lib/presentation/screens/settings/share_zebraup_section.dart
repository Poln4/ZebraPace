import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/shared/shared_container_bridge.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/shared_container_providers.dart';
import '../../widgets/section_card.dart';

/// Settings → ZebraUp: opt-in sharing of ZebraPace's outbox with ZebraUp on
/// the same phone (see SharedOutboxBuilder for exactly what's in it).
class ShareZebraUpSection extends ConsumerWidget {
  const ShareZebraUpSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!SharedContainerBridge.supported) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final on = ref.watch(shareWithZebraUpProvider).valueOrNull ?? false;
    return SectionCard(
      title: l10n.shareZebraUpTitle,
      caption: l10n.shareZebraUpCaption,
      child: Row(
        children: [
          Expanded(
            child: Text(l10n.shareZebraUpToggle,
                style: const TextStyle(fontWeight: FontWeight.w700)),
          ),
          CupertinoSwitch(value: on, onChanged: (v) => setShareWithZebraUp(ref, v)),
        ],
      ),
    );
  }
}
