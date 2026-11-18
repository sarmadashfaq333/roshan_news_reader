import 'package:flutter/material.dart';
import 'models/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;
  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Article Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(article.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text('By ${article.author} | ${article.date}', style: TextStyle(color: Colors.grey[600])),
              const Divider(height: 30),
              Text(article.body, style: const TextStyle(fontSize: 16, height: 1.5)),
              const Divider(height: 30),

              const Divider(height: 30),

            ],
          ),
        ),
      ),
    );
  }
}