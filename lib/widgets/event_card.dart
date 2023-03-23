import 'package:flutter/material.dart';
import '../models/event.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  //event to be shown in the card
  Event event;

  //constructor
  EventCard(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    //Event selection action function
    void selectEvent(BuildContext ctx) {}

    return InkWell(
      onTap: () => selectEvent,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, bottom: 15),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 130,
                height: 130,
                child: Image.network(
                  event.eventImg,
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
                      '${DateFormat('EEE, MMM d • hh:mmaaa ').format(event.date)} EET',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  SizedBox(
                      width: 200,
                      child: Text(event.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16))),
                  Text(
                    (event.state == EventState.online) ? 'Online' : 'Offline',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  FittedBox(
                    // width: 190,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.person_outline_outlined,
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                        ),
                        event.creatorFollowers < 10000
                            ? Text(
                                '${event.creatorFollowers} creator followers',
                                style: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.7),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500))
                            : Text(
                                '${event.creatorFollowers} creator follow...',
                                style: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.7),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)),
                        const Icon(
                          Icons.share,
                          size: 20,
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(
                            Icons.favorite_border_rounded,
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
