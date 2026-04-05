import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { LawRDC, LawRDCSchema } from './schemas/law-rdc.schema';
import { LawsService } from './laws.service';
import { LawsController } from './laws.controller';

@Module({
  imports: [MongooseModule.forFeature([{ name: LawRDC.name, schema: LawRDCSchema }])],
  providers: [LawsService],
  controllers: [LawsController],
  exports: [LawsService],
})
export class LawsModule {}
