import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../models/book.dart';
import 'edit_book_screen.dart';

class BookDetailScreen extends StatelessWidget {
  static const routeName = '/book-detail';

  final String id;

  BookDetailScreen(this.id);

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final book = bookProvider.books.firstWhere((book) => book.id == id);

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => EditBookScreen(book: book),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'by ${book.author}',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 10),
            Text(
              book.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Rating: ${book.rating}/5'),
                IconButton(
                  icon: Icon(Icons.star),
                  onPressed: () {
                    bookProvider.updateRating(book.id, book.rating == 5 ? 0 : book.rating + 1);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Read: ${book.isRead ? 'Yes' : 'No'}'),
                IconButton(
                  icon: Icon(book.isRead ? Icons.check_box : Icons.check_box_outline_blank),
                  onPressed: () {
                    bookProvider.toggleReadStatus(book.id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
