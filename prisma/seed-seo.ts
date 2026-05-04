import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '../src/generated/prisma/client';

const connectionString = process.env.DATABASE_URL;
if (!connectionString) {
  throw new Error('DATABASE_URL is not set');
}

const prisma = new PrismaClient({
  adapter: new PrismaPg({ connectionString }),
});

type SeoPatch = {
  sku: string;
  brand: string;
  mpn: string;
  shortDescription: string;
  metaTitle: string;
  metaDescription: string;
  keywords: string;
};

const PATCHES: SeoPatch[] = [
  {
    sku: 'GP-HV-G69',
    brand: 'Havit',
    mpn: 'HV-G69',
    shortDescription:
      'Wired USB gamepad with dual vibration motors, analog sticks and turbo buttons. Plug-and-play on Windows and Android.',
    metaTitle: 'Havit HV-G69 USB Gamepad in BDT — RB',
    metaDescription:
      'Buy the Havit HV-G69 wired USB gamepad in Bangladesh. Vibration feedback, analog sticks, plug-and-play. Cash on delivery in BDT.',
    keywords:
      'havit gamepad, hv-g69, usb controller, pc gamepad, android gamepad, wired controller bd',
  },
  {
    sku: 'IP-14P-128',
    brand: 'Apple',
    mpn: 'iPhone 14 Plus 128GB',
    shortDescription:
      '6.7" Super Retina XDR display, A15 Bionic chip, dual-camera 12MP system, all-day battery. 6GB RAM, 128GB storage.',
    metaTitle: 'iPhone 14 Plus 128GB price in BD — RB Accessories',
    metaDescription:
      'Apple iPhone 14 Plus 128GB at the best BDT price in Bangladesh. Midnight or Purple. A15 Bionic, 6.7" XDR display. Cash on delivery.',
    keywords:
      'iphone 14 plus, iphone 14+ price bd, iphone 128gb, apple phone bangladesh, midnight, purple, a15 bionic',
  },
  {
    sku: 'AP-IMAC-M1-24',
    brand: 'Apple',
    mpn: 'iMac M1 24" 2021',
    shortDescription:
      'All-in-one desktop with Apple M1 chip, 24-inch 4.5K Retina display, Magic Keyboard and Mouse included.',
    metaTitle: 'Apple iMac M1 24-inch 2021 in Bangladesh — RB',
    metaDescription:
      'Apple iMac M1 24-inch (2021) with 4.5K Retina display, M1 chip, 8GB unified memory. BDT pricing, COD across Bangladesh.',
    keywords:
      'imac m1, apple desktop, all-in-one mac, 24 inch retina, m1 chip computer, mac bd',
  },
  {
    sku: 'AP-MBA-M1-256',
    brand: 'Apple',
    mpn: 'MacBook Air M1 256GB',
    shortDescription:
      'Fanless 13.3" MacBook Air with Apple M1 chip, 8GB unified memory, 256GB SSD and up to 18 hours battery life.',
    metaTitle: 'MacBook Air M1 8/256GB price in BD — RB',
    metaDescription:
      'Apple MacBook Air with M1 chip, 8GB RAM, 256GB SSD. Space Gray or Silver. Fast, fanless, 18-hour battery. Cash on delivery in BDT.',
    keywords:
      'macbook air m1, mba m1 256gb, apple laptop bd, m1 macbook price, space gray, silver mac',
  },
  {
    sku: 'AP-AW-ULTRA',
    brand: 'Apple',
    mpn: 'Apple Watch Ultra Titanium',
    shortDescription:
      'Rugged titanium case, sapphire front, dual-frequency GPS, dive-ready 100m water resistance. 41/45/49mm sizes.',
    metaTitle: 'Apple Watch Ultra Titanium in BDT — RB',
    metaDescription:
      'Apple Watch Ultra in titanium with sapphire crystal, dual-frequency GPS and 100m water resistance. Pick 41mm, 45mm or 49mm.',
    keywords:
      'apple watch ultra, iwatch ultra, titanium watch, dive watch, smartwatch bd, watch 41mm 45mm 49mm',
  },
  {
    sku: 'LG-MX3',
    brand: 'Logitech',
    mpn: 'MX Master 3',
    shortDescription:
      'Advanced wireless mouse with MagSpeed electromagnetic scrolling, 4000 DPI tracking, USB-C fast charging and multi-device pairing.',
    metaTitle: 'Logitech MX Master 3 wireless mouse in BD — RB',
    metaDescription:
      'Logitech MX Master 3 ergonomic wireless mouse with MagSpeed scrolling and 4000 DPI tracking. Graphite or Pale Gray. BDT, COD.',
    keywords:
      'logitech mx master 3, mx master, ergonomic mouse, wireless mouse bd, mx3, logitech mouse price bangladesh',
  },
  {
    sku: 'AP-IPAD-AIR5-64',
    brand: 'Apple',
    mpn: 'iPad Air 5 64GB',
    shortDescription:
      '10.9-inch Liquid Retina display, Apple M1 chip, 12MP cameras, USB-C and all-day battery. 64GB Wi-Fi.',
    metaTitle: 'Apple iPad Air 5th Gen 64GB in BD — RB',
    metaDescription:
      'iPad Air 5th generation with M1 chip, 10.9" Liquid Retina display, USB-C. Blue or Space Gray. BDT pricing, cash on delivery.',
    keywords:
      'ipad air 5, ipad air m1, apple tablet bd, ipad 64gb, ipad air price bangladesh, blue, space gray',
  },
  {
    sku: 'AS-RT-DB',
    brand: 'Asus',
    mpn: 'RT Dual Band Wi-Fi 6',
    shortDescription:
      'Dual-band Wi-Fi 6 (AX) gigabit router with mesh support, AiProtection security and four gigabit LAN ports.',
    metaTitle: 'Asus Wi-Fi 6 Dual-Band Router in Bangladesh — RB',
    metaDescription:
      'Asus dual-band Wi-Fi 6 gigabit router with mesh support and AiProtection. Stable streaming, work-from-home ready. BDT, COD.',
    keywords:
      'asus router, wifi 6 router, dual band router bd, mesh router, gigabit router, ax router',
  },
  {
    sku: 'SM-QLED-55',
    brand: 'Samsung',
    mpn: 'QA55Q60C',
    shortDescription:
      '55-inch Quantum Dot 4K UHD smart TV with HDR10+, Object Tracking Sound Lite and Tizen smart platform.',
    metaTitle: 'Samsung 55" QLED 4K Smart TV in BD — RB',
    metaDescription:
      'Samsung 55-inch QLED 4K smart TV with Quantum Dot, HDR10+ and Tizen OS. Bright, sharp, app-rich. Cash on delivery in Bangladesh.',
    keywords:
      'samsung qled 55, 55 inch tv bd, 4k smart tv, samsung tv price bangladesh, qled 4k uhd, tizen tv',
  },
  {
    sku: 'SN-BR-65',
    brand: 'Sony',
    mpn: 'KD-65X80L',
    shortDescription:
      '65-inch 4K HDR LED panel with Sony X-Reality PRO upscaling, Triluminos Pro and Google TV.',
    metaTitle: 'Sony Bravia 65" 4K Google TV in BD — RB',
    metaDescription:
      'Sony Bravia 65-inch 4K LED with X-Reality PRO upscaling and Google TV. Vibrant colours, smart apps, COD across Bangladesh.',
    keywords:
      'sony bravia 65, 65 inch sony tv, 4k google tv, sony tv price bd, x-reality pro, hdr tv',
  },
  {
    sku: 'LG-OLED-50',
    brand: 'LG',
    mpn: 'OLED50C3PSA',
    shortDescription:
      '50-inch self-lit OLED Evo C3 with α9 AI Processor Gen6, Dolby Vision IQ, Dolby Atmos and webOS 23.',
    metaTitle: 'LG OLED 50" Evo C3 4K TV in Bangladesh — RB',
    metaDescription:
      'LG OLED Evo C3 50-inch with α9 Gen6 AI processor, Dolby Vision IQ and Dolby Atmos. Perfect blacks, infinite contrast.',
    keywords:
      'lg oled 50, oled c3, 4k oled tv bd, dolby vision, lg tv price bangladesh, alpha 9 processor',
  },
  {
    sku: 'XM-AP-4',
    brand: 'Xiaomi',
    mpn: 'Smart Air Purifier 4',
    shortDescription:
      'Smart air purifier with HEPA H13 filter, 400m³/h CADR, OLED display and Mi Home / Google Home control.',
    metaTitle: 'Xiaomi Smart Air Purifier 4 in BD — RB',
    metaDescription:
      'Xiaomi Smart Air Purifier 4 with HEPA H13 filter, OLED display and app control. Cleaner air for Dhaka homes. BDT, COD.',
    keywords:
      'xiaomi air purifier 4, mi air purifier bd, hepa h13, smart air purifier, dhaka air purifier',
  },
  {
    sku: 'PH-AF-XXL',
    brand: 'Philips',
    mpn: 'HD9870 XXL',
    shortDescription:
      '7.3-litre Twin TurboStar airfryer with Smart Sensing technology, Philips fat removal and large family-size basket.',
    metaTitle: 'Philips Airfryer XXL Premium in BD — RB',
    metaDescription:
      'Philips Airfryer XXL Premium 7.3L with Twin TurboStar and Smart Sensing. Cook for the whole family with less oil. BDT, COD.',
    keywords:
      'philips airfryer xxl, philips air fryer bd, hd9870, large air fryer, smart sensing, family air fryer',
  },
  {
    sku: 'DK-AC-15-INV',
    brand: 'Daikin',
    mpn: 'FTKM50UV',
    shortDescription:
      '1.5-ton 5-star inverter split AC with Coanda airflow, PM2.5 filter, Econo mode and copper condenser.',
    metaTitle: 'Daikin 1.5 Ton Inverter Split AC in BD — RB',
    metaDescription:
      'Daikin 5-star 1.5-ton inverter split AC with Coanda airflow and PM2.5 filter. Quiet, efficient cooling for Bangladesh weather.',
    keywords:
      'daikin 1.5 ton inverter, daikin ac bd, split ac, inverter ac price bangladesh, 5 star ac, daikin coanda',
  },
  {
    sku: 'XM-MB-8',
    brand: 'Xiaomi',
    mpn: 'Mi Band 8',
    shortDescription:
      '1.62-inch AMOLED fitness band with 150+ workout modes, heart-rate, SpO2, sleep tracking and 16-day battery life.',
    metaTitle: 'Xiaomi Mi Band 8 fitness tracker in BD — RB',
    metaDescription:
      'Xiaomi Mi Band 8 with 1.62" AMOLED display, 150+ workouts, SpO2 and 16-day battery. Graphite or Champagne Gold. BDT, COD.',
    keywords:
      'xiaomi mi band 8, mi band 8 bd, fitness band, smart band, heart rate tracker, mi band price bangladesh',
  },
  {
    sku: 'YM-PRO-6MM',
    brand: 'Pro',
    mpn: 'TPE Yoga Mat 6mm',
    shortDescription:
      'Eco-friendly 6mm TPE yoga mat with non-slip texture, double-sided grip, carry strap. SGS-tested, latex-free.',
    metaTitle: 'Pro TPE Yoga Mat 6mm in Bangladesh — RB',
    metaDescription:
      'Eco-friendly TPE 6mm yoga mat with non-slip grip and carry strap. Blue or Purple. Comfortable for daily yoga and pilates. BDT, COD.',
    keywords:
      'tpe yoga mat, yoga mat bd, 6mm exercise mat, non-slip yoga mat, yoga mat price bangladesh, fitness mat',
  },
  {
    sku: 'ADJ-DB-24KG',
    brand: 'Generic',
    mpn: 'ADJ-DB-24',
    shortDescription:
      'Adjustable dumbbell pair, 2.5–24 kg per side, quick-select dial, replaces 30+ traditional dumbbells.',
    metaTitle: 'Adjustable Dumbbell 24kg Pair in BD — RB',
    metaDescription:
      'Quick-select adjustable dumbbell pair, 2.5–24kg per side. Saves space, replaces a full rack. Cash on delivery in Bangladesh.',
    keywords:
      'adjustable dumbbell 24kg, dumbbell set bd, gym dumbbell, home gym, weight set, dumbbell price bangladesh',
  },
];

async function main() {
  console.log(`patching ${PATCHES.length} products with SEO fields...`);
  let updated = 0;
  let skipped = 0;
  for (const p of PATCHES) {
    const existing = await prisma.product.findUnique({ where: { sku: p.sku } });
    if (!existing) {
      console.warn(`  skip — no product with sku ${p.sku}`);
      skipped += 1;
      continue;
    }
    await prisma.product.update({
      where: { sku: p.sku },
      data: {
        brand: p.brand,
        mpn: p.mpn,
        condition: 'new',
        shortDescription: p.shortDescription,
        metaTitle: p.metaTitle,
        metaDescription: p.metaDescription,
        keywords: p.keywords,
      },
    });
    updated += 1;
    console.log(`  ✓ ${p.sku} — ${p.brand}`);
  }
  console.log(`done. updated=${updated} skipped=${skipped}`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
