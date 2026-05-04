#!/usr/bin/env python3
"""Generate branded placeholder product images for sourceIds 9-17.

Outputs to rb-ui/public/images/products/product-{n}-{variant}.png so seed.ts
can pick them up on next run. Also overwrites existing files in
rb-api/storage/products/{uuid}/ that mirror these source images.
"""

from __future__ import annotations

import os
import sys
from pathlib import Path
from PIL import Image, ImageDraw, ImageFilter, ImageFont

ROOT = Path(__file__).resolve().parent.parent
SOURCE_DIR = ROOT.parent / "rb-ui" / "public" / "images" / "products"
STORAGE_DIR = ROOT / "storage" / "products"

# (sourceId, primary_label, secondary_label, gradient_top, gradient_bottom, accent)
PRODUCTS = [
    (8, "Asus RT", "Wi-Fi 6 Router", (15, 23, 42), (30, 64, 175), (96, 165, 250)),
    (9, "Samsung", "55\" QLED 4K", (17, 24, 39), (88, 28, 135), (217, 70, 239)),
    (10, "Sony Bravia", "65\" 4K Google TV", (10, 10, 35), (30, 27, 75), (167, 139, 250)),
    (11, "LG OLED", "50\" Evo C3", (8, 10, 30), (76, 5, 25), (244, 63, 94)),
    (12, "Xiaomi", "Smart Air Purifier 4", (236, 254, 255), (165, 243, 252), (8, 145, 178)),
    (13, "Philips", "Airfryer XXL Premium", (45, 17, 9), (124, 45, 18), (251, 146, 60)),
    (14, "Daikin", "1.5 Ton Inverter AC", (240, 249, 255), (186, 230, 253), (3, 105, 161)),
    (15, "Xiaomi", "Mi Band 8", (7, 20, 30), (15, 40, 70), (250, 204, 21)),
    (16, "Pro TPE", "Yoga Mat 6mm", (245, 243, 255), (221, 214, 254), (124, 58, 237)),
    (17, "Adjustable", "Dumbbell 24kg Pair", (12, 12, 14), (39, 39, 42), (132, 204, 22)),
]

VARIANTS = [
    ("bg-1", 800, 800),
    ("bg-2", 800, 800),
    ("sm-1", 400, 400),
    ("sm-2", 400, 400),
]


def vertical_gradient(size: tuple[int, int], top: tuple, bottom: tuple) -> Image.Image:
    w, h = size
    base = Image.new("RGB", size, top)
    pixels = base.load()
    for y in range(h):
        t = y / (h - 1)
        r = int(top[0] + (bottom[0] - top[0]) * t)
        g = int(top[1] + (bottom[1] - top[1]) * t)
        b = int(top[2] + (bottom[2] - top[2]) * t)
        for x in range(w):
            pixels[x, y] = (r, g, b)
    return base


def font_path() -> str | None:
    candidates = [
        "/System/Library/Fonts/Supplemental/Arial Bold.ttf",
        "/System/Library/Fonts/Helvetica.ttc",
        "/Library/Fonts/Arial Bold.ttf",
        "/System/Library/Fonts/SFNS.ttf",
    ]
    for p in candidates:
        if os.path.exists(p):
            return p
    return None


