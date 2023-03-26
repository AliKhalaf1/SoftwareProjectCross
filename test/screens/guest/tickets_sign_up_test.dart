import 'package:eventbrite_replica/screens/guest/tickets_sign_up.dart';
import 'package:eventbrite_replica/screens/sign_up/sign_up_or_log_in.dart';
import 'package:eventbrite_replica/screens/tab_bar.dart';
import 'package:eventbrite_replica/widgets/button_find_things.dart';
import 'package:eventbrite_replica/widgets/log_in_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Renders TitleText1 Widget', () {
    testWidgets('tickets sign up ...', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Tickets(),
        ),
      );

      expect(find.text('Looking for your mobile tickets?'), findsOneWidget);
    });
    testWidgets('Renders expected background image',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Tickets(),
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
          home: Tickets(),
        ),
      );
      expect(find.text('Looking for your mobile tickets?'), findsOneWidget);
    });
    testWidgets('Renders LogInBtn Widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Tickets(),
        ),
      );

      final logInBtnFinder = find.byType(LogInBtn);
      expect(logInBtnFinder, findsOneWidget);
    });

    testWidgets('Renders GreyButton Widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Tickets(),
        ),
      );

      final greyButtonFinder = find.byType(GreyButton);
      expect(greyButtonFinder, findsOneWidget);
    });
    testWidgets('Tap Find Things To Do Button Navigates',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Tickets(),
        ),
      );

      final findThingsBtnFinder =
          find.widgetWithText(GreyButton, 'Find things to do');
      expect(findThingsBtnFinder, findsOneWidget);

      await tester.tap(findThingsBtnFinder);
      await tester.pumpAndSettle();

      final tabBarFinder = find.byType(TabBarScreen);
      expect(tabBarFinder, findsOneWidget);
    });
    testWidgets('Tap login button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Tickets(),
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
