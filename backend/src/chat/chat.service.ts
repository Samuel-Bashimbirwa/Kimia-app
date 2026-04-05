import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { ChatRoom } from './schemas/chat-room.schema';
import { Message } from './schemas/message.schema';

@Injectable()
export class ChatService {
  constructor(
    @InjectModel(ChatRoom.name) private roomModel: Model<ChatRoom>,
    @InjectModel(Message.name) private messageModel: Model<Message>,
  ) {}

  async findAllRooms(): Promise<ChatRoom[]> {
    return this.roomModel.find({ isActive: true }).exec();
  }

  async createRoom(data: Partial<ChatRoom>): Promise<ChatRoom> {
    const room = new this.roomModel(data);
    return room.save();
  }

  async findMessagesByRoom(roomId: string): Promise<Message[]> {
    return this.messageModel.find({ roomId }).populate('senderId', 'pseudo').exec();
  }

  async saveMessage(data: Partial<Message>): Promise<Message> {
    const message = new this.messageModel(data);
    return message.save();
  }
}
