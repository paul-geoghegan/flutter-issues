import 'package:flutter_test/flutter_test.dart';

import 'package:selected_semantics_ignored/main.dart';

void main() {
  testWidgets('app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });
}
