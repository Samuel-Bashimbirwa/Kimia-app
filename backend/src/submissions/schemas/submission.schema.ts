import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Schema as MongooseSchema } from 'mongoose';

@Schema({ timestamps: true })
export class Submission extends Document {
  @Prop({ type: MongooseSchema.Types.ObjectId, ref: 'User', required: false })
  userId?: string;

  @Prop()
  textContext: string;

  @Prop({ type: Object })
  questionnaireData: Record<string, any>;

  @Prop([String])
  tags: string[];
}

export const SubmissionSchema = SchemaFactory.createForClass(Submission);
