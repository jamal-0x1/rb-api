import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';
import { CheckoutDto } from './dto/checkout.dto';
import {
  AddOrderItemDto,
  AdminCreateOrderDto,
  UpdateOrderItemDto,
} from './dto/admin-order.dto';

const SHIPPING_RATES: Record<'free' | 'standard' | 'express', number> = {
  free: 0,
  standard: 60,
  express: 150,
};

const TERMINAL_STATUSES = new Set(['delivered', 'cancelled', 'refunded']);

type Tx = Prisma.TransactionClient;

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
                inventory: true,
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
        events: { orderBy: { createdAt: 'desc' } },
      },
    });
  }

  async findMine(userId: string) {
    return this.prisma.order.findMany({
      where: { userId },
      orderBy: { placedAt: 'desc' },
      include: {
        items: {
          include: {
            variant: { select: { id: true, sku: true, size: true, color: true } },
          },
        },
        payments: true,
      },
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

    const orderNumber = this.makeOrderNumber('ORD');

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

      await this.logEvent(
        tx,
        order.id,
        'created',
        `Order placed by customer (${order.items.length} item${order.items.length === 1 ? '' : 's'}, total ${grandTotal.toFixed(2)} BDT)`,
        { source: 'checkout', userId },
      );

      return order;
    });
  }

  async adminCreate(dto: AdminCreateOrderDto) {
    if (!dto.items || dto.items.length === 0) {
      throw new BadRequestException('Order must have at least one item');
    }

    const user = await this.prisma.user.findUnique({
      where: { id: dto.userId },
    });
    if (!user) throw new BadRequestException('Customer not found');

    const variantIds = dto.items.map((i) => i.variantId);
    const variants = await this.prisma.productVariant.findMany({
      where: { id: { in: variantIds } },
      include: { product: true, inventory: true },
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

    const shippingMethod = dto.shippingMethod ?? 'standard';
    const shippingAmount = SHIPPING_RATES[shippingMethod];
    const taxAmount = 0;
    const discountAmount = 0;
    const grandTotal = Math.max(0, subtotal + shippingAmount + taxAmount);
    const orderNumber = await this.makeUniqueInvoiceNumber();
    const status = dto.status ?? 'pending';
    const paymentMethod = dto.paymentMethod ?? 'cod';

    return this.prisma.$transaction(async (tx) => {
      const address = await tx.address.create({
        data: {
          userId: dto.userId,
          label: 'Order',
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
          userId: dto.userId,
          orderNumber,
          status,
          subtotal: subtotal.toFixed(2),
          taxAmount: taxAmount.toFixed(2),
          shippingAmount: shippingAmount.toFixed(2),
          discountAmount: discountAmount.toFixed(2),
          grandTotal: grandTotal.toFixed(2),
          currency: 'BDT',
          shippingAddressId: address.id,
          billingAddressId: address.id,
          notes: dto.notes ?? null,
          items: { create: lines },
        },
        include: { items: true },
      });

      await tx.payment.create({
        data: {
          orderId: order.id,
          method: paymentMethod,
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

      await this.logEvent(
        tx,
        order.id,
        'created',
        `Order created in admin (${order.items.length} item${order.items.length === 1 ? '' : 's'}, total ${grandTotal.toFixed(2)} BDT, status ${status})`,
        { source: 'admin', userId: dto.userId, status },
      );
      if (dto.notes) {
        await this.logEvent(tx, order.id, 'notes_changed', 'Notes added', {
          notes: dto.notes,
        });
      }

      return order;
    });
  }

  async addItem(orderId: string, dto: AddOrderItemDto) {
    return this.prisma.$transaction(async (tx) => {
      const order = await this.requireMutableOrder(tx, orderId);

      const variant = await tx.productVariant.findUnique({
        where: { id: dto.variantId },
        include: { product: true, inventory: true },
      });
      if (!variant) throw new NotFoundException('Variant not found');

      const stock = variant.inventory?.quantityOnHand ?? 0;
      if (stock < dto.quantity) {
        throw new BadRequestException(
          `Not enough stock for ${variant.product.name}: ${stock} available`,
        );
      }

      const existing = order.items.find((i) => i.variantId === dto.variantId);
      const unitPrice = Number(variant.priceOverride ?? variant.product.basePrice);

      if (existing) {
        const newQty = existing.quantity + dto.quantity;
        const lineTotal = unitPrice * newQty;
        await tx.orderItem.update({
          where: { id: existing.id },
          data: {
            quantity: newQty,
            unitPrice: unitPrice.toFixed(2),
            lineTotal: lineTotal.toFixed(2),
          },
        });
        await this.logEvent(
          tx,
          orderId,
          'item_qty_changed',
          `Increased ${variant.product.name} (${variant.sku}) quantity ${existing.quantity} → ${newQty}`,
          { variantId: variant.id, from: existing.quantity, to: newQty },
        );
      } else {
        const lineTotal = unitPrice * dto.quantity;
        await tx.orderItem.create({
          data: {
            orderId,
            variantId: variant.id,
            quantity: dto.quantity,
            unitPrice: unitPrice.toFixed(2),
            lineTotal: lineTotal.toFixed(2),
            productNameSnapshot: variant.product.name,
            variantSkuSnapshot: variant.sku,
          },
        });
        await this.logEvent(
          tx,
          orderId,
          'item_added',
          `Added ${dto.quantity}× ${variant.product.name} (${variant.sku})`,
          { variantId: variant.id, quantity: dto.quantity },
        );
      }

      await tx.inventory.update({
        where: { variantId: variant.id },
        data: { quantityOnHand: { decrement: dto.quantity } },
      });

      await this.recomputeTotals(tx, orderId);
      return this.reloadOrder(tx, orderId);
    });
  }

  async updateItem(orderId: string, itemId: string, dto: UpdateOrderItemDto) {
    return this.prisma.$transaction(async (tx) => {
      const order = await this.requireMutableOrder(tx, orderId);
      const item = order.items.find((i) => i.id === itemId);
      if (!item) throw new NotFoundException('Order item not found');

      const delta = dto.quantity - item.quantity;
      if (delta === 0) return this.reloadOrder(tx, orderId);

      if (delta > 0) {
        const inv = await tx.inventory.findUnique({
          where: { variantId: item.variantId },
        });
        const stock = inv?.quantityOnHand ?? 0;
        if (stock < delta) {
          throw new BadRequestException(
            `Not enough stock: ${stock} available, need ${delta} more`,
          );
        }
      }

      const unitPrice = Number(item.unitPrice);
      const lineTotal = unitPrice * dto.quantity;

      await tx.orderItem.update({
        where: { id: itemId },
        data: {
          quantity: dto.quantity,
          lineTotal: lineTotal.toFixed(2),
        },
      });

      await tx.inventory.update({
        where: { variantId: item.variantId },
        data: { quantityOnHand: { decrement: delta } },
      });

      await this.logEvent(
        tx,
        orderId,
        'item_qty_changed',
        `Updated ${item.productNameSnapshot} (${item.variantSkuSnapshot}) quantity ${item.quantity} → ${dto.quantity}`,
        { variantId: item.variantId, from: item.quantity, to: dto.quantity },
      );

      await this.recomputeTotals(tx, orderId);
      return this.reloadOrder(tx, orderId);
    });
  }

  async removeItem(orderId: string, itemId: string) {
    return this.prisma.$transaction(async (tx) => {
      const order = await this.requireMutableOrder(tx, orderId);
      if (order.items.length <= 1) {
        throw new BadRequestException(
          'Order must have at least one item; cancel the order instead',
        );
      }
      const item = order.items.find((i) => i.id === itemId);
      if (!item) throw new NotFoundException('Order item not found');

      await tx.orderItem.delete({ where: { id: itemId } });
      await tx.inventory.update({
        where: { variantId: item.variantId },
        data: { quantityOnHand: { increment: item.quantity } },
      });

      await this.logEvent(
        tx,
        orderId,
        'item_removed',
        `Removed ${item.quantity}× ${item.productNameSnapshot} (${item.variantSkuSnapshot})`,
        {
          variantId: item.variantId,
          quantity: item.quantity,
          itemId,
        },
      );

      await this.recomputeTotals(tx, orderId);
      return this.reloadOrder(tx, orderId);
    });
  }

  create(data: Prisma.OrderCreateInput) {
    return this.prisma.order.create({ data });
  }

  async update(id: string, data: Prisma.OrderUpdateInput) {
    return this.prisma.$transaction(async (tx) => {
      const before = await tx.order.findUnique({ where: { id } });
      if (!before) throw new NotFoundException();

      const updated = await tx.order.update({ where: { id }, data });

      const events: Array<{ type: string; message: string; payload: any }> = [];
      if (
        typeof data.status !== 'undefined' &&
        before.status !== updated.status
      ) {
        events.push({
          type: 'status_changed',
          message: `Status changed: ${before.status} → ${updated.status}`,
          payload: { from: before.status, to: updated.status },
        });
      }
      if (
        typeof data.notes !== 'undefined' &&
        (before.notes ?? null) !== (updated.notes ?? null)
      ) {
        const action =
          !before.notes && updated.notes
            ? 'added'
            : !updated.notes
              ? 'cleared'
              : 'updated';
        events.push({
          type: 'notes_changed',
          message: `Notes ${action}`,
          payload: { from: before.notes ?? null, to: updated.notes ?? null },
        });
      }

      for (const e of events) {
        await this.logEvent(tx, id, e.type, e.message, e.payload);
      }

      return updated;
    });
  }

  async remove(id: string) {
    const found = await this.prisma.order.findUnique({ where: { id } });
    if (!found) throw new NotFoundException();
    return this.prisma.order.delete({ where: { id } });
  }

  private async requireMutableOrder(tx: Tx, orderId: string) {
    const order = await tx.order.findUnique({
      where: { id: orderId },
      include: { items: true },
    });
    if (!order) throw new NotFoundException('Order not found');
    if (TERMINAL_STATUSES.has(order.status)) {
      throw new BadRequestException(
        `Cannot modify items on a ${order.status} order`,
      );
    }
    return order;
  }

  private async recomputeTotals(tx: Tx, orderId: string) {
    const order = await tx.order.findUnique({
      where: { id: orderId },
      include: { items: true, coupon: true },
    });
    if (!order) return;

    const subtotal = order.items.reduce(
      (acc, it) => acc + Number(it.lineTotal),
      0,
    );

    let discountAmount = Number(order.discountAmount);
    if (order.coupon) {
      const c = order.coupon;
      const value = Number(c.discountValue);
      discountAmount =
        c.discountType === 'percent'
          ? Math.round(((subtotal * value) / 100) * 100) / 100
          : Math.min(value, subtotal);
    }

    const grandTotal = Math.max(
      0,
      subtotal -
        discountAmount +
        Number(order.shippingAmount) +
        Number(order.taxAmount),
    );

    await tx.order.update({
      where: { id: orderId },
      data: {
        subtotal: subtotal.toFixed(2),
        discountAmount: discountAmount.toFixed(2),
        grandTotal: grandTotal.toFixed(2),
      },
    });
  }

  private reloadOrder(tx: Tx, orderId: string) {
    return tx.order.findUnique({
      where: { id: orderId },
      include: {
        items: {
          include: {
            variant: {
              include: {
                inventory: true,
                product: {
                  include: {
                    images: { where: { isPrimary: true }, take: 1 },
                  },
                },
              },
            },
          },
        },
        payments: true,
      },
    });
  }

  private makeOrderNumber(prefix: 'ORD' | 'INV' = 'ORD') {
    return `${prefix}-${Date.now()}-${Math.floor(Math.random() * 1000)
      .toString()
      .padStart(3, '0')}`;
  }

  private async logEvent(
    tx: Tx,
    orderId: string,
    type: string,
    message: string,
    payload?: Record<string, unknown> | null,
    actorUserId?: string | null,
  ) {
    await tx.orderEvent.create({
      data: {
        orderId,
        type,
        message,
        payload: payload ? (payload as Prisma.InputJsonValue) : Prisma.JsonNull,
        actorUserId: actorUserId ?? null,
      },
    });
  }

  private async makeUniqueInvoiceNumber(maxAttempts = 5): Promise<string> {
    for (let i = 0; i < maxAttempts; i++) {
      const candidate = this.makeOrderNumber('INV');
      const clash = await this.prisma.order.findUnique({
        where: { orderNumber: candidate },
        select: { id: true },
      });
      if (!clash) return candidate;
    }
    throw new BadRequestException(
      'Unable to allocate a unique invoice number — try again',
    );
  }
}
