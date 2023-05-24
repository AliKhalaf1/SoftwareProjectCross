import 'package:objectbox/objectbox.dart';

@Entity()
class OrderClass {
  @Id()
  int mockId = 0;
  int userId = 0;
  int eventId = 0;

  String id;
  final String firstName;
  final String lastName;
  final String email;
  double price;

  DateTime creation_date;

  OrderClass(this.id, this.firstName, this.lastName, this.email, this.price,
      this.creation_date);
}
