import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:oyuncak_takasi/screens/login_screen.dart';

void main() {
  testWidgets('LoginScreen has a email and password field and login button',
      (WidgetTester tester) async {
    // Build LoginScreen in the test environment.
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Verify the presence of the email field.
    expect(find.byType(TextFormField), findsNWidgets(2));

    // Verify the presence of the login button.
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
