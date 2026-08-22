import 'package:flutter/cupertino.dart';

import '../../core/theme/zebra_theme.dart';

class SectionCard extends StatefulWidget {
  const SectionCard({
    super.key,
    required this.title,
    required this.child,
    this.caption,
    this.collapsible = false,
    this.initiallyExpanded = true,
  });

  final String title;
  final String? caption;
  final Widget child;

  /// When false (the default, matching every existing call site), the card
  /// behaves exactly as before — title/caption/child always shown, no
  /// toggle. When true, the title row becomes tappable and the child can be
  /// collapsed to just the title — expand state is local UI state only,
  /// not persisted, since it's a per-view convenience, not data.
  final bool collapsible;
  final bool initiallyExpanded;

  @override
  State<SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<SectionCard> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final expanded = !widget.collapsible || _expanded;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ZebraColors.paper,
        border: Border.all(color: ZebraColors.cardBorder),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.collapsible ? () => setState(() => _expanded = !_expanded) : null,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: ZebraColors.black,
                    ),
                  ),
                ),
                if (widget.collapsible)
                  Icon(
                    expanded ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down,
                    size: 18,
                    color: CupertinoColors.systemGrey,
                  ),
              ],
            ),
          ),
          if (expanded && widget.caption != null) ...[
            const SizedBox(height: 4),
            Text(widget.caption!,
                style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
          ],
          if (expanded) ...[
            const SizedBox(height: 10),
            widget.child,
          ],
        ],
      ),
    );
  }
}
