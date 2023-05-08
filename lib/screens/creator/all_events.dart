library DraftEventsScreen;

import 'package:Eventbrite/widgets/draft_card.dart';
import 'package:flutter/material.dart';
import 'package:splash_route/splash_route.dart';
import '../../providers/getevent/getevent.dart';
import '../../widgets/backgroud.dart';
import '../../widgets/live_card.dart';
import 'event_title.dart';

/// {@category Creator}
/// {@category Screens}
///
/// This Page is used to display the creator's draft events.
class DraftEvents extends StatefulWidget {
  @override
  State<DraftEvents> createState() => _DraftEventsState();
}

class _DraftEventsState extends State<DraftEvents> {
  var _isInit = true;
  var _isLoading = false;
  List<theEvent> dataAll = [];
  int liveeventLen = 0;
  totalEvents events = totalEvents();
  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await events.fetchAndSetEvents();
      dataAll = events.allitems;
      setState(() {
        liveeventLen = dataAll.length;
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
      myWidget = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (!_isLoading && liveeventLen > 0) {
      myWidget = Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: liveeventLen,
          itemBuilder: (context, index) {
            return LiveCard(
                dataAll[index].startDate,
                dataAll[index].title,
                dataAll[index].maxTickets,
                dataAll[index].takenTickets,
                dataAll[index].price,
                key: Key(dataAll[index].id));
          },
        ),
      );
    } else {
      myWidget = Background("assets/images/draft_events.jfif");
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
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, key: Key("AddDraftEvent")),
      ),
    );
  }
}
