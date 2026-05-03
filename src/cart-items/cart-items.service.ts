import { Injectable } from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class CartItemsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.cartItem.findMany();
  }

  findOne(id: string) {
    return this.prisma.cartItem.findUnique({ where: { id } });
  }

  create(data: Prisma.CartItemCreateInput) {
    return this.prisma.cartItem.create({ data });
  }

  update(id: string, data: Prisma.CartItemUpdateInput) {
    return this.prisma.cartItem.update({ where: { id }, data });
  }

  remove(id: string) {
    return this.prisma.cartItem.delete({ where: { id } });
  }
}
