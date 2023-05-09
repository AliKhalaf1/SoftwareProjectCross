library TicketsTabBar;

import 'package:Eventbrite/screens/user/past_tickets_page.dart';
import 'package:Eventbrite/screens/user/upcoming_tickets_page.dart';
import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:Eventbrite/widgets/loading_spinner.dart';

import 'package:flutter/material.dart';

/// {@category user}
/// {@category Screens}
///
///TicketsTabBar class is a StatefulWidget that represents the tickets screen in the application.
///
/// It contains a TabBar with two tabs, one for "Upcoming" and the other for "Past tickets".
///
/// It also contains a TabBarView that displays the corresponding content for the selected tab.

class TicketsTabBar extends StatefulWidget {
  static const route = '/Tabbarevents';
  bool _isLoading = false;
  int _selectedTabIndex = 0;
  TicketsTabBar({super.key});

  @override
  State<TicketsTabBar> createState() => _TicketsTabBarState();
}

class _TicketsTabBarState extends State<TicketsTabBar> {
  void initState() {
    super.initState();
  }

  void _handleTabSelection(int index) {
    if (index != widget._selectedTabIndex) {
      setState(
        () {
          widget._selectedTabIndex = index;
        },
      );
    }

    // // Set a delay to simulate loading
    // Future.delayed(Duration(seconds: 1), () {
    //   setState(() {
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: const AppBarText("Tickets"),
            bottom: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
              child: TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      "Upcoming",
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Past tickets",
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                ],
                onTap: _handleTabSelection,
                indicatorColor: Color.fromARGB(255, 13, 18, 161),
                labelPadding: EdgeInsets.zero,
              ),
            ),
          ),
          body: !widget._isLoading
              ? TabBarView(
                  children: [
                    UpcomingTicketsPage(),
                    PastTicketsPage(),
                  ],
                )
              : const LoadingSpinner()),
    );
  }
}
