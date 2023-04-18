import 'package:Eventbrite/widgets/live_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Eventbrite/screens/creator/live_events.dart';

void main() {
  testWidgets('Live events should contain all Live events cards',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LiveEvents()));
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(LiveCard), findsAtLeastNWidgets(1));
    expect(find.byKey(const Key('AddLiveEvent')), findsOneWidget);
  });
}
