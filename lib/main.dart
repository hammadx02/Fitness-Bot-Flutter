import 'package:fitness_bot/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Bot',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const HomeScreen(),
    );
  }
}
