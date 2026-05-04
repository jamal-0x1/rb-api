import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';
import { CheckoutDto } from './dto/checkout.dto';

const SHIPPING_RATES: Record<'free' | 'standard' | 'express', number> = {
  free: 0,
  standard: 60,
  express: 150,
};

@Injectable()
export class OrdersService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.order.findMany({
      orderBy: { placedAt: 'desc' },
      include: {
        user: { select: { id: true, email: true, firstName: true, lastName: true } },
        items: true,
      },
    });
  }

  findOne(id: string) {
    return this.prisma.order.findUnique({
      where: { id },
      include: {
        user: { select: { id: true, email: true, firstName: true, lastName: true } },
        shippingAddress: true,
        billingAddress: true,
        coupon: true,
        items: {
          include: {
            variant: {
              include: {
                product: {
                  include: {
                    images: { where: { isPrimary: true }, take: 1 },
                  },
                },
              },
            },
          },
        },
        payments: { orderBy: { createdAt: 'desc' } },
        shipments: { include: { items: true } },
      },
    });
  }

  async findMine(userId: string) {
    return this.prisma.order.findMany({
      where: { userId },
      orderBy: { placedAt: 'desc' },
      include: { items: true, payments: true },
    });
  }

  async checkout(userId: string, dto: CheckoutDto) {
    if (!dto.items || dto.items.length === 0) {
      throw new BadRequestException('Cart is empty');
    }

    const variantIds = dto.items.map((i) => i.variantId);
    const variants = await this.prisma.productVariant.findMany({
      where: { id: { in: variantIds } },
      include: {
        product: true,
        inventory: true,
      },
    });

    if (variants.length !== variantIds.length) {
      throw new BadRequestException('One or more variants not found');
    }

    const variantById = new Map(variants.map((v) => [v.id, v]));

    let subtotal = 0;
    const lines = dto.items.map((it) => {
      const v = variantById.get(it.variantId)!;
      const stock = v.inventory?.quantityOnHand ?? 0;
      if (stock < it.quantity) {
        throw new BadRequestException(
          `Not enough stock for ${v.product.name}: ${stock} available`,
        );
      }
      const unitPrice = Number(v.priceOverride ?? v.product.basePrice);
      const lineTotal = unitPrice * it.quantity;
      subtotal += lineTotal;
      return {
        variantId: v.id,
        productNameSnapshot: v.product.name,
        variantSkuSnapshot: v.sku,
        quantity: it.quantity,
        unitPrice: unitPrice.toFixed(2),
        lineTotal: lineTotal.toFixed(2),
      };
    });

    let discountAmount = 0;
    let couponId: string | null = null;
    if (dto.couponCode) {
      const coupon = await this.prisma.coupon.findFirst({
        where: { code: dto.couponCode },
      });
      if (!coupon) throw new BadRequestException('Invalid coupon code');
      const now = new Date();
      if (coupon.validFrom && coupon.validFrom > now)
        throw new BadRequestException('Coupon not yet valid');
      if (coupon.validUntil && coupon.validUntil < now)
        throw new BadRequestException('Coupon expired');
      const minOrder = Number(coupon.minOrderAmount ?? 0);
      if (subtotal < minOrder) {
        throw new BadRequestException(
          `Coupon requires minimum order of ${minOrder}`,
        );
      }
      const value = Number(coupon.discountValue);
      discountAmount =
        coupon.discountType === 'percent'
          ? Math.round(((subtotal * value) / 100) * 100) / 100
          : value;
      if (discountAmount > subtotal) discountAmount = subtotal;
      couponId = coupon.id;
    }

    const shippingMethod = dto.shippingMethod ?? 'standard';
    const shippingAmount = SHIPPING_RATES[shippingMethod];
    const taxAmount = 0;
    const grandTotal = Math.max(
      0,
      subtotal - discountAmount + shippingAmount + taxAmount,
    );

    const orderNumber = `ORD-${Date.now()}-${Math.floor(Math.random() * 1000)
      .toString()
      .padStart(3, '0')}`;

    return this.prisma.$transaction(async (tx) => {
      const address = await tx.address.create({
        data: {
          userId,
          label: 'Checkout',
          line1: dto.shipping.line1,
          line2: dto.shipping.line2,
          city: dto.shipping.city,
          state: dto.shipping.state,
          postalCode: dto.shipping.postalCode,
          country: dto.shipping.country,
        },
      });

      const order = await tx.order.create({
        data: {
          userId,
          orderNumber,
          status: 'pending',
          subtotal: subtotal.toFixed(2),
          taxAmount: taxAmount.toFixed(2),
          shippingAmount: shippingAmount.toFixed(2),
          discountAmount: discountAmount.toFixed(2),
          grandTotal: grandTotal.toFixed(2),
          currency: 'BDT',
          shippingAddressId: address.id,
          billingAddressId: address.id,
          couponId,
          items: { create: lines },
        },
        include: { items: true },
      });

      await tx.payment.create({
        data: {
          orderId: order.id,
          method: dto.paymentMethod,
          amount: grandTotal.toFixed(2),
          currency: 'BDT',
          status: 'pending',
          notes: dto.notes ?? null,
        },
      });

      for (const it of dto.items) {
        await tx.inventory.update({
          where: { variantId: it.variantId },
          data: { quantityOnHand: { decrement: it.quantity } },
        });
      }

      return order;
    });
  }

  create(data: Prisma.OrderCreateInput) {
    return this.prisma.order.create({ data });
  }

  update(id: string, data: Prisma.OrderUpdateInput) {
    return this.prisma.order.update({ where: { id }, data });
  }

  async remove(id: string) {
    const found = await this.prisma.order.findUnique({ where: { id } });
    if (!found) throw new NotFoundException();
    return this.prisma.order.delete({ where: { id } });
  }
}
