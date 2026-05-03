import * as dotenv from 'dotenv';
import * as bcrypt from 'bcrypt';
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
  await prisma.paymentMethod.deleteMany();
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

  // ---- Categories (tree) ----
  console.log('seeding categories...');
  const apparel = await prisma.category.create({
    data: { name: 'Apparel', slug: 'apparel', sortOrder: 1 },
  });
  const tops = await prisma.category.create({
    data: {
      name: 'Tops',
      slug: 'tops',
      parentId: apparel.id,
      sortOrder: 1,
    },
  });
  const accessories = await prisma.category.create({
    data: { name: 'Accessories', slug: 'accessories', sortOrder: 2 },
  });

  // ---- Tags ----
  console.log('seeding tags...');
  const [tagNew, tagSale, tagOrganic] = await Promise.all([
    prisma.tag.create({ data: { name: 'new' } }),
    prisma.tag.create({ data: { name: 'sale' } }),
    prisma.tag.create({ data: { name: 'organic' } }),
  ]);

  // ---- Products ----
  console.log('seeding products...');
  const tee = await prisma.product.create({
    data: {
      categoryId: tops.id,
      sku: 'TEE-001',
      name: 'Classic Tee',
      slug: 'classic-tee',
      description: 'Soft cotton t-shirt.',
      basePrice: '24.99',
      currency: 'USD',
      images: {
        create: [
          {
            url: 'https://cdn.example.com/tee-001-front.jpg',
            altText: 'Front',
            isPrimary: true,
            sortOrder: 0,
          },
          {
            url: 'https://cdn.example.com/tee-001-back.jpg',
            altText: 'Back',
            sortOrder: 1,
          },
        ],
      },
      variants: {
        create: [
          {
            sku: 'TEE-001-S-BLK',
            size: 'S',
            color: 'Black',
            attributes: { fit: 'regular' },
          },
          {
            sku: 'TEE-001-M-BLK',
            size: 'M',
            color: 'Black',
            attributes: { fit: 'regular' },
          },
          {
            sku: 'TEE-001-L-WHT',
            size: 'L',
            color: 'White',
            priceOverride: '26.99',
            attributes: { fit: 'regular' },
          },
        ],
      },
    },
    include: { variants: true },
  });

  const cap = await prisma.product.create({
    data: {
      categoryId: accessories.id,
      sku: 'CAP-001',
      name: 'Snapback Cap',
      slug: 'snapback-cap',
      description: 'Adjustable snapback.',
      basePrice: '19.99',
      images: {
        create: [
          {
            url: 'https://cdn.example.com/cap-001.jpg',
            altText: 'Cap',
            isPrimary: true,
          },
        ],
      },
      variants: {
        create: [
          { sku: 'CAP-001-OS-NVY', size: 'OS', color: 'Navy' },
          { sku: 'CAP-001-OS-RED', size: 'OS', color: 'Red' },
        ],
      },
    },
    include: { variants: true },
  });

  // ---- ProductTags ----
  await prisma.productTag.createMany({
    data: [
      { productId: tee.id, tagId: tagNew.id },
      { productId: tee.id, tagId: tagOrganic.id },
      { productId: cap.id, tagId: tagSale.id },
    ],
  });

  // ---- Inventory ----
  console.log('seeding inventory...');
  const allVariants = [...tee.variants, ...cap.variants];
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
      code: 'FLAT5',
      discountType: 'fixed',
      discountValue: '5',
      minOrderAmount: '15',
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
            quantity: 2,
            unitPriceSnapshot: '24.99',
          },
          {
            variantId: cap.variants[0].id,
            quantity: 1,
            unitPriceSnapshot: '19.99',
          },
        ],
      },
    },
  });

  // ---- PaymentMethod for Jane ----
  console.log('seeding payment methods...');
  const janePm = await prisma.paymentMethod.create({
    data: {
      userId: jane.id,
      provider: 'stripe',
      providerToken: 'pm_test_jane_visa',
      brand: 'visa',
      last4: '4242',
      expMonth: 12,
      expYear: 2030,
      isDefault: true,
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
      status: 'paid',
      subtotal: '69.97',
      taxAmount: '5.60',
      shippingAmount: '7.00',
      discountAmount: '0',
      grandTotal: '82.57',
      currency: 'USD',
      shippingAddressId: bobAddress!.id,
      billingAddressId: bobAddress!.id,
      items: {
        create: [
          {
            variantId: tee.variants[0].id,
            quantity: 2,
            unitPrice: '24.99',
            lineTotal: '49.98',
            productNameSnapshot: tee.name,
            variantSkuSnapshot: tee.variants[0].sku,
          },
          {
            variantId: cap.variants[1].id,
            quantity: 1,
            unitPrice: '19.99',
            lineTotal: '19.99',
            productNameSnapshot: cap.name,
            variantSkuSnapshot: cap.variants[1].sku,
          },
        ],
      },
    },
    include: { items: true },
  });

  // ---- Payment ----
  console.log('seeding payment...');
  await prisma.payment.create({
    data: {
      orderId: order.id,
      paymentMethodId: null,
      provider: 'stripe',
      providerChargeId: 'ch_test_1001',
      amount: '82.57',
      currency: 'USD',
      status: 'succeeded',
      processedAt: new Date(),
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
      title: 'Love it',
      body: 'Great fit, soft fabric.',
      verifiedPurchase: true,
    },
  });
  await prisma.review.create({
    data: {
      userId: jane.id,
      productId: cap.id,
      rating: 4,
      title: 'Solid cap',
      body: 'Color slightly off but still good.',
    },
  });

  // ---- Wishlist for Jane ----
  console.log('seeding wishlist...');
  await prisma.wishlist.create({
    data: {
      userId: jane.id,
      name: 'Summer picks',
      isPublic: false,
      items: {
        create: [
          { variantId: tee.variants[2].id },
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
