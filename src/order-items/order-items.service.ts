import { Injectable } from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class OrderItemsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.orderItem.findMany();
  }

  findOne(id: string) {
    return this.prisma.orderItem.findUnique({ where: { id } });
  }

  create(data: Prisma.OrderItemCreateInput) {
    return this.prisma.orderItem.create({ data });
  }

  update(id: string, data: Prisma.OrderItemUpdateInput) {
    return this.prisma.orderItem.update({ where: { id }, data });
  }

  remove(id: string) {
    return this.prisma.orderItem.delete({ where: { id } });
  }
}
