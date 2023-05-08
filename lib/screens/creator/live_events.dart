library live_events;

import 'package:Eventbrite/providers/getevent/getevent.dart';
import 'package:Eventbrite/screens/creator/event_title.dart';
import 'package:Eventbrite/widgets/backgroud.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splash_route/splash_route.dart';

import '../../widgets/live_card.dart';

/// {@category Creator}
/// {@category Screens}
///
/// This Page is used to display the creator's live events.
///
/// It takes the context of the page as a parameter.
///
/// It then pushes the TabBarEvents page to the Navigator.
class LiveEvents extends StatefulWidget {
  const LiveEvents({super.key});
  static const route = '/Liveevents';

  @override
  State<LiveEvents> createState() => _LiveEventsState();
}

class _LiveEventsState extends State<LiveEvents> {
  var _isInit = true;
  var _isLoading = false;
  List<theEvent> dataLive = [];
  int liveeventLen = 0;
  totalEvents events = totalEvents();
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await events.fetchAndSetEvents();
      dataLive = events.allitemslive;
      setState(() {
        liveeventLen = dataLive.length;
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Widget myWidget;
    if (_isLoading) {
      myWidget = Center(
        child: CircularProgressIndicator(),
      );
    } else if (!_isLoading && liveeventLen > 0) {
      myWidget = Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: liveeventLen,
          itemBuilder: (context, index) {
            return LiveCard(
                dataLive[index].startDate,
                dataLive[index].title,
                dataLive[index].maxTickets,
                dataLive[index].takenTickets,
                dataLive[index].price,
                key: Key(dataLive[index].id));
          },
        ),
      );
    } else {
      myWidget = Background("assets/images/live_events.jfif");
    }

    String EventDesc = "event";
    return Scaffold(
      body: myWidget,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          events.fetchAndSetEvents();
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
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, key: Key("AddLiveEvent")),
      ),
    );
  }
}
