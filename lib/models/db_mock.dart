/// {@nodoc}
/// nodoc
import '../providers/events/event.dart';
import '../providers/tickets/ticket.dart';
import 'user.dart';
import 'auth.dart';

class DBMock {
  static List<Event> events = [
    Event(
        '0',
        DateTime.now().add(const Duration(hours: 3)),
        DateTime.now().add(const Duration(hours: 4)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/R.1edb438b3f510aa9f4ea42a306507e35?rik=22xbsX8Xr5Z1KQ&pid=ImgRaw&r=0',
        true,
        false,
        "Learn",
        ['smart', 'wellness', 'aykalam'],
        'Ancara messi ancara messi',
        'Amin',
        false),
    Event(
        '1',
        DateTime.now().add(const Duration(hours: 3)),
        DateTime.now().add(const Duration(days: 16)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
        false,
        false,
        "Health",
        ['smart', 'wellness', 'aykalam'],
        'Ancara messi ancara messi',
        'Megs',
        false),
    Event(
        '2',
        DateTime.now().add(const Duration(hours: 3)),
        DateTime.now().add(const Duration(days: 9)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/OIP.we5keYDOBq6j9Dm-pOGIKgHaD1?pid=ImgDet&rs=1',
        false,
        false,
        "Tech",
        ['smart', 'wellness', 'aykalam'],
        'Ancara messi ancara messi',
        'Saad',
        false),
    Event(
        '8',
        DateTime.now().add(const Duration(hours: 3)),
        DateTime.now().add(const Duration(days: 6)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://i1.wp.com/www.skeptical-science.com/wp-content/uploads/2012/02/Egyptian-actor-Adel-Imam-007-1.jpg?resize=300%2C180&ssl=1',
        false,
        false,
        "Sports & Fitness",
        ['smart', 'wellness', 'aykalam'],
        'Ancara messi ancara messi',
        'Gilany',
        false),
    Event(
        '6',
        DateTime.now().add(const Duration(hours: 3)),
        DateTime.now().add(const Duration(days: 33)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/OIP.anXdkkvjnHH-Fjm_LnX52gHaEK?pid=ImgDet&w=1600&h=900&rs=1',
        false,
        false,
        "Business",
        ['smart', 'wellness', 'aykalam'],
        'Ancara messi ancara messi',
        'Amaar',
        false),
    Event(
        '12',
        DateTime.now().add(const Duration(hours: 3)),
        DateTime.now().add(const Duration(minutes: 30, hours: 5)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/OIP.we5keYDOBq6j9Dm-pOGIKgHaD1?pid=ImgDet&rs=1',
        true,
        false,
        "Business",
        ['smart', 'wellness', 'aykalam'],
        'Ancara messi ancara messi',
        'Hazem',
        false),
    Event(
        '20',
        DateTime.now(),
        DateTime.now().add(const Duration(days: 7)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/R.1edb438b3f510aa9f4ea42a306507e35?rik=22xbsX8Xr5Z1KQ&pid=ImgRaw&r=0',
        true,
        false,
        "Culture",
        ['smart', 'wellness', 'aykalam'],
        'Ancara messi ancara messi',
        'Mahmoud',
        false),
    Event(
        '21',
        DateTime.now().add(const Duration(days: 1)),
        DateTime.now().add(const Duration(days: 4)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/OIP.anXdkkvjnHH-Fjm_LnX52gHaEK?pid=ImgDet&w=1600&h=900&rs=1',
        false,
        false,
        "Tech",
        ['smart', 'wellness', 'aykalam'],
        'Ancara messi ancara messi',
        'Ali',
        false),
    Event(
        '11',
        DateTime.now().add(const Duration(hours: 2)),
        DateTime.now().add(const Duration(minutes: 30, hours: 4)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
        false,
        false,
        "Sports & Fitness",
        ['smart', 'wellness', 'aykalam'],
        'Ancara messi ancara messi',
        'Ziad',
        false),
    Event(
        '10',
        DateTime.now().add(const Duration(hours: 1)),
        DateTime.now().add(const Duration(hours: 2)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
        false,
        false,
        "Tech",
        ['smart', 'wellness', 'aykalam'],
        'Ancara messi ancara messi',
        'Abdelhameed',
        false),
  ];

  static List<Ticket> tickets = [
    Ticket('https://i.ibb.co/vxFX1kg/IMG-20221203-WA0061.jpg',
        DateTime.now().subtract(Duration(days: 1)), 'Ana el 7koma ylaaaa'),
    Ticket('https://i.ibb.co/f08m21y/IMG-20230416-WA0022.jpg',
        DateTime.now().add(Duration(days: 1)), 'Adiny 7ob akter'),
    Ticket('', DateTime.now(), 'sika haaaaaaaa'),
  ];

  static List<Auth> auths = [
    Auth('eng_Remonda@gmail.com', '12345678'),
    Auth('gilany@gmail.com', '12345678'),
    Auth('ali@gmail.com', '12345678'),
    Auth('amin@gmail.com', '12345678'),
    Auth('ahmedsaad_2009@live.com', '123456789'),
  ];
  static List<User> users = [
    User(
        'eng_remonda@gmail.com',
        'https://i.ibb.co/0J6w62R/Whats-App-Image-2023-03-15-at-03-27-06.jpg',
        'Remonda',
        'Talaat'),
    User(
        'gilany@gmail.com',
        'https://i.ibb.co/syYKPfV/Screenshot-2023-03-15-033213.png',
        'Youssef',
        'Gilany'),
    User(
        'ali@gmail.com',
        'https://i.ibb.co/VmFXyyk/Whats-App-Image-2023-03-15-at-03-27-07-2.jpg',
        'Ali',
        'Khalaf'),
    User(
        'amin@gmail.com',
        'https://i.ibb.co/0mv1cS5/Whats-App-Image-2023-03-15-at-03-27-dd07-2.jpg',
        'Ahmed',
        'Amin'),
    User('ahmedsaad_2009@live.com',
        'https://i.ibb.co/RjYFPKB/IMG-20230412-WA0014.jpg', 'Ahmed', 'Saad'),
  ];

  static List<User> getUsers() {
    return users;
  }

  static List<Ticket> getTickets() {
    return tickets;
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

  static void updateUserImage(String email, String imageurl) {
    List<User> users = getUsers();
    for (var u in users) {
      if (u.email == email) {
        u.imageUrl = imageurl;
      }
    }
  }

  static void updateUserName(String email, String firstname, String lastname) {
    List<User> users = getUsers();
    for (var u in users) {
      if (u.email == email) {
        u.firstName = firstname;
        u.lastName = lastname;
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
