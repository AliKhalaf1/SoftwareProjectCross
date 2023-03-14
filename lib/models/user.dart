class User {
  //parameters
  final String email;
  final String ImageUrl;
  final String firstName;
  final String lastName;
  //constructor
  User(this.email, this.ImageUrl, this.firstName, this.lastName);
}

List<User> getUsers() {
  return [
    User('ahmedsaad_2009@live.com', 'asset', 'Ahmed', 'Saad'),
    User('Eng_Remonda@gmail.com', 'asset', 'Eng', 'Remoonda'),
    User('Gilany@gmail.com', 'asset', 'Youssef', 'Gilany'),
    User('Ali@gmail.com', 'asset', 'Ali', 'Khalaf'),
    User('Hazem@gmail.com', 'asset', 'Hazem', 'Montasser'),
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
