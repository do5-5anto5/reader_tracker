import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';

import '../models/book.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  late Future<List<Book>> _booksFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = DatabaseHelper.instance.readAllBooks();
  }

  // Método para recarregar os livros
  void _loadBooks() {
    setState(() {
      _booksFuture = DatabaseHelper.instance.readAllBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder<List<Book>>(
          future: _booksFuture,
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
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      bool currentIsFavorite = book.isFavorite;
                                      bool newIsFavorite =
                                          !currentIsFavorite; // Calcula o NOVO estado
                                      try {
                                        debugPrint(
                                          'SAVED_SCREEN: Attempting to toggle favorite for book ID: ${book.id} from $currentIsFavorite to $newIsFavorite',
                                        );
                                        int value = await DatabaseHelper
                                            .instance
                                            .toggleFavoriteStatus(
                                              book.id,
                                              newIsFavorite, // Passa o NOVO estado
                                            );
                                        debugPrint(
                                          'SAVED_SCREEN: toggleFavoriteStatus returned: $value. Expected new state: $newIsFavorite',
                                        );

                                        if (value > 0) {
                                          // Se a atualização no banco foi bem-sucedida
                                          // Recarregue os livros para atualizar a UI
                                          _loadBooks();
                                        } else {
                                          debugPrint(
                                            'SAVED_SCREEN: Database update did not affect any rows.',
                                          );
                                          // Opcional: Mostrar um feedback de erro se value == 0
                                          if (mounted) {
                                            // Verifica se o widget ainda está montado
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Could not update favorite status. Book not found?',
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      } catch (error) {
                                        debugPrint(
                                          'SAVED_SCREEN: Failed to toggle favorite, $error',
                                        );
                                        if (mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text('Error: $error'),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    icon: Icon(Icons.favorite),
                                    label: const Text('Add to Favorites'),
                                  ),
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
