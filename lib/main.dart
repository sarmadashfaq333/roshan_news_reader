import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'models/article.dart';
import 'article_detail_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roshan News Reader',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      routes: {
        '/detail': (context) {
          final article = ModalRoute.of(context)!.settings.arguments as Article;
          return ArticleDetailScreen(article: article);
        },
      },
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Article> _articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    final String jsonString =
    await rootBundle.loadString('assets/articles.json');
    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    setState(() {
      _articles = jsonList
          .map((item) => Article.fromJson(item as Map<String, dynamic>))
          .toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Roshan News')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _articles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_articles[index].title),
            // Yahan se naya code shuru:
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: _articles[index], // Yahan index wala article pass kiya
              );
            },
            // Naya code khatam
          );
        },
      ),
    );
  }
}