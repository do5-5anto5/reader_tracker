import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/book.dart';
import '../network/network.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NetWork netWork = NetWork();

  List<Book> _books = [];

  Future<void> _searchBooks(String query) async {
    try {
      List<Book> books = await netWork.searchBooks(query);
      if (kDebugMode) {
        setState(() {
          _books = books;
        });
      }
    } catch (e) {
      throw Exception('Failed getting network response, $e');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for a book',
                  suffix: Icon(Icons.search),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onSubmitted: (query) => _searchBooks(query),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ListView.builder(
                  itemCount: _books.length,
                  itemBuilder: (context, index) {
                    Book book = _books[index];
                    return ListTile(
                        title: Text(book.title),
                    subtitle: Text(book.authors.join(', & ')));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
