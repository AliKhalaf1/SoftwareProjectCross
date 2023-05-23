library EventTicketAttendeeModel;

import 'package:objectbox/objectbox.dart';
import '../screens/event_page.dart';
import '../widgets/buy_tickets.dart';

/// {@category Models}
///
///
/// <h1> This model represents the event tickets Placed in Orders </h1>
///
/// it's used in the [EventPage] screen
///
/// it's used in the [BuyTickets] Widget as we need ticket id
///
///   • id: tickets ids [String]
///
///   • type: regular/vip [bool]
///
///   • type:  orderId    [String]
///
///   • type:  eventId    [String]
///
///
@Entity()
class TicketAttendee {
  @Id()
  int mockId = 0;
  int eventMockId = 0;
  int orderMockId = 0;
  String id;
  String eventid;
  String orderid;
  bool isVip;
  String firstName;
  String lastName;
  String email;
  String typeOfReservedTicket = "";

  //constructor
  TicketAttendee(
    this.id,
    this.isVip,
    this.firstName,
    this.lastName,
    this.email,
    this.eventid,
    this.orderid,
  );
}
