import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../../../core/errors/error_reporter.dart';
import '../../../core/theme/zebra_theme.dart';
import '../../../data/plus/revenuecat_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/cloud_sync_providers.dart';
import '../../../providers/plus_providers.dart';
import '../../widgets/section_card.dart';

/// Settings → Zebras+: see plans (RevenueCat paywall), manage an active
/// plan (Customer Center) and restore. Buying needs a cloud account so the
/// plan follows the person to ZebraUp and new phones (business_plan.md
/// §4.1). Hidden where purchases aren't available (web, desktop).
class PlusSection extends ConsumerStatefulWidget {
  const PlusSection({super.key});

  @override
  ConsumerState<PlusSection> createState() => _PlusSectionState();
}

class _PlusSectionState extends ConsumerState<PlusSection> {
  bool _busy = false;
  String? _message;
  bool _messageIsError = false;

  @override
  Widget build(BuildContext context) {
    final service = ref.watch(revenueCatServiceProvider);
    if (!service.available) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final isPlus = ref.watch(isPlusProvider);
    final signedIn = ref.watch(cloudUserProvider) != null;

    return SectionCard(
      title: l10n.plusTitle,
      caption: isPlus ? l10n.plusCaptionActive : l10n.plusCaptionFree,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isPlus && !signedIn)
            Text(l10n.plusNeedsAccount,
                style: const TextStyle(fontSize: 13, color: CupertinoColors.systemGrey))
          else
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                color: isPlus ? ZebraColors.cardBorder : ZebraColors.brandTeal,
                onPressed: _busy ? null : (isPlus ? _manage : _showPaywall),
                child: _busy
                    ? const CupertinoActivityIndicator()
                    : Text(
                        isPlus ? l10n.plusManage : l10n.plusSeePlans,
                        style: TextStyle(
                            color: isPlus ? ZebraColors.black : ZebraColors.onColor),
                      ),
              ),
            ),
          if (signedIn)
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                onPressed: _busy ? null : _restore,
                child: Text(l10n.plusRestore),
              ),
            ),
          if (_message != null)
            Text(
              _message!,
              style: TextStyle(
                fontSize: 12,
                color: _messageIsError
                    ? CupertinoColors.destructiveRed
                    : CupertinoColors.systemGrey,
              ),
            ),
          if (kDebugMode) const _DebugOverride(),
        ],
      ),
    );
  }

  Future<void> _run(Future<void> Function(AppLocalizations l10n) action) async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      await action(l10n);
    } catch (e, st) {
      final failure = purchaseFailureFrom(e);
      if (failure != PurchaseFailure.cancelled) {
        if (failure == PurchaseFailure.other) ErrorReporter.report(e, st, where: 'plusSection');
        _show(_failureText(l10n, failure), error: failure != PurchaseFailure.pending);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _showPaywall() => _run((l10n) async {
        final result = await ref.read(revenueCatServiceProvider).presentPaywall();
        switch (result) {
          case PaywallResult.purchased:
            _show(l10n.plusPurchased);
          case PaywallResult.restored:
            _show(l10n.plusRestored);
          case PaywallResult.error:
            _show(l10n.plusErrorGeneric, error: true);
          case PaywallResult.cancelled:
          case PaywallResult.notPresented:
            break;
        }
      });

  Future<void> _manage() => _run((_) => ref.read(revenueCatServiceProvider).presentCustomerCenter());

  Future<void> _restore() => _run((l10n) async {
        final restored = await ref.read(revenueCatServiceProvider).restore();
        await ref.read(plusEntitlementProvider.notifier).apply(restored);
        _show(restored.isActiveAt(DateTime.now()) ? l10n.plusRestored : l10n.plusRestoreNothing);
      });

  void _show(String text, {bool error = false}) {
    if (!mounted) return;
    setState(() {
      _message = text;
      _messageIsError = error;
    });
  }

  String _failureText(AppLocalizations l10n, PurchaseFailure failure) => switch (failure) {
        PurchaseFailure.network => l10n.plusErrorNetwork,
        PurchaseFailure.pending => l10n.plusPending,
        PurchaseFailure.notAllowed => l10n.plusErrorNotAllowed,
        PurchaseFailure.cancelled || PurchaseFailure.other => l10n.plusErrorGeneric,
      };
}

/// Debug builds only — not translated on purpose.
class _DebugOverride extends ConsumerWidget {
  const _DebugOverride();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final override = ref.watch(plusDebugOverrideProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          const Expanded(child: Text('Debug: force Zebras+', style: TextStyle(fontSize: 12))),
          CupertinoSwitch(
            value: override ?? false,
            onChanged: (v) => ref.read(plusDebugOverrideProvider.notifier).state = v ? true : null,
          ),
        ],
      ),
    );
  }
}
