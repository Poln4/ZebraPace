import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../../core/errors/error_reporter.dart';
import '../../core/theme/zebra_theme.dart';
import '../../data/plus/revenuecat_service.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/cloud_sync_providers.dart';
import '../../providers/plus_providers.dart';

/// Shown when someone taps a Zebras+ view without the plan. Explains
/// what's locked ([message]), then opens the paywall when buying is
/// possible here. Returns true once the plan is active (bought or
/// restored), so the caller can open what was tapped.
Future<bool> openPlusGate(BuildContext context, WidgetRef ref, {required String message}) async {
  final l10n = AppLocalizations.of(context);
  final service = ref.read(revenueCatServiceProvider);
  final signedIn = ref.read(cloudUserProvider) != null;
  final canBuy = service.available && signedIn;

  final reason = !service.available
      ? l10n.plusUnavailableHere
      : (!signedIn ? l10n.plusNeedsAccount : null);

  final proceed = await showCupertinoDialog<bool>(
    context: context,
    builder: (dialogContext) => CupertinoAlertDialog(
      title: Text(l10n.plusTitle),
      content: Text(reason == null ? message : '$message\n\n$reason'),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(canBuy ? l10n.commonCancelButton : l10n.commonOkButton),
        ),
        if (canBuy)
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.plusSeePlans),
          ),
      ],
    ),
  );
  if (proceed != true || !context.mounted) return false;

  try {
    final result = await service.presentPaywall();
    return result == PaywallResult.purchased || result == PaywallResult.restored;
  } catch (e, st) {
    final failure = purchaseFailureFrom(e);
    if (failure == PurchaseFailure.other) ErrorReporter.report(e, st, where: 'plusGate');
    if (failure != PurchaseFailure.cancelled && context.mounted) {
      await showCupertinoDialog<void>(
        context: context,
        builder: (dialogContext) => CupertinoAlertDialog(
          content: Text(switch (failure) {
            PurchaseFailure.network => l10n.plusErrorNetwork,
            PurchaseFailure.pending => l10n.plusPending,
            PurchaseFailure.notAllowed => l10n.plusErrorNotAllowed,
            _ => l10n.plusErrorGeneric,
          }),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.commonOkButton),
            ),
          ],
        ),
      );
    }
    return false;
  }
}

/// What a free user sees in place of a Zebras+ card: what it offers
/// ([teaser]) and a way in. [gateMessage] is shown in the gate dialog.
class PlusLockedTeaser extends ConsumerWidget {
  const PlusLockedTeaser({super.key, required this.teaser, required this.gateMessage});

  final String teaser;
  final String gateMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 2, right: 6),
              child: Icon(CupertinoIcons.lock_fill, size: 14, color: ZebraColors.brandTealText),
            ),
            Expanded(child: Text(teaser)),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            color: ZebraColors.brandTeal,
            onPressed: () => openPlusGate(context, ref, message: gateMessage),
            child: Text(l10n.plusSeePlans, style: const TextStyle(color: ZebraColors.onColor)),
          ),
        ),
      ],
    );
  }
}
