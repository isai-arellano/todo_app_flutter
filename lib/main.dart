import 'package:flutter/material.dart';
import 'package:todo_app_flutter/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      useMaterial3: true,
    ),
    );
  }
}