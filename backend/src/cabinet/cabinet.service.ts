import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Lawyer } from './schemas/lawyer.schema';

@Injectable()
export class CabinetService {
  constructor(@InjectModel(Lawyer.name) private lawyerModel: Model<Lawyer>) {}

  async findAll(): Promise<Lawyer[]> {
    return this.lawyerModel.find().exec();
  }

  async create(data: Partial<Lawyer>): Promise<Lawyer> {
    const lawyer = new this.lawyerModel(data);
    return lawyer.save();
  }
}
