import 'package:flutter/material.dart';
import 'models/news_model.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black87,
          title: const Text('Back'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              article.imageUrl != null
                  ? Image.network(article.imageUrl!)
                  : Image.asset('assets/images/thumbnail.jpeg'),
              const SizedBox(height: 16.0),
              Text(
                article.title,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Published on ${article.publishedAt.toLocal()}',
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                article.content,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16.0, height: 1.5),
              ),
              const SizedBox(
                height: 35,
              )
            ],
          ),
        ),
      ),
    );
  }
}
