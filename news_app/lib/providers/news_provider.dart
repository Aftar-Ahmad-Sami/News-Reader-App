import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/constants.dart/string_const.dart';
import '../api.dart';
import '../models/news_model.dart';

final newsProvider =
    StateNotifierProvider<NewsNotifier, List<NewsArticle>>((ref) {
  return NewsNotifier(Api());
});

class NewsNotifier extends StateNotifier<List<NewsArticle>> {
  final Api _apiService;
  // final String apiKey = 'cbd4de19ae9f44e9b3d682fff63befda';

  NewsNotifier(this._apiService) : super([]);

  Future<void> fetchNews(BuildContext context) async {
    try {
      final news = await _apiService.fetchNews();
      final articles = news['results'] as List<dynamic>;
      url = news['nextPage'] as String;
      url = '$baseUrl&page=$url';
      final parsedArticles = articles.map((json) {
        return NewsArticle(
          title: json['title'] as String,
          description: json['description'] as String,
          imageUrl: json['image_url'] as String?,
          content: json['content'] as String,
          publishedAt: DateTime.parse(json['pubDate'] as String),
        );
      }).toList();
      state = parsedArticles;
    } catch (e) {
      debugPrint('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching news: $e'),
        ),
      );
    }
  }
}
