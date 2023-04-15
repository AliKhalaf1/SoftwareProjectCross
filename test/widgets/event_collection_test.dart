import 'package:Eventbrite/providers/event.dart';
import 'package:Eventbrite/widgets/event_card.dart';
import 'package:Eventbrite/widgets/event_collection.dart';
import 'package:Eventbrite/widgets/title_text_1.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  //========================================================================================================================================
  //                                              6 events with view more
  //========================================================================================================================================
  testWidgets('event collection', (WidgetTester tester) async {
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------------------------------------------------- DUMMY DATA -----------------------------------------------------------------
    /// I want from DB cateory titles and each category list of events

    final List<Event> test1 = List<Event>.generate(
        6,
        (index) => Event(
            12354,
            DateTime.now(),
            'We The Medicine- Healing Our Inner Child 2023.Guid...',
            'assets/images/no_user_found.jfif',
            EventState.online,
            false,"Tech",['smart','wellness','aykalam'],'0'));
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///-------------------------------------------------------END OF DUMMY DATA -----------------------------------------------------------
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: ListView(children: [
          EventCollections("Title 1", true, test1),
        ])), // Wrap EventCard with a Material widget
      ),
    );

    //----------------- Title ---------------------
    expect(find.byType(TitleText1), findsOneWidget);

    //-----------------  Events ---------------------
    expect(find.byType(EventCard), findsNWidgets(6));

    //-----------------  View more button ---------------------
    expect(find.text('View more events'), findsOneWidget);
    final viewMoreBtn = find.widgetWithText(TextButton, 'View more events');
    expect(viewMoreBtn, findsOneWidget);
  });

  //========================================================================================================================================
  //                                              2 events without view more
  //========================================================================================================================================
  testWidgets('event collection', (tester) async {
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------------------------------------------------- DUMMY DATA -----------------------------------------------------------------
    /// I want from DB cateory titles and each category list of events

    final List<Event> test2 = List<Event>.generate(
        2,
        (index) => Event(
            123,
            DateTime.now(),
            'We The Medicine- Healing Our Inner Child 2023.Guid...',
            'assets/images/no_user_found.jfif',
            EventState.online,
            false,"Tech",['smart','wellness','aykalam'],'1'));
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///-------------------------------------------------------END OF DUMMY DATA -----------------------------------------------------------
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: ListView(children: [
          EventCollections("Title 2", true, test2),
        ])), // Wrap EventCard with a Material widget
      ),
    );

    //----------------- Title ---------------------
    expect(find.byType(TitleText1), findsOneWidget);

    //-----------------  Events ---------------------
    expect(find.byType(EventCard), findsNWidgets(2));

    //-----------------  View more button ---------------------
    expect(find.text('View more events'), findsNothing);
  });
}
