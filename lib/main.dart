import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/book_provider.dart';
import './screens/book_list_screen.dart';
import './screens/edit_book_screen.dart';
import './screens/book_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => BookProvider()..loadPreferences()..loadBooks(),
      child: Consumer<BookProvider>(
        builder: (ctx, bookProvider, child) {
          return MaterialApp(
            title: 'Book Library',
            theme: ThemeData(
              primarySwatch: Colors.indigo,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: Colors.amber,
              ),
              textTheme: TextTheme(
                headlineLarge: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
                bodyMedium: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.indigo,
                titleTextStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              buttonTheme: ButtonThemeData(
                buttonColor: Colors.amber,
                textTheme: ButtonTextTheme.primary,
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
                  color: Colors.indigo,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.indigo,
                  ),
                ),
              ),
            ),
            darkTheme: ThemeData.dark(),
            themeMode: bookProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: BookListScreen(),
            routes: {
              EditBookScreen.routeName: (ctx) => EditBookScreen(),
              BookDetailScreen.routeName: (ctx) => BookDetailScreen(''),
            },
          );
        },
      ),
    );
  }
}
