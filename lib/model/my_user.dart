class MyUser {
  String? id;
  String? firstName;
  String? lastName;
  String? email;

  MyUser(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email});

  MyUser.fromJson(Map<String, dynamic> data)
      : this(
          id: data['id'],
          firstName: data['firstName'],
          lastName: data['lastName'],
          email: data['email'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fistName': firstName,
      'lastName': lastName,
      'email': email
    };
  }
}
