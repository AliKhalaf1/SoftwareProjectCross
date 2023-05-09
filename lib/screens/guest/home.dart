library GuestHomeScreen;

import 'dart:ui';

import 'package:Eventbrite/helper_functions/Search.dart';
import 'package:Eventbrite/helper_functions/constants.dart';
import 'package:Eventbrite/objectbox.dart';
import 'package:Eventbrite/providers/getevent/getevent.dart';

import '../../helper_functions/log_in.dart';
import '../../objectbox.g.dart';
import '../../providers/events/event.dart';
import '../../widgets/event_collection.dart';
import '../../providers/categories/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/events/events.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../providers/categories/categorey.dart';
import '../../widgets/loading_spinner.dart';

/// {@category Guest}
/// {@category Screens}
///
/// <h1>Home screen for Guests and Users</h1>
///
/// it contains a list of events in a column
/// andeach event is in a card
///
///
///<b>ListView</b>
///
///Widget used to add multiple items in column and overflowed items becomes scrollable.
///
///itemCount:
///it takes count of items to render inside ListView.
///
///itemBuilder:
///it render each item by loop on them until reaching itemCount.
///
///<b>EventCollections</b>
///
///Widget with certain styling and not built in widgets like (i.e. Text)
///
///You can find it in folder  under the name widgets
///
///It takes (categotey title & list of events) to render events in a coloumn where each is in a card.
///
///<b>viewMore</b>
///
///Handler for button navigate to search screen when pressing on to it.
///
///Search screen index is 1 in tabBaerScreen so we send its index to tabBaerScreen to understands which page to render.
///
class Home extends StatefulWidget {
  bool isLoading = true;
  static const homePageRoute = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Fecth them from API Categories that gets all categories
  // var _isInit = true;
  // var _isLoading = false;

  // list of all static categories
  final List<String> categoryTitles = [
    "Loyality",
    "Learn",
    "Business",
    "Health",
    "Tech",
    "Sports & Fitness",
    "Culture",
    "Music",
    "Performing & Visual Arts",
    "Holiday",
    "Hobbies",
    "Food & Drink",
  ];

  // list of list<Event> of all static categories
  List<List<Event>> events = [];

  Future<void> fetchAllEvents() async {
    setState(() {
      widget.isLoading = true;
    });
    if (Constants.MockServer == false) {
      for (int i = 0; i < categoryTitles.length; i++) {
        await search(
          "",
          "",
          "",
          "",
          DateTime(2100, 1, 1),
          DateTime(2100, 1, 1),
          categoryTitles[i],
        ).then((value) {
          if (value.isEmpty) {
            events.add([]);
          } else {
            // print('Database sucess');
            events.add(value);
            // print('success');
            // print(events.last[0].categ);
            // print(events.last[0].description);
            // print(events.last[0].id);
            // print(events.last[0].eventImg);
            // print(events.last[0].isFav);
            // print(events.last[0].organization);
          }
        });
      }
    } else {
      var eventsbox = ObjectBox.eventBox;
      for (int i = 0; i < categoryTitles.length; i++) {
        var events = eventsbox
            .query(Event_.categ.equals(categoryTitles[i]))
            .build()
            .find();

        if (events.isEmpty) {
          this.events.add([]);
        } else {
          this.events.add(events);
        }
      }
    }
  }

  // @override
  // void didChangeDependencies() {

  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    fetchAllEvents().then((value) {
      setState(() {
        widget.isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final eventsData = Provider.of<Events>(context);
    // final events = eventsData.events;

    // if (checkLoggedUser() == false) {
    //   eventsData.unFavouriteAll();
    // }

    // final cats = Provider.of<Categories>(context);

    return Scaffold(
      key: const Key("HomeScreen"),
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 1,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        shadowColor: const Color.fromARGB(255, 255, 255, 255),
        leadingWidth: double.infinity,
        leading: Stack(children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/o3.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Borto',
                    style: TextStyle(
                        fontFamily: "Neue Plak Text",
                        fontSize: 27,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 55, 55, 55))),
                Image(
                  image: AssetImage("assets/images/icon.png"),
                  width: 35,
                  height: 35,
                ),
                Text('an ',
                    style: TextStyle(
                        fontFamily: "Neue Plak Text",
                        fontSize: 27,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 55, 55, 55))),
              ],
            ),
          ),
        ]),
      ),
      body: widget.isLoading == true
          ? const LoadingSpinner()
          : SizedBox(
              height: 700,
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: const Color.fromARGB(255, 255, 72, 0),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount:
                      categoryTitles.length, // substitute with collectionCounts
                  itemBuilder: (ctx, index) {
                    // List<Event> events = [];
                    // search(
                    //   "",
                    //   "",
                    //   "",
                    //   "",
                    //   DateTime(2100, 1, 1),
                    //   DateTime(2100, 1, 1),
                    //   categoryTitles[index],
                    // ).then((value) {
                    //   if (value.isEmpty) {
                    //     events = [];
                    //     print('${categoryTitles[index]} is empty');
                    //   } else {
                    //     print('${categoryTitles[index]} is Not empty');
                    //     events = value;
                    //     print('success');
                    //     print(events[0].categ);
                    //     print(events[0].description);
                    //     print(events[0].id);
                    //     print(events[0].eventImg);
                    //     print(events[0].isFav);
                    //     print(events[0].organization);
                    //   }
                    // });
                    EventCollections(
                        categoryTitles[index], true, events[index]);

                    // List<Event> matchedEvents = events
                    //     .where(
                    //         (eventItem) => eventItem.categ == categoryTitles[index])
                    //     .toList();
                  },
                ),
              ),
            ),
    );
  }
}
