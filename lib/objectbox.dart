import 'package:Eventbrite/models/db_mock.dart';
import 'package:Eventbrite/models/user_likes_event.dart';
import 'package:Eventbrite/providers/events/event.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'models/auth.dart';
import 'models/event_promocode.dart';
import 'models/ticket_class.dart';
import 'models/user.dart';
import 'objectbox.g.dart'; // created by `flutter pub run build_runner build`

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  /// The Box for the User model.
  ///
  /// This is used to store the user's data.
  static late Box<User> userBox;
  static late Box<Auth> authBox;
  static late Box<Event> eventBox;
  static late Box<UserLikesEvents> likesBox;
  static late Box<TicketClass> ticketClassBox;
  static late Box<EventPromocodeInfo> eventPromocodeBox;

  ObjectBox._create(this.store) {
    userBox = store.box<User>();
    authBox = store.box<Auth>();
    eventBox = store.box<Event>();
    likesBox = store.box<UserLikesEvents>();
    ticketClassBox = store.box<TicketClass>();
    eventPromocodeBox = store.box<EventPromocodeInfo>();

    if (userBox.isEmpty()) {
      userBox.putMany(DBMock.users);
    }

    if (authBox.isEmpty()) {
      authBox.putMany(DBMock.auths);
    }
    if (eventBox.isEmpty()) {
      eventBox.putMany(DBMock.events);
    }
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store =
        await openStore(directory: p.join(docsDir.path, "obx-example"));
    return ObjectBox._create(store);
  }
}
