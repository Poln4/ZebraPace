import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

import '../../../../core/theme/zebra_theme.dart';

/// How a day went, as a stripe. Drawn rather than typed so every phone
/// shows the same shape (font glyphs like ▬ ┅ ∿ ═ vary in size and width
/// between fonts and often don't line up).
enum DayStripeKind { full, lowDay, floor, rest }

/// Solid = full session, dashed = low day, wave = floor, double line =
/// rest or flare. Every kind uses the same amount of ink, so a rest day
/// never looks lesser than a full one.
class DayStripe extends StatelessWidget {
  const DayStripe({super.key, required this.kind, this.width = 26, this.height = 14});

  final DayStripeKind kind;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _DayStripePainter(kind, ZebraColors.black),
    );
  }
}

class _DayStripePainter extends CustomPainter {
  _DayStripePainter(this.kind, this.color);

  final DayStripeKind kind;
  final Color color;

  static const _stroke = 3.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = _stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    final mid = size.height / 2;
    const inset = _stroke / 2;
    final left = inset;
    final right = size.width - inset;

    switch (kind) {
      case DayStripeKind.full:
        canvas.drawLine(Offset(left, mid), Offset(right, mid), paint);
      case DayStripeKind.lowDay:
        // Three dashes with two equal gaps. Flat ends: round caps would
        // spill into the gaps and make it read as a solid line when small.
        final flat = paint..strokeCap = StrokeCap.butt;
        final dash = (size.width) / 5;
        for (var i = 0; i < 3; i++) {
          final x = i * 2 * dash;
          canvas.drawLine(Offset(x, mid), Offset(x + dash, mid), flat);
        }
      case DayStripeKind.floor:
        final path = Path()..moveTo(left, mid);
        // One full, gentle wave — more crests turn into a scribble at
        // legend size.
        final amp = size.height * 0.26;
        const steps = 32;
        for (var i = 1; i <= steps; i++) {
          final t = i / steps;
          path.lineTo(left + (right - left) * t, mid - amp * math.sin(t * 2 * math.pi));
        }
        canvas.drawPath(path, paint);
      case DayStripeKind.rest:
        // Two lines at half weight each — same total ink as one full line.
        final half = paint..strokeWidth = _stroke / 2;
        final gap = size.height * 0.22;
        canvas.drawLine(Offset(left, mid - gap), Offset(right, mid - gap), half);
        canvas.drawLine(Offset(left, mid + gap), Offset(right, mid + gap), half);
    }
  }

  @override
  bool shouldRepaint(_DayStripePainter old) => old.kind != kind || old.color != color;
}
