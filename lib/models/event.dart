library EventModel;

enum EventState { online, offline }

/// {@category Models}
/// ![alone](../../assets/doc/camaro.png)
class Event {
  //parameters of the EventCard Widget
  final String eventImg; /*event card image */
  final DateTime date; /*event date*/
  final String description; /*event dscription*/
  final EventState state; /*event state (online/onsite)*/
  final int creatorFollowers; /*number of followers of the event creator*/
  bool isFav;

  //constructor
  Event(this.creatorFollowers, this.date, this.description, this.eventImg,
      this.state, this.isFav);
}
