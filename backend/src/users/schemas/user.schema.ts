import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

@Schema({ timestamps: true })
export class User extends Document {
  @Prop({ required: false })
  phone?: string;

  @Prop({ required: false })
  email?: string;

  @Prop({ required: true })
  passwordHash: string;

  @Prop({ required: true, unique: true })
  pseudo: string;
  
  @Prop({ required: false })
  emergencyContact?: string; // Le fameux "Lien" SOS

  @Prop({ required: false })
  avatarUrl?: string;

  @Prop({ default: 'user' })
  role: string;
}

export const UserSchema = SchemaFactory.createForClass(User);
