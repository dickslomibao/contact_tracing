class Client {
  String firstname;
  String middlename;
  String lastname;
  String address;
  dynamic birthdate;
  String email;
  String password;

  String type;
  Client({
    required this.firstname,
    required this.middlename,
    required this.lastname,
    required this.address,
    required this.email,
    required this.password,
    required this.birthdate,
    this.type = "client",
  });

  Map<String, dynamic> toFirestore() {
    return {
      'firstname': firstname,
      'middlename': middlename,
      'lastname': lastname,
      'address': address,
      'birthdate': birthdate,
      'type': type,
    };
  }
}
