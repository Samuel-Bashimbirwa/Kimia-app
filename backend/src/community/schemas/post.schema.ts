import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Schema as MongooseSchema } from 'mongoose';

@Schema({ timestamps: true })
export class Post extends Document {
  @Prop({ type: MongooseSchema.Types.ObjectId, ref: 'Topic', required: true })
  topicId: string;

  @Prop({ type: MongooseSchema.Types.ObjectId, ref: 'User', required: true })
  authorId: string;

  @Prop({ required: true })
  title: string;

  @Prop({ required: true })
  content: string;

  @Prop({ type: String, enum: ['NEWS', 'TESTIMONY', 'COMFORT', 'HELP'], default: 'TESTIMONY' })
  category: string;

  @Prop({ default: 0 })
  likes: number;
}

export const PostSchema = SchemaFactory.createForClass(Post);
