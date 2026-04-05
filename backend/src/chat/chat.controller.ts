import { Controller, Get, Post, Body, Param, UseGuards } from '@nestjs/common';
import { ChatService } from './chat.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('chat')
export class ChatController {
  constructor(private readonly chatService: ChatService) {}

  @Get('rooms')
  async findAllRooms() {
    return this.chatService.findAllRooms();
  }

  @Post('rooms')
  async createRoom(@Body() data: any) {
    return this.chatService.createRoom(data);
  }

  @Get('rooms/:roomId/messages')
  async findMessagesByRoom(@Param('roomId') roomId: string) {
    return this.chatService.findMessagesByRoom(roomId);
  }
}
