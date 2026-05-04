import * as dotenv from 'dotenv';
import * as bcrypt from 'bcrypt';
import * as fs from 'fs';
import * as path from 'path';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '../src/generated/prisma/client';

dotenv.config({ path: '.env.local', override: true });
dotenv.config({ path: '.env' });

const adapter = new PrismaPg({
  connectionString: process.env.DATABASE_URL,
});
const prisma = new PrismaClient({ adapter });

async function main() {
  console.log('clearing tables...');
  // delete in dependency order (children first)
  await prisma.wishlistItem.deleteMany();
  await prisma.wishlist.deleteMany();
  await prisma.review.deleteMany();
  await prisma.shipmentItem.deleteMany();
  await prisma.shipment.deleteMany();
  await prisma.payment.deleteMany();
  await prisma.orderItem.deleteMany();
  await prisma.order.deleteMany();
  await prisma.cartItem.deleteMany();
  await prisma.cart.deleteMany();
  await prisma.coupon.deleteMany();
  await prisma.inventory.deleteMany();
  await prisma.productImage.deleteMany();
  await prisma.productTag.deleteMany();
  await prisma.productVariant.deleteMany();
  await prisma.product.deleteMany();
  await prisma.tag.deleteMany();
  await prisma.category.deleteMany();
  await prisma.address.deleteMany();
  await prisma.user.deleteMany();

  // ---- Users ----
  console.log('seeding users...');
  const passwordHash = await bcrypt.hash('password123', 10);
  const [admin, jane, bob] = await Promise.all([
    prisma.user.create({
      data: {
        email: 'admin@orbitalmind.xyz',
        passwordHash,
        firstName: 'Admin',
        lastName: 'User',
        role: 'admin',
        emailVerified: true,
      },
    }),
    prisma.user.create({
      data: {
        email: 'jane@example.com',
        passwordHash,
        firstName: 'Jane',
        lastName: 'Doe',
        role: 'customer',
        emailVerified: true,
      },
    }),
    prisma.user.create({
      data: {
        email: 'bob@example.com',
        passwordHash,
        firstName: 'Bob',
        lastName: 'Smith',
        role: 'customer',
      },
    }),
  ]);

  // ---- Addresses ----
  console.log('seeding addresses...');
  const janeShipping = await prisma.address.create({
    data: {
      userId: jane.id,
      label: 'Home',
      line1: '123 Main St',
      city: 'New York',
      state: 'NY',
      postalCode: '10001',
      country: 'US',
      isDefaultShipping: true,
      isDefaultBilling: true,
    },
  });
  await prisma.address.create({
    data: {
      userId: bob.id,
      label: 'Apt',
      line1: '456 Oak Ave',
      line2: 'Apt 7B',
      city: 'Brooklyn',
      state: 'NY',
      postalCode: '11201',
      country: 'US',
      isDefaultShipping: true,
      isDefaultBilling: true,
    },
  });

  // ---- Categories (top-level for homepage) ----
  console.log('seeding categories...');
  const CATEGORY_IMAGES_SRC = path.resolve(
    __dirname,
    '../../rb-ui/public/images/categories',
  );
  const CATEGORY_STORAGE_ROOT = path.resolve(process.cwd(), 'storage/categories');
  fs.mkdirSync(CATEGORY_STORAGE_ROOT, { recursive: true });

  type SeedCategory = { name: string; slug: string; iconFile: string; sortOrder: number };
  const seedCategories: SeedCategory[] = [
    { name: 'Televisions', slug: 'televisions', iconFile: 'categories-01.png', sortOrder: 1 },
    { name: 'Laptop & PC', slug: 'laptop-pc', iconFile: 'categories-02.png', sortOrder: 2 },
    { name: 'Mobile & Tablets', slug: 'mobile-tablets', iconFile: 'categories-03.png', sortOrder: 3 },
    { name: 'Games & Videos', slug: 'games-videos', iconFile: 'categories-04.png', sortOrder: 4 },
    { name: 'Home Appliances', slug: 'home-appliances', iconFile: 'categories-05.png', sortOrder: 5 },
    { name: 'Health & Sports', slug: 'health-sports', iconFile: 'categories-06.png', sortOrder: 6 },
    { name: 'Watches', slug: 'watches', iconFile: 'categories-07.png', sortOrder: 7 },
  ];

  const categoriesBySlug: Record<string, { id: string }> = {};
  for (const sc of seedCategories) {
    const created = await prisma.category.create({
      data: { name: sc.name, slug: sc.slug, sortOrder: sc.sortOrder },
    });
    const src = path.join(CATEGORY_IMAGES_SRC, sc.iconFile);
    if (fs.existsSync(src)) {
      const destDir = path.join(CATEGORY_STORAGE_ROOT, created.id);
      fs.mkdirSync(destDir, { recursive: true });
      fs.copyFileSync(src, path.join(destDir, sc.iconFile));
      await prisma.category.update({
        where: { id: created.id },
        data: { imageUrl: `/storage/categories/${created.id}/${sc.iconFile}` },
      });
    }
    categoriesBySlug[sc.slug] = { id: created.id };
  }

  // Aliases for product mapping
  const computers = categoriesBySlug['laptop-pc'];
  const phones = categoriesBySlug['mobile-tablets'];
  const wearables = categoriesBySlug['watches'];
  const peripherals = categoriesBySlug['laptop-pc'];
  const networking = categoriesBySlug['laptop-pc'];
  const games = categoriesBySlug['games-videos'];
  const televisions = categoriesBySlug['televisions'];
  const homeAppliances = categoriesBySlug['home-appliances'];
  const healthSports = categoriesBySlug['health-sports'];
  void networking; void wearables; void peripherals;

  // ---- Tags ----
  console.log('seeding tags...');
  const [tagNew, tagSale, tagFeatured] = await Promise.all([
    prisma.tag.create({ data: { name: 'new' } }),
    prisma.tag.create({ data: { name: 'sale' } }),
    prisma.tag.create({ data: { name: 'featured' } }),
  ]);

  // ---- Products (sourced from rb-ui shopData) ----
  console.log('seeding products...');

  const SOURCE_IMAGES = path.resolve(__dirname, '../../rb-ui/public/images/products');
  const STORAGE_ROOT = path.resolve(process.cwd(), 'storage/products');

  type SeedProduct = {
    sourceId: number;
    sku: string;
    name: string;
    slug: string;
    description: string;
    basePrice: string;
    categoryId: string;
    tagIds: string[];
    variants: { sku: string; size?: string; color?: string; priceOverride?: string }[];
  };

  const seedProducts: SeedProduct[] = [
    {
      sourceId: 1,
      sku: 'GP-HV-G69',
      name: 'Havit HV-G69 USB Gamepad',
      slug: 'havit-hv-g69-usb-gamepad',
      description: 'Wired USB gamepad with vibration feedback.',
      basePrice: '3290',
      categoryId: games.id,
      tagIds: [tagSale.id],
      variants: [{ sku: 'GP-HV-G69-BLK', color: 'Black' }],
    },
    {
      sourceId: 2,
      sku: 'IP-14P-128',
      name: 'iPhone 14 Plus 6/128GB',
      slug: 'iphone-14-plus-6-128gb',
      description: 'Apple iPhone 14 Plus with 6GB RAM and 128GB storage.',
      basePrice: '98900',
      categoryId: phones.id,
      tagIds: [tagFeatured.id, tagNew.id],
      variants: [
        { sku: 'IP-14P-128-MID', color: 'Midnight' },
        { sku: 'IP-14P-128-PUR', color: 'Purple' },
      ],
    },
    {
      sourceId: 3,
      sku: 'AP-IMAC-M1-24',
      name: 'Apple iMac M1 24-inch 2021',
      slug: 'apple-imac-m1-24-2021',
      description: 'All-in-one desktop with M1 chip and 24-inch Retina display.',
      basePrice: '149900',
      categoryId: computers.id,
      tagIds: [tagFeatured.id],
      variants: [{ sku: 'AP-IMAC-M1-24-SLV', color: 'Silver' }],
    },
    {
      sourceId: 4,
      sku: 'AP-MBA-M1-256',
      name: 'MacBook Air M1 8/256GB',
      slug: 'macbook-air-m1-8-256gb',
      description: 'Apple MacBook Air with M1 chip, 8GB unified memory, 256GB SSD.',
      basePrice: '109900',
      categoryId: computers.id,
      tagIds: [tagNew.id, tagFeatured.id],
      variants: [
        { sku: 'AP-MBA-M1-256-SG', color: 'Space Gray' },
        { sku: 'AP-MBA-M1-256-SLV', color: 'Silver' },
      ],
    },
    {
      sourceId: 5,
      sku: 'AP-AW-ULTRA',
      name: 'Apple Watch Ultra',
      slug: 'apple-watch-ultra',
      description: 'Rugged titanium Apple Watch built for adventure.',
      basePrice: '89900',
      categoryId: categoriesBySlug['watches'].id,
      tagIds: [tagNew.id, tagFeatured.id],
      variants: [
        { sku: 'AP-AW-ULTRA-41', size: '41mm', color: 'Titanium' },
        { sku: 'AP-AW-ULTRA-45', size: '45mm', color: 'Titanium' },
        { sku: 'AP-AW-ULTRA-49', size: '49mm', color: 'Titanium' },
      ],
    },
    {
      sourceId: 6,
      sku: 'LG-MX3',
      name: 'Logitech MX Master 3 Mouse',
      slug: 'logitech-mx-master-3-mouse',
      description: 'Advanced wireless mouse with MagSpeed scrolling.',
      basePrice: '11900',
      categoryId: peripherals.id,
      tagIds: [tagSale.id, tagFeatured.id],
      variants: [
        { sku: 'LG-MX3-GRP', color: 'Graphite' },
        { sku: 'LG-MX3-PG', color: 'Pale Gray' },
      ],
    },
    {
      sourceId: 7,
      sku: 'AP-IPAD-AIR5-64',
      name: 'Apple iPad Air 5th Gen 64GB',
      slug: 'apple-ipad-air-5-64gb',
      description: 'Apple iPad Air with M1 chip, 10.9-inch Liquid Retina display.',
      basePrice: '64900',
      categoryId: phones.id,
      tagIds: [tagNew.id, tagFeatured.id],
      variants: [
        { sku: 'AP-IPAD-AIR5-64-BLU', color: 'Blue' },
        { sku: 'AP-IPAD-AIR5-64-SG', color: 'Space Gray' },
      ],
    },
    {
      sourceId: 8,
      sku: 'AS-RT-DB',
      name: 'Asus RT Dual Band Router',
      slug: 'asus-rt-dual-band-router',
      description: 'Dual-band Wi-Fi 6 gigabit router with mesh support.',
      basePrice: '14900',
      categoryId: networking.id,
      tagIds: [tagSale.id],
      variants: [{ sku: 'AS-RT-DB-BLK', color: 'Black' }],
    },

    // Televisions
    {
      sourceId: 9,
      sku: 'SM-QLED-55',
      name: 'Samsung 55" QLED 4K Smart TV',
      slug: 'samsung-55-qled-4k-smart-tv',
      description: 'Quantum Dot 4K UHD smart TV with HDR10+ and Tizen OS.',
      basePrice: '129900',
      categoryId: televisions.id,
      tagIds: [tagFeatured.id, tagNew.id],
      variants: [{ sku: 'SM-QLED-55-BLK', size: '55"', color: 'Black' }],
    },
    {
      sourceId: 10,
      sku: 'SN-BR-65',
      name: 'Sony Bravia 65" 4K Google TV',
      slug: 'sony-bravia-65-4k-google-tv',
      description: 'X-Reality PRO 4K HDR LED panel with Google TV.',
      basePrice: '174900',
      categoryId: televisions.id,
      tagIds: [tagFeatured.id],
      variants: [{ sku: 'SN-BR-65-BLK', size: '65"', color: 'Black' }],
    },
    {
      sourceId: 11,
      sku: 'LG-OLED-50',
      name: 'LG OLED 50" Evo C3',
      slug: 'lg-oled-50-evo-c3',
      description: 'Self-lit OLED with α9 AI Processor Gen6 and Dolby Vision.',
      basePrice: '189900',
      categoryId: televisions.id,
      tagIds: [tagNew.id],
      variants: [{ sku: 'LG-OLED-50-BLK', size: '50"', color: 'Black' }],
    },

    // Home Appliances
    {
      sourceId: 12,
      sku: 'XM-AP-4',
      name: 'Xiaomi Smart Air Purifier 4',
      slug: 'xiaomi-smart-air-purifier-4',
      description: 'HEPA H13 filter, OLED display, app-controlled.',
      basePrice: '18900',
      categoryId: homeAppliances.id,
      tagIds: [tagSale.id, tagNew.id],
      variants: [{ sku: 'XM-AP-4-WHT', color: 'White' }],
    },
    {
      sourceId: 13,
      sku: 'PH-AF-XXL',
      name: 'Philips Airfryer XXL Premium',
      slug: 'philips-airfryer-xxl-premium',
      description: 'Twin TurboStar 7.3L air fryer with Smart Sensing.',
      basePrice: '28900',
      categoryId: homeAppliances.id,
      tagIds: [tagFeatured.id],
      variants: [{ sku: 'PH-AF-XXL-BLK', color: 'Black' }],
    },
    {
      sourceId: 14,
      sku: 'DK-AC-15-INV',
      name: 'Daikin 1.5 Ton Inverter AC',
      slug: 'daikin-1-5-ton-inverter-ac',
      description: '5-star inverter split AC with Coanda airflow and PM2.5 filter.',
      basePrice: '64900',
      categoryId: homeAppliances.id,
      tagIds: [tagFeatured.id, tagSale.id],
      variants: [{ sku: 'DK-AC-15-INV-WHT', color: 'White' }],
    },

    // Health & Sports
    {
      sourceId: 15,
      sku: 'XM-MB-8',
      name: 'Xiaomi Mi Band 8',
      slug: 'xiaomi-mi-band-8',
      description: '1.62" AMOLED fitness band with 150+ workout modes.',
      basePrice: '4990',
      categoryId: healthSports.id,
      tagIds: [tagNew.id, tagSale.id],
      variants: [
        { sku: 'XM-MB-8-BLK', color: 'Graphite' },
        { sku: 'XM-MB-8-GLD', color: 'Champagne Gold' },
      ],
    },
    {
      sourceId: 16,
      sku: 'YM-PRO-6MM',
      name: 'Pro TPE Yoga Mat 6mm',
      slug: 'pro-tpe-yoga-mat-6mm',
      description: 'Eco-friendly TPE yoga mat with non-slip texture, carry strap.',
      basePrice: '2490',
      categoryId: healthSports.id,
      tagIds: [tagSale.id],
      variants: [
        { sku: 'YM-PRO-6MM-BLU', color: 'Blue' },
        { sku: 'YM-PRO-6MM-PUR', color: 'Purple' },
      ],
    },
    {
      sourceId: 17,
      sku: 'ADJ-DB-24KG',
      name: 'Adjustable Dumbbell 24kg Pair',
      slug: 'adjustable-dumbbell-24kg-pair',
      description: 'Quick-select adjustable dumbbell pair, 2.5–24kg per side.',
      basePrice: '14900',
      categoryId: healthSports.id,
      tagIds: [tagFeatured.id],
      variants: [{ sku: 'ADJ-DB-24KG-BLK', color: 'Black' }],
    },
  ];

  function copyImages(productId: string, sourceId: number) {
    const candidates = [
      { file: `product-${sourceId}-bg-1.png`, alt: 'Front', isPrimary: true },
      { file: `product-${sourceId}-bg-2.png`, alt: 'Back', isPrimary: false },
      { file: `product-${sourceId}-sm-1.png`, alt: 'Thumb 1', isPrimary: false },
      { file: `product-${sourceId}-sm-2.png`, alt: 'Thumb 2', isPrimary: false },
    ];
    const dest = path.join(STORAGE_ROOT, productId);
    fs.mkdirSync(dest, { recursive: true });
    const records: { url: string; altText: string; isPrimary: boolean; sortOrder: number }[] = [];
    candidates.forEach((c, i) => {
      const src = path.join(SOURCE_IMAGES, c.file);
      if (!fs.existsSync(src)) return;
      fs.copyFileSync(src, path.join(dest, c.file));
      records.push({
        url: `/storage/products/${productId}/${c.file}`,
        altText: c.alt,
        isPrimary: c.isPrimary,
        sortOrder: i,
      });
    });
    return records;
  }

  const createdProducts: Array<{
    id: string;
    name: string;
    sku: string;
    variants: Array<{ id: string; sku: string }>;
  }> = [];

  for (const sp of seedProducts) {
    const product = await prisma.product.create({
      data: {
        categoryId: sp.categoryId,
        sku: sp.sku,
        name: sp.name,
        slug: sp.slug,
        description: sp.description,
        basePrice: sp.basePrice,
        currency: 'BDT',
        variants: { create: sp.variants },
      },
      include: { variants: true },
    });
    const imageRecords = copyImages(product.id, sp.sourceId);
    if (imageRecords.length > 0) {
      await prisma.productImage.createMany({
        data: imageRecords.map((r) => ({ ...r, productId: product.id })),
      });
    }
    if (sp.tagIds.length > 0) {
      await prisma.productTag.createMany({
        data: sp.tagIds.map((tagId) => ({ productId: product.id, tagId })),
      });
    }
    createdProducts.push({
      id: product.id,
      name: product.name,
      sku: product.sku,
      variants: product.variants.map((v) => ({ id: v.id, sku: v.sku })),
    });
  }

  // Aliases for downstream cart/order/review/wishlist seeds
  const tee = createdProducts[1]; // iPhone (used as primary order item)
  const cap = createdProducts[5]; // MX Master mouse

  // ---- Inventory ----
  console.log('seeding inventory...');
  const allVariants = createdProducts.flatMap((p) => p.variants);
  await Promise.all(
    allVariants.map((v, i) =>
      prisma.inventory.create({
        data: {
          variantId: v.id,
          quantityOnHand: 50 + i * 10,
          reorderThreshold: 10,
        },
      }),
    ),
  );

  // ---- Coupons ----
  console.log('seeding coupons...');
  const welcomeCoupon = await prisma.coupon.create({
    data: {
      code: 'WELCOME10',
      discountType: 'percent',
      discountValue: '10',
      minOrderAmount: '20',
      usageLimit: 1000,
      validFrom: new Date(),
      validUntil: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000),
    },
  });
  await prisma.coupon.create({
    data: {
      code: 'FLAT500',
      discountType: 'fixed',
      discountValue: '500',
      minOrderAmount: '2000',
    },
  });

  // ---- Cart for Jane ----
  console.log('seeding cart...');
  const janeCart = await prisma.cart.create({
    data: {
      userId: jane.id,
      couponId: welcomeCoupon.id,
      items: {
        create: [
          {
            variantId: tee.variants[1].id,
            quantity: 1,
            unitPriceSnapshot: '98900',
          },
          {
            variantId: cap.variants[0].id,
            quantity: 1,
            unitPriceSnapshot: '11900',
          },
        ],
      },
    },
  });

  // ---- Order for Bob ----
  console.log('seeding order...');
  const bobAddress = await prisma.address.findFirst({
    where: { userId: bob.id },
  });
  const order = await prisma.order.create({
    data: {
      userId: bob.id,
      orderNumber: 'ORD-1001',
      status: 'delivered',
      subtotal: '209700',
      taxAmount: '15728',
      shippingAmount: '500',
      discountAmount: '0',
      grandTotal: '225928',
      currency: 'BDT',
      shippingAddressId: bobAddress!.id,
      billingAddressId: bobAddress!.id,
      items: {
        create: [
          {
            variantId: tee.variants[0].id,
            quantity: 2,
            unitPrice: '98900',
            lineTotal: '197800',
            productNameSnapshot: tee.name,
            variantSkuSnapshot: tee.variants[0].sku,
          },
          {
            variantId: cap.variants[1].id,
            quantity: 1,
            unitPrice: '11900',
            lineTotal: '11900',
            productNameSnapshot: cap.name,
            variantSkuSnapshot: cap.variants[1].sku,
          },
        ],
      },
    },
    include: { items: true },
  });

  // ---- Payment (cash on delivery) ----
  console.log('seeding payment...');
  await prisma.payment.create({
    data: {
      orderId: order.id,
      method: 'cod',
      amount: '225928',
      currency: 'BDT',
      status: 'collected',
      collectedAt: new Date(),
      notes: 'Collected on delivery',
    },
  });

  // ---- Shipment ----
  console.log('seeding shipment...');
  const shipment = await prisma.shipment.create({
    data: {
      orderId: order.id,
      carrier: 'UPS',
      trackingNumber: '1Z999AA10123456784',
      status: 'shipped',
      shippedAt: new Date(),
    },
  });
  await prisma.shipmentItem.createMany({
    data: order.items.map((it) => ({
      shipmentId: shipment.id,
      orderItemId: it.id,
      quantity: it.quantity,
    })),
  });

  // ---- Review ----
  console.log('seeding reviews...');
  await prisma.review.create({
    data: {
      userId: bob.id,
      productId: tee.id,
      orderItemId: order.items[0].id,
      rating: 5,
      title: 'Worth every taka',
      body: 'Display is gorgeous, battery lasts a full day.',
      verifiedPurchase: true,
    },
  });
  await prisma.review.create({
    data: {
      userId: jane.id,
      productId: cap.id,
      rating: 4,
      title: 'Smooth scrolling',
      body: 'MagSpeed wheel is genuinely useful — minor learning curve.',
    },
  });

  // ---- Wishlist for Jane ----
  console.log('seeding wishlist...');
  await prisma.wishlist.create({
    data: {
      userId: jane.id,
      name: 'Wishlist',
      isPublic: false,
      items: {
        create: [
          { variantId: createdProducts[0].variants[0].id },
          { variantId: createdProducts[4].variants[0].id },
          { variantId: cap.variants[0].id },
        ],
      },
    },
  });

  console.log('done.');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
