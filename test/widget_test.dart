import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myportfilo/app.dart';

void main() {
  testWidgets('Portfolio loads and language toggle is present', (tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();

    expect(find.textContaining('Yahya'), findsWidgets);
    expect(find.byIcon(Icons.language), findsOneWidget);
  });
}
