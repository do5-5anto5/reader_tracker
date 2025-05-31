import 'package:flutter/material.dart';

import '../models/book.dart';
import '../models/book_details_arguments.dart';

class GridViewExpanded extends StatelessWidget {
  const GridViewExpanded({
    super.key,
    required List<Book> books,
  }) : _books = books;

  final List<Book> _books;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: _books.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (context, index) {
          Book book = _books[index];
          return Padding(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              left: 2,
              right: 2,
            ),
            child: Container(
              decoration: BoxDecoration(
                color:
                Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: BookDetailsArguments(itemBook: book),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Image.network(
                        book.imageLinks['thumbnail'] ?? '',
                        scale: 1.2,
                      ),
                    ),
                    Padding(
                      // padding: const EdgeInsets.only(right: 6, left: 6, bottom: 2.8),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        book.title,
                        style:
                        Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      // padding: const EdgeInsets.only(right: 6, left: 6),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        book.authors.join(', & '),
                        style:
                        Theme.of(context).textTheme.bodySmall,
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
    );
  }
}