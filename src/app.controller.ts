import { Controller, Get } from '@nestjs/common';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { AppService } from './app.service';
import { PrismaService } from './prisma/prisma.service';

@ApiTags('health')
@Controller()
export class AppController {
  constructor(
    private readonly appService: AppService,
    private readonly prisma: PrismaService,
  ) {}

  @Get('helloworld')
  @ApiOperation({ summary: 'Hello world' })
  getHello(): string {
    return this.appService.getHello();
  }

  @Get('db/health')
  @ApiOperation({ summary: 'Database health' })
  async dbHealth() {
    const start = Date.now();
    const result = await this.prisma.$queryRaw<{ ok: number }[]>`SELECT 1 AS ok`;
    return {
      status: 'ok',
      query: result,
      latencyMs: Date.now() - start,
    };
  }
}
