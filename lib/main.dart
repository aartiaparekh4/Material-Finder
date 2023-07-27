// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:material_finder/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Finder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0XFF9470dc)),
        useMaterial3: true,
        primaryColor: const Color(0XFF9470dc),
      ),
      home: const HomeScreen(),
    );
  }
}
