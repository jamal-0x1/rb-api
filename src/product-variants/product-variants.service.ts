import {
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';
import { CreateProductVariantDto } from './dto/create-product-variant.dto';
import { UpdateProductVariantDto } from './dto/update-product-variant.dto';
import { BulkCreateVariantsDto } from './dto/bulk-create-variants.dto';

const isUniqueViolation = (e: unknown): boolean =>
  e instanceof Prisma.PrismaClientKnownRequestError && e.code === 'P2002';

@Injectable()
export class ProductVariantsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll(productId?: string) {
    return this.prisma.productVariant.findMany({
      where: productId ? { productId } : undefined,
      include: { inventory: true },
    });
  }

  findOne(id: string) {
    return this.prisma.productVariant.findUnique({
      where: { id },
      include: { inventory: true },
    });
  }

  async create(dto: CreateProductVariantDto) {
    try {
      return await this.prisma.productVariant.create({ data: dto });
    } catch (e) {
      if (isUniqueViolation(e)) {
        throw new ConflictException(`SKU "${dto.sku}" already in use.`);
      }
      throw e;
    }
  }

  async update(id: string, dto: UpdateProductVariantDto) {
    try {
      return await this.prisma.productVariant.update({
        where: { id },
        data: dto,
      });
    } catch (e) {
      if (isUniqueViolation(e)) {
        throw new ConflictException(`SKU already in use.`);
      }
      if (
        e instanceof Prisma.PrismaClientKnownRequestError &&
        e.code === 'P2025'
      ) {
        throw new NotFoundException(`Variant ${id} not found.`);
      }
      throw e;
    }
  }

  async remove(id: string) {
    try {
      return await this.prisma.productVariant.delete({ where: { id } });
    } catch (e) {
      if (
        e instanceof Prisma.PrismaClientKnownRequestError &&
        e.code === 'P2025'
      ) {
        throw new NotFoundException(`Variant ${id} not found.`);
      }
      throw e;
    }
  }

  async bulkCreate(productId: string, dto: BulkCreateVariantsDto) {
    const product = await this.prisma.product.findUnique({
      where: { id: productId },
      select: { id: true },
    });
    if (!product) throw new NotFoundException(`Product ${productId} not found.`);

    const skuSet = new Set<string>();
    for (const item of dto.items) {
      if (skuSet.has(item.sku)) {
        throw new ConflictException(`Duplicate SKU "${item.sku}" in payload.`);
      }
      skuSet.add(item.sku);
    }

    try {
      return await this.prisma.$transaction(async (tx) => {
        const results = await Promise.all(
          dto.items.map((item) =>
            tx.productVariant.create({
              data: {
                productId,
                sku: item.sku,
                size: item.size ?? null,
                color: item.color ?? null,
                priceOverride: item.priceOverride ?? null,
                weightGrams: item.weightGrams ?? null,
                inventory: {
                  create: { quantityOnHand: item.quantityOnHand ?? 0 },
                },
              },
              include: { inventory: true },
            }),
          ),
        );
        return results;
      });
    } catch (e) {
      if (isUniqueViolation(e)) {
        throw new ConflictException(
          'One or more SKUs already in use. Bulk aborted.',
        );
      }
      throw e;
    }
  }
}
