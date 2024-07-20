// book_provider.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book.dart';
import '../helpers/db_helper.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];
  String _sortOrder = 'title';
  bool _isDarkMode = false;
  List<Book> _filteredBooks = [];
  String _searchQuery = '';

  List<Book> get books {
    List<Book> sortedBooks = [..._books];
    if (_sortOrder == 'title') {
      sortedBooks.sort((a, b) => a.title.compareTo(b.title));
    } else if (_sortOrder == 'author') {
      sortedBooks.sort((a, b) => a.author.compareTo(b.author));
    }

    if (_searchQuery.isNotEmpty) {
      sortedBooks = sortedBooks.where((book) {
        return book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            book.author.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    return sortedBooks;
  }

  String get sortOrder => _sortOrder;
  bool get isDarkMode => _isDarkMode;

  Future<void> addBook(Book book) async {
    await DBHelper().insertBook(book);
    _books.add(book);
    notifyListeners();
  }

  Future<void> updateBook(String id, Book newBook) async {
    final bookIndex = _books.indexWhere((book) => book.id == id);
    if (bookIndex >= 0) {
      await DBHelper().updateBook(newBook);
      _books[bookIndex] = newBook;
      notifyListeners();
    }
  }

  Future<void> deleteBook(String id) async {
    await DBHelper().deleteBook(id);
    _books.removeWhere((book) => book.id == id);
    notifyListeners();
  }

  Future<void> toggleReadStatus(String id) async {
    final bookIndex = _books.indexWhere((book) => book.id == id);
    if (bookIndex >= 0) {
      _books[bookIndex].isRead = !_books[bookIndex].isRead;
      await DBHelper().updateBook(_books[bookIndex]);
      notifyListeners();
    }
  }

  Future<void> updateRating(String id, int rating) async {
    final bookIndex = _books.indexWhere((book) => book.id == id);
    if (bookIndex >= 0) {
      _books[bookIndex].rating = rating;
      await DBHelper().updateBook(_books[bookIndex]);
      notifyListeners();
    }
  }

  Future<void> setSortOrder(String order) async {
    _sortOrder = order;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('sortOrder', _sortOrder);
    notifyListeners();
  }

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _sortOrder = prefs.getString('sortOrder') ?? 'title';
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> loadBooks() async {
    _books = await DBHelper().getBooks();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  void searchBooks(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
