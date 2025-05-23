import 'package:flutter/material.dart';
import 'package:reader_tracker/pages/main_page.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0x00e94d2a)),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}


