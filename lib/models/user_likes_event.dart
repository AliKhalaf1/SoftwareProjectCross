import 'package:objectbox/objectbox.dart';

@Entity()
class UserLikesEvents {
  @Id()
  int mockId = 0;
  final int userId;
  final int eventId;

  UserLikesEvents(this.userId, this.eventId);
}
