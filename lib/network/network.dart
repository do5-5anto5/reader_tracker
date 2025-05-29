import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/book.dart';

class NetWork {
  static const String baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  // Future<List<Book>> searchBooks(String query) async {
  Future<void> searchBooks(String query) async {
    var url = Uri.parse('$baseUrl?q=$query');
    var response = await http.get(url);

    if (response.statusCode == 200) {
     // we have data (json)
     var data = json.decode(response.body);
     if (kDebugMode) {
       print(data['totalItems']);
     }
    } else {
      // return [];
    }
}}