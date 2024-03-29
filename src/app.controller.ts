import { PrismaService } from './prisma/prisma.service';
import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(
    private readonly appService: AppService,
    private prismaService: PrismaService,
  ) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Get('/content1')
  async getContent1() {
    return await this.prismaService.getContent1();
  }
}
