import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Query,
} from '@nestjs/common';
import { ApiOperation, ApiQuery, ApiTags } from '@nestjs/swagger';
import { ProductVariantsService } from './product-variants.service';
import { CreateProductVariantDto } from './dto/create-product-variant.dto';
import { UpdateProductVariantDto } from './dto/update-product-variant.dto';
import { BulkCreateVariantsDto } from './dto/bulk-create-variants.dto';

@ApiTags('product-variants')
@Controller('product-variants')
export class ProductVariantsController {
  constructor(private readonly service: ProductVariantsService) {}

  @Get()
  @ApiOperation({ summary: 'List' })
  @ApiQuery({ name: 'productId', required: false })
  findAll(@Query('productId') productId?: string) {
    return this.service.findAll(productId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get one' })
  findOne(@Param('id') id: string) {
    return this.service.findOne(id);
  }

  @Post()
  @ApiOperation({ summary: 'Create' })
  create(@Body() dto: CreateProductVariantDto) {
    return this.service.create(dto);
  }

  @Post('bulk/:productId')
  @ApiOperation({
    summary: 'Bulk create variants for a product (atomic)',
  })
  bulkCreate(
    @Param('productId') productId: string,
    @Body() dto: BulkCreateVariantsDto,
  ) {
    return this.service.bulkCreate(productId, dto);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update' })
  update(@Param('id') id: string, @Body() dto: UpdateProductVariantDto) {
    return this.service.update(id, dto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete' })
  remove(@Param('id') id: string) {
    return this.service.remove(id);
  }
}
