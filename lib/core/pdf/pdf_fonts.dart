import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;

/// Fonts for every PDF the app makes: the app's own Nunito for Latin text,
/// with Noto Sans TC (a ~2 MB subset, see tool/build_pdf_cjk_font.py) as
/// the fallback for Chinese — in the interface strings and in anything the
/// person typed, whatever language the app is in. The PDF base fonts
/// (Helvetica) have neither Chinese nor characters like "−".
///
/// Bundled, never downloaded. Loaded once and reused.
class PdfFonts {
  PdfFonts._();

  static const nunitoRegular = 'assets/google_fonts/Nunito-Regular.ttf';
  static const nunitoBold = 'assets/google_fonts/Nunito-Bold.ttf';
  static const notoSansTc = 'assets/pdf_fonts/NotoSansTC-Regular-subset.ttf';

  static Future<pw.ThemeData>? _theme;

  static Future<pw.ThemeData> theme() => _theme ??= _load();

  static Future<pw.ThemeData> _load() async {
    try {
      return await _read();
    } catch (_) {
      _theme = null; // a failed load is retried next time, not remembered
      rethrow;
    }
  }

  static Future<pw.ThemeData> _read() async {
    final regular = pw.Font.ttf(await rootBundle.load(nunitoRegular));
    final bold = pw.Font.ttf(await rootBundle.load(nunitoBold));
    final chinese = pw.Font.ttf(await rootBundle.load(notoSansTc));
    return pw.ThemeData.withFont(
      base: regular,
      bold: bold,
      italic: regular,
      boldItalic: bold,
      fontFallback: [chinese],
    );
  }

  /// Neither font has emoji (labels like "🌩️ …", or anything typed), so
  /// they'd print as empty boxes. Removes misc symbols and dingbats
  /// (U+2600–27BF), variation selectors, emoji joiners and combiners
  /// (U+200D, U+20E3), "ℹ" (U+2139) and everything from U+1F000; keeps
  /// punctuation and math signs.
  static String withoutEmoji(String text) => String.fromCharCodes(text.runes.where((r) =>
          !(r >= 0x2600 && r <= 0x27BF) &&
          !(r >= 0xFE00 && r <= 0xFE0F) &&
          r != 0x200D &&
          r != 0x20E3 &&
          r != 0x2139 &&
          r < 0x1F000))
      .replaceAll(RegExp(r'[^\S\n]+'), ' ') // spaces left by removed emoji; keeps line breaks
      .trim();
}
