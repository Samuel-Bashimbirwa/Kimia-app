import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Topic } from './schemas/topic.schema';
import { Post } from './schemas/post.schema';
import { Comment } from './schemas/comment.schema';

@Injectable()
export class CommunityService {
  constructor(
    @InjectModel(Topic.name) private topicModel: Model<Topic>,
    @InjectModel(Post.name) private postModel: Model<Post>,
    @InjectModel(Comment.name) private commentModel: Model<Comment>,
  ) {}

  async findAllTopics(): Promise<Topic[]> {
    return this.topicModel.find().exec();
  }

  async createTopic(data: Partial<Topic>): Promise<Topic> {
    const topic = new this.topicModel(data);
    return topic.save();
  }

  async findPostsByTopic(topicId: string): Promise<Post[]> {
    return this.postModel.find({ topicId }).populate('authorId', 'pseudo').exec();
  }

  async createPost(data: Partial<Post>): Promise<Post> {
    const post = new this.postModel(data);
    return post.save();
  }

  async createComment(data: Partial<Comment>): Promise<Comment> {
    const comment = new this.commentModel(data);
    return comment.save();
  }

  async findCommentsByPost(postId: string): Promise<Comment[]> {
    return this.commentModel.find({ postId }).populate('authorId', 'pseudo').exec();
  }
}
