import { Injectable } from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class AddressesService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.address.findMany();
  }

  findOne(id: string) {
    return this.prisma.address.findUnique({ where: { id } });
  }

  create(data: Prisma.AddressCreateInput) {
    return this.prisma.address.create({ data });
  }

  update(id: string, data: Prisma.AddressUpdateInput) {
    return this.prisma.address.update({ where: { id }, data });
  }

  remove(id: string) {
    return this.prisma.address.delete({ where: { id } });
  }
}
