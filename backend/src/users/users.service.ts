import { Injectable, ConflictException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from './schemas/user.schema';

@Injectable()
export class UsersService {
  constructor(@InjectModel(User.name) private userModel: Model<User>) {}

  async findByPseudo(pseudo: string): Promise<User | null> {
    return this.userModel.findOne({ pseudo }).exec();
  }

  async findById(id: string): Promise<User | null> {
    return this.userModel.findById(id).exec();
  }

  async create(userData: Partial<User>): Promise<User> {
    if (!userData.pseudo) {
      throw new ConflictException('Le pseudo est requis.');
    }
    const existingUser = await this.findByPseudo(userData.pseudo);
    if (existingUser) {
      throw new ConflictException('Ce pseudo est déjà utilisé.');
    }
    const createdUser = new this.userModel(userData);
    return createdUser.save();
  }

  async update(id: string, updateData: Partial<User>): Promise<User | null> {
    return this.userModel.findByIdAndUpdate(id, updateData, { new: true }).exec();
  }
}
