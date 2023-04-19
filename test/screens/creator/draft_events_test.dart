import 'package:Eventbrite/widgets/draft_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Eventbrite/screens/creator/draft_events.dart';

void main() {
  testWidgets('DraftEvents widget test', (WidgetTester tester) async {
    // Build the widget.
    await tester.pumpWidget(MaterialApp(home: DraftEvents()));

    // Check if the ListView is displayed.
    expect(find.byType(ListView), findsOneWidget);

    // Check if two DraftCards are displayed.
    expect(find.byType(DraftCard), findsAtLeastNWidgets(1));

    // Tap on the FloatingActionButton.
    await tester.tap(find.byKey(const Key('AddDraftEvent')));
    await tester.pumpAndSettle();
  });
}
