import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('App Bar Text Test', (WidgetTester tester) async {
    const title = 'test Text';
    const fontFamily = 'Neue Plak Text';
    const fontStyle = FontStyle.normal;
    const fontWeight = FontWeight.w600;
    const fontSize = 23.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: null,
          body: AppBarText(title),
        ),
      ),
    );

    //-----------------Title Text---------------------
    expect(
      find.text(title),
      findsOneWidget,
      reason: 'title Text not found',
    );

    //-----------------Font Match ---------------------
    expect(
      tester.widget<Text>(find.byType(Text)).style?.fontFamily,
      fontFamily,
      reason: 'fontFamily not found',
    );

    expect(
      tester.widget<Text>(find.byType(Text)).style?.fontSize,
      fontSize,
      reason: 'Font Size doesn\'t match',
    );
    expect(
      tester.widget<Text>(find.byType(Text)).style?.fontStyle,
      fontStyle,
      reason: ' fontStyle doesn\'t match',
    );
    expect(
      tester.widget<Text>(find.byType(Text)).style?.fontWeight,
      fontWeight,
      reason: 'fontWeight doesn\'t match',
    );
  });
}
