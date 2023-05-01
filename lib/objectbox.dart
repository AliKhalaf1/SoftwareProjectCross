import 'package:Eventbrite/models/db_mock.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'models/auth.dart';
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
  static late Box<User, Auth> userlikesBox;
  ObjectBox._create(this.store) {
    userBox = store.box<User>();
    authBox = store.box<Auth>();
    userlikesBox = store.box<User, Auth>();

    if (userBox.isEmpty()) {
      userBox.putMany(DBMock.users);
    }

    if (authBox.isEmpty()) {
      authBox.putMany(DBMock.auths);
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
