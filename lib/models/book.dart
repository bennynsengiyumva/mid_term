class Book {
  final String id;
  String title;
  String author;
  int rating;
  bool isRead;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.rating = 0,
    this.isRead = false,
  });
}
