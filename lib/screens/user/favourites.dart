import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:Eventbrite/widgets/fav_event_collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/events/event.dart';
import '../../providers/events/fav_events.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

List<List<Event>> sortAndSplitByDate(List<Event> list) {
  var length = list.length;
  if (length == 0) {
    return [];
  }
  List<Event> sortedByDateList = list;
  sortedByDateList.sort((a, b) => a.date.compareTo(b.date));

  DateTime refrenceDate = sortedByDateList[0].date;
  List<int> lengths = [];
  int count = 0;
  for (int i = 0; i < sortedByDateList.length; i++) {
    if (i == sortedByDateList.length - 1) {
      lengths.add(count);
    } else if (refrenceDate != sortedByDateList[i].date) {
      lengths.add(count);
      count = 0;
      refrenceDate = sortedByDateList[i].date;
    }
    count++;
  }

  print('------------------------length = ');
  //print(sortedByDateListSplit.length);
  return [];
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    final favsData = Provider.of<FavEvents>(context);
    final favourites = favsData.favs;
    //final sortedFavs = sortAndSplitByDate(favourites);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const AppBarText('Favourites'),
      ),
      body: SizedBox(
        height: 700,
        child: favourites.length == 0
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
                padding: const EdgeInsets.only(top: 40),
                itemCount: 1, // substitute with collectionCounts
                itemBuilder: (ctx, index) {
                  return FavEventCollection(
                    DateFormat.yMEd().format(favourites[0].date),
                    favourites,
                    key: Key('fav_event_${index}'),
                  );
                },
              ),
      ),
    );
  }
}
