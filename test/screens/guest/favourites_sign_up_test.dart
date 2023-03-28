import 'package:Eventbrite/screens/guest/favourites_sign_up.dart';
import 'package:Eventbrite/screens/sign_up/sign_up_or_log_in.dart';
import 'package:Eventbrite/widgets/log_in_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Favourites Render the four texts', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: FavouritesSignUp(),
      ),
    );

    expect(find.text('See your favourite in one place'), findsOneWidget);
    expect(find.text('Log in to see your favourites'), findsOneWidget);
    expect(find.text('Explore events'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
  });

  testWidgets('Renders expected background image', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: FavouritesSignUp(),
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
    expect(assetImageProvider.assetName, equals('assets/images/images1.jfif'));
  });

  testWidgets('LogInBtn Tab Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: FavouritesSignUp(),
      ),
    );

    final logInBtnFinder = find.byType(LogInBtn);
    expect(logInBtnFinder, findsOneWidget);
    await tester.tap(logInBtnFinder);
    await tester.pumpAndSettle();
    final signUpOrLogInFinder = find.byType(SignUpOrLogIn);
    expect(signUpOrLogInFinder, findsOneWidget);
  });
}
