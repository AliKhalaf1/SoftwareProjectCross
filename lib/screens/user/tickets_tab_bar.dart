library TicketsTabBar;

/// {@category user}
/// {@category Screens}
///
///TicketsTabBar class is a StatefulWidget that represents the tickets screen in the application.
///
/// It contains a TabBar with two tabs, one for "Upcoming" and the other for "Past tickets".
///
/// It also contains a TabBarView that displays the corresponding content for the selected tab.

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
  _TicketsTabBarState createState() => _TicketsTabBarState();
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
        int price = 0;
        for (int i = 0; i < resData.length; i++) {
          price = resData[i]['price'];
          DateTime DateTimesss = DateTime.parse(resData[i]['created_date']);
          Ticket newticket = Ticket(
            resData[i]['image_link'],
            DateTime.parse(resData[i]['created_date']),
            '${resData[i]['first_name']} ${resData[i]['last_name']}',
            price.toDouble(),
          );
          newticket.OrderId = resData[i]['id'];

          widget.newtickets.add(newticket);
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
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: const AppBarText("Orders"),
            ),
            body: widget._isLoading
                ? const LoadingSpinner()
                : UpcomingTicketsPage(widget.newtickets)));
  }
}
