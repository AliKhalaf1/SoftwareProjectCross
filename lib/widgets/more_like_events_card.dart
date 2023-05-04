library MoreLikeEventCard;

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
class MoreLikeEventCard extends StatefulWidget {
  const MoreLikeEventCard({super.key});

  @override
  State<MoreLikeEventCard> createState() => _MoreLikeEventCardState();
}

class _MoreLikeEventCardState extends State<MoreLikeEventCard> {
  @override
  Widget build(BuildContext context) {
    //----------------------- Event provider ------------------------------

    final event = Provider.of<Event>(context, listen: false);
    final favsData = Provider.of<FavEvents>(context);

    //----------------------- Methods ------------------------------

    Future<void> toggleFav(BuildContext ctx) async {
      //add to favourites list
      bool isLogged = await checkLoggedUser();
      setState(() {
        if (isLogged) {
          //Call toggleStatus function from event class
          if (event.isFav) {
            favsData.removeEventFromFav(event);
          } else {
            favsData.addEventToFav(event);
          }
        } else {
          Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
            return const SignUpOrLogIn();
          }));
        }
      });
    }

    return Stack(
      fit: StackFit.loose,
      children: [
        InkWell(
          key: const Key("MoreLikeEventCard"),
          onTap: () => selectEvent(context, event),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 130,
                  child: event.eventImg.startsWith('http')
                      ? Image.network(
                          event.eventImg,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          event.eventImg,
                          fit: BoxFit.cover,
                        )),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                    '${DateFormat('EEE, MMM d • hh:mmaaa ').format(event.startDate)} EET',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14)),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 8.0),
                  width: 200,
                  height: 40,
                  child: Text(event.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16))),
            ],
          ),
        ),
        Positioned(
          bottom: 2,
          right: 0,
          child: IconButton(
            key: const Key("AddToFavBtn"),
            onPressed: () => toggleFav(context),
            icon: Icon(
              key: const Key("favIcon"),
              !event.isFav
                  ? Icons.favorite_border_rounded
                  : Icons.favorite_sharp,
              color: !event.isFav
                  ? const Color.fromRGBO(0, 0, 0, 0.7)
                  : const Color.fromARGB(255, 209, 65, 12),
            ),
          ),
        ),
      ],
    );
  }
}
