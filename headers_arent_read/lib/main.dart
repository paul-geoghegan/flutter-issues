import 'package:flutter/material.dart';

const String _appTitle = 'Headers Aren\'t Read';

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
          primary: const Color(0xFFE95420), // Ubuntu Orange
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
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BUG: Orca only announces "header" — the label is never read.
            Semantics(
              header: true,
              child: Focus(
                child: Text('Section One'),
              ),
            ),

            SizedBox(height: 32),
            // WORKS: Orca reads the text correctly when header is removed.
            Semantics(
              header: false,
              child: Focus(
                child: Text('Section Two'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
