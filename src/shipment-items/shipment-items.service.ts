import { Injectable } from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ShipmentItemsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.shipmentItem.findMany();
  }

  findOne(id: string) {
    return this.prisma.shipmentItem.findUnique({ where: { id } });
  }

  create(data: Prisma.ShipmentItemCreateInput) {
    return this.prisma.shipmentItem.create({ data });
  }

  update(id: string, data: Prisma.ShipmentItemUpdateInput) {
    return this.prisma.shipmentItem.update({ where: { id }, data });
  }

  remove(id: string) {
    return this.prisma.shipmentItem.delete({ where: { id } });
  }
}
