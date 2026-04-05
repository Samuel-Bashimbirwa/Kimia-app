import { Controller, Get, Post, Body } from '@nestjs/common';
import { CabinetService } from './cabinet.service';
import { Lawyer } from './schemas/lawyer.schema';

@Controller('cabinet')
export class CabinetController {
  constructor(private readonly cabinetService: CabinetService) {}

  @Get()
  async findAll(): Promise<Lawyer[]> {
    return this.cabinetService.findAll();
  }

  @Post()
  async create(@Body() data: any): Promise<Lawyer> {
    return this.cabinetService.create(data);
  }

  @Post('seed')
  async seed() {
    const defaultLawyers = [
      { name: 'Dr. Jean Mukendi', specialty: 'Droit de la famille & Violences conjugales', contactEmail: 'mukendi@justice.cd', phone: '+243810000001' },
      { name: 'Me. Sarah Kabange', specialty: 'Droit des mineurs & Protection sociale', contactEmail: 'kabange@barreau.cd', phone: '+243810000002' },
      { name: 'Cabinet Amani & Co', specialty: 'Assistance juridique aux victimes', contactEmail: 'info@amani-law.cd', phone: '+243810000003' },
    ];
    for (const l of defaultLawyers) {
      await this.cabinetService.create(l);
    }
    return { message: 'Seeding successful' };
  }
}
