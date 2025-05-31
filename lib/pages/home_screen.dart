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
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for a book',
                    suffix: Icon(Icons.search),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onSubmitted: (query) => _searchBooks(query),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: _books.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (context, index) {
                    Book book = _books[index];
                    return Container(
                      decoration: BoxDecoration(
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/details');
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(18),
                                child: Image.network(
                                  book.imageLinks['thumbnail'] ?? '',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  book.title,
                                  style: Theme.of(context).textTheme.titleSmall,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  book.authors.join(', & '),
                                  style: Theme.of(context).textTheme.bodySmall,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Expanded(
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: ListView.builder(
              //       itemCount: _books.length,
              //       itemBuilder: (context, index) {
              //         Book book = _books[index];
              //         return ListTile(
              //             title: Text(book.title),
              //         subtitle: Text(book.authors.join(', & ')));
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
