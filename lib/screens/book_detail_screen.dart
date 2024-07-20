import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';

class BookDetailScreen extends StatelessWidget {
  static const routeName = '/book-detail';

  @override
  Widget build(BuildContext context) {
    final bookId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedBook = Provider.of<BookProvider>(context, listen: false).findById(bookId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedBook.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Author: ${loadedBook.author}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Rating: ${loadedBook.rating}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Read: ${loadedBook.isRead ? 'Yes' : 'No'}', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
