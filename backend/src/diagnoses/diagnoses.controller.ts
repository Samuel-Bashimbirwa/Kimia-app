import { Controller, Get, Param, UseGuards } from '@nestjs/common';
import { DiagnosesService } from './diagnoses.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('diagnoses')
export class DiagnosesController {
  constructor(private readonly diagnosesService: DiagnosesService) {}

  @Get('submission/:submissionId')
  async findBySubmissionId(@Param('submissionId') submissionId: string) {
    return this.diagnosesService.findBySubmissionId(submissionId);
  }
}
