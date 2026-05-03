import { Injectable } from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ProductVariantsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.productVariant.findMany();
  }

  findOne(id: string) {
    return this.prisma.productVariant.findUnique({ where: { id } });
  }

  create(data: Prisma.ProductVariantCreateInput) {
    return this.prisma.productVariant.create({ data });
  }

  update(id: string, data: Prisma.ProductVariantUpdateInput) {
    return this.prisma.productVariant.update({ where: { id }, data });
  }

  remove(id: string) {
    return this.prisma.productVariant.delete({ where: { id } });
  }
}
