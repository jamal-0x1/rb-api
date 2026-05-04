import { Injectable } from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';

export type SortKey = 'latest' | 'oldest' | 'price-asc' | 'price-desc';

export type ProductFilter = {
  tag?: string;
  tags?: string[];
  categoryId?: string;
  categoryIds?: string[];
  sizes?: string[];
  colors?: string[];
  minPrice?: number;
  maxPrice?: number;
  inStock?: boolean;
  sort?: SortKey;
  limit?: number;
};

@Injectable()
export class ProductsService {
  constructor(private readonly prisma: PrismaService) {}

  private buildWhere(opts: ProductFilter): Prisma.ProductWhereInput {
    const where: Prisma.ProductWhereInput = { active: true };

    const catIds = [
      ...(opts.categoryId ? [opts.categoryId] : []),
      ...(opts.categoryIds ?? []),
    ].filter(Boolean);
    if (catIds.length > 0) where.categoryId = { in: catIds };

    const tagNames = [
      ...(opts.tag ? [opts.tag] : []),
      ...(opts.tags ?? []),
    ].filter(Boolean);
    if (tagNames.length > 0) {
      where.tags = { some: { tag: { name: { in: tagNames } } } };
    }

    const variantClauses: Prisma.ProductVariantWhereInput[] = [];
    if (opts.sizes && opts.sizes.length > 0) {
      variantClauses.push({ size: { in: opts.sizes } });
    }
    if (opts.colors && opts.colors.length > 0) {
      variantClauses.push({ color: { in: opts.colors } });
    }
    if (opts.inStock) {
      variantClauses.push({
        inventory: { is: { quantityOnHand: { gt: 0 } } },
      });
    }
    if (variantClauses.length > 0) {
      where.variants = { some: { AND: variantClauses } };
    }

    if (opts.minPrice !== undefined || opts.maxPrice !== undefined) {
      where.basePrice = {
        ...(opts.minPrice !== undefined ? { gte: opts.minPrice } : {}),
        ...(opts.maxPrice !== undefined ? { lte: opts.maxPrice } : {}),
      };
    }

    return where;
  }

  private buildOrderBy(sort?: SortKey): Prisma.ProductOrderByWithRelationInput {
    switch (sort) {
      case 'oldest':
        return { createdAt: 'asc' };
      case 'price-asc':
        return { basePrice: 'asc' };
      case 'price-desc':
        return { basePrice: 'desc' };
      case 'latest':
      default:
        return { createdAt: 'desc' };
    }
  }

  findAll(opts: ProductFilter = {}) {
    return this.prisma.product.findMany({
      where: this.buildWhere(opts),
      include: {
        images: { orderBy: [{ isPrimary: 'desc' }, { sortOrder: 'asc' }] },
        variants: true,
        category: true,
        tags: { include: { tag: true } },
      },
      take: opts.limit,
      orderBy: this.buildOrderBy(opts.sort),
    });
  }

  async facets() {
    const products = await this.prisma.product.findMany({
      where: { active: true },
      select: {
        basePrice: true,
        categoryId: true,
        category: { select: { id: true, name: true, slug: true } },
        variants: { select: { size: true, color: true } },
        tags: { include: { tag: { select: { name: true } } } },
      },
    });

    const categoryMap = new Map<
      string,
      { id: string; name: string; slug: string; count: number }
    >();
    const sizeMap = new Map<string, number>();
    const colorMap = new Map<string, number>();
    const tagMap = new Map<string, number>();
    let minPrice = Number.POSITIVE_INFINITY;
    let maxPrice = 0;

    for (const p of products) {
      if (p.category) {
        const prev = categoryMap.get(p.category.id);
        categoryMap.set(p.category.id, {
          id: p.category.id,
          name: p.category.name,
          slug: p.category.slug,
          count: (prev?.count ?? 0) + 1,
        });
      }
      const price = Number(p.basePrice);
      if (Number.isFinite(price)) {
        if (price < minPrice) minPrice = price;
        if (price > maxPrice) maxPrice = price;
      }
      const sizesOnProduct = new Set<string>();
      const colorsOnProduct = new Set<string>();
      for (const v of p.variants) {
        if (v.size) sizesOnProduct.add(v.size);
        if (v.color) colorsOnProduct.add(v.color);
      }
      sizesOnProduct.forEach((s) =>
        sizeMap.set(s, (sizeMap.get(s) ?? 0) + 1),
      );
      colorsOnProduct.forEach((c) =>
        colorMap.set(c, (colorMap.get(c) ?? 0) + 1),
      );
      for (const t of p.tags) {
        const name = t.tag.name;
        tagMap.set(name, (tagMap.get(name) ?? 0) + 1);
      }
    }

    if (!Number.isFinite(minPrice)) minPrice = 0;

    return {
      categories: Array.from(categoryMap.values()).sort((a, b) =>
        a.name.localeCompare(b.name),
      ),
      sizes: Array.from(sizeMap.entries())
        .map(([value, count]) => ({ value, count }))
        .sort((a, b) => a.value.localeCompare(b.value)),
      colors: Array.from(colorMap.entries())
        .map(([value, count]) => ({ value, count }))
        .sort((a, b) => a.value.localeCompare(b.value)),
      tags: Array.from(tagMap.entries())
        .map(([value, count]) => ({ value, count }))
        .sort((a, b) => a.value.localeCompare(b.value)),
      priceRange: {
        min: Math.floor(minPrice),
        max: Math.ceil(maxPrice),
      },
    };
  }

  findOne(id: string) {
    return this.prisma.product.findUnique({
      where: { id },
      include: {
        images: { orderBy: [{ isPrimary: 'desc' }, { sortOrder: 'asc' }] },
        variants: true,
        category: true,
        tags: { include: { tag: true } },
      },
    });
  }

  findBySlug(slug: string) {
    return this.prisma.product.findUnique({
      where: { slug },
      include: {
        images: { orderBy: [{ isPrimary: 'desc' }, { sortOrder: 'asc' }] },
        variants: true,
        category: true,
        tags: { include: { tag: true } },
      },
    });
  }

  create(data: Prisma.ProductCreateInput) {
    return this.prisma.product.create({ data });
  }

  update(id: string, data: Prisma.ProductUpdateInput) {
    return this.prisma.product.update({ where: { id }, data });
  }

  remove(id: string) {
    return this.prisma.product.delete({ where: { id } });
  }
}
