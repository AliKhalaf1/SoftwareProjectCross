import 'package:objectbox/objectbox.dart';

@Entity()
class TicketClass {
  @Id()
  int mockId = 0;
  int eventId = 0;
  final String id;
  final String name;
  bool isVip;
  double price;
  int maxQuantity;
  int availableQuantity = 0;
  DateTime startDate;
  DateTime endDate;

  TicketClass(this.id, this.name, this.isVip, this.price, this.maxQuantity,
      this.startDate, this.endDate) {
    availableQuantity = maxQuantity;
  }
}
