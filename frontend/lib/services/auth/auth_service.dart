import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
      print(gAuth);

      // create new credentials for the user.
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      print("credential is $credential");

      // sign in
      return await _firebaseAuth.signInWithCredential(credential);
    } catch (error) {
      print("user unable to sign in error: $error");
      rethrow;
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
