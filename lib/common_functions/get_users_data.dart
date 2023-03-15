import '../models/user.dart';

List<User> getUsers() {
  return [
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
        'Ameen@gmail.com',
        'https://i.ibb.co/VmFXyyk/Whats-App-Image-2023-03-15-at-03-27-07-2.jpg',
        'Ahmed',
        'Amin'),
    User(
        'Amin@gmail.com',
        'https://i.ibb.co/0mv1cS5/Whats-App-Image-2023-03-15-at-03-27-dd07-2.jpg',
        'Ahmed',
        'Amin'),
  ];
}

User getUserData(String email) {
  List<User> users = getUsers();
  for (var user in users) {
    if (user.email == email) {
      return user;
    }
  }
  return User('null', 'null', 'null', 'null');
}
