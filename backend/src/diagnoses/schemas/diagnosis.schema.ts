import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Schema as MongooseSchema } from 'mongoose';

@Schema({ timestamps: true })
export class Diagnosis extends Document {
  @Prop({ type: MongooseSchema.Types.ObjectId, ref: 'Submission', required: true })
  submissionId: string;

  @Prop({ type: MongooseSchema.Types.ObjectId, ref: 'User', required: false })
  userId: string;

  @Prop({ required: true })
  score: number;

  @Prop([{ type: MongooseSchema.Types.ObjectId, ref: 'LawRDC' }])
  matchedLaws: string[];

  @Prop([String])
  recommendations: string[];
}

export const DiagnosisSchema = SchemaFactory.createForClass(Diagnosis);
