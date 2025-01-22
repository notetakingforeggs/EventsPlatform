import 'package:events_platform_frontend/services/api/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes:[
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
      

      // Method to send the token to the backend
      // send credential.accessToken


      // sign in
      return await _firebaseAuth.signInWithCredential(credential);
    } catch (error) {
      print("user unable to sign in error: $error");
      rethrow;
    }
  }

  // Get OAuth Token - NOT WORKING
  Future<dynamic> getOAuthAccessToken() async{
    User? user = getCurrentUser();
    if(user != null){
      final idToken = await user.getIdToken();
      final info = await user.getIdTokenResult();
      // print("$idToken");
      print("Claims:${info.claims}");

      final googleAccessToken = info.claims?['oauthAccessToken'];
      print("Google Access Token:  $googleAccessToken");
      return googleAccessToken;
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
