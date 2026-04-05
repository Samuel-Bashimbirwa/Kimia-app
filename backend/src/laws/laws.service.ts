import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { LawRDC } from './schemas/law-rdc.schema';

@Injectable()
export class LawsService {
  constructor(@InjectModel(LawRDC.name) private lawModel: Model<LawRDC>) {}

  async findAll(query?: string, category?: string): Promise<LawRDC[]> {
    const filter: any = {};
    if (query) {
      const words = query.split(/\s+/).filter(w => w.length > 3);
      filter.$or = [
        { title: { $regex: query, $options: 'i' } },
        { body: { $regex: query, $options: 'i' } },
        { keywords: { $in: words.map(w => new RegExp(w, 'i')) } },
      ];
      if (words.length > 0) {
          filter.$or.push({ body: { $regex: words.join('|'), $options: 'i' } });
      }
    }
    if (category) {
      filter.categories = category;
    }
    return this.lawModel.find(filter).exec();
  }

  async findOne(id: string): Promise<LawRDC | null> {
    return this.lawModel.findById(id).exec();
  }

  async seed(laws: Partial<LawRDC>[]): Promise<void> {
    await this.lawModel.deleteMany({});
    await this.lawModel.insertMany(laws);
  }
}
