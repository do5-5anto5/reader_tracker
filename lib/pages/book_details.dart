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
              mainAxisAlignment: MainAxisAlignment.center,
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Save'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.favorite),
                          label: const Text('Add to Favorites'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text('Description', style: textTheme.titleMedium),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withAlpha(150),
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(
                          context,
                        ).colorScheme.inversePrimary.withAlpha(40),
                      ),
                      child: Text(book.description),
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
