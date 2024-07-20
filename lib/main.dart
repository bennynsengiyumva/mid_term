import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/book_provider.dart';
import './screens/book_list_screen.dart';
import './screens/book_detail_screen.dart';
import './screens/edit_book_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => BookProvider(),
      child: MaterialApp(
        title: 'My Library',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BookListScreen(),
        routes: {
          BookDetailScreen.routeName: (ctx) => BookDetailScreen(),
          EditBookScreen.routeName: (ctx) => EditBookScreen(),
        },
      ),
    );
  }
}
