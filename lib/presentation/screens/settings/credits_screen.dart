import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../core/errors/error_reporter.dart';
import '../../../core/theme/zebra_theme.dart';
import '../../../data/plus/revenuecat_service.dart';
import '../../../domain/services/plus_access.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/cloud_sync_providers.dart';
import '../../../providers/plus_providers.dart';
import '../../widgets/section_card.dart';

/// Settings → Zebras+ → AI credits & sponsoring (business_plan.md §4.5).
/// Both are consumables: the store charges, RevenueCat's webhook tells
/// Supabase, and the balance shown here is read back from Supabase. The
/// phone never adds credits on its own.
class CreditsScreen extends ConsumerStatefulWidget {
  const CreditsScreen({super.key});

  @override
  ConsumerState<CreditsScreen> createState() => _CreditsScreenState();
}

class _CreditsScreenState extends ConsumerState<CreditsScreen> {
  /// Which package is mid-purchase, so only its button spins.
  String? _buying;
  String? _message;
  bool _messageIsError = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final signedIn = ref.watch(cloudUserProvider) != null;
    final packages = ref.watch(consumablePackagesProvider);
    final balance = ref.watch(aiCreditBalanceProvider);

    return CupertinoPageScaffold(
      backgroundColor: ZebraColors.bg,
      navigationBar: CupertinoNavigationBar(middle: Text(l10n.creditsScreenTitle)),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: [
            if (!signedIn)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(l10n.plusNeedsAccount, style: _grey),
              )
            else ...[
              SectionCard(
                title: l10n.creditsTitle,
                caption: l10n.creditsCaption,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    balance.when(
                      data: (n) => Text(
                        l10n.creditsBalance(n ?? 0),
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      loading: () => const CupertinoActivityIndicator(),
                      error: (_, _) => Text(l10n.creditsBalanceError, style: _grey),
                    ),
                    const SizedBox(height: 12),
                    _buyButton(
                      packages,
                      pick: (p) => p.credits,
                      label: (price) => l10n.creditsBuy(PlusConstants.creditsPerPack, price),
                      onBought: _afterCredits,
                    ),
                  ],
                ),
              ),
              SectionCard(
                title: l10n.sponsorTitle,
                caption: l10n.sponsorCaption,
                child: _buyButton(
                  packages,
                  pick: (p) => p.sponsor,
                  label: l10n.sponsorBuy,
                  onBought: () async => _show(l10n.sponsorThanks),
                ),
              ),
              if (_message != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    _message!,
                    style: TextStyle(
                      fontSize: 13,
                      color: _messageIsError
                          ? CupertinoColors.destructiveRed
                          : CupertinoColors.systemGrey,
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  static const _grey = TextStyle(fontSize: 13, color: CupertinoColors.systemGrey);

  Widget _buyButton(
    AsyncValue<ConsumablePackages> packages, {
    required Package? Function(ConsumablePackages) pick,
    required String Function(String price) label,
    required Future<void> Function() onBought,
  }) {
    final l10n = AppLocalizations.of(context);
    return packages.when(
      loading: () => const CupertinoActivityIndicator(),
      error: (_, _) => Text(l10n.consumablesUnavailable, style: _grey),
      data: (p) {
        final package = pick(p);
        if (package == null) return Text(l10n.consumablesUnavailable, style: _grey);
        final busy = _buying == package.identifier;
        return SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            color: ZebraColors.brandTeal,
            onPressed: _buying != null ? null : () => _buy(package, onBought),
            child: busy
                ? const CupertinoActivityIndicator()
                : Text(label(package.storeProduct.priceString),
                    style: const TextStyle(color: ZebraColors.onColor)),
          ),
        );
      },
    );
  }

  Future<void> _buy(Package package, Future<void> Function() onBought) async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _buying = package.identifier;
      _message = null;
    });
    try {
      await ref.read(revenueCatServiceProvider).purchase(package);
      await onBought();
    } catch (e, st) {
      final failure = purchaseFailureFrom(e);
      if (failure != PurchaseFailure.cancelled) {
        if (failure == PurchaseFailure.other) {
          ErrorReporter.report(e, st, where: 'creditsScreen');
        }
        _show(
          switch (failure) {
            PurchaseFailure.network => l10n.plusErrorNetwork,
            PurchaseFailure.pending => l10n.plusPending,
            PurchaseFailure.notAllowed => l10n.plusErrorNotAllowed,
            PurchaseFailure.cancelled || PurchaseFailure.other => l10n.plusErrorGeneric,
          },
          error: failure != PurchaseFailure.pending,
        );
      }
    } finally {
      if (mounted) setState(() => _buying = null);
    }
  }

  /// The webhook usually lands within a few seconds; re-read the balance
  /// until it moves, then stop. If it hasn't by then, say so — it will
  /// show up the next time this screen opens.
  Future<void> _afterCredits() async {
    final l10n = AppLocalizations.of(context);
    final before = ref.read(aiCreditBalanceProvider).valueOrNull ?? 0;
    _show(l10n.creditsArriving);
    for (var i = 0; i < 6 && mounted; i++) {
      await Future<void>.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      ref.invalidate(aiCreditBalanceProvider);
      try {
        final now = await ref.read(aiCreditBalanceProvider.future);
        if ((now ?? 0) > before) {
          _show(l10n.creditsPurchased);
          return;
        }
      } catch (_) {
        // Keep trying; a failed read just shows the error text above.
      }
    }
  }

  void _show(String text, {bool error = false}) {
    if (!mounted) return;
    setState(() {
      _message = text;
      _messageIsError = error;
    });
  }
}
