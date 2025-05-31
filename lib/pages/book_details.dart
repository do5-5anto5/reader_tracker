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
    final bookDetailsArguments = ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    final Book book = bookDetailsArguments.itemBook;
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        // title: const Text('Book Details'),
      ),
    );
  }
}
