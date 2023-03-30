library SearchScreen;

import 'package:flutter/material.dart';

import '../models/event.dart';
import '../widgets/event_collection.dart';

class Search extends StatelessWidget {
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
  final List<Event> test1 = List<Event>.generate(
      6,
      (index) => Event(
          12354,
          DateTime.now(),
          'We The Medicine- Healing Our Inner Child 2023.Guid...',
          'https://cdn.evbstatic.com/s3-build/fe/build/images/7240401618ed7526be7cec3b43684583-2_tablet_1067x470.jpg',
          EventState.online,
          false));
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///-------------------------------------------------------END OF DUMMY DATA -----------------------------------------------------------

  Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white38,
          foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.filter_list_sharp,
                color: Colors.black,
              ),
              onPressed: () {
                // do something
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: TextButton(
                    onPressed: null,
                    child: Text(
                      'Online events',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color.fromARGB(229, 41, 41, 41),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Start searching...',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 147, 147, 147)),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(229, 41, 41, 41), width: 2.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 15, 106, 181), width: 2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 12,
                  itemBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      child: Card(
                        child: Text('Ahmed'),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 320,
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.orange.shade900,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 40),
                  itemCount: 1, // substitute with collectionCounts
                  itemBuilder: (ctx, index) {
                    return EventCollections("${10}K events",false , test1);
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
