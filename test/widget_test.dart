import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:axscend_flutter_task/main.dart';

// Basic widget smoke test: verify the app builds and shows the Users screen title.
void main() {
  testWidgets('App loads and shows Users screen title', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    // Verify AppBar title appears
    expect(find.text('Users'), findsOneWidget);
  });
}