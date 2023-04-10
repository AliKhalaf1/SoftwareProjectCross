import 'package:Eventbrite/screens/user/live_events.dart';
import 'package:Eventbrite/screens/user/past_events.dart';
import 'package:Eventbrite/widgets/tab_bar_Events.dart';
import 'package:flutter/material.dart';

class EventDrawer extends StatefulWidget {
  const EventDrawer({super.key});

  @override
  State<EventDrawer> createState() => _EventDrawerState();
}

class _EventDrawerState extends State<EventDrawer> {
  late Color mainIconColor;
  late List<Color> iconColors;

  @override
  void initState() {
    super.initState();
    mainIconColor = Color.fromRGBO(124, 120, 155, 1);
    iconColors = List.filled(
      7,
      mainIconColor,
    );
    iconColors[1] = const Color.fromARGB(255, 209, 65, 12);
  }

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

  void eventNavigate(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      TabBarEvents.route,
    ); // we use same string in main it’s a key
  }

  Widget buildlistview(
      String title, IconData icon, int index, Function handler) {
    Color splashColor = index != 0 ? Colors.grey : Colors.transparent;
    return InkWell(
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
          style: TextStyle(
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
      child: Column(
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
          buildlistview('Ahmed Magdy', Icons.business_center_rounded, 0, () {
            iconHandler(0);
          }),
          buildlistview('Events', Icons.date_range_rounded, 1, () {
            //code of Navigate
            eventNavigate(context);
            iconHandler(1);
          }),
          buildlistview('Search Orders', Icons.event_rounded, 2, () {
            iconHandler(2);
          }),
          buildlistview('Change Organisation', Icons.compare_arrows_rounded, 3,
              () {
            iconHandler(3);
          }),
          Divider(),
          buildlistview('Device Settings', Icons.settings, 4, () {
            iconHandler(4);
          }),
          buildlistview('Feedback', Icons.mms, 5, () {
            iconHandler(5);
          }),
          Divider(),
          Column(
            children: [
              ListTile(
                leading: Text(
                  "ahmedfec2000@gmail.com",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(94, 92, 109, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              buildlistview('Log Out', Icons.logout, 6, () {
                iconHandler(6);
              }),
            ],
          ),
        ],
      ),
    );
  }
}
