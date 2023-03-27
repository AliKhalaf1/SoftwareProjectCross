import 'package:Eventbrite/screens/guest/profile_sign_up.dart';
import 'package:Eventbrite/widgets/button_link.dart';
import 'package:Eventbrite/widgets/log_in_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Guest Profile Page test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileSignUp(),
      ),
    );

    //----------------- Check UI Elements Exists---------------------
    expect(
      find.byType(ButtonLink),
      findsNWidgets(3),
      reason: 'The Link Buttons  aren\'t found',
    );

    //----------------- Check Log In Button Exists---------------------
    expect(
      find.widgetWithText(LogInBtn, 'Log In'),
      findsOneWidget,
      reason: 'The Log In Button isn\'t found',
    );
  });
}
