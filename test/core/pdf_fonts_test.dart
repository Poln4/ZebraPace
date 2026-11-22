import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf/pdf.dart';
import 'package:zebrapace_app/core/pdf/pdf_fonts.dart';

Future<Set<int>> _charsIn(String asset) async =>
    TtfParser(await rootBundle.load(asset)).charToGlyphIndexMap.keys.toSet();

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('every character in the app strings can be printed by the PDF fonts', () async {
    final nunito = await _charsIn(PdfFonts.nunitoRegular);
    final noto = await _charsIn(PdfFonts.notoSansTc);
    final missing = <String, Set<String>>{};
    for (final lang in ['en', 'es', 'zh']) {
      final strings = jsonDecode(File('lib/l10n/app_$lang.arb').readAsStringSync()) as Map;
      for (final entry in strings.entries) {
        final value = entry.value;
        if (value is! String || entry.key.toString().startsWith('@')) continue;
        for (final rune in PdfFonts.withoutEmoji(value).runes) {
          if (rune <= 0x20 || nunito.contains(rune) || noto.contains(rune)) continue;
          missing.putIfAbsent(lang, () => {}).add(String.fromCharCode(rune));
        }
      }
    }
    expect(missing, isEmpty,
        reason: 'Re-run tool/build_pdf_cjk_font.py so the Chinese subset includes these.');
  });

  test('the Chinese subset covers everyday characters', () async {
    final noto = await _charsIn(PdfFonts.notoSansTc);
    for (final c in '王小明散步水療痠痛發作休息謝謝醫生復健'.runes) {
      expect(noto, contains(c), reason: String.fromCharCode(c));
    }
  });

  test('withoutEmoji keeps line breaks in typed text', () {
    expect(PdfFonts.withoutEmoji('First 😊 question\nSecond'), 'First question\nSecond');
  });
}
