/// @nodoc
enum EventState { online, offline }

/// {@category Basics}
/// parameters of the EventCard Widget ya megzoooooooo
class Event {
  //parameters of the EventCard Widget

  final String eventRoute; /*route path of the event screen*/
  final String eventImg; /*event card image */
  final DateTime date; /*event date*/
  final String description; /*event dscription*/
  final EventState state; /*event state (online/onsite)*/
  final int creatorFollowers; /*number of followers of the event creator*/

  //constructor
  Event(this.creatorFollowers, this.date, this.description, this.eventImg,
      this.eventRoute, this.state);
}
