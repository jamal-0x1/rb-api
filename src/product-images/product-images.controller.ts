import {
  BadRequestException,
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ApiBody, ApiConsumes, ApiOperation, ApiTags } from '@nestjs/swagger';
import { diskStorage } from 'multer';
import { extname, join } from 'path';
import { mkdirSync } from 'fs';
import { randomUUID } from 'crypto';
import { ProductImagesService } from './product-images.service';

const STORAGE_ROOT = join(process.cwd(), 'storage', 'products');
mkdirSync(STORAGE_ROOT, { recursive: true });

const ALLOWED_MIMES = new Set([
  'image/jpeg',
  'image/png',
  'image/webp',
  'image/gif',
  'image/avif',
]);

@ApiTags('product-images')
@Controller('product-images')
export class ProductImagesController {
  constructor(private readonly service: ProductImagesService) {}

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

  @Post('upload/:productId')
  @ApiOperation({ summary: 'Upload image file for a product' })
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    schema: {
      type: 'object',
      properties: { file: { type: 'string', format: 'binary' } },
    },
  })
  @UseInterceptors(
    FileInterceptor('file', {
      storage: diskStorage({
        destination: (req, _file, cb) => {
          const productId = String((req.params as Record<string, string>).productId);
          const dir = join(STORAGE_ROOT, productId);
          mkdirSync(dir, { recursive: true });
          cb(null, dir);
        },
        filename: (_req, file, cb) => {
          const ext = extname(file.originalname).toLowerCase();
          cb(null, `${Date.now()}-${randomUUID().slice(0, 8)}${ext}`);
        },
      }),
      limits: { fileSize: 10 * 1024 * 1024 },
      fileFilter: (_req, file, cb) => {
        if (!ALLOWED_MIMES.has(file.mimetype)) {
          return cb(new BadRequestException('Unsupported file type'), false);
        }
        cb(null, true);
      },
    }),
  )
  async upload(
    @Param('productId') productId: string,
    @UploadedFile() file: Express.Multer.File,
    @Body('altText') altText?: string,
    @Body('isPrimary') isPrimary?: string,
  ) {
    if (!file) throw new BadRequestException('Missing file');
    const url = `/storage/products/${productId}/${file.filename}`;
    return this.service.create({
      product: { connect: { id: productId } },
      url,
      altText: altText ?? null,
      isPrimary: isPrimary === 'true' || isPrimary === '1',
    });
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
