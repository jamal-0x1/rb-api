import { BadRequestException, Injectable } from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';
import { CreateReviewDto } from './dto/create-review.dto';

@Injectable()
export class ReviewsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.review.findMany();
  }

  findOne(id: string) {
    return this.prisma.review.findUnique({ where: { id } });
  }

  async listByProduct(productId: string) {
    const [items, agg] = await Promise.all([
      this.prisma.review.findMany({
        where: { productId },
        orderBy: { createdAt: 'desc' },
        take: 50,
        include: {
          user: {
            select: { id: true, firstName: true, lastName: true, email: true },
          },
        },
      }),
      this.prisma.review.aggregate({
        where: { productId },
        _count: { _all: true },
        _avg: { rating: true },
      }),
    ]);
    return {
      items,
      stats: {
        count: agg._count._all,
        average: Number(agg._avg.rating ?? 0),
      },
    };
  }

  async createForUser(userId: string, dto: CreateReviewDto) {
    const product = await this.prisma.product.findUnique({
      where: { id: dto.productId },
      select: { id: true },
    });
    if (!product) throw new BadRequestException('Product not found');

    const existing = await this.prisma.review.findFirst({
      where: { userId, productId: dto.productId },
    });
    if (existing) {
      throw new BadRequestException('You already reviewed this product');
    }

    const orderItem = await this.prisma.orderItem.findFirst({
      where: {
        order: { userId },
        variant: { productId: dto.productId },
      },
      select: { id: true },
    });

    return this.prisma.review.create({
      data: {
        userId,
        productId: dto.productId,
        rating: dto.rating,
        title: dto.title ?? null,
        body: dto.body ?? null,
        orderItemId: orderItem?.id ?? null,
        verifiedPurchase: !!orderItem,
      },
      include: {
        user: {
          select: { id: true, firstName: true, lastName: true, email: true },
        },
      },
    });
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
