library live_events;

import 'package:Eventbrite/providers/createevent/createevent.dart';
import 'package:Eventbrite/providers/getevent/getevent.dart';
import 'package:Eventbrite/screens/creator/event_dashboard.dart';
import 'package:Eventbrite/screens/creator/event_title.dart';
import 'package:Eventbrite/widgets/backgroud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  late final events;
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      events = Provider.of<totalEvents>(context, listen: false);
      try {
        await events.fetchAndSetEvents();
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('error in fetching catched'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

      dataLive = events.allitemslive;
      setState(() {
        liveeventLen = dataLive.length;
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshProducts(BuildContext context) async {
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

  @override
  Widget build(BuildContext context) {
    Widget myWidget;
    if (_isLoading) {
      myWidget = Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      );
    } else if (!_isLoading && liveeventLen > 0) {
      myWidget = Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: liveeventLen,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(EventsDashboard.route,
                    arguments: {'event': dataLive[index]});
              },
              child: LiveCard(
                  dataLive[index].startDate,
                  dataLive[index].title,
                  dataLive[index].maxTickets,
                  dataLive[index].takenTickets,
                  dataLive[index].price,
                  key: Key(dataLive[index].id)),
            );
          },
        ),
      );
    } else {
      myWidget = Background("assets/images/live_events.jfif");
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        color: Colors.orange,
        child: myWidget,
      ),
    );
  }
}
