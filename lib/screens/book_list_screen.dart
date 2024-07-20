// book_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
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
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                bookProvider.searchBooks(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (ctx, index) {
                final book = books[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(book.title, style: Theme.of(context).textTheme.bodyLarge),
                    subtitle: Text(book.author),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.secondary),
                      onPressed: () {
                        bookProvider.deleteBook(book.id);
                      },
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => BookDetailScreen(book.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => EditBookScreen(),
            ),
          );
        },
      ),
    );
  }
}
