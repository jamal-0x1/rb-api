import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '../src/generated/prisma/client';
import * as fs from 'fs';
import * as path from 'path';

const connectionString = process.env.DATABASE_URL;
if (!connectionString) {
  throw new Error('DATABASE_URL is not set');
}

const prisma = new PrismaClient({
  adapter: new PrismaPg({ connectionString }),
});

const CANDIDATE_SOURCES = [
  process.env.SEED_IMAGES_SOURCE,
  path.resolve(__dirname, '../seed-images'),
  path.resolve(__dirname, 'seed-source-images'),
  path.resolve(__dirname, '../../rb-ui/public/images/products'),
].filter((p): p is string => !!p);

const SOURCE_IMAGES = CANDIDATE_SOURCES.find((p) => fs.existsSync(p));
if (!SOURCE_IMAGES) {
  throw new Error(
    `no source-image dir found. tried: ${CANDIDATE_SOURCES.join(', ')}`,
  );
}
console.log(`source images: ${SOURCE_IMAGES}`);

const STORAGE_ROOT = path.resolve(process.cwd(), 'storage/products');

const REAL_SOURCE_IDS = [1, 2, 3, 4, 5, 6, 7, 8];
const VARIANTS = [
  { suffix: 'bg-1', alt: 'Front', isPrimary: true },
  { suffix: 'bg-2', alt: 'Back', isPrimary: false },
  { suffix: 'sm-1', alt: 'Thumb 1', isPrimary: false },
  { suffix: 'sm-2', alt: 'Thumb 2', isPrimary: false },
];

function pick<T>(arr: T[]): T {
  return arr[Math.floor(Math.random() * arr.length)];
}

async function main() {
  const products = await prisma.product.findMany({ select: { id: true, sku: true, name: true } });
  console.log(`reshuffling images for ${products.length} products...`);

  let totalCopied = 0;
  let totalRows = 0;

  for (const p of products) {
    const sourceId = pick(REAL_SOURCE_IDS);
    const dest = path.join(STORAGE_ROOT, p.id);

    // wipe existing storage dir
    if (fs.existsSync(dest)) {
      for (const f of fs.readdirSync(dest)) {
        fs.unlinkSync(path.join(dest, f));
      }
    } else {
      fs.mkdirSync(dest, { recursive: true });
    }

    // wipe existing image rows
    await prisma.productImage.deleteMany({ where: { productId: p.id } });

    const records: { url: string; altText: string; isPrimary: boolean; sortOrder: number }[] = [];

    for (let i = 0; i < VARIANTS.length; i++) {
      const v = VARIANTS[i];
      const file = `product-${sourceId}-${v.suffix}.png`;
      const src = path.join(SOURCE_IMAGES!, file);
      if (!fs.existsSync(src)) continue;
      const destFile = `${v.suffix}.png`;
      fs.copyFileSync(src, path.join(dest, destFile));
      records.push({
        url: `/storage/products/${p.id}/${destFile}`,
        altText: `${p.name} — ${v.alt}`,
        isPrimary: v.isPrimary,
        sortOrder: i,
      });
      totalCopied += 1;
    }

    if (records.length > 0) {
      await prisma.productImage.createMany({
        data: records.map((r) => ({ ...r, productId: p.id })),
      });
      totalRows += records.length;
    }

    console.log(`  ✓ ${p.sku.padEnd(18)} ← product-${sourceId}-* (${records.length} files)`);
  }

  console.log(`done. files=${totalCopied} rows=${totalRows}`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
