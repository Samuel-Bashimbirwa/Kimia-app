import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Schema as MongooseSchema } from 'mongoose';

@Schema({ timestamps: true })
export class ChatRoom extends Document {
  @Prop({ required: true })
  name: string;

  @Prop()
  topic: string;

  @Prop([{ type: MongooseSchema.Types.ObjectId, ref: 'User' }])
  members: string[];

  @Prop({ default: true })
  isActive: boolean;
}

export const ChatRoomSchema = SchemaFactory.createForClass(ChatRoom);
