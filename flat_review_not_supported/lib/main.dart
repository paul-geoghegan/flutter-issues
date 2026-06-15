import 'package:flutter/material.dart';

const String _appTitle = 'Flat Review Not Supported';

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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // These Text widgets are plain, unfocusable content.
            // In a web browser a screen reader user can navigate through
            // all of this text line-by-line or word-by-word using the arrow
            // keys (browse/reading mode). On the Linux desktop, Orca's flat
            // review (Insert+U/I/O for previous/current/next line, or
            // Insert+KP_5 etc. for words) allows the same kind of navigation
            // in native apps.
            //
            // BUG: Neither mechanism works in Flutter. Flat review always
            // reports just the name of the app and browse-mode
            // arrow keys just move through focusable content. The only content a screen reader can
            // reach is content that has keyboard focus — i.e. widgets that
            // have been given a Focus ancestor or are inherently focusable
            // (buttons, text fields, etc.).
            const Text('Line one — this text is NOT focusable.'),
            const SizedBox(height: 8),
            const Text('Line two — also not focusable.'),
            const SizedBox(height: 8),
            const Text('Line three — also not focusable.'),
            const SizedBox(height: 32),
            // WORKAROUND: wrapping Text in a Focus widget makes it reachable
            // via Tab, but that is not the same as flat review — the user
            // must know to tab to each item and cannot navigate freely. along with the fact that usually only interactable widgets are focusable, this is not a good workaround.
            Focus(
              child: const Text(
                'This line IS focusable (wrapped in Focus) '
                'and can be reached with Tab, but flat review '
                'still does not let the user navigate to it freely.',
              ),
            ),
            const SizedBox(height: 32),
            // A button is focusable by default and is readable — but only
            // because focus exists, not because flat review works.
            ElevatedButton(
              onPressed: () {},
              child: const Text('Focusable button — readable via Tab only'),
            ),
          ],
        ),
      ),
    );
  }
}
