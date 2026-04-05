import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { Diagnosis, DiagnosisSchema } from './schemas/diagnosis.schema';
import { DiagnosesService } from './diagnoses.service';
import { DiagnosesController } from './diagnoses.controller';

@Module({
  imports: [MongooseModule.forFeature([{ name: Diagnosis.name, schema: DiagnosisSchema }])],
  providers: [DiagnosesService],
  controllers: [DiagnosesController],
  exports: [DiagnosesService],
})
export class DiagnosesModule {}
