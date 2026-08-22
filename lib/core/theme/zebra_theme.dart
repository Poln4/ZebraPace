import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palette ported verbatim from app.py — a muted sage-teal, not bright cyan.
/// Black & white stripes stay for the zebra motif itself; everything else
/// leans warm — cream paper, moss/sand in reserve for charts.
class ZebraColors {
  ZebraColors._();

  static const black = Color(0xFF2B2420); // warm near-black
  static const white = Color(0xFFFFFFFF);
  static const paper = Color(0xFFFFFCF6); // warm off-white for cards/forms
  static const brandTeal = Color(0xFF4A9B8E); // signature accent / primary
  static const teal = Color(0xFF6E8B5E); // secondary accent / chart series
  static const sand = Color(0xFFE8C39E); // tertiary accent / chart series
  static const success = Color(0xFF2F8F5B);
  static const bg = Color(0xFFF6EFE3); // warm cream page background
  static const cardBorder = Color(0xFFE6D9C3);

  static const primary = brandTeal;
  static const accent = sand;

  /// The text color to use on top of any color in this palette used as a
  /// button/badge background. Every palette color below is mid-to-light
  /// luminance, so [black] clears WCAG AA (4.5:1) against all of them —
  /// verified: brandTeal 6.4:1, teal 5.5:1, sand 12.7:1, cardBorder higher
  /// still, destructive red 5.9:1. White text on these same backgrounds
  /// mostly fails AA (e.g. white-on-brandTeal is only 3.3:1) — that gap is
  /// exactly the "can't read the button text" bug this constant fixes.
  static const onColor = black;
}

class ZebraTheme {
  ZebraTheme._();

  static TextTheme _textTheme(Color body, Color heading) {
    return TextTheme(
      displayLarge: GoogleFonts.fraunces(color: heading, fontWeight: FontWeight.w600),
      headlineMedium: GoogleFonts.fraunces(color: heading, fontWeight: FontWeight.w600),
      titleLarge: GoogleFonts.fraunces(color: heading, fontWeight: FontWeight.w600),
      bodyMedium: GoogleFonts.nunito(color: body),
      bodyLarge: GoogleFonts.nunito(color: body),
      labelLarge: GoogleFonts.nunito(color: body, fontWeight: FontWeight.w700),
    );
  }

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: ZebraColors.bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ZebraColors.brandTeal,
          brightness: Brightness.light,
          surface: ZebraColors.paper,
        ),
        textTheme: _textTheme(ZebraColors.black, ZebraColors.black),
        cardTheme: CardThemeData(
          color: ZebraColors.paper,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: ZebraColors.cardBorder),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: ZebraColors.bg,
          foregroundColor: ZebraColors.black,
          elevation: 0,
        ),
      );

  static CupertinoThemeData get cupertino => CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: ZebraColors.brandTeal,
        // CupertinoButton.filled() paints its text in this color. Left
        // unset it defaults to white, which only reaches ~3.3:1 contrast
        // against brandTeal (fails WCAG AA's 4.5:1 for normal text) — black
        // clears 6.4:1. See ZebraColors.onColor.
        primaryContrastingColor: ZebraColors.onColor,
        scaffoldBackgroundColor: ZebraColors.bg,
        barBackgroundColor: ZebraColors.paper,
        textTheme: CupertinoTextThemeData(
          textStyle: GoogleFonts.nunito(color: ZebraColors.black),
          navTitleTextStyle: GoogleFonts.fraunces(
            color: ZebraColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
          navLargeTitleTextStyle: GoogleFonts.fraunces(
            color: ZebraColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 34,
          ),
        ),
      );
}
