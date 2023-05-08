import 'drawer.dart';
import '../screens/creator/all_events.dart';
import '../screens/creator/live_events.dart';
import '../screens/creator/past_events.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
      child: Scaffold(
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
        drawer: EventDrawer(),
        body: TabBarView(
          children: [
            LiveEvents(),
            PastEvents(),
            DraftEvents(),
          ],
        ),
      ),
    );
  }
}
