import 'package:flutter/foundation.dart';

enum EventState
{
  online,
  offline
}

class Event {
  //parameters of the EventCard Widget
  final String eventRoute; /*route path of the event screen*/
  final String eventImg; /*event card image */
  final DateTime date; /*event date*/
  final String description; /*event dscription*/
  final EventState state; /*event state*/
  final int creatorFollowers;

  //constructor
  Event(this.creatorFollowers,this.date,this.description,this.eventImg,this.eventRoute,this.state);
}