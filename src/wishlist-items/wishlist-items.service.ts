import { Injectable } from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class WishlistItemsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.wishlistItem.findMany();
  }

  findOne(id: string) {
    return this.prisma.wishlistItem.findUnique({ where: { id } });
  }

  create(data: Prisma.WishlistItemCreateInput) {
    return this.prisma.wishlistItem.create({ data });
  }

  update(id: string, data: Prisma.WishlistItemUpdateInput) {
    return this.prisma.wishlistItem.update({ where: { id }, data });
  }

  remove(id: string) {
    return this.prisma.wishlistItem.delete({ where: { id } });
  }
}
