library EventTicketModel;

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
///   • id: tickets ids [String]
///
///   • type: regular/vip [String]
///
///   • name: ticket name [String]
///
///   • ticketPrice: 0 if free / Vip tickets price [int]
///
///   • startDate: when sales Start [DateTime]
///
///   • endDate: when sales end [DateTime]
///
///   • avaliableQuantity: avaliable quantity of each ticket [int]
///
///   • selectedQuantity: selected quantity of each ticket from avaliableQuantity [int]
///
@Entity()
class EventTicketInfo {
  @Id()
  int idsMock = 0;
  //parameters
  // @Unique()
  String id;
  String type;
  String name;
  int ticketPrice;
  DateTime startDate;
  DateTime endDate;
  int avaliableQuantity;
  int selectedQuantity = 0;

  //constructor
  EventTicketInfo(
    this.id,
    this.type,
    this.name,
    this.ticketPrice,
    this.startDate,
    this.endDate,
    this.avaliableQuantity,
  );
}
