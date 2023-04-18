import 'package:Eventbrite/widgets/backgroud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Eventbrite/screens/creator/past_events.dart';

void main() {
  testWidgets('Should display no past events', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: PastEvents()));
   expect(find.byType(Background), findsOneWidget);
    
    final finder = find.byKey(const Key('AddPastEvent'));
    expect(finder, findsOneWidget);
  });
}
