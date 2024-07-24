import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/book_provider.dart';
import './screens/add_book_screen.dart';
import './screens/book_detail_screen.dart';
import './screens/book_list_screen.dart';
import './screens/edit_book_screen.dart';
import './screens/search_screen.dart';

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
            title: 'NB Library',
            theme: bookProvider.isDarkMode
                ? ThemeData.dark()
                : ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.grey[200],
            ),
            home: HomeScreen(),
            routes: {
              EditBookScreen.routeName: (ctx) => EditBookScreen(),
              BookDetailScreen.routeName: (ctx) => BookDetailScreen(''),
              SearchScreen.routeName: (ctx) => SearchScreen(),
              AddBookScreen.routeName: (ctx) => AddBookScreen(),
            },
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    BookListScreen(),
    SearchScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Provider.of<BookProvider>(context).isDarkMode;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: isDarkMode ? Colors.white : Colors.red[100],
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddBookScreen.routeName);
        },
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
