library EventTicketsModel;

import 'package:objectbox/objectbox.dart';
import '../screens/event_page.dart';
import '../widgets/buy_tickets.dart';

/// {@category Models}
///
///
/// <h1> This model represents the event tickets Data </h1>
///
/// it's used in the [EventPage] screen
///
/// it's used in the [BuyTickets] Widget as we need ticket id
///
///  Anylist[0] : Regular - Anylist[1] : Vip
///
///   • ids: tickets ids [List<String>]
/// 
///   • names: tickets names [List<String>]
///
///   • avaliableQuantaties: avaliable quantities of each type [List<int>]
///
///   • startDates: when sales Start [List<DateTime>]
/// 
///   • ebdDates: when sales end [List<DateTime>]
/// 
///   • vipTicketPrice: Vip tickets price [int]
///
@Entity()
class EventTicketsInfo {
  @Id()
  List<int> idsMock = List<int>.filled(2, 0);
  //parameters
  // @Unique()
  List<String> ids = List<String>.filled(2, '');
  List<String> names = List<String>.filled(2, '');
  // List<bool> types =
  //     List<bool>.filled(2, false); /*false: doesnt exist / true: exists */
  List<int> avaliableQuantaties = List<int>.filled(2, 0); /*Avaliable number */
  List<DateTime> startDates = List<DateTime>.filled(
      2, DateTime.now().subtract(const Duration(days: 1000)));
  List<DateTime> endDates = List<DateTime>.filled(
      2, DateTime.now().subtract(const Duration(days: 1000)));
  int vipTicketPrice;
  //constructor
  EventTicketsInfo(
      this.ids,
      this.names,
      // this.types,
      this.avaliableQuantaties,
      this.startDates,
      this.endDates,
      this.vipTicketPrice);
}
