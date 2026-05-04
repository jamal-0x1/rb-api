import { Injectable } from '@nestjs/common';
import { unlink } from 'fs/promises';
import { join } from 'path';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ProductImagesService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.productImage.findMany();
  }

  findOne(id: string) {
    return this.prisma.productImage.findUnique({ where: { id } });
  }

  create(data: Prisma.ProductImageCreateInput) {
    return this.prisma.productImage.create({ data });
  }

  update(id: string, data: Prisma.ProductImageUpdateInput) {
    return this.prisma.productImage.update({ where: { id }, data });
  }

  async remove(id: string) {
    const row = await this.prisma.productImage.findUnique({ where: { id } });
    const deleted = await this.prisma.productImage.delete({ where: { id } });
    if (row?.url?.startsWith('/storage/')) {
      const filePath = join(process.cwd(), row.url.replace(/^\//, ''));
      await unlink(filePath).catch(() => undefined);
    }
    return deleted;
  }
}
