import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { SubmissionsModule } from './submissions/submissions.module';
import { LawsModule } from './laws/laws.module';
import { DiagnosesModule } from './diagnoses/diagnoses.module';
import { CommunityModule } from './community/community.module';
import { ChatModule } from './chat/chat.module';
import { CabinetModule } from './cabinet/cabinet.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    MongooseModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: async (configService: ConfigService) => ({
        uri: configService.get<string>('MONGODB_URI'),
      }),
      inject: [ConfigService],
    }),
    AuthModule,
    UsersModule,
    SubmissionsModule,
    LawsModule,
    DiagnosesModule,
    CommunityModule,
    ChatModule,
    CabinetModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
