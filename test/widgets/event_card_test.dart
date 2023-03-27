// import '../../../lib/helper_functions/log_in.dart';
import 'package:Eventbrite/models/event.dart';
// import '../../../lib/screens/sign_up/sign_up_or_log_in.dart';
import 'package:Eventbrite/widgets/event_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  testWidgets('Event card test', (WidgetTester tester) async {
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------------------------------------------------- DUMMY DATA -----------------------------------------------------------------
    /// I want from DB cateory titles and each category list of events
    const imageUrl = 'assets/images/no_user_found.jfif';

    final Event event = Event(
        123,
        DateTime.now().add(const Duration(days: 1)),
        'We The Medicine- Healing Our Inner Child 2023.Guid...',
        imageUrl,
        EventState.online,
        false);
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///-------------------------------------------------------END OF DUMMY DATA -----------------------------------------------------------

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: null,
          body: EventCard(event), // Wrap EventCard with a Material widget
        ),
      ),
    );

    //----------------- Image ---------------------
    expect(find.byType(Image), findsOneWidget);

    //----------------- Descreption ---------------------
    expect(find.text(event.description), findsOneWidget);

    //----------------- Date ---------------------
    expect(
        find.text(
            '${DateFormat('EEE, MMM d • hh:mmaaa ').format(event.date)} EET'),
        findsOneWidget,
        reason: 'Date is not correct');

    //----------------- status(online/offline) ---------------------
    expect(find.text((event.state == EventState.online) ? 'Online' : 'Offline'),
        findsOneWidget);

    //----------------- followers ---------------------
    expect(
        find.text(event.creatorFollowers < 10000
            ? '${event.creatorFollowers} creator followers'
            : '${event.creatorFollowers} creator follow...'),
        findsOneWidget);

    //----------------- Person Icon ---------------------
    expect(find.byKey(const Key("person")), findsOneWidget);

    //----------------- Share Icon ---------------------
    expect(find.byKey(const Key("share")), findsOneWidget);

    //----------------- Button ---------------------
    final iconBtn = find.byType(IconButton);
    expect(iconBtn, findsOneWidget);
  });
}
