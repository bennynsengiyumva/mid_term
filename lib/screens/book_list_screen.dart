import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../widgets/book_item.dart';
import 'edit_book_screen.dart';

class BookListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookData = Provider.of<BookProvider>(context);
    final books = bookData.books;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Library'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditBookScreen.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (ctx, i) => BookItem(books[i]),
      ),
    );
  }
}
