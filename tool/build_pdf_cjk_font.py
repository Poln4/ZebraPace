"""Rebuilds assets/pdf_fonts/NotoSansTC-Regular-subset.ttf, the Chinese
fallback font for the PDFs (lib/core/pdf/pdf_fonts.dart).

Keeps Big5 level 1 (the ~5,400 everyday Traditional characters), Big5
symbols, CJK punctuation, full-width forms and every character in the app's
ARB strings, at Regular weight, as a static TrueType file (the pdf package
can't read variable fonts). Re-run after adding Chinese strings that use a
rare character.

  python3 -m venv /tmp/fontvenv && /tmp/fontvenv/bin/pip install fonttools
  curl -L -o /tmp/NotoSansTC.ttf \
    "https://github.com/google/fonts/raw/main/ofl/notosanstc/NotoSansTC%5Bwght%5D.ttf"
  /tmp/fontvenv/bin/python tool/build_pdf_cjk_font.py /tmp/NotoSansTC.ttf lib/l10n \
    assets/pdf_fonts/NotoSansTC-Regular-subset.ttf

Noto Sans TC is under the SIL Open Font License 1.1
(assets/pdf_fonts/NotoSansTC-OFL.txt). Its only Reserved Font Name is
"Source", which this subset doesn't use.
"""
import sys, json, re
from fontTools.ttLib import TTFont
from fontTools.varLib import instancer
from fontTools import subset

src, arb_dir, out = sys.argv[1], sys.argv[2], sys.argv[3]

chars = set()
# Big5 level 1 (frequent characters, 0xA440–0xC67E) and Big5 symbols (0xA140–0xA3BF).
for lead in range(0xA1, 0xC7):
    for trail in list(range(0x40, 0x7F)) + list(range(0xA1, 0xFF)):
        code = (lead << 8) | trail
        if code < 0xA140 or code > 0xC67E:
            continue
        try:
            chars.add(bytes([lead, trail]).decode('big5'))
        except UnicodeDecodeError:
            pass
# Every character in the app's Chinese strings (and the English/Spanish ones, harmless).
for name in ('app_zh.arb', 'app_en.arb', 'app_es.arb'):
    for v in json.load(open(f'{arb_dir}/{name}', encoding='utf-8')).values():
        if isinstance(v, str):
            chars.update(v)
# CJK punctuation and full-width forms.
chars.update(chr(c) for c in range(0x3000, 0x3040))
chars.update(chr(c) for c in range(0xFF00, 0xFFF0))
cjk = sum(1 for c in chars if 0x4E00 <= ord(c) <= 0x9FFF)
print('characters:', len(chars), 'CJK ideographs:', cjk)

font = TTFont(src)
font = instancer.instantiateVariableFont(font, {'wght': 400})
opts = subset.Options()
opts.layout_features = ['*']
opts.name_IDs = ['*']
opts.notdef_outline = True
opts.hinting = False
sub = subset.Subsetter(opts)
sub.populate(unicodes=[ord(c) for c in chars])
sub.subset(font)
font.flavor = None
font.save(out)
