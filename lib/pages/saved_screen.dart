import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';

import '../models/book.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder<List<Book>>(
          future: DatabaseHelper.instance.readAllBooks(),
          builder:
              (context, snapshot) =>
                  snapshot.hasData
                      ? ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var book = snapshot.data![index];
                          return Card(
                            child: ListTile(
                              title: Text(book.title),
                              leading: Image.network(
                                book.imageLinks['smallThumbnail'] ?? '',
                                fit: BoxFit.cover,
                              ),
                              trailing: Icon(Icons.delete),
                              subtitle: Column(
                                children: [
                                  Text(book.authors.join(', ')),
                                  ElevatedButton.icon(onPressed: () async {
                                    
                                  },
                                  icon: Icon(Icons.favorite),
                                  label: const Text('Add to Favorites'))
                                ],
                              ),
                            ),
                          );
                        },
                      )
                      : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
