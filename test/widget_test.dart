import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:webcal_client_app/app/app.dart';

void main() {
  testWidgets('renders WebCal app shell', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: WebCalApp()));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
