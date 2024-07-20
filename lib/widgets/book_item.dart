import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../screens/book_detail_screen.dart';
import '../screens/edit_book_screen.dart';
import '../models/book.dart'; // Import the Book model

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
          Navigator.of(context).pushNamed(EditBookScreen.routeName, arguments: book.id);
        },
      ),
      onTap: () {
        Navigator.of(context).pushNamed(BookDetailScreen.routeName, arguments: book.id);
      },
    );
  }
}
