import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { Topic, TopicSchema } from './schemas/topic.schema';
import { Post, PostSchema } from './schemas/post.schema';
import { Comment, CommentSchema } from './schemas/comment.schema';
import { CommunityService } from './community.service';
import { CommunityController } from './community.controller';

@Module({
  imports: [MongooseModule.forFeature([
    { name: Topic.name, schema: TopicSchema },
    { name: Post.name, schema: PostSchema },
    { name: Comment.name, schema: CommentSchema },
  ])],
  providers: [CommunityService],
  controllers: [CommunityController],
  exports: [CommunityService],
})
export class CommunityModule {}
