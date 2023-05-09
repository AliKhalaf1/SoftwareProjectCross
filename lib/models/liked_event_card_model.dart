import 'package:Eventbrite/objectbox.g.dart';

@Entity()
class LikedEventCardModel {
  @Id()
  int mockId = 0;
  String id;
  final String title;
  final DateTime startDate;
  final String eventImageUrl;
  final bool isOnline;

  LikedEventCardModel(
    this.id,
    this.title,
    this.startDate,
    this.eventImageUrl,
    this.isOnline,
  );
}
