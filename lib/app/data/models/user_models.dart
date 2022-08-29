class UserModels {
  String email;
  String displayName;
  String uid;
  bool isAdmin;
  // List likedItems;

  UserModels(
      {required this.email,
      required this.displayName,
      required this.uid,
      this.isAdmin = false
      // required this.likedItems
      });

  factory UserModels.fromJson(Map<String, dynamic> fromJson) {
    return UserModels(
        email: fromJson['email'],
        displayName: fromJson['displayName'],
        uid: fromJson['uid'],
        isAdmin: fromJson['isAdmin']
        // likedItems: fromJson['likedItems']
        );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'displayName': displayName,
        'uid': uid,
        'isAdmin': isAdmin
        // 'likedItems': likedItems
      };
}
