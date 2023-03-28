import 'package:Eventbrite/screens/sign_up/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //========================================================================================================================================
  //                                              CHECK ALL WITHOUT LOGIN BTN
  //========================================================================================================================================
  testWidgets('Sign Up Form Test', (WidgetTester tester) async {
    const dummyemail = 'test@test.com';

    await tester.pumpWidget(
      MaterialApp(
        home: SignUpForm(dummyemail),
      ),
    );

    //----------------- Check Fields Exists---------------------
    expect(
      find.widgetWithText(TextField, 'First Name*'),
      findsOneWidget,
      reason: 'First Name Field not found',
    );
    expect(
      find.widgetWithText(TextField, 'Surname*'),
      findsOneWidget,
      reason: 'Last Name Field not found',
    );

    expect(
      find.widgetWithText(DisabledEmailField, 'Email'),
      findsOneWidget,
      reason: 'Email Field not found',
    );
    expect(
      find.widgetWithText(DisabledEmailField, dummyemail),
      findsOneWidget,
      reason: 'Email Field not found',
    );

    expect(
      find.widgetWithText(TextField, 'Confirm Email*'),
      findsOneWidget,
      reason: 'Confirm Email Field not found',
    );

    // ========================================================================================================================================
    //                                              CHECK SignUp button
    // ========================================================================================================================================

    //----------------- SignUp button ---------------------
    final signUpBtn = find.widgetWithText(
      SignUpBtn,
      'Sign Up',
    );

    expect(
      signUpBtn,
      findsOneWidget,
      reason: 'SignUp Button not found',
    );
  });
}
