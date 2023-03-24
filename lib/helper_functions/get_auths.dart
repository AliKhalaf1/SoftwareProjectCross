import '../models/auth.dart';

List<Auth> getAuths() {
  return [
    Auth('ahmedsaad_2009@live.com', '12345678'),
    Auth('Eng_Remonda@gmail.com', '12345678'),
    Auth('Gilany@gmail.com', '12345678'),
    Auth('Ali@gmail.com', '12345678'),
    Auth('Hazem@gmail.com', '12345678'),
  ];
}

bool checkEmail(String email) {
  List<Auth> auths = getAuths();
  for (var auth in auths) {
    if (auth.email == email) {
      return true;
    }
  }
  return false;
}

bool checkAuth(String email, String password) {
  List<Auth> auths = getAuths();
  for (var auth in auths) {
    if (auth.email == email && auth.password == password) {
      return true;
    }
  }
  return false;
}
