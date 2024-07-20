import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];

  List<Book> get books {
    return [..._books];
  }

  Future<void> addBook(Book book) async {
    _books.add(book);
    notifyListeners();
  }

  Future<void> updateBook(String id, Book newBook) async {
    final bookIndex = _books.indexWhere((book) => book.id == id);
    if (bookIndex >= 0) {
      _books[bookIndex] = newBook;
      notifyListeners();
    }
  }

  Future<void> deleteBook(String id) async {
    _books.removeWhere((book) => book.id == id);
    notifyListeners();
  }

  Book findById(String id) {
    return _books.firstWhere((book) => book.id == id);
  }

  Future<void> loadBooks() async {
    // Load books from persistent storage if needed
    notifyListeners();
  }
}
