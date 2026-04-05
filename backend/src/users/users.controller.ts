import { Controller, Get, Patch, Body, UseGuards, Request } from '@nestjs/common';
import { UsersService } from './users.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @UseGuards(JwtAuthGuard)
  @Get('profile')
  getProfile(@Request() req: any) {
    return this.usersService.findById(req.user.userId);
  }

  @UseGuards(JwtAuthGuard)
  @Patch('profile')
  updateProfile(@Request() req: any, @Body() updateData: any) {
    // Only allow updating specific fields
    const { pseudo, emergencyContact, avatarUrl } = updateData;
    return this.usersService.update(req.user.userId, { 
      pseudo, 
      emergencyContact, 
      avatarUrl 
    });
  }
}
