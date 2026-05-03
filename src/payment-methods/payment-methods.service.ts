import { Injectable } from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class PaymentMethodsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.paymentMethod.findMany();
  }

  findOne(id: string) {
    return this.prisma.paymentMethod.findUnique({ where: { id } });
  }

  create(data: Prisma.PaymentMethodCreateInput) {
    return this.prisma.paymentMethod.create({ data });
  }

  update(id: string, data: Prisma.PaymentMethodUpdateInput) {
    return this.prisma.paymentMethod.update({ where: { id }, data });
  }

  remove(id: string) {
    return this.prisma.paymentMethod.delete({ where: { id } });
  }
}
