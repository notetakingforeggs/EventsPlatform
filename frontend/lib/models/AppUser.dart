class AppUser {
  final String firebaseUid; // Firebase UID
  final String? email;
  final String? displayName; // Optional
  final String? photoUrl; // Optional
  String? googleToken; // Optional (Firebase ID token or Google OAuth token)

  AppUser({
    required this.firebaseUid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.googleToken,
  });

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'firebaseUid': firebaseUid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'googleToken': googleToken,
    };
  }

  // Create an object from a JSON map
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      firebaseUid: json['uid'],
      email: json['email'],
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      googleToken: json['googleToken'],
    );
  }

  @override
  String toString() {
    return 'AppUser{uid: $firebaseUid, email: $email, displayName: $displayName, photoUrl: $photoUrl, googleToken: $googleToken}';
  }
}