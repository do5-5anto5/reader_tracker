import 'package:flutter/material.dart';

import '../models/book.dart';
import '../models/book_details_arguments.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final bookDetailsArguments =
        ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    final Book book = bookDetailsArguments.itemBook;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                if (book.imageLinks.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.network(
                      book.imageLinks['thumbnail'] ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                Column(
                  children: [
                    Text(
                      book.title,
                      style: textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    if (book.title == '' || book.authors.isEmpty)
                      Text(
                        book.authors.join(', '),
                        style: textTheme.titleSmall,
                      ),
                    Text(
                      'Published ${book.publishedDate}',
                      style: textTheme.bodySmall,
                    ),
                    Text(
                      'Page count ${book.pageCount.toString()}',
                      style: textTheme.bodySmall,
                    ),
                    Text(
                      'Language: ${book.language}',
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
