library EventTicketsModel;

import 'package:objectbox/objectbox.dart';
import '../screens/event_page.dart';

/// {@category Models}
///
///
/// <h1> This model represents the event tickets Data </h1>
///
/// it's used in the [EventPage] screen
///
///  Anylist[0] : Regular - Anylist[1] : Vip
///
///   • names: tickets names [List<String>]
///
///   • avaliableQuantaties: avaliable quantities of each type [List<int>]
///
///   • durations: swhen sales end [List<String>]
///
@Entity()
class EventTicketsInfo {
  @Id()
  int id = 0;
  //parameters
  // @Unique()
  List<String> names = List<String>.filled(2, '');
  // List<bool> types =
  //     List<bool>.filled(2, false); /*false: doesnt exist / true: exists */
  List<int> avaliableQuantaties = List<int>.filled(2, 0); /*Avaliable number */
  List<String> durations = List<String>.filled(1, '');
  //constructor
  EventTicketsInfo(
    this.names,
    // this.types,
    this.avaliableQuantaties,
    this.durations,
  );
}
