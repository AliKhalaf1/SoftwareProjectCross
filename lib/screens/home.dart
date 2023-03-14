import 'package:eventbrite_replica/widgets/event_collection.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';

class Home extends StatelessWidget {
  ////////////////////////////////////////////////////////////////////////////////////////////
  /// I want from DB cateory titles and each category list of events
  final Event event = Event(
      123,
      DateTime.now(),
      'We The Medicine- Healing Our Inner Child 2023.Guid...',
      'https://cdn.evbstatic.com/s3-build/fe/build/images/7240401618ed7526be7cec3b43684583-2_tablet_1067x470.jpg',
      'eventRoute',
      EventState.online);

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

  void addDummyData() {
    for (var i = 0; i < 2; i++) {
      for (var j = 0; j < 1; j++) {
        // Map<String, Event> m = {categoryTitles[i]: event};
        categoriesList[i].add(event);
        print(categoriesList.length);
        print(categoriesList[i].length);
      }
    }
  }
  ////////////////////////////////////////////////////////////////////////////////////////////

  //conunt of the categories in home screen
  final int collectionCounts;
  final List<List<Event>> categoriesList = List.filled(2, []);

  Home(this.collectionCounts, {super.key});

  @override
  Widget build(BuildContext context) {
    //////////////////////////////////////////////////////////////////////
    addDummyData();
//index to loop with it on all categories
    //////////////////////////////////////////////////////////////////////

    return Scaffold(
      body: SizedBox(
        height: 700,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 30),
          itemCount: collectionCounts,
          itemBuilder: (ctx, index) {
            return Column(
              children: categoriesList.map((e) {
                return EventCollections(categoryTitles[index], e);
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
