import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/book.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  factory DBHelper() {
    return _instance;
  }

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'books.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE books(
        id TEXT PRIMARY KEY,
        title TEXT,
        author TEXT,
        description TEXT,
        rating INTEGER,
        isRead INTEGER
      )
    ''');
  }

  Future<void> insertBook(Book book) async {
    final db = await database;
    await db.insert(
      'books',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateBook(Book book) async {
    final db = await database;
    await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<void> deleteBook(String id) async {
    final db = await database;
    await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Book>> getBooks() async {
    final db = await database;
    final maps = await db.query('books');

    return List.generate(maps.length, (i) {
      return Book(
        id: maps[i]['id'] as String,
        title: maps[i]['title'] as String,
        author: maps[i]['author'] as String,
        description: maps[i]['description'] as String,
        rating: maps[i]['rating'] as int,
        isRead: maps[i]['isRead'] == 1,
      );
    });
  }
}
