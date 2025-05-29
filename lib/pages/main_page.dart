import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reader_tracker/network/network.dart';
import 'package:reader_tracker/pages/saved_screen.dart';

import '../models/book.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int _currentIndex = 0;

  NetWork netWork = NetWork();

  Future<void> _searchBooks(String query) async {
    try {
      List<Book> books = await netWork.searchBooks(query);
      if (kDebugMode) {
        print('Books: ${books.toString()}');
      }
    } catch (e) {
      throw Exception('Failed getting network response');
    }
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const SavedScreen(),
    const FavoriteScreen(),
  ];

  @override
  void initState() {
    _searchBooks('android');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: (const Text('A.Reader')),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Saved'),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
