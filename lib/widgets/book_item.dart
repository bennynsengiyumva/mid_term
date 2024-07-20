import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../screens/book_detail_screen.dart';
import '../screens/edit_book_screen.dart';
import '../models/book.dart';

class BookItem extends StatelessWidget {
  final Book book;

  BookItem(this.book);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      subtitle: Text(book.author),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => EditBookScreen(book: book),
            ),
          );
        },
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => BookDetailScreen(book.id),
          ),
        );
      },
    );
  }
}
