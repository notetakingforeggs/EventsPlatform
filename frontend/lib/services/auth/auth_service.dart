import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // google sign in
  signInWithGoogle() async {
    // begin sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain details from the request
    final GoogleSignInAuthentication gauth = await gUser!.authentication;

    // create new credentials for the user.
    final credential = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );

    // sign in
    return await _firebaseAuth.signInWithCredential(credential);
  }
}
