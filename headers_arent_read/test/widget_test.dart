import 'package:flutter_test/flutter_test.dart';

import 'package:headers_arent_read/main.dart';

void main() {
  testWidgets('app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });
}
