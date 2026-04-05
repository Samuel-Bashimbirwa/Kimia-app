import { Controller, Get, Param, Query, Post, Body } from '@nestjs/common';
import { LawsService } from './laws.service';
import { LawRDC } from './schemas/law-rdc.schema';

@Controller('laws')
export class LawsController {
  constructor(private readonly lawsService: LawsService) {}

  @Get()
  async findAll(@Query('query') query: string, @Query('category') category: string): Promise<LawRDC[]> {
    return this.lawsService.findAll(query, category);
  }

  @Get(':id')
  async findOne(@Param('id') id: string): Promise<LawRDC | null> {
    return this.lawsService.findOne(id);
  }

  @Post('seed')
  async seed(@Body() laws: Partial<LawRDC>[]) {
    return this.lawsService.seed(laws);
  }
}
