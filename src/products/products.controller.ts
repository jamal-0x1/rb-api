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
import { ProductsService } from './products.service';
import type { SortKey } from './products.service';

const splitCsv = (raw?: string): string[] | undefined => {
  if (!raw) return undefined;
  const arr = raw
    .split(',')
    .map((s) => s.trim())
    .filter(Boolean);
  return arr.length > 0 ? arr : undefined;
};

const parseNumber = (raw?: string): number | undefined => {
  if (raw === undefined || raw === '') return undefined;
  const n = Number(raw);
  return Number.isFinite(n) ? n : undefined;
};

@ApiTags('products')
@Controller('products')
export class ProductsController {
  constructor(private readonly service: ProductsService) {}

  @Get('facets')
  @ApiOperation({ summary: 'Filter facets for storefront' })
  facets() {
    return this.service.facets();
  }

  @Get()
  @ApiOperation({ summary: 'List' })
  @ApiQuery({ name: 'tag', required: false })
  @ApiQuery({ name: 'tags', required: false, description: 'CSV' })
  @ApiQuery({ name: 'categoryId', required: false })
  @ApiQuery({ name: 'categoryIds', required: false, description: 'CSV' })
  @ApiQuery({ name: 'sizes', required: false, description: 'CSV' })
  @ApiQuery({ name: 'colors', required: false, description: 'CSV' })
  @ApiQuery({ name: 'minPrice', required: false, type: Number })
  @ApiQuery({ name: 'maxPrice', required: false, type: Number })
  @ApiQuery({ name: 'inStock', required: false, type: Boolean })
  @ApiQuery({ name: 'sort', required: false })
  @ApiQuery({ name: 'limit', required: false, type: Number })
  findAll(
    @Query('tag') tag?: string,
    @Query('tags') tags?: string,
    @Query('categoryId') categoryId?: string,
    @Query('categoryIds') categoryIds?: string,
    @Query('sizes') sizes?: string,
    @Query('colors') colors?: string,
    @Query('minPrice') minPrice?: string,
    @Query('maxPrice') maxPrice?: string,
    @Query('inStock') inStock?: string,
    @Query('sort') sort?: string,
    @Query('limit') limit?: string,
  ) {
    return this.service.findAll({
      tag,
      tags: splitCsv(tags),
      categoryId,
      categoryIds: splitCsv(categoryIds),
      sizes: splitCsv(sizes),
      colors: splitCsv(colors),
      minPrice: parseNumber(minPrice),
      maxPrice: parseNumber(maxPrice),
      inStock: inStock === 'true' || inStock === '1',
      sort: sort as SortKey | undefined,
      limit: parseNumber(limit),
    });
  }

  @Get('slug/:slug')
  @ApiOperation({ summary: 'Get by slug' })
  findBySlug(@Param('slug') slug: string) {
    return this.service.findBySlug(slug);
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
}
