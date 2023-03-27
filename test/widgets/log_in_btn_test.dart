import 'package:Eventbrite/widgets/log_in_btn.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Log In Btn Test', (WidgetTester tester) async {
    const title = 'Log In';
    final Function onPressed = () {};
    const primaryColor = Colors.white;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: null,
          body: LogInBtn(
            title,
            onPressed,
          ),
        ),
      ),
    );

    //-----------------Title Text---------------------
    expect(
      find.text(title),
      findsOneWidget,
      reason: 'title Text not found',
    );

    //-----------------OnPressed---------------------
    expect(tester.widget<LogInBtn>(find.byType(LogInBtn)).onPressed, onPressed,
        reason: 'onPressed function not found');
  });
}
