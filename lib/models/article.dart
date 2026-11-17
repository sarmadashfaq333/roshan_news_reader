class Article {
  final int id;
  final String title;
  final String summary;
  final String category;
  final String date;

  const Article({
    required this.id,
    required this.title,
    required this.summary,
    required this.category,
    required this.date,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int,
      title: json['title'] as String,
      summary: json['summary'] as String,
      category: json['category'] as String,
      date: json['date'] as String,
    );
  }
}