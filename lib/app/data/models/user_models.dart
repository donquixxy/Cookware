class UserModels {
  String email;
  String displayName;
  String uid;
  // List likedItems;

  UserModels({
    required this.email,
    required this.displayName,
    required this.uid,
    // required this.likedItems
  });

  factory UserModels.fromJson(Map<String, dynamic> fromJson) {
    return UserModels(
      email: fromJson['email'],
      displayName: fromJson['displayName'],
      uid: fromJson['uid'],
      // likedItems: fromJson['likedItems']
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'displayName': displayName,
        'uid': uid,
        // 'likedItems': likedItems
      };
}
