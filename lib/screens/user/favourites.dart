library FavouritesPage;

import 'package:Eventbrite/helper_functions/Likes_functions.dart';
import 'package:Eventbrite/models/liked_event_card_model.dart';
import 'package:Eventbrite/providers/getevent/getevent.dart';
import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:Eventbrite/widgets/fav_event_card.dart';
import 'package:Eventbrite/widgets/fav_event_collection.dart';
import 'package:Eventbrite/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/events/event.dart';
import '../../providers/events/fav_events.dart';

/// {@category user}
/// {@category Screens}
///
/// This Page is used to display the user's favourite events.
///
/// It uses the [FavEventCollection] widget to display the events.
class Favourites extends StatefulWidget {
  Favourites({super.key});
  List<Event> LikedEvents = [];
  bool isLoading = false;
  @override
  State<Favourites> createState() => _FavouritesState();
}

List<List<Event>> sortAndSplitByDate(List<Event> list) {
  var length = list.length;
  if (length == 0) {
    return [];
  }
  List<Event> sortedByDateList = list;
  sortedByDateList.sort((a, b) => a.startDate.compareTo(b.startDate));

  DateTime refrenceDate = sortedByDateList[0].startDate;
  List<int> lengths = [];
  int count = 0;
  for (int i = 0; i < sortedByDateList.length; i++) {
    if (i == sortedByDateList.length - 1) {
      lengths.add(count);
    } else if (refrenceDate != sortedByDateList[i].startDate) {
      lengths.add(count);
      count = 0;
      refrenceDate = sortedByDateList[i].startDate;
    }
    count++;
  }

  return [];
}

class _FavouritesState extends State<Favourites> {
  void Refresh() {
    setState(() {
      widget.isLoading = true;
    });

    getLikedEvents().then(
      (value) {
        widget.LikedEvents = value;
        setState(() {
          widget.isLoading = false;
        });
      },
    );
  }

  @override
  void initState() {
    Refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const AppBarText('Favourites'),
      ),
      body: widget.isLoading
          ? const LoadingSpinner()
          : SizedBox(
              height: 700,
              child: widget.LikedEvents.length == 0
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05,
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05,
                          bottom: MediaQuery.of(context).size.height * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No liked events Yet',
                            style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            'You have not added any events to your favourites yet.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: widget.LikedEvents.length,
                      itemBuilder: (context, index) {
                        return FavouriteEventCard(widget.LikedEvents[index]);
                      }),
            ),
    );
  }
}
