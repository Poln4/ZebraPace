import 'package:flutter/cupertino.dart';

/// Renders text containing `**bold**` segments (the only markdown the l10n
/// strings use, e.g. monthChapterShowedUp/monthChapterScoreRange) as actual
/// bold spans instead of showing the literal asterisks.
class BoldMarkdownText extends StatelessWidget {
  const BoldMarkdownText(this.text, {super.key, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final boldPattern = RegExp(r'\*\*(.+?)\*\*');
    final spans = <TextSpan>[];
    var cursor = 0;
    for (final match in boldPattern.allMatches(text)) {
      if (match.start > cursor) {
        spans.add(TextSpan(text: text.substring(cursor, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(fontWeight: FontWeight.w700),
      ));
      cursor = match.end;
    }
    if (cursor < text.length) {
      spans.add(TextSpan(text: text.substring(cursor)));
    }
    return Text.rich(TextSpan(style: style, children: spans));
  }
}
