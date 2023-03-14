class Auth {
  //parameters of the EventCard Widget
  final String email;
  final String password;

  //constructor
  Auth(this.email, this.password);
}

List<Auth> getAuths() {
  return [
    Auth('ahmedsaad_2009@live.com', '123456'),
    Auth('Eng_Remonda@gmail.com', '123456'),
    Auth('Gilany@gmail.com', '123456'),
    Auth('Ali@gmail.com', '123456'),
    Auth('Hazem@gmail.com', '123456'),
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
