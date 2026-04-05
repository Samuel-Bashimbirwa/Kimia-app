import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { Lawyer, LawyerSchema } from './schemas/lawyer.schema';
import { CabinetService } from './cabinet.service';
import { CabinetController } from './cabinet.controller';

@Module({
  imports: [MongooseModule.forFeature([{ name: Lawyer.name, schema: LawyerSchema }])],
  providers: [CabinetService],
  controllers: [CabinetController],
  exports: [CabinetService],
})
export class CabinetModule {}
