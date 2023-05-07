import 'package:objectbox/objectbox.dart';

@Entity()
class TicketClass {
  @Id()
  int mockId = 0;
  final String name;
  bool isVip;
  double price;
  int maxQuantity;
  int availableQuantity = 0;
  DateTime startDate;
  DateTime endDate;

  TicketClass(this.name, this.isVip, this.price, this.maxQuantity,
      this.startDate, this.endDate) {
    availableQuantity = maxQuantity;
  }
}
