library EventModel;

enum EventState { online, offline }

/// {@category Models}
///## Event class that stores each event information inside following attributes
///
///   • eventImg: cover image for the event
/// 
///   • date: date when the event held
/// 
///   • description: short description on the event and activities that will take place
/// 
///   • state: Online / Offline
/// 
///   • creatorFollowers: number of followers who follow the event organizer
/// 
///   • isFav: boolean variable check if user mark this event to its favourites or not
///  
/// 
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
