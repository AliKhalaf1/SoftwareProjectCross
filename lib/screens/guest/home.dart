library GuestHomeScreen;

import '../../widgets/event_collection.dart';
import 'package:flutter/material.dart';
import '../../models/event.dart';

/// {@category Guest}
/// {@category Screens}
///      It is surrounded by scafold to be rendered as a screen because it is screen widget. 
/// 
///      Extends StatelessWidget as there is no change in any state in screen that could change rendered page content. 
/// 
///      DUMMY DATA to be substituted after linking with Apis and database.
/// 
///     ###ListView
/// 
///      Wdiget used to add multiple items in column and overflowed items becomes scrollable.
/// 
///       #####itemCount
/// 
///         it takes count of items to render inside ListView.
/// 
///       #####itemBuilder
/// 
///         it render each item by loop on them until reaching itemCount.
/// 
///     ###EventCollections
/// 
///      Widget with certain styling and not built in widgets like (i.e. Text)
/// 
///      You can find it in folder  under the name widgets
/// 
///      It takes (categotey title & list of events) to render events in a coloumn where each is in a card.
/// 
///     ###viewMore
/// 
///      Handler for button navigate to search screen when pressing on to it.
/// 
///      Search screen index is 1 in tabBaerScreen so we send its index to tabBaerScreen to understands which page to render.
/// 

class Home extends StatelessWidget {
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///------------------------------------------------------- DUMMY DATA -----------------------------------------------------------------
  /// I want from DB cateory titles and each category list of events
  final Event event = Event(
      123,
      DateTime.now(),
      'We The Medicine- Healing Our Inner Child 2023.Guid...',
      'https://cdn.evbstatic.com/s3-build/fe/build/images/7240401618ed7526be7cec3b43684583-2_tablet_1067x470.jpg',
      EventState.online,
      false);

  final List<String> categoryTitles = [
    "Title 1",
    "Title 2",
    "Title 3",
    "Title 4",
    "Title 5",
    "Title 6",
    "Title 7",
    "Title 8",
    "Title 9",
    "Title 10"
  ];

  void addDummyData(List<Event> t1, List<Event> t2) {
    categoriesList.add(t1);
    categoriesList.add(t2);
  }

  final List<Event> test1 = List<Event>.generate(
      6,
      (index) => Event(
          12354,
          DateTime.now(),
          'We The Medicine- Healing Our Inner Child 2023.Guid...',
          'https://cdn.evbstatic.com/s3-build/fe/build/images/7240401618ed7526be7cec3b43684583-2_tablet_1067x470.jpg',
          EventState.online,
          false));
  final List<Event> test2 = List<Event>.generate(
      2,
      (index) => Event(
          123,
          DateTime.now(),
          'We The Medicine- Healing Our Inner Child 2023.Guid...',
          'https://cdn.evbstatic.com/s3-build/fe/build/images/7240401618ed7526be7cec3b43684583-2_tablet_1067x470.jpg',
          EventState.online,
          false));
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///-------------------------------------------------------END OF DUMMY DATA -----------------------------------------------------------

  //conunt of the categories in home screen
  final int collectionCounts;
  final List<List<Event>> categoriesList = [];
  Home(this.collectionCounts, {super.key});

  @override
  Widget build(BuildContext context) {
    //////////////////////////////////////////////////////////////////////
    addDummyData(test1, test2);
    //////////////////////////////////////////////////////////////////////

    return Scaffold(
      body: SizedBox(
        height: 700,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 40),
          itemCount: 2, // substitute with collectionCounts
          itemBuilder: (ctx, index) {
            return EventCollections(
                categoryTitles[index], categoriesList[index]);
          },
        ),
      ),
    );
  }
}
