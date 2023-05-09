library DraftEventsScreen;

import 'package:Eventbrite/providers/events/event.dart';
import 'package:Eventbrite/widgets/draft_card.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_route/splash_route.dart';
import '../../providers/getevent/getevent.dart';
import '../../widgets/backgroud.dart';
import '../../widgets/live_card.dart';
import 'event_title.dart';

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

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
  late final events;
  @override
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
      dataAll = events.allitems;
      setState(() {
        liveeventLen = dataAll.length;
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

    dataAll = events.allitems;
    setState(() {
      liveeventLen = dataAll.length;
      _isLoading = false;
    });
  }

  Future<void> exportToCsv() async {
    final directory = await getExternalStorageDirectory();

    List<List<String>> csvData = [
      [
        'Event Title',
        'Start Date',
        'End Date',
        'Price',
        'Max Tickets',
        'Taken Tickets'
      ]
    ];

    dataAll.forEach((element) {
      List<String> row = [
        element.title,
        element.startDate,
        element.endDate,
        element.price.toString(),
        element.maxTickets.toString(),
        element.takenTickets.toString()
      ];
      csvData.add(row);
    });

    print(csvData.length);

    String csv = const ListToCsvConverter().convert(csvData);

    String filename = '${directory!.path}/events.csv';

    final file = File(filename);
    await file.writeAsString(csv);
    print("directionnnn");
    print(filename);
  }

  @override
  Widget build(BuildContext context) {
    Widget myWidget;
    if (_isLoading) {
      myWidget = const Center(
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
      body: RefreshIndicator(
        child: myWidget,
        onRefresh: () => _refreshProducts(context),
        color: Colors.orange,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // exportToCsv();
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
