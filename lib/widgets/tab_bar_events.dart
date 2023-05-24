library CreatorEventsPage;

import 'package:splash_route/splash_route.dart';

import '../helper_functions/userInfo.dart';
import '../screens/creator/event_title.dart';
import 'drawer.dart';
import '../screens/creator/all_events.dart';
import '../screens/creator/live_events.dart';
import '../screens/creator/past_events.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// {@category Widgets}
///
///TabBarEvents widget that contains a DefaultTabController widget and a FutureBuilder widget.
///
///The DefaultTabController widget creates a tabbed layout with three tabs: "Live", "Past", and "All".
///
/// The FutureBuilder widget fetches the first name and last name of the user and displays them in the EventDrawer widget.

class TabBarEvents extends StatefulWidget {
  static const route = '/Tabbarevents';

  TabBarEvents({super.key});

  @override
  State<TabBarEvents> createState() => _TabBarEventsState();
}

class _TabBarEventsState extends State<TabBarEvents> {
  int _selectedTabIndex = 0;

  void _handleTabSelection(int index) {
    if (index != _selectedTabIndex) {
      setState(
        () {
          _selectedTabIndex = index;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: FutureBuilder(
        future: Future.wait([getFirstName(), getLastName()]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return Center(child: CircularProgressIndicator());
          } else {
            String firstname = "";
            String lastname = "";
            if (!snapshot.hasError) {
              firstname = snapshot.data![0];
              lastname = snapshot.data![1];
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromRGBO(31, 10, 61, 1),
                title: const Text(
                  "Events",
                  style: TextStyle(
                      fontFamily: "Neue Plak Extended",
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(40),
                  child: Container(
                    color: Colors.white,
                    child: TabBar(
                      tabs: [
                        Tab(
                          child: Text(
                            "Live",
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Past",
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "All",
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                      ],
                      onTap: _handleTabSelection,
                      indicatorColor: Colors.blue[600],
                      labelPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
              drawer: EventDrawer(userName: "$firstname $lastname"),
              body: TabBarView(
                children: [
                  LiveEvents(),
                  PastEvents(),
                  DraftEvents(),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    SplashRoute(
                      targetPage: EventTitle(),
                      splashColor: const Color.fromRGBO(209, 65, 12, 1),
                      startFractionalOffset: const FractionalOffset(1.0, 1.0),
                      transitionDuration: const Duration(milliseconds: 800),
                    ),
                  );
                },
                tooltip: 'Increment',
                child: Icon(
                  Icons.add,
                  key: Key("AddPastEvent"),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }
        },
      ),
    );
  }
}
