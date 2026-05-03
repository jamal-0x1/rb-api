import { Injectable } from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ReviewsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.review.findMany();
  }

  findOne(id: string) {
    return this.prisma.review.findUnique({ where: { id } });
  }

  create(data: Prisma.ReviewCreateInput) {
    return this.prisma.review.create({ data });
  }

  update(id: string, data: Prisma.ReviewUpdateInput) {
    return this.prisma.review.update({ where: { id }, data });
  }

  remove(id: string) {
    return this.prisma.review.delete({ where: { id } });
  }
}
