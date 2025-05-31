import 'package:flutter/material.dart';
import 'package:reader_tracker/pages/book_details.dart';
import 'package:reader_tracker/pages/favorites_screen.dart';
import 'package:reader_tracker/pages/home_screen.dart';
import 'package:reader_tracker/pages/main_page.dart';
import 'package:reader_tracker/pages/saved_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'A.Reader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0x00F18215)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/details': (context) => const BookDetailsScreen(),
        '/saved': (context) => const SavedScreen(),
        '/favorites': (context) => const FavoriteScreen(),
      },
      home: const MainPage(),
    );
  }
}


