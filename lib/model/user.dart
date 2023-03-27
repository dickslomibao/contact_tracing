class User {
  String name;
  String address;
  String email;
  String password;
  String type;
  User({
    required this.name,
    required this.address,
    required this.email,
    required this.password,
    this.type = "client",
  });
}
