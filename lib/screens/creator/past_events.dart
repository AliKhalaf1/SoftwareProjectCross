library past_events;

import 'package:flutter/material.dart';
import 'package:splash_route/splash_route.dart';
import 'package:Eventbrite/providers/getevent/getevent.dart';

import '../../widgets/backgroud.dart';
import '../../widgets/live_card.dart';
import 'event_title.dart';

/// {@category Creator}
/// {@category Screens}
///
/// This Page is used to display the creator's past events.
///
class PastEvents extends StatefulWidget {
  const PastEvents({super.key});
  static const route = '/Pastevents';

  @override
  State<PastEvents> createState() => _PastEventsState();
}

class _PastEventsState extends State<PastEvents> {
  @override
  var _isInit = true;
  var _isLoading = false;
  List<theEvent> dataPast = [];
  int pasteventLen = 0;
  totalEvents events = totalEvents();
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await events.fetchAndSetEvents();
      dataPast = events.allitemsended;
      setState(() {
        pasteventLen = dataPast.length;
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    Widget myWidget;
    if (_isLoading) {
      myWidget = Center(
        child: CircularProgressIndicator(),
      );
    } else if (!_isLoading && pasteventLen > 0) {
      myWidget = Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: pasteventLen,
          itemBuilder: (context, index) {
            return LiveCard(
                dataPast[index].startDate,
                dataPast[index].title,
                dataPast[index].maxTickets,
                dataPast[index].takenTickets,
                dataPast[index].price,
                key: Key(dataPast[index].id));
          },
        ),
      );
    } else {
      myWidget = Background("assets/images/past_events.jfif");
    }
    return Scaffold(
      body: myWidget,
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
}
