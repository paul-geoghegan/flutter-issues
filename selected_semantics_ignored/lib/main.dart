import 'package:flutter/material.dart';

const String _appTitle = 'Selected Semantics Ignored';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedListIndex = 1;
  bool _toggleSelected = true;

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
            // --- List items ---
            // BUG: Orca does not announce "selected" when navigating to a
            // list item that has Semantics(selected: true). The selected
            // state is set in the widget tree but the AT-SPI STATE_SELECTED
            // flag is never exposed to the screen reader.
            const Text('List (item 1 is selected):'),
            const SizedBox(height: 8),
            for (int i = 0; i < 3; i++)
              Semantics(
                selected: _selectedListIndex == i,
                child: ListTile(
                  title: Text('List item $i'),
                  selected: _selectedListIndex == i,
                  onTap: () => setState(() => _selectedListIndex = i),
                ),
              ),

            const SizedBox(height: 24),

            // --- Toggle / checkbox-style button ---
            // BUG: same issue — "selected" (toggled/pressed) state is
            // visually correct but Orca never announces "selected".
            const Text('Toggle button (currently selected):'),
            const SizedBox(height: 8),
            Semantics(
              selected: _toggleSelected,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _toggleSelected
                      ? Theme.of(context).colorScheme.primary
                      : null,
                  foregroundColor: _toggleSelected ? Colors.white : null,
                ),
                onPressed: () =>
                    setState(() => _toggleSelected = !_toggleSelected),
                child: Text(
                    'Toggle button (currently ${_toggleSelected ? 'selected' : 'not selected'})',
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- Plain focusable Semantics node ---
            // NOTE: it is unclear whether a non-interactive node is expected
            // to expose STATE_SELECTED on all platforms, so this case is
            // included only for comparison rather than as a definitive bug.
            const Text('Plain focusable Semantics node (selected: true):'),
            const SizedBox(height: 8),
            Focus(
              child: Semantics(
                selected: true,
                label: 'Static selected item',
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Static selected item'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
