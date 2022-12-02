import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('about page', (tester) async {
    final findTypeText = find.byType(Text);

    await tester.pumpWidget(const MaterialApp(home: AboutPage()));

    expect(findTypeText, findsOneWidget);

    await tester.tap(find.byType(IconButton));
  });
}
