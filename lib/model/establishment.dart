class Establishment {
  String name;
  String contactPerson;
  String addess;
  String email;
  String password;
  String type;

  Establishment({
    required this.name,
    required this.contactPerson,
    required this.addess,
    required this.email,
    required this.password,
    this.type = "establishement",
  });

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'contactPerson': contactPerson,
      'addess': addess,
      'type': type,
    };
  }
}
