class UserModel {
  final String fullName;
  final String email;
  final String profileImageURL;

  UserModel({
    required this.fullName,
    required this.email,
    required this.profileImageURL,
  });

  Map<String, dynamic> toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "ProfileImageURL": profileImageURL
    };
  }
}
