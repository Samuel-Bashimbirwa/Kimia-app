import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Submission } from './schemas/submission.schema';
import { LawsService } from '../laws/laws.service';
import { DiagnosesService } from '../diagnoses/diagnoses.service';

@Injectable()
export class SubmissionsService {
  constructor(
    @InjectModel(Submission.name) private submissionModel: Model<Submission>,
    private readonly lawsService: LawsService,
    private readonly diagnosesService: DiagnosesService,
  ) {}

  async create(data: Partial<Submission>): Promise<Submission> {
    const submission = new this.submissionModel(data);
    return submission.save();
  }

  async analyze(id: string): Promise<any> {
    const submission = await this.submissionModel.findById(id).exec();
    if (!submission) return null;

    // Simple analysis based on tags and text
    const laws = await this.lawsService.findAll(submission.textContext);
    
    // Create a diagnosis logic
    const score = this.calculateScore(submission);
    
    const diagnosis = await this.diagnosesService.create({
        submissionId: submission._id.toString(),
        userId: submission.userId?.toString(),
        score,
        matchedLaws: laws.map(l => l._id.toString()),
        recommendations: ["Consulter un avocat", "Garder les preuves"]
    });

    return diagnosis;
  }

  private calculateScore(submission: Submission): number {
    // Logic: keywords matching + questionnaire complexity
    let score = 20;
    if (submission.textContext.includes('force')) score += 30;
    if (submission.tags.includes('urgence')) score += 40;
    return Math.min(score, 100);
  }
}
