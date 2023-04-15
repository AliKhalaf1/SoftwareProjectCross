library GuestHomeScreen;

import '../../widgets/event_collection.dart';
import '../../models/categories/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/events/events.dart';

/// {@category Guest}
/// {@category Screens}
///
/// <h1>Home screen for Guests and Users</h1>
///
/// it contains a list of events in a column
/// andeach event is in a card
///
///DUMMY DATA to be substituted after linking with Apis and database.
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
  static const homePageRoute = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Fecth them from API Categories that gets all categories
  var _isInit = true;
  var _isLoading = false;

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

  late final Categories cats;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      cats.fetchCategories().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final eventsData = Provider.of<Events>(context);
    final events = eventsData.events;

    return Scaffold(
      body: SizedBox(
        height: 700,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 40),
          itemCount: 2, // substitute with collectionCounts
          itemBuilder: (ctx, index) {
            return EventCollections(cats.categories[index].title, true, events);
          },
        ),
      ),
    );
  }
}
