import 'package:flutter/cupertino.dart';

import '../../../../core/constants/content.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/section_card.dart';

class PrinciplesExpander extends StatefulWidget {
  const PrinciplesExpander({super.key});

  @override
  State<PrinciplesExpander> createState() => _PrinciplesExpanderState();
}

class _PrinciplesExpanderState extends State<PrinciplesExpander> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      title: l10n.principlesExpanderTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => setState(() => _expanded = !_expanded),
            child: Text(
                _expanded
                    ? l10n.principlesExpanderHideButton
                    : l10n.principlesExpanderShowButton,
                style: const TextStyle(color: ZebraColors.brandTeal, fontSize: 13)),
          ),
          if (_expanded)
            ...adaptiveBodyPrinciples(l10n).map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                      const SizedBox(height: 2),
                      Text(p.fact, style: const TextStyle(fontSize: 12)),
                      const SizedBox(height: 2),
                      Text(p.inspiration,
                          style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                      const SizedBox(height: 2),
                      Text(p.citation,
                          style: const TextStyle(fontSize: 10.5, color: CupertinoColors.systemGrey)),
                    ],
                  ),
                )),
        ],
      ),
    );
  }
}
