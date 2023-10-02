import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'details.dart';
import 'models/news_model.dart';
import 'providers/news_provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final RefreshController _refreshController = RefreshController();
  List<NewsArticle> newsList = []; // Add a list to hold news articles

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchNews();
    });
  }

  Future<dynamic> _fetchNews() async {
    try {
      final articles = await ref.read(newsProvider.notifier).fetchNews(context);
      return articles;
    } catch (e) {
      return [];
    }
  }

  void _onRefresh() async {
    final articles = await _fetchNews();
    setState(() {
      newsList = articles;
    });
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(newsProvider);
    final newsList = ref.read(newsProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black87,
          centerTitle: true,
          title: const Text(
            'News',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final newsArticle = newsList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              NewsDetailPage(article: newsArticle),
                        ),
                      );
                    },
                    leading: SizedBox(
                      width: 80.0,
                      child: newsArticle.imageUrl != null
                          ? Image.network(newsArticle.imageUrl!)
                          : Image.asset('assets/images/thumbnail.jpeg'),
                    ),
                    title:
                        Text(newsArticle.title, textAlign: TextAlign.justify),
                    subtitle: Text(newsArticle.description,
                        textAlign: TextAlign.justify),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
