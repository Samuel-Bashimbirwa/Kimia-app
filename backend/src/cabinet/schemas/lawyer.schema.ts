import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

@Schema({ timestamps: true })
export class Lawyer extends Document {
  @Prop({ required: true })
  name: string;

  @Prop()
  specialty: string;

  @Prop()
  contactEmail: string;

  @Prop()
  phone: string;
}

export const LawyerSchema = SchemaFactory.createForClass(Lawyer);
