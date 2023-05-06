library EventPromocodeModel;

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
/// it's used in the [BuyTickets] Widget as we need promocode id
///
///
///   • name: promocode name  [String]
///
///   • isLimited: determine true: limited or false: unlimited  [bool]
///
///   • avliableAmount: avliable amount if limited [int]
///
///   • type: determine discount by value or %  [String]
///
///   • discount: discount value [int]
///
///   • startDate: [DateTime]
///
///   • endDate: [DateTime]
///

@Entity()
class EventPromocodeInfo {
  @Id()
  int id = 0;
  //parameters
  // @Unique()
  String name;
  bool isLimited; /*true: limited / false:unlimited */
  int avliableAmount; /*current_amount from API */
  /*To Be: promocode type => % or value lesa ha3raf hoa type eh*/
  String type;
  int discount; /* discount_percentage OR discount_percentage depending on type */
  DateTime startDate;
  DateTime endDate;

  EventPromocodeInfo(this.name, this.isLimited, this.avliableAmount, this.type,
      this.discount, this.startDate, this.endDate);
}
