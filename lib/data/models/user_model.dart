class UserModel {
  String name;
  String email;
  String id;
  UserModel({
    required this.email,
    required this.id,
    required this.name,
  });

  factory UserModel.fromJson(jsonData) {
    return UserModel(
      email: jsonData['email'],
      id: jsonData['id'],
      name: jsonData['name'],
    );
  }

  Map toJson() {
    return {
      'name': name,
      'email': email,
      'id': id,
    };
  }
}
