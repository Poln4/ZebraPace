# App Store "Universal" creative asset (product page header + search
# results) in en/es/zh: 5244x2950 PNG, no transparency. Apple crops it per
# device, so the icon and words sit inside the art safe area
# (1402x962 at x 1921, y 660); the soft stripes fill the rest.
# Needs Pillow. From zebrapace_app/:
#   python3 store/graphics/make_app_store_universal.py assets/icon/app_icon.png assets/google_fonts store/graphics
# Writes universal-<lang>.png, plus universal-<lang>-guide.png with the
# safe area outlined (for checking only; don't upload those).
import sys
from PIL import Image, ImageChops, ImageDraw, ImageFilter, ImageFont

icon_path, fonts, out_dir = sys.argv[1], sys.argv[2], sys.argv[3]
W, H = 5244, 2950
SAFE = (1921, 660, 1921 + 1402, 660 + 962)
bg = (0xF6, 0xEF, 0xE3)       # app background (ZebraColors.bg)
stripe = (0xEC, 0xE2, 0xD1)   # a shade darker, so stripes stay quiet
ink = (0x2B, 0x24, 0x20)
teal = (0x2F, 0x6F, 0x65)

taglines = {
    'en': ('Pace your energy.', 'Rest counts too.'),
    'es': ('Dosifica tu energía.', 'Descansar también cuenta.'),
    'zh': ('調配你的體力。', '休息也算數。'),
}


def background():
    img = Image.new('RGB', (W, H), bg)
    d = ImageDraw.Draw(img)
    # wide diagonal zebra stripes across the whole canvas
    step, width = 420, 150
    for x0 in range(-H, W + H, step):
        d.polygon([(x0, 0), (x0 + width, 0), (x0 + width - H // 2, H), (x0 - H // 2, H)], fill=stripe)
    # keep the safe area calm: a soft cream glow behind the art
    glow = Image.new('L', (W, H), 0)
    gd = ImageDraw.Draw(glow)
    pad = 260
    gd.rounded_rectangle((SAFE[0] - pad, SAFE[1] - pad, SAFE[2] + pad, SAFE[3] + pad), radius=400, fill=255)
    glow = glow.filter(ImageFilter.GaussianBlur(220))
    return Image.composite(Image.new('RGB', (W, H), bg), img, glow)


icon = Image.open(icon_path).convert('RGB').resize((480, 480), Image.LANCZOS)
icon = icon.point(lambda v: 255 if v > 225 else min(255, int(v * 255 / 225)))

for lang, (l1, l2) in taglines.items():
    img = background()
    sx0, sy0, sx1, sy1 = SAFE
    # icon on the left of the safe area, vertically centred in it
    ix, iy = sx0 + 10, sy0 + (sy1 - sy0 - icon.height) // 2
    tile = img.crop((ix, iy, ix + icon.width, iy + icon.height))
    img.paste(ImageChops.multiply(tile, icon), (ix, iy))
    d = ImageDraw.Draw(img)
    tx = ix + icon.width + 40
    max_w = sx1 - tx - 20
    ts = 170
    while d.textlength('ZebraPace', font=ImageFont.truetype(f'{fonts}/Fraunces-SemiBold.ttf', ts)) > max_w:
        ts -= 4
    d.text((tx, sy0 + 250), 'ZebraPace', font=ImageFont.truetype(f'{fonts}/Fraunces-SemiBold.ttf', ts), fill=ink)
    font_file = '/System/Library/Fonts/STHeiti Medium.ttc' if lang == 'zh' else f'{fonts}/Nunito-Regular.ttf'
    size = 80
    while True:
        f = ImageFont.truetype(font_file, size)
        if max(d.textlength(l, font=f) for l in (l1, l2)) <= max_w or size <= 40:
            break
        size -= 2
    d.text((tx + 6, sy0 + 500), l1, font=f, fill=teal)
    d.text((tx + 6, sy0 + 500 + int(size * 1.35)), l2, font=f, fill=teal)
    img.save(f'{out_dir}/universal-{lang}.png', optimize=True)

    guide = img.copy()
    ImageDraw.Draw(guide).rectangle(SAFE, outline=(220, 40, 40), width=8)
    guide.resize((W // 4, H // 4), Image.LANCZOS).save(f'{out_dir}/universal-{lang}-guide.png')
print('done')
