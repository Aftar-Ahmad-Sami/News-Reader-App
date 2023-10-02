class NewsArticle {
  final String title;
  final String description;
  final String? imageUrl;
  final String content;
  final DateTime publishedAt;

  NewsArticle({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
    required this.publishedAt,
  });
}
