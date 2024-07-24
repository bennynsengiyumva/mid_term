import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/book_provider.dart';
import '../screens/add_book_screen.dart'; // Import AddBookScreen
import '../screens/book_detail_screen.dart';
import '../screens/edit_book_screen.dart';

class BookListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final books = bookProvider.books;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Book Library'),
        actions: [
          IconButton(
            icon: Icon(bookProvider.isDarkMode ? Icons.brightness_7 : Icons.brightness_2),
            onPressed: () {
              bookProvider.toggleTheme();
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              bookProvider.setSortOrder(value);
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Sort by Title'),
                value: 'title',
              ),
              PopupMenuItem(
                child: Text('Sort by Author'),
                value: 'author',
              ),
              PopupMenuItem(
                child: Text('Sort by Read Status'),
                value: 'read',
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (ctx, index) {
                final book = books[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          bookProvider.deleteBook(book.id);
                        },
                      ),
                      Icon(book.isRead
                          ? Icons.check_box
                          : Icons.check_box_outline_blank),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => BookDetailScreen(book.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddBookScreen.routeName);
        },
      ),
    );
  }
}