import 'package:Eventbrite/helper_functions/log_in.dart';
import 'package:Eventbrite/models/db_mock.dart';
import 'package:Eventbrite/models/user.dart';
import 'package:Eventbrite/screens/creator/live_events.dart';
import 'package:Eventbrite/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Drawer should contain all menu items',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EventDrawer(),
      ),
    );
    expect(find.text('Events'), findsOneWidget);
    expect(find.text('Search Orders'), findsOneWidget);
    expect(find.text('Change Organisation'), findsOneWidget);
    expect(find.text('Device Settings'), findsOneWidget);
    expect(find.text('Feedback'), findsOneWidget);
    expect(find.text('Log Out'), findsOneWidget);
  });
}
