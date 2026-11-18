class Article {
  final int id;
  final String title;
  final String author;
  final String summary;
  final String body;
  final String category;
  final String date;

  const Article({
    required this.id,
    required this.title,
    required this.author,
    required this.summary,
    required this.body,
    required this.category,
    required this.date,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String? ?? 'Roshan Microfinance',
      summary: json['summary'] as String,
      body: json['body'] as String? ?? json['summary'] as String,
      category: json['category'] as String,
      date: json['date'] as String,
    );
  }
}