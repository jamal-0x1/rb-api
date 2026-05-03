import { Injectable } from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class CartsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.cart.findMany();
  }

  findOne(id: string) {
    return this.prisma.cart.findUnique({ where: { id } });
  }

  create(data: Prisma.CartCreateInput) {
    return this.prisma.cart.create({ data });
  }

  update(id: string, data: Prisma.CartUpdateInput) {
    return this.prisma.cart.update({ where: { id }, data });
  }

  remove(id: string) {
    return this.prisma.cart.delete({ where: { id } });
  }
}
