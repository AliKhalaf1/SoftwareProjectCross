library FavouriteEventCard;

import 'package:Eventbrite/helper_functions/Likes_functions.dart';
import 'package:Eventbrite/models/liked_event_card_model.dart';
import 'package:Eventbrite/providers/events/fav_events.dart';
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
  final LikedEventCardModel event;
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
          onTap: () => selectFavEvent(context, widget.event),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, bottom: 15),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 100,
                    height: 100,
                    child: widget.event.eventImageUrl.startsWith('http')
                        ? FadeInImage(
                            placeholder: const AssetImage(
                                'assets/images/no_image_found.png'),
                            imageErrorBuilder: (context, error, stackTrace) =>
                                const Image(
                              image: AssetImage(
                                  'assets/images/no_image_found.png'),
                              fit: BoxFit.cover,
                            ),
                            image: NetworkImage(widget.event.eventImageUrl),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            widget.event.eventImageUrl,
                            fit: BoxFit.cover,
                          )),
                Container(
                  height: 100,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
