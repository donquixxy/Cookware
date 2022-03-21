class UserModels {
  String email;
  String displayName;
  String uid;

  UserModels(
      {required this.email, required this.displayName, required this.uid});

  factory UserModels.fromJson(Map<String, dynamic> fromJson) {
    return UserModels(
        email: fromJson['email'],
        displayName: fromJson['displayName'],
        uid: fromJson['uid']);
  }

  Map<String, dynamic> toJson() =>
      {'email': email, 'displayName': displayName, 'uid': uid};
}
