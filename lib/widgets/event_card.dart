import 'package:flutter/material.dart';
import '../models/event.dart';
import 'package:intl/intl.dart';



class EventCard extends StatelessWidget {
  //event to be shown in the card
  Event event;

  //constructor
  EventCard(this.event);

  @override
  Widget build(BuildContext context) {
    //Event selection action function
    void selectEvent(BuildContext ctx) {
      
    }

    return InkWell(
      onTap: () => selectEvent,

      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Container(width: 200,height: 200, child: Image.network(event.eventImg,fit: BoxFit.cover,)),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat.yMMMd().format(event.date)),
                  Text(event.description),
                  Text(event.state == 0? 'online':'offline'),
                  Row(
                    //last elements
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