def draw_card(
    size: tuple[int, int],
    primary: str,
    secondary: str,
    top: tuple,
    bottom: tuple,
    accent: tuple,
    variant: int,
) -> Image.Image:
    w, h = size
    img = vertical_gradient(size, top, bottom)
    draw = ImageDraw.Draw(img, "RGBA")

    # Determine if dark gradient (light text) or light gradient (dark text)
    avg = (top[0] + top[1] + top[2] + bottom[0] + bottom[1] + bottom[2]) / 6
    is_dark = avg < 128
    text_color = (245, 245, 250) if is_dark else (15, 23, 42)
    label_color = (
        (200, 200, 220) if is_dark else (90, 90, 110)
    )

    # Soft accent orb
    orb_radius = int(min(w, h) * 0.5)
    cx = w * (0.78 if variant % 2 == 0 else 0.22)
    cy = h * (0.28 if variant % 2 == 0 else 0.72)
    orb = Image.new("RGBA", size, (0, 0, 0, 0))
    od = ImageDraw.Draw(orb)
    od.ellipse(
        [cx - orb_radius, cy - orb_radius, cx + orb_radius, cy + orb_radius],
        fill=(accent[0], accent[1], accent[2], 95),
    )
    orb = orb.filter(ImageFilter.GaussianBlur(radius=orb_radius * 0.35))
    img.paste(orb, (0, 0), orb)

    # Secondary accent ring
    ring_r = int(min(w, h) * 0.18)
    rcx = int(w * (0.22 if variant % 2 == 0 else 0.78))
    rcy = int(h * 0.7)
    draw.ellipse(
        [rcx - ring_r, rcy - ring_r, rcx + ring_r, rcy + ring_r],
        outline=(accent[0], accent[1], accent[2], 140),
        width=max(2, int(min(w, h) * 0.005)),
    )

    fp = font_path()
    if fp:
        primary_size = int(min(w, h) * 0.085)
        secondary_size = int(min(w, h) * 0.045)
        sku_size = int(min(w, h) * 0.03)
        primary_font = ImageFont.truetype(fp, primary_size)
        secondary_font = ImageFont.truetype(fp, secondary_size)
        sku_font = ImageFont.truetype(fp, sku_size)
    else:
        primary_font = ImageFont.load_default()
        secondary_font = ImageFont.load_default()
        sku_font = ImageFont.load_default()

    pb = draw.textbbox((0, 0), primary, font=primary_font)
    sb = draw.textbbox((0, 0), secondary, font=secondary_font)
    p_w, p_h = pb[2] - pb[0], pb[3] - pb[1]
    s_w, s_h = sb[2] - sb[0], sb[3] - sb[1]
    gap = int(min(w, h) * 0.022)
    total_h = p_h + gap + s_h
    p_x = (w - p_w) // 2
    p_y = (h - total_h) // 2 - int(min(w, h) * 0.02)
    s_x = (w - s_w) // 2
    s_y = p_y + p_h + gap

    draw.text((p_x, p_y), primary, font=primary_font, fill=text_color)
    draw.text((s_x, s_y), secondary, font=secondary_font, fill=label_color)

    label = f"VARIANT {variant + 1:02d}"
    lb = draw.textbbox((0, 0), label, font=sku_font)
    l_w = lb[2] - lb[0]
    pad_x = int(min(w, h) * 0.025)
    pad_y = int(min(w, h) * 0.01)
    badge_x = (w - l_w) // 2
    badge_y = int(h * 0.86)
    draw.rounded_rectangle(
        [
            badge_x - pad_x,
            badge_y - pad_y,
            badge_x + l_w + pad_x,
            badge_y + (lb[3] - lb[1]) + pad_y * 2,
        ],
        radius=int(min(w, h) * 0.025),
        fill=(accent[0], accent[1], accent[2], 220),
    )
    draw.text((badge_x, badge_y), label, font=sku_font, fill=text_color)

    return img


def main() -> int:
    SOURCE_DIR.mkdir(parents=True, exist_ok=True)
    written = 0
    for entry in PRODUCTS:
        sid, primary, secondary, top, bottom, accent = entry
        for i, (suffix, w, h) in enumerate(VARIANTS):
            img = draw_card((w, h), primary, secondary, top, bottom, accent, i)
            target = SOURCE_DIR / f"product-{sid}-{suffix}.png"
            img.save(target, "PNG", optimize=True)
            written += 1

    # Mirror into storage by re-copying source → existing storage product dirs.
    # The seed maps sourceId → productId via DB, but here we only know source
    # filenames. Find storage subdirs that contain a matching product-{sid}-* file
    # and overwrite.
    if STORAGE_DIR.exists():
        for entry in PRODUCTS:
            sid = entry[0]
            for product_dir in STORAGE_DIR.iterdir():
                if not product_dir.is_dir():
                    continue
                for suffix, _, _ in VARIANTS:
                    name = f"product-{sid}-{suffix}.png"
                    target = product_dir / name
                    src = SOURCE_DIR / name
                    if target.exists() and src.exists():
                        target.write_bytes(src.read_bytes())

    print(f"wrote {written} source images, mirrored into storage")
    return 0


if __name__ == "__main__":
    sys.exit(main())
