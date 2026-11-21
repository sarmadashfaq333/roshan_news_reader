import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
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
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    setState(() {
      _isLoading = true;
    });

    // 2 second ka wait
    await Future.delayed(const Duration(seconds: 2));

    Random random = Random();
    bool shouldFail = random.nextBool(); // 50% chance error

    if (shouldFail) {
      setState(() {
        _isLoading = false;
      });
      // Error popup dikhayein
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Network Error'),
          content: const Text('Failed to load articles. Please check your internet connection.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                fetchArticles(); // Dobara try karein
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    } else {
      // Agar error nahi aaya to data load karein
      final String jsonString = await rootBundle.loadString('assets/articles.json');
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;

      setState(() {
        _articles = jsonList.map((item) => Article.fromJson(item as Map<String, dynamic>)).toList();
        _isLoading = false;
      });
    }
  }

  @override

  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    title: const Text('Roshan News'),
    actions: [
      IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: () {
          fetchArticles();
        },
      ),
    ],
  ),
body: _isLoading
? const Center(child: CircularProgressIndicator())
: RefreshIndicator(
onRefresh: fetchArticles,
child: ListView.builder(
itemCount: _articles.length,
itemBuilder: (context, index) {
return ListTile(
title: Text(_articles[index].title),
onTap: () {
Navigator.pushNamed(
context,
'/detail',
arguments: _articles[index],
);
},
);
},
),
),
);
  }
}