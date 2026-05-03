import { Injectable } from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ShipmentsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.shipment.findMany();
  }

  findOne(id: string) {
    return this.prisma.shipment.findUnique({ where: { id } });
  }

  create(data: Prisma.ShipmentCreateInput) {
    return this.prisma.shipment.create({ data });
  }

  update(id: string, data: Prisma.ShipmentUpdateInput) {
    return this.prisma.shipment.update({ where: { id }, data });
  }

  remove(id: string) {
    return this.prisma.shipment.delete({ where: { id } });
  }
}
