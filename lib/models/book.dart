class Book {
  String id;
  String title;
  String author;
  String description;
  int rating;
  bool isRead;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    this.rating = 0,
    this.isRead = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'rating': rating,
      'isRead': isRead ? 1 : 0,
    };
  }
}