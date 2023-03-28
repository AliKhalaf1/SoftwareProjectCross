import 'package:Eventbrite/screens/guest/tickets_sign_up.dart';
import 'package:Eventbrite/screens/sign_up/sign_up_or_log_in.dart';
import 'package:Eventbrite/screens/tab_bar.dart';
import 'package:Eventbrite/widgets/button_find_things.dart';
import 'package:Eventbrite/widgets/log_in_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Renders TitleText1 Widget', () {
    testWidgets('tickets sign up ...', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TicketsSignUp(),
        ),
      );

      expect(find.text('Looking for your mobile tickets?'), findsOneWidget);
    });
    testWidgets('Renders expected background image',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TicketsSignUp(),
        ),
      );

      final containerFinder = find.byKey(
        const Key('myContainerKey'),
      );
      expect(containerFinder, findsOneWidget);

      final containerWidget = tester.widget<Container>(containerFinder);
      final decoration = containerWidget.decoration as BoxDecoration;

      final imageProvider = decoration.image as DecorationImage;
      final assetImageProvider = imageProvider.image as AssetImage;
      expect(
        assetImageProvider.assetName,
        equals('assets/images/images.jfif'),
      );
    });
    testWidgets('Renders TitleText2 Widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TicketsSignUp(),
        ),
      );
      expect(find.text('Looking for your mobile tickets?'), findsOneWidget);
    });
    testWidgets('Renders LogInBtn Widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TicketsSignUp(),
        ),
      );

      final logInBtnFinder = find.byType(LogInBtn);
      expect(logInBtnFinder, findsOneWidget);
    });

    testWidgets('Renders GreyButton Widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TicketsSignUp(),
        ),
      );

      final greyButtonFinder = find.byType(GreyButtonLogout);
      expect(greyButtonFinder, findsOneWidget);
    });
    testWidgets('Tap Find Things To Do Button Navigates',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TicketsSignUp(),
        ),
      );

      final findThingsBtnFinder =
          find.widgetWithText(GreyButtonLogout, 'Find things to do');
      expect(findThingsBtnFinder, findsOneWidget);

      await tester.tap(findThingsBtnFinder);
      await tester.pumpAndSettle();

      final tabBarFinder = find.byType(TabBarScreen);
      expect(tabBarFinder, findsOneWidget);
    });
    testWidgets('Tap login button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TicketsSignUp(),
        ),
      );

      final logInBtnFinder = find.byType(LogInBtn);
      expect(logInBtnFinder, findsOneWidget);
      await tester.tap(logInBtnFinder);
      await tester.pumpAndSettle();

      final signUpOrLogInFinder = find.byType(SignUpOrLogIn);
      expect(signUpOrLogInFinder, findsOneWidget);
    });
  });
}
