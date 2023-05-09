library FavouriteEventCard;

import 'package:Eventbrite/helper_functions/Likes_functions.dart';
import 'package:Eventbrite/models/liked_event_card_model.dart';
import 'package:Eventbrite/providers/events/fav_events.dart';
import 'package:Eventbrite/screens/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper_functions/events_handlers.dart';
import '../helper_functions/log_in.dart';
import '../providers/events/event.dart';
import 'package:intl/intl.dart';

import '../screens/sign_up/sign_up_or_log_in.dart';

/// {@category Widgets}
///
///   It is StatefulWidget as its content changes depending on actions taken inside screen use this widget.
///
///   It consists of 2 widgets Inkwell and favIcon surrounded by stack.
///
///   If user can not add to favourite unless user logged-in or he will be navigated to login screen
///
///   Date format used here is
///
///<strong>'EEE, MMM d • hh:mmaaa ' </strong>
///
class FavouriteEventCard extends StatefulWidget {
  //event to be shown in the card
  final Event event;
  bool isFav = true;
  //constructor
  FavouriteEventCard(this.event, {super.key});
  @override
  State<FavouriteEventCard> createState() => _FavouriteEventCardState();
}

class _FavouriteEventCardState extends State<FavouriteEventCard> {
  @override
  Widget build(BuildContext context) {
    // //----------------------- Event provider ------------------------------

    // final event = Provider.of<Event>(context, listen: false);
    // final favsData = Provider.of<FavEvents>(context);

    // //----------------------- Methods ------------------------------

    return Stack(
      fit: StackFit.loose,
      children: [
        InkWell(
          key: const Key("EventsCard"),
          onTap: () => selectEvent(context, widget.event),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, bottom: 15),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 100,
                    height: 100,
                    child: widget.event.eventImg.startsWith('http')
                        ? FadeInImage(
                            placeholder: const AssetImage(
                                'assets/images/no_image_found.png'),
                            imageErrorBuilder: (context, error, stackTrace) =>
                                const Image(
                              image: AssetImage(
                                  'assets/images/no_image_found.png'),
                              fit: BoxFit.cover,
                            ),
                            image: NetworkImage(widget.event.eventImg),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            widget.event.eventImg,
                            fit: BoxFit.cover,
                          )),
                Container(
                  height: 100,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${DateFormat('EEE, MMM d • hh:mmaaa ').format(widget.event.startDate)} EET',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14)),
                      SizedBox(
                          width: 200,
                          child: Text(widget.event.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16))),
                      Text(
                        (widget.event.isOnline == true) ? 'Online' : 'Offline',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Row(
                        children: [
                          const Icon(
                            key: Key("person"),
                            Icons.person_outline_outlined,
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                          ),
                          SizedBox(
                            width: 130,
                            child: Text(widget.event.organization,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.7),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 2,
          right: 10,
          child: IconButton(
            key: const Key("AddToFavBtn"),
            onPressed: () {
              UnlikeEvent(context, widget.event.id, widget.event.mockId);
              setState(() {
                widget.isFav = !widget.isFav;
              });
            },
            icon: Icon(
              key: const Key("favIcon"),
              widget.isFav == false
                  ? Icons.favorite_border_rounded
                  : Icons.favorite_sharp,
              color: const Color.fromARGB(255, 209, 65, 12),
            ),
          ),
        ),
      ],
    );
  }
}

void UnlikeEvent(
  BuildContext context,
  String eventId,
  int eventmockID,
) async {
  // Navigator.of(context).pop();
  bool state = await UnlikeEventHelper(eventId, eventmockID);

  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TabBarScreen(
            title: "Favourites",
            tabBarIndex: 2,
          )));
  if (state != true) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Something Wrong Happened"),
    ));
  }
}
