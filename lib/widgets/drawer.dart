library CreatorViewSideDrawer;

import 'package:Eventbrite/helper_functions/log_in.dart';
import 'package:Eventbrite/models/db_mock.dart';
import 'package:Eventbrite/widgets/tab_bar_Events.dart';
import 'package:flutter/material.dart';
import '../helper_functions/log_out.dart';
import '../models/user.dart';
import '../screens/tab_bar.dart';

/// {@category Creator}
/// {@category Widgets}
///
/// This Widget is used to display the creator's side drawer.
///

class EventDrawer extends StatefulWidget {
  EventDrawer({super.key});
  var email = '';
  var Name = '';

  bool isLoading = false;
  @override
  State<EventDrawer> createState() => _EventDrawerState();
}

class _EventDrawerState extends State<EventDrawer> {
  late Color mainIconColor;
  late List<Color> iconColors;

  @override
  void initState() {
    Future<String> email = getEmail();
    User currUser;
    email.then((value) {
      currUser = DBMock.getUserData(value);
      setState(() {
        widget.email = currUser.email;
        widget.Name = currUser.firstName + ' ' + currUser.lastName;
      });
    });

    super.initState();
    // enable icon if page opened relate to the icon
    mainIconColor = Color.fromRGBO(124, 120, 155, 1);
    iconColors = List.filled(
      7,
      mainIconColor,
    );
    iconColors[1] = const Color.fromARGB(255, 209, 65, 12);
  }

  void logOutLogic(BuildContext ctx) {
    setLoggedOut();
    Navigator.of(ctx).popUntil((route) => route.isFirst);
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
      return TabBarScreen(title: 'Profile', tabBarIndex: 4);
    }));
  }

// to enable icon and disable
  void iconHandler(int index) {
    setState(() {
      if (index != 0) {
        iconColors.fillRange(
          0,
          6,
          Color.fromRGBO(124, 120, 155, 1),
        );
        iconColors[index] = Theme.of(context).primaryColor;
      }
    });
  }

// navigate to events page
  void eventNavigate(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      TabBarEvents.route,
    ); // we use same string in main it’s a key
  }

// Function return the main widget in the Drawer
  Widget buildlistview(String title, IconData icon, int index, Function handler,
      {required Key key}) {
    Color splashColor = index != 0 ? Colors.grey : Colors.transparent;
    return InkWell(
      key: key,
      onTap: handler as void Function(),
      splashColor: splashColor,
      highlightColor: splashColor,
      child: ListTile(
        leading: Icon(
          icon,
          size: 26,
          color: iconColors[index],
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Color.fromRGBO(94, 92, 109, 1),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 90,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              '',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildlistview(widget.Name, Icons.business_center_rounded, 0, () {
            iconHandler(0);
          }, key: const Key("UserName")),
          buildlistview('Events', Icons.date_range_rounded, 1, () {
            //code of Navigate
            eventNavigate(context);
            iconHandler(1);
          }, key: const Key("Events")),
          buildlistview('Search Orders', Icons.event_rounded, 2, () {
            iconHandler(2);
          }, key: const Key("SearchOrders")),
          buildlistview('Change Organisation', Icons.compare_arrows_rounded, 3,
              () {
            iconHandler(3);
          }, key: const Key("Change Organisation")),
          const Divider(),
          buildlistview('Device Settings', Icons.settings, 4, () {
            iconHandler(4);
          }, key: const Key("Device Settings")),
          buildlistview('Feedback', Icons.mms, 5, () {
            iconHandler(5);
          }, key: const Key("Feedback")),
          const Divider(),
          Column(
            children: [
              ListTile(
                leading: Text(
                  widget.email,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(94, 92, 109, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              buildlistview('Log Out', Icons.logout, 6, () {
                logOutLogic(context);
                iconHandler(6);
              }, key: const Key("Log Out")),
            ],
          ),
        ],
      ),
    );
  }
}
