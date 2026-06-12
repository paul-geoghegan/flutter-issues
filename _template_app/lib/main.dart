import 'package:flutter/material.dart';

const String _appTitle = 'Template App';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE95420), // Ubuntu Orange
          primary: const Color(0xFFE95420),   // Ubuntu Orange
          secondary: const Color(0xFF772953), // Canonical Aubergine
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(_appTitle),
      ),
      body: const Center(
        child: Placeholder(),
      ),
    );
  }
}
