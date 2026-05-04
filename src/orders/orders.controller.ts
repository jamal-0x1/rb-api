import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  UseGuards,
} from '@nestjs/common';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';
import { CurrentUser } from '../auth/current-user.decorator';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { CheckoutDto } from './dto/checkout.dto';
import {
  AddOrderItemDto,
  AdminCreateOrderDto,
  UpdateOrderItemDto,
} from './dto/admin-order.dto';
import { OrdersService } from './orders.service';

@ApiTags('orders')
@Controller('orders')
export class OrdersController {
  constructor(private readonly service: OrdersService) {}

  @Post('checkout')
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  @ApiOperation({ summary: 'Place an order from the cart (auth required)' })
  checkout(
    @CurrentUser() user: { id: string },
    @Body() body: CheckoutDto,
  ) {
    return this.service.checkout(user.id, body);
  }

  @Get('mine')
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  @ApiOperation({ summary: "Current user's orders" })
  mine(@CurrentUser() user: { id: string }) {
    return this.service.findMine(user.id);
  }

  @Post('admin')
  @ApiOperation({ summary: 'Admin create order with line items' })
  adminCreate(@Body() body: AdminCreateOrderDto) {
    return this.service.adminCreate(body);
  }

  @Get()
  @ApiOperation({ summary: 'List' })
  findAll() {
    return this.service.findAll();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get one' })
  findOne(@Param('id') id: string) {
    return this.service.findOne(id);
  }

  @Post()
  @ApiOperation({ summary: 'Create' })
  create(@Body() body: any) {
    return this.service.create(body);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update' })
  update(@Param('id') id: string, @Body() body: any) {
    return this.service.update(id, body);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete' })
  remove(@Param('id') id: string) {
    return this.service.remove(id);
  }

  @Post(':id/items')
  @ApiOperation({ summary: 'Admin: add a line item to an order' })
  addItem(@Param('id') id: string, @Body() body: AddOrderItemDto) {
    return this.service.addItem(id, body);
  }

  @Patch(':id/items/:itemId')
  @ApiOperation({ summary: 'Admin: update a line item quantity' })
  updateItem(
    @Param('id') id: string,
    @Param('itemId') itemId: string,
    @Body() body: UpdateOrderItemDto,
  ) {
    return this.service.updateItem(id, itemId, body);
  }

  @Delete(':id/items/:itemId')
  @ApiOperation({ summary: 'Admin: remove a line item from an order' })
  removeItem(
    @Param('id') id: string,
    @Param('itemId') itemId: string,
  ) {
    return this.service.removeItem(id, itemId);
  }
}
