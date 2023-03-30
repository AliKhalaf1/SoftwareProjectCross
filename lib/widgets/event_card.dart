library EventCard;

import 'package:flutter/material.dart';
import '../helper_functions/events_handlers.dart';
import '../helper_functions/log_in.dart';
import '../models/event.dart';
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
class EventCard extends StatefulWidget {
  //event to be shown in the card
  Event event;

  //constructor
  EventCard(this.event, {super.key});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    //Methods

    bool isFavourite() {
      return widget.event.isFav;
    }

    Future<void> toggleFav(BuildContext ctx) async {
      //add to favourites list
      bool isLogged = await checkLoggedUser();
      setState(() {
        if (isLogged) {
          widget.event.isFav = !widget.event.isFav;
        } else {
          Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
            return const SignUpOrLogIn();
          }));
        }
      });
    }

    void share() {
      return;
    }

    return Stack(
      fit: StackFit.loose,
      children: [
        InkWell(
          onTap: () => selectEvent(context),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, bottom: 15),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 130,
                    height: 130,
                    child: widget.event.eventImg.startsWith('http')
                        ? Image.network(
                            widget.event.eventImg,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            widget.event.eventImg,
                            fit: BoxFit.cover,
                          )),
                Container(
                  height: 130,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${DateFormat('EEE, MMM d • hh:mmaaa ').format(widget.event.date)} EET',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14)),
                      SizedBox(
                          width: 200,
                          child: Text(widget.event.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16))),
                      Text(
                        (widget.event.state == EventState.online)
                            ? 'Online'
                            : 'Offline',
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
                            width: 95,
                            child: Text(
                                '${widget.event.creatorFollowers} creator followers',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.7),
                                    fontSize: 10,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: share,
                  icon: const Icon(
                    key: Key("share"),
                    Icons.share,
                    size: 20,
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                  ),
                ),
                IconButton(
                  onPressed: () => toggleFav(context),
                  icon: Icon(
                    key: const Key("fav"),
                    !isFavourite()
                        ? Icons.favorite_border_rounded
                        : Icons.favorite_sharp,
                    color: !isFavourite()
                        ? const Color.fromRGBO(0, 0, 0, 0.7)
                        : const Color.fromARGB(255, 209, 65, 12),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
