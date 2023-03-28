import 'package:Eventbrite/screens/find_tickets.dart';
import 'package:Eventbrite/screens/sign_in/email_check.dart';
import 'package:Eventbrite/screens/sign_up/sign_up_or_log_in.dart';
import 'package:Eventbrite/widgets/log_in_btn.dart';
import 'package:Eventbrite/widgets/title_text_1.dart';
import 'package:Eventbrite/widgets/title_text_2.dart';
import 'package:Eventbrite/widgets/transparent_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //========================================================================================================================================
  //                                              CHECK ALL WITHOUT LOGIN BTN
  //========================================================================================================================================
  testWidgets('sign up or log in', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpOrLogIn(),
      ),
    );

    //----------------- Lets get started ---------------------
    expect(
        find.widgetWithText(TitleText1, 'Let\'s get started'), findsOneWidget);

    //----------------- paragrapth ---------------------
    expect(
        find.widgetWithText(TitleText2,
            'Sign up or log in in to see what\'s happening near you'),
        findsOneWidget);

    //----------------- continue with facebook button ---------------------
    final contWithFaceBtn =
        find.widgetWithText(TransparentButton, 'Continue With Facebook');
    expect(contWithFaceBtn, findsOneWidget);

    //----------------- continue with google button ---------------------
    final contWithgoogleBtn =
        find.widgetWithText(TransparentButton, 'Continue With Google');
    expect(contWithgoogleBtn, findsOneWidget);

    //----------------- find tickets button ---------------------
    final dontHaveAccount = find.widgetWithText(
        TextButton, 'I bought tickets, but I don\'t have an account.');
    expect(dontHaveAccount, findsOneWidget);
    await tester.tap(dontHaveAccount);
    await tester.pumpAndSettle();
    final findTickets = find.byType(FindTickets);
    expect(findTickets, findsOneWidget);
  });

  //========================================================================================================================================
  //                                              CHECK LOGIN BTN
  //========================================================================================================================================
  testWidgets('sign up or log in', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpOrLogIn(),
      ),
    );

    //----------------- Login button ---------------------
    final loginBtn =
        find.widgetWithText(LogInBtn, 'Continue with email address');
    expect(loginBtn, findsOneWidget);
    await tester.tap(loginBtn);
    await tester.pumpAndSettle();
    final emailCheck = find.byType(EmailCheck);
    expect(emailCheck, findsOneWidget);
  });
}
