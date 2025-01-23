class AppUser {
  final String uid; // Firebase UID
  final String? email;
  final String? displayName; // Optional
  final String? photoUrl; // Optional
  String? googleToken; // Optional (Firebase ID token or Google OAuth token)

  AppUser({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.googleToken,
  });

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'googleToken': googleToken,
    };
  }

  // Create an object from a JSON map
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      email: json['email'],
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      googleToken: json['googleToken'],
    );
  }
}