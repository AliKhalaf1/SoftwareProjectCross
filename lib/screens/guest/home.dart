library GuestHomeScreen;

import '../../providers/events/event.dart';
import '../../widgets/event_collection.dart';
import '../../providers/categories/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/events/events.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../providers/categories/categorey.dart';

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
  // var _isInit = true;
  // var _isLoading = false;

  final List<String> categoryTitles = [
    "Tech",
    "Sports",
    "Health & Wellness",
    "Art",
    "Business",
    "Family & Education",
    "Science",
    "Culture"
  ];

  // List<Categorey> _categories = [];

  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     Provider.of<Categories>(context).fetchCategories().then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  // @override
  // Future<void> didChangeDependencies() async {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     final url = Uri.http('http://127.0.0.1:8000/categories/');
  //     try {
  //       final response = await http.get(url);
  //       final extractedData =
  //           json.decode(response.body) as Map<String, List<String>>;
  //       if (extractedData == null) {
  //         return;
  //       }
  //       final List<Categorey> loadedcategories = [];
  //       extractedData.forEach((catTitle, subCats) {
  //         loadedcategories.add(Categorey(catTitle, subCats));
  //       });
  //       _categories = loadedcategories;

  //       setState(() {
  //         _isLoading = false;
  //       });
  //     } catch (error) {
  //       throw (error);
  //     }
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final eventsData = Provider.of<Events>(context);
    final events = eventsData.events;

    // final cats = Provider.of<Categories>(context);

    return Scaffold(
      body: SizedBox(
        height: 700,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 40),
          itemCount: categoryTitles.length, // substitute with collectionCounts
          itemBuilder: (ctx, index) {
            List<Event> matchedEvents = events.where((eventItem) => eventItem.categ == categoryTitles[index]).toList();
            return EventCollections(categoryTitles[index], true, matchedEvents);
          },
        ),
      ),
    );
  }
}
