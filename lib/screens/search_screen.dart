library SearchScreen;

import 'package:Eventbrite/widgets/grey_area.dart';
import 'package:flutter/material.dart';

import '../providers/event.dart';
import '../providers/tags.dart';
import '../providers/fav_events.dart';
import '../widgets/event_collection.dart';
import 'filters.dart';
import 'package:provider/provider.dart';
import '../../providers/events.dart';

class Search extends StatefulWidget {
  static const searchPageRoute = '/search';

  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///------------------------------------------------------- DUMMY DATA -----------------------------------------------------------------
  /// I want from DB cateory titles and each category list of events
  // final Event event = Event(
  //     123,
  //     DateTime.now(),
  //     'We The Medicine- Healing Our Inner Child 2023.Guid...',
  //     'https://cdn.evbstatic.com/s3-build/fe/build/images/7240401618ed7526be7cec3b43684583-2_tablet_1067x470.jpg',
  //     EventState.online,
  //     false);

  // final List<Event> test1 = List<Event>.generate(
  //     6,
  //     (index) => Event(
  //         12354,
  //         DateTime.now(),
  //         'We The Medicine- Healing Our Inner Child 2023.Guid...',
  //         'https://cdn.evbstatic.com/s3-build/fe/build/images/7240401618ed7526be7cec3b43684583-2_tablet_1067x470.jpg',
  //         EventState.online,
  //         false));

  /**Rendring list only could be used even after remove dummy data */
  final List<Tag> tags = [
    Tag('Today', false),
    Tag('Tomorrow', false),
    Tag('This weekend', false),
    Tag('This month', false),
    Tag('past', false),
    Tag('Learn', false),
    Tag('Business', false),
    Tag('Health & Weellness', false),
    Tag('Tech', false),
  ];

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///-------------------------------------------------------END OF DUMMY DATA -----------------------------------------------------------

  //=======================================================================================================================================
  //========================================================= filters data ===============================================================
  /*============ Selected Tags =========='*/
  ///List that conatins selected tags/filters
  List<Tag> selectedTags = [];

  //=======================================================================================================================================
  //========================================================= filters data ===============================================================

  @override
  Widget build(BuildContext context) {
    //------------------------------------- Variables -------------------------------------------------//
    ///Event list
    final eventsData = Provider.of<Events>(context);
    final events = eventsData.events;

    final favsData = Provider.of<FavEvents>(context);
    final favourites = favsData.favs;

    //------------------------------------- Methods -------------------------------------------------//
    /// Function that select tags and only render thier new style.
    ///
    /// Tags that is selected rendered first.
    void selectTag(BuildContext ctx, Tag toggleTag) {
      setState(() {
        toggleTag.selected = !toggleTag.selected;
        if (selectedTags.contains(toggleTag)) {
          selectedTags.remove(toggleTag);
          tags.remove(toggleTag);
          tags.insert(selectedTags.length, toggleTag);
        } else {
          selectedTags.add(toggleTag);
          tags.remove(toggleTag);
          tags.insert(0, toggleTag);
        }
      });
    }

    ///View Filters handeler function.
    ///
    ///FilterScreen takes selectedTags list to edit it when select an new filter.
    void viewFilters(BuildContext ctx) {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
        return FilterScreen(selectedTags);
      }));
    }

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
              onPressed: () => viewFilters(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
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
                  cursorWidth: 0.5,
                  cursorColor: Colors.grey,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'Start searching...',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 147, 147, 147)),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(229, 41, 41, 41), width: 2.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 67, 96, 244), width: 2.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tags.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: tags[index].selected
                                ? const Color.fromARGB(255, 67, 96, 244)
                                : const Color.fromARGB(255, 242, 242, 242)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(60),
                          splashColor: const Color.fromARGB(255, 67, 96, 244),
                          onTap: () => selectTag(context,
                              tags[index]), // Action when button is pressed
                          child: Container(
                            height: 10,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  tags[index].title,
                                  style: TextStyle(
                                      color: tags[index].selected
                                          ? Colors.white
                                          : Color.fromARGB(255, 104, 104, 104),
                                      fontSize: 12),
                                ),
                                tags[index].selected
                                    ? const Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Icon(
                                          Icons.close_outlined,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      )
                                    : const GreyArea()
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 700,
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: Colors.orange.shade900,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 40),
                    itemCount: 1, // substitute with collectionCounts
                    itemBuilder: (ctx, index) {
                      return EventCollections(
                          "${events.length} events", false, favourites);
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
