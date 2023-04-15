import 'drawer.dart';
import '../screens/creator/draft_events.dart';
import '../screens/creator/live_events.dart';
import '../screens/creator/past_events.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TabBarEvents extends StatefulWidget {
  static const route = '/Tabbarevents';
  @override
  State<TabBarEvents> createState() => _TabBarEventsState();
}

class _TabBarEventsState extends State<TabBarEvents> {
  int _selectedTabIndex = 0;
  late bool _isLoading;
  void initState() {
    super.initState();
    _isLoading = true;
    // Set a delay to simulate loading
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _handleTabSelection(int index) {
    if (index != _selectedTabIndex) {
      setState(
        () {
          _selectedTabIndex = index;
          _isLoading = true;
        },
      );
    }

    // Set a delay to simulate loading
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
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
            ),
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
                      "Draft",
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
        body: !_isLoading
            ? TabBarView(
                children: [
                  LiveEvents(),
                  PastEvents(),
                  DraftEvents(),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.discreteCircle(
                        secondRingColor: Colors.grey,
                        thirdRingColor: Colors.grey,
                        color: Colors.grey,
                        size: 60),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Loading")
                  ],
                ),
              ),
      ),
    );
  }
}
