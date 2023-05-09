library TicketsTabBar;

import 'dart:convert';

import 'package:Eventbrite/helper_functions/log_in.dart';
import 'package:Eventbrite/providers/tickets/tickets.dart';
import 'package:Eventbrite/screens/user/past_tickets_page.dart';
import 'package:Eventbrite/screens/user/upcoming_tickets_page.dart';
import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:Eventbrite/widgets/loading_spinner.dart';

import 'package:flutter/material.dart';

import '../../helper_functions/constants.dart';
import '../../providers/tickets/ticket.dart';
import 'package:http/http.dart' as http;

class TicketsTabBar extends StatefulWidget {
  static const route = '/Tabbarevents';
  bool _isLoading = false;
  int _selectedTabIndex = 0;
  List<Ticket> oldtickets = [];
  List<Ticket> newtickets = [];
  TicketsTabBar({super.key});

  @override
  State<TicketsTabBar> createState() => _TicketsTabBarState();
}

class _TicketsTabBarState extends State<TicketsTabBar> {
  void initState() {
    super.initState();
    getOrders();
  }

  void getOrders() async {
    setState(() {
      widget._isLoading = true;
    });

    if (Constants.MockServer == false) {
      print("I'm here1");
      // string to uri
      var uri = Uri.parse('${Constants.host}/orders/myorders/');
      print(uri);
      //create multipart request
      String token = await getToken();

      Map<String, String> reqHeaders = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response = await http.get(uri, headers: reqHeaders);

      var res = response.body;
      var resData = jsonDecode(res);
      if (res.length == 0) {
        widget.oldtickets = [];
        widget.newtickets = [];
      } else {
        widget.oldtickets = [];
        widget.newtickets = [];
        for (int i = 0; i < resData.length; i++) {
          DateTime DateTimesss = DateTime.parse(resData[i]['created_date']);
          Ticket newticket = Ticket(
            resData[i]['image_link'],
            DateTime.parse(resData[i]['created_date']),
            '${resData[i]['first_name']} ${resData[i]['last_name']}',
          );
          newticket.OrderId = resData[i]['id'];
          if (DateTimesss.isBefore(DateTime.now())) {
            widget.oldtickets.add(newticket);
          } else {
            widget.newtickets.add(newticket);
          }
        }
      }
    } else {}

    setState(() {
      widget._isLoading = false;
    });
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
                    UpcomingTicketsPage(widget.oldtickets),
                    PastTicketsPage(widget.newtickets),
                  ],
                )
              : const LoadingSpinner()),
    );
  }
}
