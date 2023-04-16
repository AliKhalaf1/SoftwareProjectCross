import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:Eventbrite/widgets/fav_event_collection.dart';
import 'package:flutter/material.dart';
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
  List<List<Event>> sortedByDateListSplit = [];
  DateTime refrenceDate = sortedByDateList[0].date;
  int j = 0;
  for (int i = 0; i < sortedByDateList.length; i++) {
    if (refrenceDate != sortedByDateList[i].date) {
      sortedByDateListSplit.add([]);
      refrenceDate = sortedByDateList[i].date;
      j++;
    }
    sortedByDateListSplit[j].add(sortedByDateList[i]);
  }
  return sortedByDateListSplit;
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    final favsData = Provider.of<FavEvents>(context);
    final favourites = favsData.favs;
    final sortedFavs = sortAndSplitByDate(favourites);
    return Scaffold(
      appBar: AppBar(
        title: const AppBarText('Favourites'),
      ),
      body: SizedBox(
        height: 700,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 40),
          itemCount: sortedFavs.length, // substitute with collectionCounts
          itemBuilder: (ctx, index) {
            return FavEventCollection(
                sortedFavs[index][0].date.toString(), sortedFavs[index]);
          },
        ),
      ),
    );
  }
}
