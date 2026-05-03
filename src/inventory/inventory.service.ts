import { Injectable } from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class InventoryService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.inventory.findMany();
  }

  findOne(id: string) {
    return this.prisma.inventory.findUnique({ where: { id } });
  }

  create(data: Prisma.InventoryCreateInput) {
    return this.prisma.inventory.create({ data });
  }

  update(id: string, data: Prisma.InventoryUpdateInput) {
    return this.prisma.inventory.update({ where: { id }, data });
  }

  remove(id: string) {
    return this.prisma.inventory.delete({ where: { id } });
  }
}
