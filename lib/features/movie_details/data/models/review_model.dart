class ReviewModel {
  final String author;
  final String content;
  final DateTime createdAt;
  final num? rating;
  final String? avatarPath;

  ReviewModel({
    required this.author,
    required this.content,
    required this.createdAt,
    this.rating,
    this.avatarPath,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    final authorDetails = json['author_details'] ?? {};
    return ReviewModel(
      author: json['author'] ?? 'Unknown',
      content: json['content'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      rating: authorDetails['rating'],
      avatarPath: authorDetails['avatar_path'],
    );
  }
}
