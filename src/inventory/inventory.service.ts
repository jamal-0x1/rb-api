import {
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { Prisma } from '../generated/prisma/client';
import { PrismaService } from '../prisma/prisma.service';
import { CreateInventoryDto } from './dto/create-inventory.dto';
import { UpdateInventoryDto } from './dto/update-inventory.dto';

@Injectable()
export class InventoryService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.inventory.findMany();
  }

  findOne(id: string) {
    return this.prisma.inventory.findUnique({ where: { id } });
  }

  async create(dto: CreateInventoryDto) {
    try {
      return await this.prisma.inventory.create({ data: dto });
    } catch (e) {
      if (
        e instanceof Prisma.PrismaClientKnownRequestError &&
        e.code === 'P2002'
      ) {
        throw new ConflictException(
          `Inventory already exists for variant ${dto.variantId}.`,
        );
      }
      throw e;
    }
  }

  async update(id: string, dto: UpdateInventoryDto) {
    try {
      return await this.prisma.inventory.update({
        where: { id },
        data: dto,
      });
    } catch (e) {
      if (
        e instanceof Prisma.PrismaClientKnownRequestError &&
        e.code === 'P2025'
      ) {
        throw new NotFoundException(`Inventory ${id} not found.`);
      }
      throw e;
    }
  }

  async remove(id: string) {
    try {
      return await this.prisma.inventory.delete({ where: { id } });
    } catch (e) {
      if (
        e instanceof Prisma.PrismaClientKnownRequestError &&
        e.code === 'P2025'
      ) {
        throw new NotFoundException(`Inventory ${id} not found.`);
      }
      throw e;
    }
  }
}
