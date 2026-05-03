import { Injectable } from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class WishlistsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.wishlist.findMany();
  }

  findOne(id: string) {
    return this.prisma.wishlist.findUnique({ where: { id } });
  }

  create(data: Prisma.WishlistCreateInput) {
    return this.prisma.wishlist.create({ data });
  }

  update(id: string, data: Prisma.WishlistUpdateInput) {
    return this.prisma.wishlist.update({ where: { id }, data });
  }

  remove(id: string) {
    return this.prisma.wishlist.delete({ where: { id } });
  }
}
