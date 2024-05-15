class UserModel {
  final String fullName;
  final String email;

  UserModel({
    required this.fullName,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "FullName": fullName,
      "Email": email,
    };
  }
}
