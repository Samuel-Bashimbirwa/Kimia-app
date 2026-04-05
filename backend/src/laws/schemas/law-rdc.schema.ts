import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

@Schema({ timestamps: true })
export class LawRDC extends Document {
  @Prop({ default: 'RDC' })
  jurisdiction: string;

  @Prop()
  source: string;

  @Prop({ required: true })
  reference: string;

  @Prop({ required: true })
  title: string;

  @Prop({ required: true })
  body: string;

  @Prop([String])
  keywords: string[];

  @Prop([String])
  categories: string[];

  @Prop()
  penalties: string;

  @Prop()
  versioning: string;
}

export const LawRDCSchema = SchemaFactory.createForClass(LawRDC);
