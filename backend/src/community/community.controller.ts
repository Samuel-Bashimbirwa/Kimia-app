import { Controller, Get, Post, Body, Param, Query, UseGuards, Request } from '@nestjs/common';
import { CommunityService } from './community.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('community')
export class CommunityController {
  constructor(private readonly communityService: CommunityService) {}

  @Get('topics')
  async findAllTopics() {
    return this.communityService.findAllTopics();
  }

  @Post('topics')
  async createTopic(@Body() data: any) {
    return this.communityService.createTopic(data);
  }

  @Get('posts')
  async findPostsByTopic(@Query('topicId') topicId: string) {
    return this.communityService.findPostsByTopic(topicId);
  }

  @UseGuards(JwtAuthGuard)
  @Post('posts')
  async createPost(@Body() data: any, @Request() req: any) {
    return this.communityService.createPost({ ...data, authorId: req.user.userId });
  }

  @Get('posts/:postId/comments')
  async findCommentsByPost(@Param('postId') postId: string) {
    return this.communityService.findCommentsByPost(postId);
  }

  @UseGuards(JwtAuthGuard)
  @Post('comments')
  async createComment(@Body() data: any, @Request() req: any) {
    return this.communityService.createComment({ ...data, authorId: req.user.userId });
  }
}
