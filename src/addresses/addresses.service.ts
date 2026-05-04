import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
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

  // ---- user-scoped ----

  findMine(userId: string) {
    return this.prisma.address.findMany({
      where: { userId },
      orderBy: [
        { isDefaultShipping: 'desc' },
        { isDefaultBilling: 'desc' },
        { createdAt: 'desc' },
      ],
    });
  }

  createForUser(
    userId: string,
    body: {
      label?: string | null;
      line1: string;
      line2?: string | null;
      city: string;
      state?: string | null;
      postalCode: string;
      country: string;
      isDefaultShipping?: boolean;
      isDefaultBilling?: boolean;
    },
  ) {
    return this.prisma.address.create({
      data: {
        user: { connect: { id: userId } },
        label: body.label ?? null,
        line1: body.line1,
        line2: body.line2 ?? null,
        city: body.city,
        state: body.state ?? null,
        postalCode: body.postalCode,
        country: body.country,
        isDefaultShipping: body.isDefaultShipping ?? false,
        isDefaultBilling: body.isDefaultBilling ?? false,
      },
    });
  }

  async updateForUser(
    userId: string,
    id: string,
    body: Prisma.AddressUpdateInput,
  ) {
    const addr = await this.prisma.address.findUnique({ where: { id } });
    if (!addr) throw new NotFoundException('Address not found');
    if (addr.userId !== userId) throw new ForbiddenException();
    return this.prisma.address.update({ where: { id }, data: body });
  }

  async removeForUser(userId: string, id: string) {
    const addr = await this.prisma.address.findUnique({ where: { id } });
    if (!addr) throw new NotFoundException('Address not found');
    if (addr.userId !== userId) throw new ForbiddenException();
    return this.prisma.address.delete({ where: { id } });
  }
}
