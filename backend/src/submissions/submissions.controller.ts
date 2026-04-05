import { Controller, Post, Body, Get, Param, UseGuards } from '@nestjs/common';
import { SubmissionsService } from './submissions.service';
import { Submission } from './schemas/submission.schema';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('submissions')
export class SubmissionsController {
  constructor(private readonly submissionsService: SubmissionsService) {}

  @Post()
  async create(@Body() data: Partial<Submission>): Promise<Submission> {
    return this.submissionsService.create(data);
  }

  @Post(':id/analyze')
  async analyze(@Param('id') id: string) {
    return this.submissionsService.analyze(id);
  }

  @Get()
  async findAll() {
      // Logic to list user's submissions
      return [];
  }
}
