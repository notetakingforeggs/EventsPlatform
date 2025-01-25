import 'package:events_platform_frontend/models/AppUser.dart';
import 'package:events_platform_frontend/services/api/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/calendar',
  ]);

  // get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // google sign in
  signInWithGoogle() async {
    print("signing in with google");
    // begin sign in process
    try {
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
      print("printing");

      // check for cancel
      if (gUser == null) return;

      // obtain details from the request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // create new credentials for the user.
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // sign in to firebase using the constructed credential from the google creds
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      print("accessToken: ${credential.accessToken}");
      print("idToken: ${credential.idToken}");
      print("oooooooooo");
      return {
        "userCredential": userCredential,
        "googleIdToken": credential.idToken,
        "googleAccessToken": credential.accessToken,
      };
    } catch (error) {
      print("user unable to sign in error: $error");
      rethrow;
    }
  }

  // Get OAuth Token - NOT WORKING
  Future<dynamic> getOAuthAccessToken() async {
    User? user = getCurrentUser();
    if (user != null) {
      final idToken = await user.getIdToken();
      final info = await user.getIdTokenResult();
      print("$idToken");
      print("Claims:${info.claims}");

      final googleAccessToken = info.claims?['oauthAccessToken'];
      print("Google Access Token:  $googleAccessToken");
      return googleAccessToken;
    }
  }

  checkGoogleSignIn() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn().signInSilently();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print(googleAuth.accessToken); // This will refresh the token if expired
    }
  }

  signOut() async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
        print("user signed out from google");
      }
      await _firebaseAuth.signOut();
      print("user signed out from firebasea");
    } catch (e) {
      print("there has been some error signing out: $e");
    }
  }
}
