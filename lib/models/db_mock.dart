import 'user.dart';
import 'auth.dart';

class DBMock {
  static List<Auth> auths = [
    Auth('Eng_Remonda@gmail.com', '12345678'),
    Auth('Gilany@gmail.com', '12345678'),
    Auth('Ali@gmail.com', '12345678'),
    Auth('Amin@gmail.com', '12345678'),
  ];
  static List<User> users = [
    User(
        'Eng_Remonda@gmail.com',
        'https://i.ibb.co/0J6w62R/Whats-App-Image-2023-03-15-at-03-27-06.jpg',
        'Remonda',
        'Talaat'),
    User(
        'Gilany@gmail.com',
        'https://i.ibb.co/syYKPfV/Screenshot-2023-03-15-033213.png',
        'Youssef',
        'Gilany'),
    User(
        'Ali@gmail.com',
        'https://i.ibb.co/VmFXyyk/Whats-App-Image-2023-03-15-at-03-27-07-2.jpg',
        'Ali',
        'Khalaf'),
    User(
        'Amin@gmail.com',
        'https://i.ibb.co/0mv1cS5/Whats-App-Image-2023-03-15-at-03-27-dd07-2.jpg',
        'Ahmed',
        'Amin'),
  ];

  static List<User> getUsers() {
    return users;
  }

  static User getUserData(String email) {
    List<User> users = getUsers();
    for (var user in users) {
      if (user.email == email) {
        return user;
      }
    }
    return User('null', 'null', 'null', 'null');
  }

  static bool addUser(User user, Auth auth) {
    for (var a in auths) {
      if (a.email == auth.email) {
        return false;
      }
    }
    auths.add(auth);
    users.add(user);
    return true;
  }

  static void removeUser(String email) {
    List<User> users = getUsers();
    for (var user in users) {
      if (user.email == email) {
        users.remove(user);
      }
    }
  }

  static void updateUser(User user) {
    List<User> users = getUsers();
    for (var u in users) {
      if (u.email == user.email) {
        u = user;
      }
    }
  }

  static List<Auth> getAuths() {
    return auths;
  }

  static bool checkEmail(String email) {
    List<Auth> auths = getAuths();
    for (var auth in auths) {
      if (auth.email == email) {
        return true;
      }
    }
    return false;
  }

  static bool checkAuth(String email, String password) {
    List<Auth> auths = getAuths();
    for (var auth in auths) {
      if (auth.email == email && auth.password == password) {
        return true;
      }
    }
    return false;
  }
}