import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Diagnosis } from './schemas/diagnosis.schema';

@Injectable()
export class DiagnosesService {
  constructor(@InjectModel(Diagnosis.name) private diagnosisModel: Model<Diagnosis>) {}

  async create(data: Partial<Diagnosis>): Promise<Diagnosis> {
    const diagnosis = new this.diagnosisModel(data);
    return diagnosis.save();
  }

  async findBySubmissionId(submissionId: string): Promise<Diagnosis | null> {
    return this.diagnosisModel.findOne({ submissionId }).exec();
  }
}
