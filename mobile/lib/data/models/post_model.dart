class PostModel {
  final String id;
  final String topicId;
  final String authorId;
  final String title;
  final String content;
  final String category;
  final int likes;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.topicId,
    required this.authorId,
    required this.title,
    required this.content,
    required this.category,
    this.likes = 0,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'] ?? '',
      topicId: json['topicId'] ?? '',
      authorId: json['authorId'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      category: json['category'] ?? 'TESTIMONY',
      likes: json['likes'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
