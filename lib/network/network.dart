import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/book.dart';

class NetWork {
  static const String baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  Future<List<Book>> searchBooks(String query) async {
    var url = Uri.parse('$baseUrl?q=$query');
    var response = await http.get(url);

    if (response.statusCode == 200) {
     // we have data (json)
     var data = json.decode(response.body);
     if (data['items'] != null && data['items'] is List) {
       List<Book> books = (data['items'] as List<dynamic>)
       .map((book) => Book.fromJson(book as Map<String, dynamic>))
       .toList();

       return books;
     } else {
       return [];
     }
    } else {
      throw(Exception('Failed to load books'));
    }
}}