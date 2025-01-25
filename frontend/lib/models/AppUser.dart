class AppUser {
  final String firebaseUid; // Firebase UID
  final String? email;
  final String? displayName; // Optional
  final String? photoUrl; // Optional
  String? googleIdToken;
  String? googleAccessToken;

  AppUser({
    required this.firebaseUid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.googleIdToken,
    this.googleAccessToken,
  });

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'firebaseUid': firebaseUid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'googleIdToken': googleIdToken,
      'googleAccessToken': googleAccessToken,
    };
  }


  // Create an object from a JSON map
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      firebaseUid: json['uid'],
      email: json['email'],
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      googleIdToken: json['googleIdToken'],
      googleAccessToken: json['googleAccessToken'],
    );
  }

  @override
  String toString() {
    return 'AppUser{uid: $firebaseUid, email: $email, displayName: $displayName, photoUrl: $photoUrl, googleToken: $googleIdToken, googleAccessToken: $googleAccessToken}';
  }
}