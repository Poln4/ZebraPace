import 'package:flutter/cupertino.dart';

import '../../core/theme/zebra_theme.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.title, required this.child, this.caption});

  final String title;
  final String? caption;
  final Widget child;

  @override
  Widget build(BuildContext context) {
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
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: ZebraColors.black,
            ),
          ),
          if (caption != null) ...[
            const SizedBox(height: 4),
            Text(caption!, style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
          ],
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
