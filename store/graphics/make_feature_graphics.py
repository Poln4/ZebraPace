# Google Play feature graphics (1024x500) in en/es/zh from the app icon.
# Needs Pillow. From zebrapace_app/:
#   python3 store/graphics/make_feature_graphics.py assets/icon/app_icon.png assets/google_fonts store/graphics
# icon-512.png is just: sips -z 512 512 assets/icon/app_icon.png --out store/graphics/icon-512.png
import sys
from PIL import Image, ImageChops, ImageDraw, ImageFont
icon_path, fonts, out_dir = sys.argv[1], sys.argv[2], sys.argv[3]
W, H = 1024, 500
bg = (0xF6, 0xEF, 0xE3)          # app background (ZebraColors.bg)
ink = (0x2B, 0x24, 0x20)
teal = (0x2F, 0x6F, 0x65)
icon = Image.open(icon_path).convert('RGB').resize((470, 470), Image.LANCZOS)
# the drawing's paper is near-white, not white: lift it to pure white so
# no square edge shows once it's multiplied onto the cream
icon = icon.point(lambda v: 255 if v > 225 else min(255, int(v * 255 / 225)))
taglines = {
    'en': ('Pace your energy.', 'Rest counts too.'),
    'es': ('Dosifica tu energía.', 'Descansar también cuenta.'),
    'zh': ('調配你的體力。', '休息也算數。'),
}
title_font = ImageFont.truetype(f'{fonts}/Fraunces-SemiBold.ttf', 92)
for lang, (l1, l2) in taglines.items():
    img = Image.new('RGB', (W, H), bg)
    # multiply: the icon's white paper disappears into the cream, ink stays
    tile = Image.new('RGB', icon.size, bg)
    img.paste(ImageChops.multiply(tile, icon), (40, 15))
    d = ImageDraw.Draw(img)
    x = 530
    d.text((x, 150), 'ZebraPace', font=title_font, fill=ink)
    font_file = '/System/Library/Fonts/STHeiti Medium.ttc' if lang == 'zh' else f'{fonts}/Nunito-Regular.ttf'
    size = 40
    while True:  # shrink until both lines keep a 40 px right margin
        f = ImageFont.truetype(font_file, size)
        if max(d.textlength(l, font=f) for l in (l1, l2)) <= W - x - 4 - 40 or size <= 28:
            break
        size -= 1
    d.text((x + 4, 275), l1, font=f, fill=teal)
    d.text((x + 4, 328), l2, font=f, fill=teal)
    img.save(f'{out_dir}/feature-{lang}.png', optimize=True)
